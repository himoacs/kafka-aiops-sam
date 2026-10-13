---
name: kafka-consumer-lag-troubleshoot
description: >-
  Diagnosis procedure for "consumer lag is high / growing / my consumer is not
  keeping up": separates a slow consumer from a stuck consumer, a rebalance, no
  live members, a producer burst and partition skew, using lag trend, committed
  offset movement, group state, rebalance metrics and logs. Loaded by the Kafka
  Orchestrator Agent before delegating any consumer-lag question.
tags: [kafka, consumer, lag, rebalance, troubleshooting]
---

# Consumer Lag Troubleshooting

"Lag is high" is a symptom. Classify it first, because the fixes differ.

## Step 1: gather evidence (delegate in parallel; always name the group and topic)

| Ask | Specialist | Why |
|---|---|---|
| Lag trend: `kafka_consumergroup_lag_sum` over 60 min and `deriv(...[5m])` | Metrics Agent | growing, flat or draining |
| Consumption rate `rate(kafka_consumergroup_current_offset_sum[5m])` vs production rate `sum(rate(kafka_topic_partition_current_offset{topic=...}[5m]))` | Metrics Agent | is the consumer keeping pace |
| `kafka_consumergroup_members` over time (flipping values = membership churn) and `kafka_coordinator_group_numgroupspreparingrebalance`. Do **not** rely on `consumer_group_rebalance_count`: it only counts groups on the new KIP-848 protocol and is 0 for classic groups | Metrics Agent | no members / rebalancing |
| `describe_consumer_group` with `include_offsets=true`: state, members, per-partition committed offset and lag | Cluster Agent | group state and skew across partitions |
| Broker lines `Preparing to rebalance group <g>` / `Stabilized group <g> generation N` for the group in the window (count them and note the generation numbers and the joining/leaving member ids), plus WARN/ERROR for the consumer service | Logs Agent | the authoritative rebalance history; timeouts, exceptions, group churn |

## Step 2: classify

| Evidence | Classification |
|---|---|
| Group state `Empty`, or `members = 0` | **No live consumers.** Application down or not subscribed. |
| Consumption rate ≈ 0 while lag grows, members present, state `Stable`, no rebalances | **Stuck consumer.** Alive but not committing (blocked processing, long poll loop, poison record on one partition, deadlock). Look at which partitions have zero offset movement. |
| State `PreparingRebalance`/`CompletingRebalance`, or repeated rebalances, consumption rate sawtooths | **Rebalance storm.** Members joining/leaving or exceeding `max.poll.interval.ms`; logs show group churn. |
| Consumption rate > 0 but below production rate; lag grows steadily on all partitions | **Slow consumer** (under-provisioned or slow processing) or **producer burst**. Compare rates: production jumped (burst) or consumption fell (slow). |
| One or few partitions carry most of the lag; others near zero | **Partition skew / hot key / poison record.** Check per-partition production rate and the partitions' offsets. |
| Lag was high and is draining | **Recovering.** Report the drain rate and estimated time to zero. |

If two classifications fit, say so and say what additional evidence would separate them. Do not guess.

## Step 3: explain with documented facts

Ask the Kafka Expert Agent agent for the documented behavior of any setting you mention (`max.poll.interval.ms`, `session.timeout.ms`, `auto.offset.reset`, the new group protocol) and cite it. Do not state defaults from memory.

## Step 4: report

1. **Classification** in one line, with confidence.
2. **Evidence** table (metric / value / window) with citations.
3. **Impact:** consumed vs produced rate, lag size, estimated catch-up time if draining.
4. **Proposed next steps** for a human, labeled as not executed, for example `kafka-consumer-groups.sh --bootstrap-server ... --describe --group <g>`, or `--reset-offsets ... --dry-run` (never an execute form) for offset problems.
5. If the topic or group has an owner or a retention policy in the knowledge base (`acme-kafka-knowledge`), add an "Acme context" section: who owns it and the policy that limits the safe options (for example compliance retention).
