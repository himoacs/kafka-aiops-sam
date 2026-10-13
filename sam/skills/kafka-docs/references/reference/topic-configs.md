---
title: Topic configs
source_url: https://kafka.apache.org/42/configuration/topic-configs/
kafka_version: 4.2
source_path: content/en/42/generated/topic_config.html
---

# Topic configs (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## cleanup.policy

This config designates the retention policy to use on log segments. The "delete" policy (which is the default) will discard old segments when their retention time or size limit has been reached. The "compact" policy will enable log compaction, which retains the latest value for each key. It is also possible to specify both policies in a comma-separated list (e.g. "delete,compact"). In this case, old segments will be discarded per the retention time and size configuration, while retained segments will be compacted. An empty list means infinite retention - no cleanup policies will be applied and log segments will be retained indefinitely. Note that with remote storage enabled, local retention limits (log.local.retention.ms and log.local.retention.bytes) are still applied to local segments.

- **Type:** list
- **Default:** delete
- **Valid Values:** [compact, delete]
- **Server Default Property:** log.cleanup.policy
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_cleanup.policy

## compression.gzip.level

The compression level to use if compression.type is set to `gzip`.

- **Type:** int
- **Default:** -1
- **Valid Values:** [1,...,9] or -1
- **Server Default Property:** compression.gzip.level
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_compression.gzip.level

## compression.lz4.level

The compression level to use if compression.type is set to `lz4`.

- **Type:** int
- **Default:** 9
- **Valid Values:** [1,...,17]
- **Server Default Property:** compression.lz4.level
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_compression.lz4.level

## compression.type

Specify the final compression type for a given topic. This configuration accepts the standard compression codecs ('gzip', 'snappy', 'lz4', 'zstd'). It additionally accepts 'uncompressed' which is equivalent to no compression; and 'producer' which means retain the original compression codec set by the producer.

- **Type:** string
- **Default:** producer
- **Valid Values:** [uncompressed, zstd, lz4, snappy, gzip, producer]
- **Server Default Property:** compression.type
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_compression.type

## compression.zstd.level

The compression level to use if compression.type is set to `zstd`.

- **Type:** int
- **Default:** 3
- **Valid Values:** [-131072,...,22]
- **Server Default Property:** compression.zstd.level
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_compression.zstd.level

## delete.retention.ms

The amount of time to retain delete tombstone markers for log compacted topics. This setting also gives a bound on the time in which a consumer must complete a read if they begin from offset 0 to ensure that they get a valid snapshot of the final stage (otherwise delete tombstones may be collected before they complete their scan).

- **Type:** long
- **Default:** 86400000 (1 day)
- **Valid Values:** [0,...]
- **Server Default Property:** log.cleaner.delete.retention.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_delete.retention.ms

## file.delete.delay.ms

The time to wait before deleting a file from the filesystem

- **Type:** long
- **Default:** 60000 (1 minute)
- **Valid Values:** [0,...]
- **Server Default Property:** log.segment.delete.delay.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_file.delete.delay.ms

## flush.messages

This setting allows specifying an interval at which we will force an fsync of data written to the log. For example if this was set to 1 we would fsync after every message; if it were 5 we would fsync after every five messages. In general we recommend you not set this and use replication for durability and allow the operating system's background flush capabilities as it is more efficient. This setting can be overridden on a per-topic basis (see the per-topic configuration section).

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Server Default Property:** log.flush.interval.messages
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_flush.messages

## flush.ms

This setting allows specifying a time interval at which we will force an fsync of data written to the log. For example if this was set to 1000 we would fsync after 1000 ms had passed. Note that this setting depends on the broker-level configuration `log.flush.scheduler.interval.ms`, which controls how frequently the flush check occurs. In general we recommend you not set this and use replication for durability and allow the operating system's background flush capabilities as it is more efficient.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [0,...]
- **Server Default Property:** log.flush.interval.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_flush.ms

## follower.replication.throttled.replicas

A list of replicas for which log replication should be throttled on the follower side. The list should describe a set of replicas in the form [PartitionId]:[BrokerId],[PartitionId]:[BrokerId]:... or alternatively the wildcard '*' can be used to throttle all replicas for this topic.

- **Type:** list
- **Default:** ""
- **Valid Values:** [partitionId]:[brokerId],[partitionId]:[brokerId],...
- **Server Default Property:** null
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_follower.replication.throttled.replicas

## index.interval.bytes

This setting controls how frequently Kafka adds entries to its offset index and, conditionally, to its time index. The default setting ensures that we index a message roughly every 4096 bytes. More frequent indexing allows reads to jump closer to the exact position in the log but results in larger index files. You probably don't need to change this.

Note: the time index will be inserted only when the timestamp is greater than the last indexed timestamp.

- **Type:** int
- **Default:** 4096 (4 kibibytes)
- **Valid Values:** [0,...]
- **Server Default Property:** log.index.interval.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_index.interval.bytes

## leader.replication.throttled.replicas

