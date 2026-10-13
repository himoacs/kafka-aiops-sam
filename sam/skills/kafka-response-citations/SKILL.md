---
name: kafka-response-citations
description: >-
  Citation format every agent must attach to findings in its final answer -
  identifies the exact tool call, agent, query parameters, and timestamp
  behind each claim, so operators can verify the mesh isn't hallucinating.
  Loaded by all agents; the Kafka Orchestrator Agent additionally follows
  the synthesis rule for preserving specialist citations verbatim.
tags: [citations, evidence, formatting]
---

# Response Citations

Every finding in a final answer must carry a citation showing exactly which tool call or document produced it. This is what lets an operator verify a claim against the underlying system instead of trusting the mesh's word for it.

## Format

Immediately after the paragraph, bullet group, or table that presents a finding, add its own line:

```
[Source: <agent_name> · <tool_name> | <key params> | timestamp: <ISO8601 UTC>]
```

- **`<agent_name>`** - your own resource name (e.g. `kafka_metrics_agent`).
- **`<tool_name>`** - the exact tool you called, in whatever case convention that connector uses. Don't normalize it.
- **`<key params>`** - the parameters that define *what was queried*, enough for someone to re-run it: the PromQL or LogQL expression and range, or the topic/group name.
- **`timestamp`** - the wall-clock time you made the tool call, ISO8601 UTC. Not a timestamp found inside the returned data; cite that as part of the finding text if relevant.

## Placement

**One tag per finding-bearing block** (a paragraph, bullet group, or table), not after every sentence. Only add a second tag within the same block if it draws on a different tool call.

## Per-source examples

**Prometheus** (Metrics Agent):
```
[Source: kafka_metrics_agent · execute_query | promql=sum(kafka_server_replicamanager_underreplicatedpartitions) | timestamp: 2026-10-09T14:32:00Z]
```
Name whichever instant or range query tool you actually called.

**Loki** (Logs Agent):
```
[Source: kafka_logs_agent · query_range | logql={role="broker"} |= "NotEnoughReplicas", range=2026-10-09T14:00:00Z..2026-10-09T14:30:00Z | timestamp: 2026-10-09T14:32:00Z]
```

**Kafka cluster** (Cluster Agent):
```
[Source: kafka_cluster_agent · describe_consumer_group | group_id=payments-consumer, include_offsets=true | timestamp: 2026-10-09T14:32:00Z]
```

**Kafka documentation** (Expert Agent): cite the file and the docs URL, as defined in the `kafka-docs` skill:
```
[Source: kafka-docs 4.2 · grep_skill_resources | file=reference/topic-configs.md, pattern=^## min.insync.replicas | url=https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.insync.replicas]
```
Facts from the live web use `[Source: live web · <url> | fetched: <ISO8601 UTC>]`.

**Institutional knowledge**:
```
[Source: acme-kafka-knowledge · read_skill_resource | references/topic-ownership.md]
```

## Orchestrator synthesis rule

When combining specialist answers into the final report, **preserve every `[Source: ...]` tag verbatim** from the specialist text, positioned immediately after wherever that finding ends up in the synthesized answer. Do not drop, merge, renumber, or reword a citation. If a claim in the synthesized answer is your own inference across specialists' findings rather than a single sourced fact, don't fabricate a citation for it; say so in plain prose instead (e.g. "Taken together, these two findings suggest...").
