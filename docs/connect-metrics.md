# Connect your metrics (Prometheus)

The metrics agent queries Prometheus through [pab1it0/prometheus-mcp-server](https://github.com/pab1it0/prometheus-mcp-server)
(pinned at 1.6.2) with PromQL. Its skill (`sam/skills/kafka-metrics-queries`) and the health-check and lag skills
use specific **metric names and labels**. The agents work as well as your metrics match that contract.

## 1. Point the MCP at your Prometheus

In `mcp/.env`:

| Variable | Meaning |
|---|---|
| `PROMETHEUS_URL` | base URL, for example `http://host.docker.internal:9090` |
| `PROMETHEUS_USERNAME`, `PROMETHEUS_PASSWORD` | basic auth, if your Prometheus needs it |
| `PROMETHEUS_TOKEN` | bearer token alternative |
| `PROMETHEUS_ORG_ID` | tenant id for multi-tenant stores (Mimir, Cortex, Thanos receive) |

Anything that serves the **Prometheus HTTP query API** works: Prometheus itself, Thanos Query, Mimir, Cortex,
VictoriaMetrics, Grafana Cloud's Prometheus endpoint, Amazon Managed Service for Prometheus (with a
SigV4-signing proxy in front). Only plain Prometheus was tested. Verify:

```bash
cd mcp && docker compose up -d prometheus-mcp && cd ..
mcp/scripts/mcp-smoke.sh http://localhost:9202/mcp execute_query '{"query":"count(up)"}'
```

## 2. The metric contract

The skills query these series. Sources are in brackets.

| Area | Metrics |
|---|---|
| Replication health | `kafka_server_replicamanager_underreplicatedpartitions`, `kafka_server_replicamanager_isrshrinkspersec_count` [JMX] ; `kafka_topic_partition_under_replicated_partition`, `kafka_topic_partition_in_sync_replica`, `kafka_topic_partition_replicas`, `kafka_topic_partition_leader`, `kafka_topic_partition_leader_is_preferred` [kafka-exporter] |
| Controller / KRaft | `kafka_controller_kafkacontroller_activecontrollercount`, `kafka_controller_kafkacontroller_offlinepartitionscount`, `kafka_server_raftmetrics_current_leader` [JMX] |
| Traffic and errors | `kafka_server_brokertopicmetrics_bytesinpersec_count`, `kafka_server_brokertopicmetrics_failedproducerequestspersec_count`, `kafka_network_requestmetrics_errorspersec_count_total`, `kafka_network_requestmetrics_totaltimems_99thpercentile` [JMX] |
| Consumer groups | `kafka_consumergroup_lag`, `kafka_consumergroup_lag_sum`, `kafka_consumergroup_current_offset_sum`, `kafka_consumergroup_members`, `kafka_topic_partition_current_offset`, `kafka_brokers` [kafka-exporter] ; `kafka_coordinator_group_numgroupspreparingrebalance`, `kafka_coordinator_group_numgroupsstable`, `kafka_server_groupcoordinator_consumer_group_rebalance_count` [JMX] |
| Storage | `kafka_log_log_size`, `kafka_log_log_logendoffset`, `kafka_log_logmanager_offlinelogdirectorycount`, `node_filesystem_avail_bytes`, `node_filesystem_size_bytes` [JMX, node-exporter] |
| Security | `kafka_server_socketservermetrics_failed_authentication`, `kafka_server_socketservermetrics_successful_authentication`, `kafka_server_socketservermetrics_connection_count` [JMX] |
| Alerts, targets | `ALERTS{alertstate="firing"}`, `up` [Prometheus] |

Scrape jobs assumed: `kafka-broker`, `kafka-controller` (JMX exporter), `kafka-exporter`, `node`.

## 3. Three ways to meet the contract

**A. Use our rules (simplest for a new setup).** `reference/jmx-exporter/kafka-rules.yml` is the JMX exporter
configuration that produces the JMX names above (adapted from the Strimzi and Prometheus community rule sets).
Run the Prometheus JMX exporter java agent on each broker and controller with that file, run
[kafka-exporter](https://github.com/danielqsj/kafka_exporter) for consumer-group metrics, and scrape both.
`reference/prometheus/kafka-alerts.yml` adds the alert rules the health check reads through `ALERTS`.

**B. You already have Kafka metrics under different names** (Strimzi's rules, Confluent's, a vendor exporter, a
managed service). Compare names, then edit the skills:
1. Ask the metrics agent, or run in Prometheus, `list_metrics` with `filter_pattern` `kafka_`.
2. For each row of the table, find your equivalent (the JMX bean names in the Kafka docs are in
   `sam/skills/kafka-docs/references/operations/monitoring.md`).
3. Replace the names in `sam/skills/kafka-metrics-queries/SKILL.md` (and the few uses in
   `kafka-health-check` and `consumer-lag-troubleshoot`), update the **Site-specific values** paragraph (cluster
   label, job names), then re-run `scripts/apply.sh`.
Many Strimzi-style names are close to ours but not identical; check each one rather than assume.

**C. Metrics live in a non-Prometheus tool** (Datadog, CloudWatch, Dynatrace, New Relic, Splunk Observability).
If the tool exposes a Prometheus-compatible query API, use route B. Otherwise swap the connector for that tool's
MCP server and rewrite `kafka-metrics-queries` for its query language, the same way
[connect-logs.md](connect-logs.md) describes for logs. The agent prompt `sam/agents/kafka_metrics_agent.yaml`
names PromQL, so update it too. Untested.

## 4. Lessons already encoded in the skill (keep them when you edit)

- Per-partition log metrics (`kafka_log_log_*`) have one series **per replica**. Aggregate with `max`, not `sum`,
  or sizes and offsets are multiplied by the replication factor.
- `kafka_server_groupcoordinator_consumer_group_rebalance_count` only covers groups on the new consumer protocol
  (KIP-848). Classic-protocol rebalances show in the broker logs, not here.
- `kafka_network_requestmetrics_errorspersec_count_total` includes an `error="NONE"` series that counts
  **successful** requests. Always filter `error!="NONE"`.
- Fetch p99 latency includes the long-poll wait (`fetch.max.wait.ms`), so a few hundred milliseconds is normal.
- Judge disk from alerts and current usage, not from a `predict_linear` taken across a one-off step.

## No alert rules?

The health check still works from raw metrics; it just cannot say "an alert is firing". If your alerts live in
Alertmanager or elsewhere, mirror them as Prometheus alerting rules or tell the skill where to look.
