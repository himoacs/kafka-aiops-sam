---
title: Consumer metrics
source_url: https://kafka.apache.org/42/operations/monitoring/
kafka_version: 4.2
source_path: content/en/42/generated/consumer_metrics.html
---

# Consumer metrics (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## bytes-consumed-rate

- **Description:** The average number of bytes consumed per second
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## bytes-consumed-total

- **Description:** The total number of bytes consumed
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-latency-avg

- **Description:** The average time taken for a fetch request.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-latency-max

- **Description:** The max time taken for any fetch request.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-rate

- **Description:** The number of fetch requests per second.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-size-avg

- **Description:** The average number of bytes fetched per request
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-size-max

- **Description:** The maximum number of bytes fetched per request
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-throttle-time-avg

- **Description:** The average throttle time in ms
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-throttle-time-max

- **Description:** The maximum throttle time in ms
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-total

- **Description:** The total number of fetch requests.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-consumed-rate

- **Description:** The average number of records consumed per second
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-consumed-total

- **Description:** The total number of records consumed
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lag-max

- **Description:** The maximum lag in terms of number of records for any partition in this window. NOTE: This is based on current offset and not committed offset
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lead-min

- **Description:** The minimum lead in terms of number of records for any partition in this window
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-per-request-avg

- **Description:** The average number of records in each request
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## bytes-consumed-rate

- **Description:** The average number of bytes consumed per second for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## bytes-consumed-total

- **Description:** The total number of bytes consumed for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-size-avg

- **Description:** The average number of bytes fetched per request for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## fetch-size-max

- **Description:** The maximum number of bytes fetched per request for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-consumed-rate

- **Description:** The average number of records consumed per second for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-consumed-total

- **Description:** The total number of records consumed for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-per-request-avg

- **Description:** The average number of records in each request for a topic. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## preferred-read-replica

- **Description:** The current read replica for the partition, or -1 if reading from leader. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lag

- **Description:** The latest lag of the partition. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lag-avg

- **Description:** The average lag of the partition. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lag-max

- **Description:** The max lag of the partition. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lead

- **Description:** The latest lead of the partition. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lead-avg

- **Description:** The average lead of the partition. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-lead-min

- **Description:** The min lead of the partition. Note: For topic names with periods (.), an additional metric with underscores is emitted. However, the periods replaced metric is deprecated. Please use the metric with actual topic name instead.
- **Mbean name:** kafka.consumer:type=consumer-fetch-manager-metrics,partition="{partition}",topic="{topic}",client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/
