---
title: Group configs
source_url: https://kafka.apache.org/42/configuration/group-configs/
kafka_version: 4.2
source_path: content/en/42/generated/group_config.html
---

# Group configs (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## consumer.heartbeat.interval.ms

The heartbeat interval given to the members of a consumer group.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_consumer.heartbeat.interval.ms

## consumer.session.timeout.ms

The timeout to detect client failures when using the consumer group protocol.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_consumer.session.timeout.ms

## share.auto.offset.reset



- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_share.auto.offset.reset

## share.heartbeat.interval.ms

The heartbeat interval given to the members of a share group.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_share.heartbeat.interval.ms

## share.isolation.level

Controls how to read records written transactionally. If set to "read_committed", the share group will only deliver transactional records which have been committed. If set to "read_uncommitted", the share group will return all messages, even transactional messages which have been aborted. Non-transactional records will be returned unconditionally in either mode.

- **Type:** string
- **Default:** read_uncommitted
- **Valid Values:** [read_committed, read_uncommitted]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_share.isolation.level

## share.record.lock.duration.ms

The record acquisition lock duration in milliseconds for share groups.

- **Type:** int
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1000,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_share.record.lock.duration.ms

## share.session.timeout.ms

The timeout to detect client failures when using the share group protocol.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_share.session.timeout.ms

## streams.heartbeat.interval.ms

The heartbeat interval given to the members.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_streams.heartbeat.interval.ms

## streams.initial.rebalance.delay.ms

The amount of time the group coordinator will wait for more streams clients to join a new group before performing the first rebalance. A longer delay means potentially fewer rebalances.

- **Type:** int
- **Default:** 3000 (3 seconds)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_streams.initial.rebalance.delay.ms

## streams.num.standby.replicas

The number of standby replicas for each task.

- **Type:** int
- **Default:** 0
- **Valid Values:** [0,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_streams.num.standby.replicas

## streams.session.timeout.ms

The timeout to detect client failures when using the streams group protocol.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/group-configs/#groupconfigs_streams.session.timeout.ms
