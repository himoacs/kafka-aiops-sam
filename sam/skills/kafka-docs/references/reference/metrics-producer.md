---
title: Producer metrics
source_url: https://kafka.apache.org/42/operations/monitoring/
kafka_version: 4.2
source_path: content/en/42/generated/producer_metrics.html
---

# Producer metrics (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## batch-size-avg

- **Description:** The average number of bytes sent per partition per-request.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## batch-size-max

- **Description:** The max number of bytes sent per partition per-request.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## batch-split-rate

- **Description:** The average number of batch splits per second
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## batch-split-total

- **Description:** The total number of batch splits
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## compression-rate-avg

- **Description:** The average compression rate of record batches, defined as the average ratio of the compressed batch size over the uncompressed size.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## metadata-age

- **Description:** The age in seconds of the current producer metadata being used.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## produce-throttle-time-avg

- **Description:** The average time in ms a request was throttled by a broker
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## produce-throttle-time-max

- **Description:** The maximum time in ms a request was throttled by a broker
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-error-rate

- **Description:** The average per-second number of record sends that resulted in errors
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-error-total

- **Description:** The total number of record sends that resulted in errors
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-queue-time-avg

- **Description:** The average time in ms record batches spent in the send buffer.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-queue-time-max

- **Description:** The maximum time in ms record batches spent in the send buffer.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-retry-rate

- **Description:** The average per-second number of retried record sends
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-retry-total

- **Description:** The total number of retried record sends
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-send-rate

- **Description:** The average number of records sent per second.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-send-total

- **Description:** The total number of records sent.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-size-avg

- **Description:** The average record size
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-size-max

- **Description:** The maximum record size
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## records-per-request-avg

- **Description:** The average number of records per request.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## request-latency-avg

- **Description:** The average request latency in ms
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## request-latency-max

- **Description:** The maximum request latency in ms
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## requests-in-flight

- **Description:** The current number of in-flight requests awaiting a response.
- **Mbean name:** kafka.producer:type=producer-metrics,client-id="{client-id}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## byte-rate

- **Description:** The average number of bytes sent per second for a topic.
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## byte-total

- **Description:** The total number of bytes sent for a topic.
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## compression-rate

- **Description:** The average compression rate of record batches for a topic, defined as the average ratio of the compressed batch size over the uncompressed size.
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-error-rate

- **Description:** The average per-second number of record sends that resulted in errors for a topic
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-error-total

- **Description:** The total number of record sends that resulted in errors for a topic
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-retry-rate

- **Description:** The average per-second number of retried record sends for a topic
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-retry-total

- **Description:** The total number of retried record sends for a topic
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-send-rate

- **Description:** The average number of records sent per second for a topic.
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## record-send-total

- **Description:** The total number of records sent for a topic.
- **Mbean name:** kafka.producer:type=producer-topic-metrics,client-id="{client-id}",topic="{topic}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/
