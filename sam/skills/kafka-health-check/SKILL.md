---
name: kafka-health-check
description: >-
  Procedure and escalation tiers for Kafka cluster health questions: what to ask
  the metrics, log and cluster specialists, how to score each area and how to
  report. Loaded by the Kafka Orchestrator Agent before delegating any
  health or "is anything wrong" question.
tags: [kafka, health, monitoring, orchestration]
---

# Kafka Health Check

## Choose the tier

| Request | Tier | Fan-out |
|---|---|---|
| "How is Kafka doing?", "any issues?", a bare "health check" | **Quick** | Metrics Agent only: firing alerts + 5 vital signs. Escalate to Standard only if something is wrong. |
| "Check the cluster", "is replication healthy?" | **Standard** | Metrics Agent + Cluster Agent in parallel. |
| Explicit "full / complete / thorough health check" | **Full** | Metrics Agent + Cluster Agent + Logs Agent in parallel, then Expert only to explain findings. |

State the tier and plan in one sentence before dispatching.

## What to ask each specialist (always give the time range and the output format)

**Metrics Agent** (last 60 min unless told otherwise) - ask for, as a table with current value and trend:
1. Firing alerts (`ALERTS{alertstate="firing"}`), and any down scrape targets.
2. Active controller count (expect exactly 1), KRaft quorum leader and epoch changes, offline partitions.
3. Under-replicated, under-min-ISR and at-min-ISR partitions; ISR shrink/expand rate.
4. Consumer-group lag per group and topic, with trend (`deriv` of lag_sum) and consumption rate.
5. Produce/fetch p99 latency and failed requests; host disk used and predicted fill time.

**Cluster Agent** - `cluster_overview`; `describe_topic` for any topic with URP; every consumer group's state and members; effective values of `min.insync.replicas`, `unclean.leader.election.enable`, `default.replication.factor` and their **source** (flag dynamic overrides and anything below the baseline RF=3, min.ISR=2).

**Logs Agent** (Full tier) - WARN/ERROR counts per service for the window, the top distinct messages, and any broker restarts or leader/quorum transitions.

## Scoring (per area, then overall = the worst area)

| Status | Meaning |
|---|---|
| **Healthy** | No alerts, URP 0, offline 0, one active controller, lag flat or draining |
| **Degraded** | Warning alerts, URP > 0 but min-ISR met, lag growing but under a minute of data, a controller down with quorum intact |
| **Critical** | Offline partitions, under-min-ISR (producers failing with `acks=all`), no/duplicate active controller, quorum lost, consumer group stuck, log dir offline |

Do not invent thresholds; when unsure, show the numbers and say what you could not judge.

### Judgement rules (avoid false alarms)

- **Disk:** judge capacity from the alerts (`KafkaDiskUsageHigh`, `KafkaDiskWillFillIn24h`) and the current used percentage. Do **not** compute your own `predict_linear` and call it Critical: a one-off step (image load, restore, compaction) extrapolates into a bogus fill time. Mark disk Degraded only if an alert is firing, Critical only if usage is above 90% or a log directory is offline.
- **Fetch latency:** `FetchConsumer` and `FetchFollower` p99 include the long-poll wait (`fetch.max.wait.ms`, 500 ms by default), so a few hundred milliseconds is normal. Judge request latency by **Produce** p99 and by errors; flag fetch latency only if it jumped relative to its own history or coincides with lag growth or ISR churn.
- **Request errors:** `kafka_network_requestmetrics_errorspersec_count_total` includes an `error="NONE"` series that counts *successful* requests. Count only series with `error!="NONE"`; with none, report request errors as 0. Never call a rate of `NONE` an error.
- **Config findings** (a dynamic override, a value differing from the baseline) are **notices**. They do not change the overall status unless the value is below the baseline (RF < 3, min.ISR < 2, unclean election enabled).
- A status below Healthy needs evidence from an alert or a metric crossing the definitions above, not a hunch about a likely cause.

## Report structure

1. One-line verdict with overall status.
2. Table: Area | Status | Evidence (with the specialist's `[Source: ...]` tag).
3. Findings ordered by severity, each with the likely cause **only if the evidence supports it**.
4. Recommended next steps. Any change is a **proposed command for a human**; you never claim to have run one.
5. If a baseline deviation was found in configs (RF, min ISR, unclean election), call it out even when everything else is green.

## Rules

- Never skip the cluster-vs-docs split: documented defaults come from the Expert agent, live values from Cluster Agent.
- Load `response-citations`; preserve specialist citations verbatim.
- Be concise: lead with the verdict, then evidence.
