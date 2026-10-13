# Architecture

## Agents

One orchestrator plans and delegates; four specialists each own one data source. The specialists never talk to
each other; the orchestrator combines their evidence into one answer.

| Agent | Data source | Connector | Skills it loads |
|---|---|---|---|
| `kafka_orchestrator_agent` | none directly | none | `kafka-health-check`, `consumer-lag-troubleshoot`, `acme-kafka-knowledge` (example), `response-citations` |
| `kafka_cluster_agent` | live cluster state: brokers, topics, partitions, ISR, configs, consumer groups and lag | `kafka_mcp` | `kafka-cluster-queries`, `response-citations` |
| `kafka_metrics_agent` | Prometheus: broker, controller, lag, disk metrics, firing alerts | `prometheus` | `kafka-metrics-queries`, `response-citations` |
| `kafka_logs_agent` | Loki: broker, controller and client logs | `loki` | `kafka-log-queries`, `response-citations` |
| `kafka_expert_agent` | the Apache Kafka 4.2 docs (config defaults, error codes, metrics, procedures) and the live web for KIPs and JIRA | built-in web tool | `kafka-docs`, `response-citations` |

## A typical flow

*"`payments-consumer` fell behind between 11:00 and 11:15. Slow, stuck, or a rebalance?"*

1. The orchestrator loads `consumer-lag-troubleshoot`, a playbook that separates the three causes by lag trend,
   committed-offset movement, group state and rebalance log lines.
2. It asks the metrics agent for lag and offset series over the window, the logs agent for rebalance lines from
   the broker logs, and the cluster agent for the group's current state.
3. It may ask the expert agent what a config or error name means.
4. It answers with a conclusion, the evidence, a proposed (never executed) next step, and a source line for every
   fact: `[Source: <agent> · <tool> | <query> | <timestamp>]`.

## Skills

| Skill | Purpose |
|---|---|
| `kafka-metrics-queries` | PromQL mechanics, the metric contract, pitfalls |
| `kafka-log-queries` | LogQL mechanics, the label contract, query patterns, how to read auth lines |
| `kafka-cluster-queries` | how to read the cluster tools, config sources, proposed-command rules |
| `kafka-health-check` | a "how is the cluster?" checklist with judgement rules to avoid false alarms |
| `consumer-lag-troubleshoot` | slow vs stuck vs rebalancing |
| `kafka-docs` | Apache Kafka 4.2 docs as searchable files; rules for citing them |
| `response-citations` | the citation format |
| `acme-kafka-knowledge` | **example** institutional knowledge ([customize-knowledge.md](customize-knowledge.md)) |

Skills use progressive disclosure: a short `SKILL.md` routes to larger reference files that the agent searches
and reads on demand, so context stays small. The `kafka-docs` corpus is about 1 MB; rebuild it from the Apache
Kafka site with `docs-corpus/fetch.sh` (pinned commit in `docs-corpus/SOURCE_REF`).

## MCP servers

| Server | Image | Port | Talks to |
|---|---|---|---|
| Kafka MCP | `ghcr.io/tuannvm/kafka-mcp-server:2.0.2` | 9201 | your Kafka brokers (as a describe-only principal) |
| Prometheus MCP | `ghcr.io/pab1it0/prometheus-mcp-server:1.6.2` | 9202 | your Prometheus HTTP API |
| Loki MCP | built from `incu6us/loki-mcp-server` v0.0.4 | 9203 | your Loki HTTP API |

All three run from `mcp/docker-compose.yaml`, bind to `127.0.0.1`, and connect outward. SAM reaches them over
MCP's streamable HTTP transport through the connectors in `sam/connectors/`.
