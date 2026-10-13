---
name: kafka-metrics-queries
description: >-
  PromQL mechanics and the verified Kafka metric catalog for this deployment:
  broker and KRaft controller JMX metrics, consumer-group lag from
  kafka-exporter, per-partition log sizes, request latency, host disk, and
  firing alerts. Loaded by the Kafka Metrics Agent before its first query.
tags: [kafka, prometheus, promql, metrics, lag, replication]
---

# Kafka Metrics Queries

Data source: Prometheus. Metric names follow `reference/jmx-exporter/kafka-rules.yml` (JMX exporter) plus kafka-exporter for consumer-group lag and node-exporter for host data.

**Site-specific values: edit this paragraph to match your estate** (see `docs/connect-metrics.md`). Defaults: cluster label `cluster="my-cluster"` (attached at scrape time; drop it from queries if you have none); broker job `kafka-broker`; KRaft controller job `kafka-controller`; consumer-group job `kafka-exporter`; host job `node`. Broker ids are your brokers' `node.id` values; get them from the cluster agent (`list_brokers`).

## Tools

| Tool | Parameters |
|---|---|
| `execute_query` | `query`, optional `time` (instant) |
| `execute_range_query` | `query`, `start`, `end` (RFC3339 or Unix), `step` (e.g. `60s`) |
| `list_metrics` / `get_metric_metadata` | `filter_pattern` to discover or describe a metric |
| `get_targets` | scrape target health (`state`: `active`/`dropped`) |

Use an instant query for "now", a range query for a trend. Default window: last 60 minutes for state, 24 hours for trends, and always state the window you used.

## Verified metric catalog

**Alerts (start here for "any issues?")**
- `ALERTS{alertstate="firing"}` with label `alertname` (`KafkaBrokerDown`, `KafkaUnderReplicatedPartitions`, `KafkaConsumerGroupLagHigh`, ...). No rows means nothing is firing.
- `up{job=~"kafka-broker|kafka-controller"} == 0` lists down targets.

**Availability and KRaft**
- `sum(kafka_controller_kafkacontroller_activecontrollercount)` must be 1.
- `kafka_controller_kafkacontroller_offlinepartitionscount`, `_activebrokercount`, `_fencedbrokercount`, `_globalpartitioncount`, `_preferredreplicaimbalancecount`.
- `kafka_server_raftmetrics_current_leader` (quorum leader id), `_current_epoch` (a rising epoch means leader elections), `_high_watermark`, `_commit_latency_avg`.
- `kafka_brokers` (broker count seen by kafka-exporter).

**Replication health**
- `kafka_server_replicamanager_underreplicatedpartitions`, `_underminisrpartitioncount`, `_atminisrpartitioncount`, `_leadercount`, `_partitioncount`, `_offlinereplicacount` (per broker).
- `rate(kafka_server_replicamanager_isrshrinkspersec_count[5m])` and `..._isrexpandspersec_count`: ISR churn. Shrinks without matching expands mean a follower is not catching up.
- Per partition: `kafka_topic_partition_under_replicated_partition{topic,partition}`, `kafka_topic_partition_in_sync_replica`, `kafka_topic_partition_replicas`, `kafka_topic_partition_leader` (value = leader broker id), `kafka_topic_partition_leader_is_preferred`.

**Consumer groups (kafka-exporter)**
- `kafka_consumergroup_lag{consumergroup,topic,partition}`, `kafka_consumergroup_lag_sum{consumergroup,topic}`.
- `kafka_consumergroup_current_offset_sum` and `rate(kafka_consumergroup_current_offset_sum[5m])` = consumption rate; `rate(kafka_topic_partition_current_offset[5m])` summed by topic = production rate.
- `kafka_consumergroup_members{consumergroup}` (0 means no live consumer).
- Lag trend: `deriv(kafka_consumergroup_lag_sum[5m])` (messages per second; positive = growing).
- Group coordinator (**classic** consumer protocol, which these consumers use): `kafka_coordinator_group_numgroupsstable`, `_numgroupspreparingrebalance`, `_numgroupscompletingrebalance`, `_numgroupsempty`, `_numgroupsdead` (instant gauges, so a brief rebalance can be missed between scrapes). Rebalance **history** for classic groups is best taken from the broker logs (`Preparing to rebalance group <g>` with a rising generation number) and from `kafka_consumergroup_members` flipping between values. `kafka_server_groupcoordinator_consumer_group_rebalance_count` / `_rate` count only groups on the **new** KIP-848 consumer protocol and stay 0 for classic groups; a 0 there is not evidence of stability.

**Throughput, per topic and partition**
- `rate(kafka_server_brokertopicmetrics_bytesinpersec_count{topic="..."}[5m])`, `..._bytesoutpersec_count`, `..._messagesinpersec_count`.
- Failures: `rate(kafka_server_brokertopicmetrics_failedproducerequestspersec_count[5m])`, `..._failedfetchrequestspersec_count`.
- Hot partitions: `max by (partition) (rate(kafka_log_log_logendoffset{topic="..."}[5m]))` (skew = one partition far above the rest). **`kafka_log_log_*` has one series per replica** (RF=3 means three series per partition, one per broker), so aggregate a partition's logical value with **`max by`**, never `sum by`, which would count every message RF times. Use `sum` only when you want total bytes on disk (`sum by (topic) (kafka_log_log_size{...})` = size including all replicas, `max by (topic, partition)` = size of one copy).

**Request latency and errors**
- `kafka_network_requestmetrics_totaltimems_99thpercentile{request=~"Produce|FetchConsumer|FetchFollower"}` (also `_50thpercentile`, `_mean`, and the `requestqueuetimems_`, `localtimems_`, `remotetimems_`, `responsesendtimems_` breakdown).
- `increase(kafka_network_requestmetrics_errorspersec_count_total{request,error!="NONE"}[5m])` for error types.
  **Always exclude `error="NONE"`**: ErrorsPerSec also carries a `NONE` series that counts *successful* requests (it tracks request volume, e.g. ~30/s on a healthy cluster). Report a request error only for a non-`NONE` error label, and name that label (e.g. `NOT_ENOUGH_REPLICAS`, `TOPIC_AUTHORIZATION_FAILED`).

**Security signals**
- `increase(kafka_server_socketservermetrics_failed_authentication[5m])` (cumulative counter exposed as a gauge; always use `increase`), `kafka_server_socketservermetrics_successful_authentication`, `kafka_server_socketservermetrics_connection_count{listener}`.

**Capacity**
- `1 - node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}`; `predict_linear(node_filesystem_avail_bytes{mountpoint="/"}[6h], 86400)` (negative = full within 24 h).
- `kafka_log_logmanager_offlinelogdirectorycount` (must be 0).

## Rules

1. **Counters need `rate` or `increase`.** Series ending `_count`, `_total`, or `..._count` from `*persec` are cumulative.
2. **Use the exact names above.** If a query returns nothing, check the name with `list_metrics` (`filter_pattern`) before concluding "no data"; say whether the metric is missing or the value is simply zero.
3. **Broker id mapping:** a value in `kafka_topic_partition_leader` is a broker id, not a host. Map ids to hosts with `list_brokers` (cluster agent) or the `instance` label of the broker JMX series; do not guess.
4. Per-partition series are large. Aggregate (`sum by (topic)`, `topk`) unless asked for partitions.
5. Report numbers with units and the time window. Do not diagnose; give the evidence.
6. Load `response-citations` before finalizing; cite the tool, the PromQL and the range.