A list of replicas for which log replication should be throttled on the leader side. The list should describe a set of replicas in the form [PartitionId]:[BrokerId],[PartitionId]:[BrokerId]:... or alternatively the wildcard '*' can be used to throttle all replicas for this topic.

- **Type:** list
- **Default:** ""
- **Valid Values:** [partitionId]:[brokerId],[partitionId]:[brokerId],...
- **Server Default Property:** null
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_leader.replication.throttled.replicas

## local.retention.bytes

The maximum size of local log segments that can grow for a partition before it deletes the old segments. Default value is -2, it represents `retention.bytes` value to be used. The effective value should always be less than or equal to `retention.bytes` value.

- **Type:** long
- **Default:** -2
- **Valid Values:** [-2,...]
- **Server Default Property:** log.local.retention.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_local.retention.bytes

## local.retention.ms

The number of milliseconds to keep the local log segment before it gets deleted. Default value is -2, it represents `retention.ms` value is to be used. The effective value should always be less than or equal to `retention.ms` value.

- **Type:** long
- **Default:** -2
- **Valid Values:** [-2,...]
- **Server Default Property:** log.local.retention.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_local.retention.ms

## max.compaction.lag.ms

The maximum time a message will remain ineligible for compaction in the log. Only applicable for logs that are being compacted.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Server Default Property:** log.cleaner.max.compaction.lag.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_max.compaction.lag.ms

## max.decompressed.message.bytes

The maximum decompressed size, in bytes, of a single record the broker will accept; larger records are rejected with an `InvalidRecordException`. It is enforced where the broker decompresses records: produce validation of compressed batches, log compaction, and offset lookups by timestamp or max timestamp against the local log or remote storage. Unlike `max.message.bytes`, which bounds the compressed batch on the wire, this bounds the decompressed size of an individual record. Lowering it below the size of already-stored records makes compaction and timestamp offset lookups of affected partitions fail until it is raised again. The default imposes no limit beyond the largest record the broker could allocate anyway; set a smaller value to enforce a per-record cap.

- **Type:** int
- **Default:** 2147483639
- **Valid Values:** [1,...,2147483639]
- **Server Default Property:** max.decompressed.message.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_max.decompressed.message.bytes

## max.message.bytes

The largest record batch size allowed by Kafka (after compression if compression is enabled).

- **Type:** int
- **Default:** 1048588
- **Valid Values:** [0,...]
- **Server Default Property:** message.max.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_max.message.bytes

## message.timestamp.after.max.ms

This configuration sets the allowable timestamp difference between the message timestamp and the broker's timestamp. The message timestamp can be later than or equal to the broker's timestamp, with the maximum allowable difference determined by the value set in this configuration. If message.timestamp.type=CreateTime, the message will be rejected if the difference in timestamps exceeds this specified threshold. This configuration is ignored if message.timestamp.type=LogAppendTime.

- **Type:** long
- **Default:** 3600000 (1 hour)
- **Valid Values:** [0,...]
- **Server Default Property:** log.message.timestamp.after.max.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_message.timestamp.after.max.ms

## message.timestamp.before.max.ms

This configuration sets the allowable timestamp difference between the broker's timestamp and the message timestamp. The message timestamp can be earlier than or equal to the broker's timestamp, with the maximum allowable difference determined by the value set in this configuration. If message.timestamp.type=CreateTime, the message will be rejected if the difference in timestamps exceeds this specified threshold. This configuration is ignored if message.timestamp.type=LogAppendTime.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [0,...]
- **Server Default Property:** log.message.timestamp.before.max.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_message.timestamp.before.max.ms

## message.timestamp.type

Define whether the timestamp in the message is message create time or log append time.

- **Type:** string
- **Default:** CreateTime
- **Valid Values:** [CreateTime, LogAppendTime]
- **Server Default Property:** log.message.timestamp.type
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_message.timestamp.type

## min.cleanable.dirty.ratio

This configuration controls how frequently the log compactor will attempt to clean the log (assuming log compaction is enabled). By default we will avoid cleaning a log where more than 50% of the log has been compacted. This ratio bounds the maximum space wasted in the log by duplicates (at 50% at most 50% of the log could be duplicates). A higher ratio will mean fewer, more efficient cleanings but will mean more wasted space in the log. If the max.compaction.lag.ms or the min.compaction.lag.ms configurations are also specified, then the log compactor considers the log to be eligible for compaction as soon as either: (i) the dirty ratio threshold has been met and the log has had dirty (uncompacted) records for at least the min.compaction.lag.ms duration, or (ii) if the log has had dirty (uncompacted) records for at most the max.compaction.lag.ms period.

- **Type:** double
- **Default:** 0.5
- **Valid Values:** [0,...,1]
- **Server Default Property:** log.cleaner.min.cleanable.ratio
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.cleanable.dirty.ratio

## min.compaction.lag.ms

The minimum time a message will remain uncompacted in the log. Only applicable for logs that are being compacted.

