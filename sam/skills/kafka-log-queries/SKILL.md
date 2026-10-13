---
name: kafka-log-queries
description: >-
  LogQL mechanics for Kafka logs in Loki: the label set, log line formats for
  brokers, controllers and client apps, and query patterns for replication,
  rebalancing, authentication, KRaft elections and client errors. Loaded by the
  Kafka Logs Agent before its first query.
tags: [kafka, loki, logql, logs]
---

# Kafka Log Queries

Data source: Loki, with Kafka broker, KRaft controller and client application logs.

**Site-specific values: edit the Labels section to match your estate** (see `docs/connect-logs.md`). The defaults come from `reference/alloy/config.alloy`. If you use another log store (OpenSearch, Splunk, ...), this skill's query table is the part to translate.

## Tools

| Tool | Parameters |
|---|---|
| `label_values` | `label`, optional `start`/`end` |
| `labels` | optional `start`/`end` |
| `series` | `match` (a selector), optional `start`/`end` |
| `query_range` | `query` (LogQL), `start`, `end`, `limit`, `direction` (`backward` = newest first) |
| `query` | instant LogQL (use for metric queries such as `count_over_time`) |

Always pass `start` and `end` (RFC3339). Default window: last 60 minutes; widen only when asked. Keep `limit` small (50-100) and narrow the query rather than raising it.

## Labels

`cluster` (default `my-cluster`), `role` (`broker`, `controller`, `client`), `service` (the container or application name, for example one value per broker and per client app), `level` (`INFO`, `WARN`, `ERROR`, ...). Check live values with `label_values` before writing a selector; do not assume service names.

## Line formats

- Brokers and controllers: `[2026-10-09 05:50:36,375] INFO [Component id=101] message (kafka.package.Class)`.
- Client apps: `INFO message`, `ERROR message`. If a client app logs periodic progress lines, their absence is a signal; check what your apps log.

## Query patterns (confirm each with a real query; Kafka wording varies by version)

| Question | LogQL |
|---|---|
| Problems anywhere | `{cluster="my-cluster", level=~"WARN\|ERROR"}` |
| Problems on one node | `{service="<service-name>", level=~"WARN\|ERROR"}` |
| Replication / ISR changes | `{role="broker"} \|~ "Shrinking ISR\|Expanding ISR\|NotEnoughReplicas\|NOT_ENOUGH_REPLICAS"` |
| Leader changes | `{role="broker"} \|~ "(?i)became leader\|leader election\|LeaderAndIsr"` |
| Broker lifecycle | `{role="broker"} \|~ "Kafka Server started\|shutting down\|Shutdown completed\|Starting"` |
| KRaft quorum / elections | `{role=~"controller\|broker"} \|~ "(?i)quorum\|transition to\|election\|Candidate\|Leader"` |
| Consumer rebalances (authoritative history; the metrics do not capture classic-protocol rebalances) | `{role="broker"} \|~ "(?i)preparing to rebalance group <group>\|stabilized group <group>\|member.*(removed\|failed)"`; count with `count_over_time(... [10m])` and note the generation numbers and member ids |
| Consumer client trouble | `{role="client", level=~"WARN\|ERROR"}` ; `{role="client"} \|~ "(?i)rebalance\|max.poll\|offset\|commit"` |
| Authentication failures | `{role="broker"} \|~ "Failed authentication"` (line says the client address and reason, e.g. invalid credentials) |
| Authorization (ACL) denials | `{role="broker"} \|~ "is Denied operation"` (format: `Principal = User:x is Denied operation = WRITE ... on resource = Topic:LITERAL:name`) |
| Producer failures | `{role="client"} \|~ "(?i)delivery failed\|timeout\|RecordTooLarge\|NotEnoughReplicas"` |
| Disk / log dir | `{role="broker"} \|~ "(?i)log dir\|No space\|offline\|IOException"` |
| Volume of problems per service | `sum by (service) (count_over_time({cluster="my-cluster", level=~"WARN\|ERROR"}[15m]))` (use `query`) |

**Reading auth lines:** a `Failed authentication` line gives only the client IP and reason; it does **not** name the user, so never state which username or principal a failing client is configured with. An authorization denial (`is Denied operation`) does name the principal, operation and topic. Treat them as two separate problems (credentials vs missing ACL) and do not merge them into one cause. Do not say a service is down or unavailable unless a metric or log shows it; failed writes by one principal say nothing about its other traffic.

## Rules

1. **Start narrow, then widen.** Begin with `level=~"WARN|ERROR"` for the time window, summarize by `service`, then open the noisiest.
2. **Quote lines exactly** with their timestamp and service. Do not paraphrase an error message you will cite.
3. **Absence is a finding only if you queried the right window and selector.** Say "no matching lines in <window> for <selector>" rather than "no problems".
4. **Decode Kafka error names** you encounter (`NOT_ENOUGH_REPLICAS`, `OFFSET_OUT_OF_RANGE`, ...) by pointing the orchestrator to the Kafka Expert Agent agent; do not guess meanings.
5. You report evidence; the orchestrator draws conclusions.
6. Load `kafka-response-citations` before finalizing; cite the tool, the LogQL and the range.
