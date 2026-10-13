---
name: kafka-cluster-queries
description: >-
  Mechanics of the Kafka MCP connector: the read-only tools available, their
  parameters, what each returns, and the traps (consumer lag needs
  include_offsets, no message payloads, nothing can change cluster state).
  Loaded by the Kafka Cluster Agent before its first tool call.
tags: [kafka, cluster, topics, consumer-groups, mcp]
---

# Kafka Cluster Queries

You see the **live cluster** through a read-only principal (`mcp-reader`). It can describe cluster, topic and consumer-group metadata. It **cannot** read message payloads, produce, alter configs, change ACLs or reset offsets: Kafka itself denies those. Never claim to have done any of them.

## Tools

| Tool | Parameters | Use for |
|---|---|---|
| `cluster_overview` | none | Controller id, broker count, topic and partition counts, under-replicated and offline partition counts. Start here. |
| `list_brokers` | none | Configured broker addresses. |
| `list_topics` | none | Every topic with partition count and replication factor (internal topics flagged). |
| `describe_topic` | `topic_name` | Per-partition leader, replicas and ISR. A partition whose `Isr` is shorter than `Replicas` is under-replicated. |
| `describe_configs` | `resource_type` (`topic` or `broker`), `resource_name`, optional `config_keys` | Effective config with its **source** (`DEFAULT_CONFIG`, `STATIC_BROKER_CONFIG`, `DYNAMIC_*`). Pass `config_keys` to keep output small. |
| `list_consumer_groups` | none | Group ids and states. |
| `describe_consumer_group` | `group_id`, **`include_offsets=true`** | State, members and, with offsets, committed offset and **lag per partition**. Without `include_offsets=true` there is no lag in the answer. |

## Rules

1. **Always pass `include_offsets=true`** when the question touches lag, progress or "is the consumer stuck".
2. **Config source matters.** When reporting a config value, state its source. A value that differs from the documented default is a finding (for example a dynamic cluster-wide override). Do not state a Kafka default from memory; that is the expert agent's job.
3. **Broker ids:** use `list_brokers` for the id-to-host mapping and `cluster_overview` for the active controller id; never assume ids or host names.
4. **Report only what the tools return.** If a tool errors with an authorization failure, say that the read-only principal is not permitted to do it; do not retry with other tools to get around it.
5. **Remediation is advice, not action.** If a fix is warranted, give the exact CLI command (`kafka-consumer-groups.sh --reset-offsets ... --dry-run`, `kafka-reassign-partitions.sh`, `kafka-acls.sh`, `kafka-configs.sh`) for a human to run, and label it as a proposed command that you did not execute.
6. Load `response-citations` before finalizing. Cite the tool and its key parameters, for example `describe_consumer_group | group_id=payments-consumer, include_offsets=true`.