- **Type:** long
- **Default:** 0
- **Valid Values:** [0,...]
- **Server Default Property:** log.cleaner.min.compaction.lag.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.compaction.lag.ms

## min.insync.replicas

Specifies the minimum number of in-sync replicas (including the leader) required for a write to succeed when a producer sets `acks` to "all" (or "-1"). In the `acks=all` case, every in-sync replica must acknowledge a write for it to be considered successful. E.g., if a topic has `replication.factor` of 3 and the ISR set includes all three replicas, then all three replicas must acknowledge an `acks=all` write for it to succeed, even if `min.insync.replicas` happens to be less than 3. If `acks=all` and the current ISR set contains fewer than `min.insync.replicas` members, then the producer will raise an exception (either `NotEnoughReplicas` or `NotEnoughReplicasAfterAppend`).
Regardless of the `acks` setting, the messages will not be visible to the consumers until they are replicated to all in-sync replicas and the `min.insync.replicas` condition is met.
When used together, `min.insync.replicas` and `acks` allow you to enforce greater durability guarantees. A typical scenario would be to create a topic with a replication factor of 3, set `min.insync.replicas` to 2, and produce with `acks` of "all". This ensures that a majority of replicas must persist a write before it's considered successful by the producer and it's visible to consumers.

Note that when the Eligible Leader Replicas feature is enabled, the semantics of this config changes. Please refer to the ELR section for more info.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Server Default Property:** min.insync.replicas
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.insync.replicas

## preallocate

True if we should preallocate the file on disk when creating a new log segment.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Server Default Property:** log.preallocate
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_preallocate

## remote.log.copy.disable

Determines whether tiered data for a topic should become read only, and no more data uploading on a topic. Once this config is set to true, the local retention configuration (i.e. local.retention.ms/bytes) becomes irrelevant, and all data expiration follows the topic-wide retention configuration(i.e. retention.ms/bytes).

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Server Default Property:** null
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_remote.log.copy.disable

## remote.log.delete.on.disable

Determines whether tiered data for a topic should be deleted after tiered storage is disabled on a topic. This configuration should be enabled when trying to set `remote.storage.enable` from true to false

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Server Default Property:** null
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_remote.log.delete.on.disable

## remote.storage.enable

To enable tiered storage for a topic, set this configuration to true. To disable tiered storage for a topic that has it enabled, set this configuration to false. When disabling, you must also set `remote.log.delete.on.disable` to true.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Server Default Property:** null
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_remote.storage.enable

## retention.bytes

This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy. By default there is no size limit only a time limit. Since this limit is enforced at the partition level, multiply it by the number of partitions to compute the topic retention in bytes. Additionally, retention.bytes configuration operates independently of "segment.ms" and "segment.bytes" configurations. Moreover, it triggers the rolling of new segment if the retention.bytes is configured to zero.

- **Type:** long
- **Default:** -1
- **Valid Values:** (empty)
- **Server Default Property:** log.retention.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_retention.bytes

## retention.ms

This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy. This represents an SLA on how soon consumers must read their data. If set to -1, no time limit is applied. Additionally, retention.ms configuration operates independently of "segment.ms" and "segment.bytes" configurations. Moreover, it triggers the rolling of new segment if the retention.ms condition is satisfied.

- **Type:** long
- **Default:** 604800000 (7 days)
- **Valid Values:** [-1,...]
- **Server Default Property:** log.retention.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_retention.ms

## segment.bytes

This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.

- **Type:** int
- **Default:** 1073741824 (1 gibibyte)
- **Valid Values:** [1048576,...]
- **Server Default Property:** log.segment.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_segment.bytes

## segment.index.bytes

This configuration controls the size of the index that maps offsets to file positions. We preallocate this index file and shrink it only after log rolls. You generally should not need to change this setting.

- **Type:** int
- **Default:** 10485760 (10 mebibytes)
- **Valid Values:** [4,...]
- **Server Default Property:** log.index.size.max.bytes
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_segment.index.bytes

## segment.jitter.ms

The maximum random jitter subtracted from the scheduled segment roll time to avoid thundering herds of segment rolling

- **Type:** long
- **Default:** 0
- **Valid Values:** [0,...]
- **Server Default Property:** log.roll.jitter.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_segment.jitter.ms

## segment.ms

This configuration controls the period of time after which Kafka will force the log to roll even if the segment file isn't full to ensure that retention can delete or compact old data.

- **Type:** long
- **Default:** 604800000 (7 days)
- **Valid Values:** [1,...]
- **Server Default Property:** log.roll.ms
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_segment.ms

## unclean.leader.election.enable

Indicates whether to enable replicas not in the ISR set to be elected as leader as a last resort, even though doing so may result in data loss.

Note: In KRaft mode, when enabling this config dynamically, it needs to wait for the unclean leader electionthread to trigger election periodically (default is 5 minutes). Please run `kafka-leader-election.sh` with `unclean` option to trigger the unclean leader election immediately if needed.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Server Default Property:** unclean.leader.election.enable
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_unclean.leader.election.enable
