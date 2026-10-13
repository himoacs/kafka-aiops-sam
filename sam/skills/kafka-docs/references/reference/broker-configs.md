---
title: Broker configs
source_url: https://kafka.apache.org/42/configuration/broker-configs/
kafka_version: 4.2
source_path: content/en/42/generated/kafka_config.html
---

# Broker configs (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## controller.listener.names

A comma-separated list of the names of the listeners used by the controller. This is required when communicating with the controller quorum, the broker will always use the first listener in this list.

- **Type:** list
- **Default:** (empty)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.listener.names

## node.id

The node ID associated with the roles this process is playing when `process.roles` is non-empty. This is required configuration when running in KRaft mode.

- **Type:** int
- **Default:** (empty)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_node.id

## process.roles

The roles that this process plays: 'broker', 'controller', or 'broker,controller' if it is both.

- **Type:** list
- **Default:** (empty)
- **Valid Values:** [broker, controller]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_process.roles

## add.partitions.to.txn.retry.backoff.max.ms

The maximum allowed timeout for adding partitions to transactions on the server side. It only applies to the actual add partition operations, not the verification. It will not be effective if it is larger than request.timeout.ms

- **Type:** int
- **Default:** 100
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_add.partitions.to.txn.retry.backoff.max.ms

## add.partitions.to.txn.retry.backoff.ms

The server-side retry backoff when the server attemptsto add the partition to the transaction

- **Type:** int
- **Default:** 20
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_add.partitions.to.txn.retry.backoff.ms

## advertised.listeners

Specifies the listener addresses that the Kafka brokers will advertise to clients and other brokers. The config is useful where the actual listener configuration `listeners` does not represent the addresses that clients should use to connect, such as in cloud environments. The addresses are published to and managed by the controller, the brokers pull these data from the controller as needed. In IaaS environments, this may need to be different from the interface to which the broker binds. If this is not set, the value for `listeners` will be used. Unlike `listeners`, it is not valid to advertise the 0.0.0.0 meta-address.
Also unlike `listeners`, there can be duplicated ports in this property, so that one listener can be configured to advertise another listener's address. This can be useful in some cases where external load balancers are used.

- **Type:** list
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_advertised.listeners

## auto.create.topics.enable

Enable auto creation of topic on the server.

- **Type:** boolean
- **Default:** true
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_auto.create.topics.enable

## auto.leader.rebalance.enable

Enables auto leader balancing. A background thread checks the distribution of partition leaders at regular intervals, configurable by leader.imbalance.check.interval.seconds. If the leader is imbalanced, leader rebalance to the preferred leader for partitions is triggered.

- **Type:** boolean
- **Default:** true
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_auto.leader.rebalance.enable

## background.threads

The number of threads to use for various background processing tasks

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_background.threads

## broker.id

The broker id for this server.

- **Type:** int
- **Default:** -1
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_broker.id

## compression.type

Specify the final compression type for a given topic. This configuration accepts the standard compression codecs ('gzip', 'snappy', 'lz4', 'zstd'). It additionally accepts 'uncompressed' which is equivalent to no compression; and 'producer' which means retain the original compression codec set by the producer.

- **Type:** string
- **Default:** producer
- **Valid Values:** [uncompressed, zstd, lz4, snappy, gzip, producer]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_compression.type

## controller.quorum.bootstrap.servers

List of endpoints to use for bootstrapping the cluster metadata. The endpoints are specified in comma-separated list of `{host}:{port}` entries. For example: `localhost:9092,localhost:9093,localhost:9094`.

- **Type:** list
- **Default:** ""
- **Valid Values:** non-empty list
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.bootstrap.servers

## controller.quorum.election.backoff.max.ms

Maximum time in milliseconds before starting new elections. This is used in the binary exponential backoff mechanism that helps prevent gridlocked elections

- **Type:** int
- **Default:** 1000 (1 second)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.election.backoff.max.ms

## controller.quorum.election.timeout.ms

Maximum time in milliseconds to wait without being able to fetch from the leader before triggering a new election

- **Type:** int
- **Default:** 1000 (1 second)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.election.timeout.ms

## controller.quorum.fetch.timeout.ms

Maximum time without a successful fetch from the current leader before becoming a candidate and triggering an election for voters; Maximum time a leader can go without receiving valid fetch or fetchSnapshot request from a majority of the quorum before resigning.

- **Type:** int
- **Default:** 2000 (2 seconds)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.fetch.timeout.ms

## controller.quorum.voters

Map of id/endpoint information for the set of voters in a comma-separated list of `{id}@{host}:{port}` entries. This is the old way of defining membership for controller quorums and should NOT be set if using dynamic quorums. Instead, controller.quorum.bootstrap.servers should be set,and the voter set is determined by the --standalone or --initial-controllers flags when formatting.For example: `1@localhost:9092,2@localhost:9093,3@localhost:9094`

- **Type:** list
- **Default:** ""
- **Valid Values:** non-empty list
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.voters

## delete.topic.enable

When set to true, topics can be deleted by the admin client. When set to false, deletion requests will be explicitly rejected by the broker.

- **Type:** boolean
- **Default:** true
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_delete.topic.enable

## early.start.listeners

A comma-separated list of listener names which may be started before the authorizer has finished initialization. This is useful when the authorizer is dependent on the cluster itself for bootstrapping, as is the case for the StandardAuthorizer (which stores ACLs in the metadata log.) By default, all listeners included in controller.listener.names will also be early start listeners. A listener should not appear in this list if it accepts external traffic.

- **Type:** list
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_early.start.listeners

## group.coordinator.threads

The number of threads used by the group coordinator.

- **Type:** int
- **Default:** 4
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.coordinator.threads

## leader.imbalance.check.interval.seconds

The frequency with which the partition rebalance check is triggered by the controller

- **Type:** long
- **Default:** 300
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_leader.imbalance.check.interval.seconds

## listeners

Listener List - Comma-separated list of URIs we will listen on and the listener names. If the listener name is not a security protocol, `listener.security.protocol.map` must also be set.
Listener names and port numbers must be unique unless one listener is an IPv4 address and the other listener is an IPv6 address (for the same port).
Specify hostname as 0.0.0.0 to bind to all interfaces.
Leave hostname empty to bind to default interface.
Examples of legal listener lists:
`PLAINTEXT://myhost:9092,SSL://:9091`
`CLIENT://0.0.0.0:9092,REPLICATION://localhost:9093`
`PLAINTEXT://127.0.0.1:9092,SSL://[::1]:9092`

- **Type:** list
- **Default:** PLAINTEXT://:9092
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_listeners

## log.dir

A comma-separated list of the directories where the log data is stored. (supplemental to log.dirs property)

- **Type:** list
- **Default:** /tmp/kafka-logs
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.dir

## log.dirs

A comma-separated list of the directories where the log data is stored. If not set, the value in log.dir is used.

- **Type:** list
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.dirs

## log.flush.interval.messages

The number of messages accumulated on a log partition before messages are flushed to disk.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.interval.messages

## log.flush.interval.ms

The maximum time in ms that a message in any topic is kept in memory before flushed to disk. If not set, the value in log.flush.scheduler.interval.ms is used

- **Type:** long
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.interval.ms

## log.flush.offset.checkpoint.interval.ms

The frequency with which we update the persistent record of the last flush which acts as the log recovery point.

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.offset.checkpoint.interval.ms

## log.flush.scheduler.interval.ms

The frequency in ms that the log flusher checks whether any log needs to be flushed to disk

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.scheduler.interval.ms

## log.flush.start.offset.checkpoint.interval.ms

The frequency with which we update the persistent record of log start offset

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.start.offset.checkpoint.interval.ms

## log.retention.bytes

The maximum size of the log before deleting it

- **Type:** long
- **Default:** -1
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.bytes

## log.retention.hours

The number of hours to keep a log file before deleting it (in hours), tertiary to log.retention.ms property

- **Type:** int
- **Default:** 168
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.hours

## log.retention.minutes

The number of minutes to keep a log file before deleting it (in minutes), secondary to log.retention.ms property. If not set, the value in log.retention.hours is used

- **Type:** int
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.minutes

## log.retention.ms

The number of milliseconds to keep a log file before deleting it (in milliseconds), If not set, the value in log.retention.minutes is used. If set to -1, no time limit is applied.

- **Type:** long
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.ms

## log.roll.hours

The maximum time before a new log segment is rolled out (in hours), secondary to log.roll.ms property

- **Type:** int
- **Default:** 168
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.roll.hours

## log.roll.jitter.hours

The maximum jitter to subtract from logRollTimeMillis (in hours), secondary to log.roll.jitter.ms property

- **Type:** int
- **Default:** 0
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.roll.jitter.hours

## log.roll.jitter.ms

The maximum jitter to subtract from logRollTimeMillis (in milliseconds). If not set, the value in log.roll.jitter.hours is used

- **Type:** long
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.roll.jitter.ms

## log.roll.ms

The maximum time before a new log segment is rolled out (in milliseconds). If not set, the value in log.roll.hours is used

- **Type:** long
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.roll.ms

## log.segment.bytes

The maximum size of a single log file

- **Type:** int
- **Default:** 1073741824 (1 gibibyte)
- **Valid Values:** [1048576,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.segment.bytes

## log.segment.delete.delay.ms

The amount of time to wait before deleting a file from the filesystem. If the value is 0 and there is no file to delete, the system will wait 1 millisecond. Low value will cause busy waiting

- **Type:** long
- **Default:** 60000 (1 minute)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.segment.delete.delay.ms

## message.max.bytes

The largest record batch size allowed by Kafka (after compression if compression is enabled).This can be set per topic with the topic level `max.message.bytes` config.

- **Type:** int
- **Default:** 1048588
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_message.max.bytes

## metadata.log.dir

This configuration determines where we put the metadata log. If it is not set, the metadata log is placed in the first log directory from log.dirs.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.log.dir

## metadata.log.max.record.bytes.between.snapshots

This is the maximum number of bytes in the log between the latest snapshot and the high-watermark needed before generating a new snapshot. The default value is 20971520. To generate snapshots based on the time elapsed, see the `metadata.log.max.snapshot.interval.ms` configuration. The Kafka node will generate a snapshot when either the maximum time interval is reached or the maximum bytes limit is reached.

- **Type:** long
- **Default:** 20971520
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.log.max.record.bytes.between.snapshots

## metadata.log.max.snapshot.interval.ms

This is the maximum number of milliseconds to wait to generate a snapshot if there are committed records in the log that are not included in the latest snapshot. A value of zero disables time based snapshot generation. The default value is 3600000. To generate snapshots based on the number of metadata bytes, see the `metadata.log.max.record.bytes.between.snapshots` configuration. The Kafka node will generate a snapshot when either the maximum time interval is reached or the maximum bytes limit is reached.

- **Type:** long
- **Default:** 3600000 (1 hour)
- **Valid Values:** [0,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.log.max.snapshot.interval.ms

## metadata.log.segment.bytes

The maximum size of a single metadata log file.

- **Type:** int
- **Default:** 1073741824 (1 gibibyte)
- **Valid Values:** [8388608,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.log.segment.bytes

## metadata.log.segment.ms

The maximum time before a new metadata log file is rolled out (in milliseconds).

- **Type:** long
- **Default:** 604800000 (7 days)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.log.segment.ms

## metadata.max.retention.bytes

The maximum combined size of the metadata log and snapshots before deleting old snapshots and log files. Since at least one snapshot must exist before any logs can be deleted, this is a soft limit.

- **Type:** long
- **Default:** 104857600 (100 mebibytes)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.max.retention.bytes

## metadata.max.retention.ms

The number of milliseconds to keep a metadata log file or snapshot before deleting it. Since at least one snapshot must exist before any logs can be deleted, this is a soft limit.

- **Type:** long
- **Default:** 604800000 (7 days)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.max.retention.ms

## min.insync.replicas

Specifies the minimum number of in-sync replicas (including the leader) required for a write to succeed when a producer sets `acks` to "all" (or "-1"). In the `acks=all` case, every in-sync replica must acknowledge a write for it to be considered successful. E.g., if a topic has `replication.factor` of 3 and the ISR set includes all three replicas, then all three replicas must acknowledge an `acks=all` write for it to succeed, even if `min.insync.replicas` happens to be less than 3. If `acks=all` and the current ISR set contains fewer than `min.insync.replicas` members, then the producer will raise an exception (either `NotEnoughReplicas` or `NotEnoughReplicasAfterAppend`).
Regardless of the `acks` setting, the messages will not be visible to the consumers until they are replicated to all in-sync replicas and the `min.insync.replicas` condition is met.
When used together, `min.insync.replicas` and `acks` allow you to enforce greater durability guarantees. A typical scenario would be to create a topic with a replication factor of 3, set `min.insync.replicas` to 2, and produce with `acks` of "all". This ensures that a majority of replicas must persist a write before it's considered successful by the producer and it's visible to consumers.

Note that when the Eligible Leader Replicas feature is enabled, the semantics of this config changes. Please refer to the ELR section for more info.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_min.insync.replicas

## num.io.threads

The number of threads that the server uses for processing requests, which may include disk I/O

- **Type:** int
- **Default:** 8
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.io.threads

## num.network.threads

The number of threads that the server uses for receiving requests from the network and sending responses to the network. Noted: each listener (except for controller listener) creates its own thread pool.

- **Type:** int
- **Default:** 3
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.network.threads

## num.recovery.threads.per.data.dir

The number of threads per data directory to be used for log recovery at startup and flushing at shutdown

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.recovery.threads.per.data.dir

## num.replica.alter.log.dirs.threads

The number of threads that can move replicas between log directories, which may include disk I/O. The default value is equal to the number of directories specified in the `log.dir` or `log.dirs` configuration property.

- **Type:** int
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.replica.alter.log.dirs.threads

## num.replica.fetchers

Number of fetcher threads used to replicate records from each source broker. The total number of fetchers on each broker is bound by `num.replica.fetchers` multiplied by the number of brokers in the cluster.Increasing this value can increase the degree of I/O parallelism in the follower and leader broker at the cost of higher CPU and memory utilization.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.replica.fetchers

## offset.metadata.max.bytes

The maximum size for a metadata entry associated with an offset commit.

- **Type:** int
- **Default:** 4096 (4 kibibytes)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offset.metadata.max.bytes

## offsets.commit.timeout.ms

Offset commit will be delayed until all replicas for the offsets topic receive the commit or this timeout is reached. This is similar to the producer request timeout. This is applied to all the writes made by the coordinator.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.commit.timeout.ms

## offsets.load.buffer.size

Batch size for reading from the offsets segments when loading group metadata into the cache (soft-limit, overridden if records are too large).

- **Type:** int
- **Default:** 5242880
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.load.buffer.size

## offsets.retention.check.interval.ms

Frequency at which to check for stale offsets

- **Type:** long
- **Default:** 600000 (10 minutes)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.retention.check.interval.ms

## offsets.retention.minutes

For subscribed consumers, committed offset of a specific partition will be expired and discarded when 1) this retention period has elapsed after the consumer group loses all its consumers (i.e. becomes empty); 2) this retention period has elapsed since the last time an offset is committed for the partition and the group is no longer subscribed to the corresponding topic. For standalone consumers (using manual assignment), offsets will be expired after this retention period has elapsed since the time of last commit. Note that when a group is deleted via the delete-group request, its committed offsets will also be deleted without extra retention period; also when a topic is deleted via the delete-topic request, upon propagated metadata update any group's committed offsets for that topic will also be deleted without extra retention period.

- **Type:** int
- **Default:** 10080
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.retention.minutes

## offsets.topic.compression.codec

Compression codec for the offsets topic - compression may be used to achieve "atomic" commits.

- **Type:** int
- **Default:** 0
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.topic.compression.codec

## offsets.topic.num.partitions

The number of partitions for the offset commit topic (should not change after deployment).

- **Type:** int
- **Default:** 50
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.topic.num.partitions

## offsets.topic.replication.factor

The replication factor for the offsets topic (set higher to ensure availability). Internal topic creation will fail until the cluster size meets this replication factor requirement.

- **Type:** short
- **Default:** 3
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.topic.replication.factor

## offsets.topic.segment.bytes

The offsets topic segment bytes should be kept relatively small in order to facilitate faster log compaction and cache loads.

- **Type:** int
- **Default:** 104857600 (100 mebibytes)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.topic.segment.bytes

## queued.max.requests

The number of queued requests allowed for data-plane, before blocking the network threads

- **Type:** int
- **Default:** 500
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_queued.max.requests

## replica.fetch.min.bytes

Minimum bytes expected for each fetch response. If not enough bytes, wait up to `replica.fetch.wait.max.ms` (broker config). Even if the total data available in the broker exceeds replica.fetch.min.bytes, the actual returned size may still be less than this value due to per-partition limits replica.fetch.max.bytes and max returned limits replica.fetch.response.max.bytes

- **Type:** int
- **Default:** 1
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.min.bytes

## replica.fetch.wait.max.ms

The maximum wait time for each fetcher request issued by follower replicas. This value should always be less than the replica.lag.time.max.ms at all times to prevent frequent shrinking of ISR for low throughput topics

- **Type:** int
- **Default:** 500
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.wait.max.ms

## replica.high.watermark.checkpoint.interval.ms

The frequency with which the high watermark is saved out to disk

- **Type:** long
- **Default:** 5000 (5 seconds)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.high.watermark.checkpoint.interval.ms

## replica.lag.time.max.ms

If a follower hasn't sent any fetch requests or hasn't consumed up to the leader's log end offset for at least this time, the leader will remove the follower from ISR

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.lag.time.max.ms

## replica.socket.receive.buffer.bytes

The socket receive buffer for network requests to the leader for replicating data

- **Type:** int
- **Default:** 65536 (64 kibibytes)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.socket.receive.buffer.bytes

## replica.socket.timeout.ms

The socket timeout for network requests. Its value should be at least replica.fetch.wait.max.ms

- **Type:** int
- **Default:** 30000 (30 seconds)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.socket.timeout.ms

## request.timeout.ms

The configuration controls the maximum amount of time the client will wait for the response of a request. If the response is not received before the timeout elapses the client will resend the request if necessary or fail the request if retries are exhausted.

- **Type:** int
- **Default:** 30000 (30 seconds)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_request.timeout.ms

## sasl.mechanism.controller.protocol

SASL mechanism used for communication with controllers. Default is GSSAPI.

- **Type:** string
- **Default:** GSSAPI
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.mechanism.controller.protocol

## sasl.oauthbearer.expected.audience

The (strongly recommended) comma-delimited setting for the broker to use to verify that the JWT was issued for one of the expected audiences. The JWT will be inspected for the standard OAuth "aud" claim and if this value is set, the broker will match the value from JWT's "aud" claim to see if there is an exact match. If there is no match, the broker will reject the JWT and authentication will fail. If this value is not set, the broker will accept a token that has no "aud" claim, which is strongly discouraged.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.expected.audience

## sasl.oauthbearer.expected.issuer

The (strongly recommended) setting for the broker to use to verify that the JWT was created by the expected issuer. The JWT will be inspected for the standard OAuth "iss" claim and if this value is set, the broker will match it exactly against what is in the JWT's "iss" claim. If there is no match, the broker will reject the JWT and authentication will fail. If this value is not set, the broker will accept a JWT bearing any (or no) issuer, which is strongly discouraged.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.expected.issuer

## share.coordinator.load.buffer.size

Batch size for reading from the share-group state topic when loading state information into the cache (soft-limit, overridden if records are too large).

- **Type:** int
- **Default:** 5242880
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.load.buffer.size

## share.coordinator.state.topic.compression.codec

Compression codec for the share-group state topic.

- **Type:** int
- **Default:** 0
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.state.topic.compression.codec

## share.coordinator.state.topic.min.isr

Overridden min.insync.replicas for the share-group state topic.

- **Type:** short
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.state.topic.min.isr

## share.coordinator.state.topic.num.partitions

The number of partitions for the share-group state topic (should not change after deployment).

- **Type:** int
- **Default:** 50
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.state.topic.num.partitions

## share.coordinator.state.topic.replication.factor

Replication factor for the share-group state topic. Topic creation will fail until the cluster size meets this replication factor requirement.

- **Type:** short
- **Default:** 3
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.state.topic.replication.factor

## share.coordinator.state.topic.segment.bytes

The log segment size for the share-group state topic.

- **Type:** int
- **Default:** 104857600 (100 mebibytes)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.state.topic.segment.bytes

## share.coordinator.write.timeout.ms

The duration in milliseconds that the share coordinator will wait for all replicas of the share-group state topic to receive a write.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.write.timeout.ms

## socket.receive.buffer.bytes

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.

- **Type:** int
- **Default:** 102400 (100 kibibytes)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.receive.buffer.bytes

## socket.request.max.bytes

The maximum number of bytes in a socket request

- **Type:** int
- **Default:** 104857600 (100 mebibytes)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.request.max.bytes

## socket.send.buffer.bytes

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.

- **Type:** int
- **Default:** 102400 (100 kibibytes)
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.send.buffer.bytes

## transaction.max.timeout.ms

The maximum allowed timeout for transactions. If a client’s requested transaction time exceed this, then the broker will return an error in InitProducerIdRequest. This prevents a client from too large of a timeout, which can stall consumers reading from topics included in the transaction.

- **Type:** int
- **Default:** 900000 (15 minutes)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.max.timeout.ms

## transaction.state.log.load.buffer.size

Batch size for reading from the transaction log segments when loading producer ids and transactions into the cache (soft-limit, overridden if records are too large).

- **Type:** int
- **Default:** 5242880
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.state.log.load.buffer.size

## transaction.state.log.min.isr

The minimum number of replicas that must acknowledge a write to transaction topic in order to be considered successful.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.state.log.min.isr

## transaction.state.log.num.partitions

The number of partitions for the transaction topic (should not change after deployment).

- **Type:** int
- **Default:** 50
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.state.log.num.partitions

## transaction.state.log.replication.factor

The replication factor for the transaction topic (set higher to ensure availability). Internal topic creation will fail until the cluster size meets this replication factor requirement.

- **Type:** short
- **Default:** 3
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.state.log.replication.factor

## transaction.state.log.segment.bytes

The transaction topic segment bytes should be kept relatively small in order to facilitate faster log compaction and cache loads

- **Type:** int
- **Default:** 104857600 (100 mebibytes)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.state.log.segment.bytes

## transactional.id.expiration.ms

The time in ms that the transaction coordinator will wait without receiving any transaction status updates for the current transaction before expiring its transactional id. Transactional IDs will not expire while a the transaction is still ongoing.

- **Type:** int
- **Default:** 604800000 (7 days)
- **Valid Values:** [1,...]
- **Importance:** high
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transactional.id.expiration.ms

## unclean.leader.election.enable

Indicates whether to enable replicas not in the ISR set to be elected as leader as a last resort, even though doing so may result in data loss

Note: In KRaft mode, when enabling this config dynamically, it needs to wait for the unclean leader election thread to trigger election periodically (default is 5 minutes). Please run `kafka-leader-election.sh` with `unclean` option to trigger the unclean leader election immediately if needed.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** high
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_unclean.leader.election.enable

## broker.heartbeat.interval.ms

The length of time in milliseconds between broker heartbeats.

- **Type:** int
- **Default:** 2000 (2 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_broker.heartbeat.interval.ms

## broker.rack

Rack of the broker. This will be used in rack aware replication assignment for fault tolerance. Examples: `RACK1`, `us-east-1d`

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_broker.rack

## broker.session.timeout.ms

The length of time in milliseconds that a broker lease lasts if no heartbeats are made.

- **Type:** int
- **Default:** 9000 (9 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_broker.session.timeout.ms

## compression.gzip.level

The compression level to use if compression.type is set to 'gzip'.

- **Type:** int
- **Default:** -1
- **Valid Values:** [1,...,9] or -1
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_compression.gzip.level

## compression.lz4.level

The compression level to use if compression.type is set to 'lz4'.

- **Type:** int
- **Default:** 9
- **Valid Values:** [1,...,17]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_compression.lz4.level

## compression.zstd.level

The compression level to use if compression.type is set to 'zstd'.

- **Type:** int
- **Default:** 3
- **Valid Values:** [-131072,...,22]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_compression.zstd.level

## connections.max.idle.ms

Idle connections timeout: the server socket processor threads close the connections that idle more than this

- **Type:** long
- **Default:** 600000 (10 minutes)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_connections.max.idle.ms

## connections.max.reauth.ms

When explicitly set to a positive number (the default is 0, not a positive number), a session lifetime that will not exceed the configured value will be communicated to v2.2.0 or later clients when they authenticate. The broker will disconnect any such connection that is not re-authenticated within the session lifetime and that is then subsequently used for any purpose other than re-authentication. Configuration names can optionally be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.oauthbearer.connections.max.reauth.ms=3600000

- **Type:** long
- **Default:** 0
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_connections.max.reauth.ms

## controlled.shutdown.enable

Enable controlled shutdown of the server.

- **Type:** boolean
- **Default:** true
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controlled.shutdown.enable

## controller.quorum.append.linger.ms

The duration in milliseconds that the leader will wait for writes to accumulate before flushing them to disk.

- **Type:** int
- **Default:** 25
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.append.linger.ms

## controller.quorum.request.timeout.ms

The configuration controls the maximum amount of time the client will wait for the response of a request. If the response is not received before the timeout elapses the client will resend the request if necessary or fail the request if retries are exhausted.

- **Type:** int
- **Default:** 2000 (2 seconds)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.request.timeout.ms

## controller.socket.timeout.ms

The socket timeout for controller-to-broker channels.

- **Type:** int
- **Default:** 30000 (30 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.socket.timeout.ms

## default.replication.factor

The replication factor for automatically created topics, and for topics created with -1 as the replication factor

- **Type:** int
- **Default:** 1
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_default.replication.factor

## delegation.token.expiry.time.ms

The token validity time in milliseconds before the token needs to be renewed. Default value 1 day.

- **Type:** long
- **Default:** 86400000 (1 day)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_delegation.token.expiry.time.ms

## delegation.token.max.lifetime.ms

The token has a maximum lifetime beyond which it cannot be renewed anymore. Default value 7 days.

- **Type:** long
- **Default:** 604800000 (7 days)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_delegation.token.max.lifetime.ms

## delegation.token.secret.key

Secret key to generate and verify delegation tokens. The same key must be configured across all the brokers. If using Kafka with KRaft, the key must also be set across all controllers. If the key is not set or set to empty string, brokers will disable the delegation token support.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_delegation.token.secret.key

## delete.records.purgatory.purge.interval.requests

The purge interval (in number of requests) of the delete records request purgatory

- **Type:** int
- **Default:** 1
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_delete.records.purgatory.purge.interval.requests

## fetch.max.bytes

The maximum number of bytes we will return for a fetch request. Must be at least 1024.

- **Type:** int
- **Default:** 57671680 (55 mebibytes)
- **Valid Values:** [1024,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_fetch.max.bytes

## fetch.purgatory.purge.interval.requests

The purge interval (in number of requests) of the fetch request purgatory

- **Type:** int
- **Default:** 1000
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_fetch.purgatory.purge.interval.requests

## group.consumer.assignors

The server side assignors as a list of either names for builtin assignors or full class names for customer assignors. The first one in the list is considered as the default assignor to be used in the case where the consumer does not specify an assignor. The supported builtin assignors are: uniform, range.

- **Type:** list
- **Default:** uniform,range
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.assignors

## group.consumer.heartbeat.interval.ms

The heartbeat interval given to the members of a consumer group.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.heartbeat.interval.ms

## group.consumer.max.heartbeat.interval.ms

The maximum heartbeat interval for registered consumers.

- **Type:** int
- **Default:** 15000 (15 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.max.heartbeat.interval.ms

## group.consumer.max.session.timeout.ms

The maximum allowed session timeout for registered consumers.

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.max.session.timeout.ms

## group.consumer.max.size

The maximum number of consumers that a single consumer group can accommodate. This value will only impact groups under the CONSUMER group protocol. To configure the max group size when using the CLASSIC group protocol use group.max.size instead.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.max.size

## group.consumer.migration.policy

The config that enables converting the non-empty classic group using the consumer embedded protocol to the non-empty consumer group using the consumer group protocol and vice versa; conversions of empty groups in both directions are always enabled regardless of this policy. bidirectional: both upgrade from classic group to consumer group and downgrade from consumer group to classic group are enabled, upgrade: only upgrade from classic group to consumer group is enabled, downgrade: only downgrade from consumer group to classic group is enabled, disabled: neither upgrade nor downgrade is enabled. In this mode a member using the classic protocol is not allowed to join or rejoin a non-empty consumer group; if a group is already mixed (for example because this policy was changed), its classic-protocol members are rejected when they next attempt to rejoin.

- **Type:** string
- **Default:** bidirectional
- **Valid Values:** (case insensitive) [DISABLED, DOWNGRADE, UPGRADE, BIDIRECTIONAL]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.migration.policy

## group.consumer.min.heartbeat.interval.ms

The minimum heartbeat interval for registered consumers.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.min.heartbeat.interval.ms

## group.consumer.min.session.timeout.ms

The minimum allowed session timeout for registered consumers.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.min.session.timeout.ms

## group.consumer.session.timeout.ms

The timeout to detect client failures when using the consumer group protocol.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.consumer.session.timeout.ms

## group.coordinator.append.linger.ms

The duration in milliseconds that the coordinator will wait for writes to accumulate before flushing them to disk. Increasing this value improves write efficiency and batch size, but also increases the response latency for requests, as the coordinator must wait for batches to be flushed to disk before completing request processing. Transactional writes are not accumulated. Set to -1 for an adaptive linger time that minimizes latency based on the workload.

- **Type:** int
- **Default:** -1
- **Valid Values:** [-1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.coordinator.append.linger.ms

## group.coordinator.rebalance.protocols

The list of enabled rebalance protocols.

- **Type:** list
- **Default:** classic,consumer,streams
- **Valid Values:** [consumer, classic, share, streams]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.coordinator.rebalance.protocols

## group.initial.rebalance.delay.ms

The amount of time the group coordinator will wait for more consumers to join a new group before performing the first rebalance. A longer delay means potentially fewer rebalances, but increases the time until processing begins.

- **Type:** int
- **Default:** 3000 (3 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.initial.rebalance.delay.ms

## group.max.session.timeout.ms

The maximum allowed session timeout for registered consumers. Longer timeouts give consumers more time to process messages in between heartbeats at the cost of a longer time to detect failures.

- **Type:** int
- **Default:** 1800000 (30 minutes)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.max.session.timeout.ms

## group.max.size

The maximum number of consumers that a single consumer group can accommodate.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.max.size

## group.min.session.timeout.ms

The minimum allowed session timeout for registered consumers. Shorter timeouts result in quicker failure detection at the cost of more frequent consumer heartbeating, which can overwhelm broker resources.

- **Type:** int
- **Default:** 6000 (6 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.min.session.timeout.ms

## group.share.assignors

The server-side assignors as a list of either names for built-in assignors or full class names for custom assignors. The list must contain only a single entry which is used by all groups. The supported built-in assignors are: simple.

- **Type:** list
- **Default:** simple
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.assignors

## group.share.delivery.count.limit

The maximum number of delivery attempts for a record delivered to a share group.

- **Type:** int
- **Default:** 5
- **Valid Values:** [2,...,10]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.delivery.count.limit

## group.share.heartbeat.interval.ms

The heartbeat interval given to the members of a share group.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.heartbeat.interval.ms

## group.share.max.heartbeat.interval.ms

The maximum heartbeat interval for share group members.

- **Type:** int
- **Default:** 15000 (15 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.max.heartbeat.interval.ms

## group.share.max.record.lock.duration.ms

The record acquisition lock maximum duration in milliseconds for share groups.

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [30000,...,3600000]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.max.record.lock.duration.ms

## group.share.max.session.timeout.ms

The maximum allowed session timeout for share group members.

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.max.session.timeout.ms

## group.share.max.share.sessions

The maximum number of share sessions per broker.

- **Type:** int
- **Default:** 2000
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.max.share.sessions

## group.share.max.size

The maximum number of members that a single share group can accommodate.

- **Type:** int
- **Default:** 200
- **Valid Values:** [1,...,1000]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.max.size

## group.share.min.heartbeat.interval.ms

The minimum heartbeat interval for share group members.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.min.heartbeat.interval.ms

## group.share.min.record.lock.duration.ms

The record acquisition lock minimum duration in milliseconds for share groups.

- **Type:** int
- **Default:** 15000 (15 seconds)
- **Valid Values:** [1000,...,30000]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.min.record.lock.duration.ms

## group.share.min.session.timeout.ms

The minimum allowed session timeout for share group members.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.min.session.timeout.ms

## group.share.partition.max.record.locks

Share-group record lock limit per share-partition.

- **Type:** int
- **Default:** 2000
- **Valid Values:** [100,...,10000]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.partition.max.record.locks

## group.share.record.lock.duration.ms

The record acquisition lock duration in milliseconds for share groups.

- **Type:** int
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1000,...,3600000]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.record.lock.duration.ms

## group.share.session.timeout.ms

The timeout to detect client failures when using the share group protocol.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.share.session.timeout.ms

## group.streams.heartbeat.interval.ms

The heartbeat interval given to the members.

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.heartbeat.interval.ms

## group.streams.initial.rebalance.delay.ms

The amount of time the group coordinator will wait for more streams clients to join a new group before performing the first rebalance. A longer delay means potentially fewer rebalances.

- **Type:** int
- **Default:** 3000 (3 seconds)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.initial.rebalance.delay.ms

## group.streams.max.heartbeat.interval.ms

The maximum allowed value for the group-level configuration of streams.heartbeat.interval.ms

- **Type:** int
- **Default:** 15000 (15 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.max.heartbeat.interval.ms

## group.streams.max.session.timeout.ms

The maximum allowed value for the group-level configuration of streams.session.timeout.ms

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.max.session.timeout.ms

## group.streams.max.size

The maximum number of streams clients that a single streams group can accommodate.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.max.size

## group.streams.max.standby.replicas

The maximum allowed value for the group-level configuration of streams.num.standby.replicas

- **Type:** int
- **Default:** 2
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.max.standby.replicas

## group.streams.min.heartbeat.interval.ms

The minimum allowed value for the group-level configuration of streams.heartbeat.interval.ms

- **Type:** int
- **Default:** 5000 (5 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.min.heartbeat.interval.ms

## group.streams.min.session.timeout.ms

The minimum allowed value for the group-level configuration of streams.session.timeout.ms

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.min.session.timeout.ms

## group.streams.num.standby.replicas

The number of standby replicas for each task.

- **Type:** int
- **Default:** 0
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.num.standby.replicas

## group.streams.session.timeout.ms

The timeout to detect client failures when using the streams group protocol.

- **Type:** int
- **Default:** 45000 (45 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_group.streams.session.timeout.ms

## initial.broker.registration.timeout.ms

When initially registering with the controller quorum, the number of milliseconds to wait before declaring failure and exiting the broker process.

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_initial.broker.registration.timeout.ms

## inter.broker.listener.name

Name of listener used for communication between brokers. If this is unset, the listener name is defined by security.inter.broker.protocol. It is an error to set this and security.inter.broker.protocol properties at the same time.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_inter.broker.listener.name

## log.cleaner.backoff.ms

The amount of time to sleep when there are no logs to clean

- **Type:** long
- **Default:** 15000 (15 seconds)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.backoff.ms

## log.cleaner.dedupe.buffer.size

The total memory used for log deduplication across all cleaner threads

- **Type:** long
- **Default:** 134217728
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.dedupe.buffer.size

## log.cleaner.delete.retention.ms

The amount of time to retain tombstone message markers for log compacted topics. This setting also gives a bound on the time in which a consumer must complete a read if they begin from offset 0 to ensure that they get a valid snapshot of the final stage (otherwise tombstones messages may be collected before a consumer completes their scan).

- **Type:** long
- **Default:** 86400000 (1 day)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.delete.retention.ms

## log.cleaner.enable

This configuration has been deprecated and will be removed in Kafka 5.0. Users should not set it to false to prepare for its future removal. Enable the log cleaner process to run on the server. Should be enabled if using any topics with a cleanup.policy=compact including the internal offsets topic. If disabled those topics will not be compacted and continually grow in size.

- **Type:** boolean
- **Default:** true
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.enable

## log.cleaner.io.buffer.load.factor

Log cleaner dedupe buffer load factor. The percentage full the dedupe buffer can become. A higher value will allow more log to be cleaned at once but will lead to more hash collisions

- **Type:** double
- **Default:** 0.9
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.io.buffer.load.factor

## log.cleaner.io.buffer.size

The total memory used for log cleaner I/O buffers across all cleaner threads

- **Type:** int
- **Default:** 524288
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.io.buffer.size

## log.cleaner.io.max.bytes.per.second

The log cleaner will be throttled so that the sum of its read and write i/o will be less than this value on average

- **Type:** double
- **Default:** 1.7976931348623157E308
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.io.max.bytes.per.second

## log.cleaner.max.compaction.lag.ms

The maximum time a message will remain ineligible for compaction in the log. Only applicable for logs that are being compacted.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.max.compaction.lag.ms

## log.cleaner.min.cleanable.ratio

The minimum ratio of dirty log to total log for a log to eligible for cleaning. If the log.cleaner.max.compaction.lag.ms or the log.cleaner.min.compaction.lag.ms configurations are also specified, then the log compactor considers the log eligible for compaction as soon as either: (i) the dirty ratio threshold has been met and the log has had dirty (uncompacted) records for at least the log.cleaner.min.compaction.lag.ms duration, or (ii) if the log has had dirty (uncompacted) records for at most the log.cleaner.max.compaction.lag.ms period.

- **Type:** double
- **Default:** 0.5
- **Valid Values:** [0,...,1]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.min.cleanable.ratio

## log.cleaner.min.compaction.lag.ms

The minimum time a message will remain uncompacted in the log. Only applicable for logs that are being compacted.

- **Type:** long
- **Default:** 0
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.min.compaction.lag.ms

## log.cleaner.threads

The number of background threads to use for log cleaning

- **Type:** int
- **Default:** 1
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleaner.threads

## log.cleanup.policy

This config designates the retention policy to use on log segments. The "delete" policy (which is the default) will discard old segments when their retention time or size limit has been reached. The "compact" policy will enable log compaction, which retains the latest value for each key. It is also possible to specify both policies in a comma-separated list (e.g. "delete,compact"). In this case, old segments will be discarded per the retention time and size configuration, while retained segments will be compacted. An empty list means infinite retention - no cleanup policies will be applied and log segments will be retained indefinitely. Note that with remote storage enabled, local retention limits (log.local.retention.ms and log.local.retention.bytes) are still applied to local segments.

- **Type:** list
- **Default:** delete
- **Valid Values:** [compact, delete]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.cleanup.policy

## log.index.interval.bytes

The interval with which we add an entry to the offset index.

- **Type:** int
- **Default:** 4096 (4 kibibytes)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.index.interval.bytes

## log.index.size.max.bytes

The maximum size in bytes of the offset index

- **Type:** int
- **Default:** 10485760 (10 mebibytes)
- **Valid Values:** [4,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.index.size.max.bytes

## log.local.retention.bytes

The maximum size of local log segments that can grow for a partition before it gets eligible for deletion. Default value is -2, it represents `log.retention.bytes` value to be used. The effective value should always be less than or equal to `log.retention.bytes` value.

- **Type:** long
- **Default:** -2
- **Valid Values:** [-2,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.local.retention.bytes

## log.local.retention.ms

The number of milliseconds to keep the local log segments before it gets eligible for deletion. Default value is -2, it represents `log.retention.ms` value is to be used. The effective value should always be less than or equal to `log.retention.ms` value.

- **Type:** long
- **Default:** -2
- **Valid Values:** [-2,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.local.retention.ms

## log.message.timestamp.after.max.ms

This configuration sets the allowable timestamp difference between the message timestamp and the broker's timestamp. The message timestamp can be later than or equal to the broker's timestamp, with the maximum allowable difference determined by the value set in this configuration. If log.message.timestamp.type=CreateTime, the message will be rejected if the difference in timestamps exceeds this specified threshold. This configuration is ignored if log.message.timestamp.type=LogAppendTime.

- **Type:** long
- **Default:** 3600000 (1 hour)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.message.timestamp.after.max.ms

## log.message.timestamp.before.max.ms

This configuration sets the allowable timestamp difference between the broker's timestamp and the message timestamp. The message timestamp can be earlier than or equal to the broker's timestamp, with the maximum allowable difference determined by the value set in this configuration. If log.message.timestamp.type=CreateTime, the message will be rejected if the difference in timestamps exceeds this specified threshold. This configuration is ignored if log.message.timestamp.type=LogAppendTime.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.message.timestamp.before.max.ms

## log.message.timestamp.type

Define whether the timestamp in the message is message create time or log append time. The value should be either `CreateTime` or `LogAppendTime`.

- **Type:** string
- **Default:** CreateTime
- **Valid Values:** [CreateTime, LogAppendTime]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.message.timestamp.type

## log.preallocate

Should pre allocate file when create new segment? If you are using Kafka on Windows, you probably need to set it to true.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.preallocate

## log.retention.check.interval.ms

The frequency in milliseconds that the log cleaner checks whether any log is eligible for deletion

- **Type:** long
- **Default:** 300000 (5 minutes)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.check.interval.ms

## max.connection.creation.rate

The maximum connection creation rate we allow in the broker at any time. Listener-level limits may also be configured by prefixing the config name with the listener prefix, for example, `listener.name.internal.max.connection.creation.rate`.Broker-wide connection rate limit should be configured based on broker capacity while listener limits should be configured based on application requirements. New connections will be throttled if either the listener or the broker limit is reached, with the exception of inter-broker listener. Connections on the inter-broker listener will be throttled only when the listener-level rate limit is reached.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.connection.creation.rate

## max.connections

The maximum number of connections we allow in the broker at any time. This limit is applied in addition to any per-ip limits configured using max.connections.per.ip. Listener-level limits may also be configured by prefixing the config name with the listener prefix, for example, `listener.name.internal.max.connections.per.ip`. Broker-wide limit should be configured based on broker capacity while listener limits should be configured based on application requirements. New connections are blocked if either the listener or broker limit is reached. Connections on the inter-broker listener are permitted even if broker-wide limit is reached. The least recently used connection on another listener will be closed in this case.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.connections

## max.connections.per.ip

The maximum number of connections we allow from each ip address. This can be set to 0 if there are overrides configured using max.connections.per.ip.overrides property. New connections from the ip address are dropped if the limit is reached.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.connections.per.ip

## max.connections.per.ip.overrides

A comma-separated list of per-ip or hostname overrides to the default maximum number of connections. An example value is "hostName:100,127.0.0.1:200"

- **Type:** string
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.connections.per.ip.overrides

## max.decompressed.message.bytes

The maximum decompressed size, in bytes, of a single record the broker will accept; larger records are rejected with an `InvalidRecordException`. It is enforced where the broker decompresses records: produce validation of compressed batches, log compaction, and offset lookups by timestamp or max timestamp against the local log or remote storage. Unlike `max.message.bytes`, which bounds the compressed batch on the wire, this bounds the decompressed size of an individual record. Lowering it below the size of already-stored records makes compaction and timestamp offset lookups of affected partitions fail until it is raised again. The default imposes no limit beyond the largest record the broker could allocate anyway; set a smaller value to enforce a per-record cap. This can be set per topic with the topic level `max.decompressed.message.bytes` config.

- **Type:** int
- **Default:** 2147483639
- **Valid Values:** [1,...,2147483639]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.decompressed.message.bytes

## max.incremental.fetch.session.cache.slots

The maximum number of total incremental fetch sessions that we will maintain. FetchSessionCache is sharded into 8 shards and the limit is equally divided among all shards. Sessions are allocated to each shard in round-robin. Only entries within a shard are considered eligible for eviction.

- **Type:** int
- **Default:** 1000
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.incremental.fetch.session.cache.slots

## max.request.partition.size.limit

The maximum number of partitions can be served in one request.

- **Type:** int
- **Default:** 2000
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_max.request.partition.size.limit

## num.partitions

The default number of log partitions per topic

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.partitions

## principal.builder.class

The fully qualified name of a class that implements the KafkaPrincipalBuilder interface, which is used to build the KafkaPrincipal object used during authorization. If no principal builder is defined, the default behavior depends on the security protocol in use. For SSL authentication, the principal will be derived using the rules defined by `ssl.principal.mapping.rules` applied on the distinguished name from the client certificate if one is provided; otherwise, if client authentication is not required, the principal name will be ANONYMOUS. For SASL authentication, the principal will be derived using the rules defined by `sasl.kerberos.principal.to.local.rules` if GSSAPI is in use, and the SASL authentication ID for other mechanisms. For PLAINTEXT, the principal will be ANONYMOUS. Note that custom implementations of `KafkaPrincipalBuilder` is required to implement `KafkaPrincipalSerde` interface, otherwise brokers will not be able to forward requests to the controller.

- **Type:** class
- **Default:** org.apache.kafka.common.security.authenticator.DefaultKafkaPrincipalBuilder
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_principal.builder.class

## producer.purgatory.purge.interval.requests

The purge interval (in number of requests) of the producer request purgatory

- **Type:** int
- **Default:** 1000
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_producer.purgatory.purge.interval.requests

## queued.max.request.bytes

The number of queued bytes allowed before no more requests are read

- **Type:** long
- **Default:** -1
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_queued.max.request.bytes

## remote.fetch.max.wait.ms

The maximum amount of time the server will wait before answering the fetch request containing remote fetch partitions. It's important to be aware that the request will only be responded after all remote partitions have been successfully fetched, have failed, or this timeout is exceeded.

- **Type:** int
- **Default:** 500
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.fetch.max.wait.ms

## remote.list.offsets.request.timeout.ms

The maximum amount of time the server will wait for the remote list offsets request to complete.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.list.offsets.request.timeout.ms

## remote.log.manager.copier.thread.pool.size

Size of the thread pool used in scheduling tasks to copy segments.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.copier.thread.pool.size

## remote.log.manager.copy.max.bytes.per.second

The maximum number of bytes that can be copied from local storage to remote storage per second. This is a global limit for all the partitions that are being copied from local storage to remote storage. The default value is Long.MAX_VALUE, which means there is no limit on the number of bytes that can be copied per second.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.copy.max.bytes.per.second

## remote.log.manager.copy.quota.window.num

The number of samples to retain in memory for remote copy quota management. The default value is 11, which means there are 10 whole windows + 1 current window.

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.copy.quota.window.num

## remote.log.manager.copy.quota.window.size.seconds

The time span of each sample for remote copy quota management. The default value is 1 second.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.copy.quota.window.size.seconds

## remote.log.manager.expiration.thread.pool.size

Size of the thread pool used in scheduling tasks to clean up the expired remote log segments.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.expiration.thread.pool.size

## remote.log.manager.fetch.max.bytes.per.second

The maximum number of bytes that can be fetched from remote storage to local storage per second. This is a global limit for all the partitions that are being fetched from remote storage to local storage. The default value is Long.MAX_VALUE, which means there is no limit on the number of bytes that can be fetched per second.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.fetch.max.bytes.per.second

## remote.log.manager.fetch.quota.window.num

The number of samples to retain in memory for remote fetch quota management. The default value is 11, which means there are 10 whole windows + 1 current window.

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.fetch.quota.window.num

## remote.log.manager.fetch.quota.window.size.seconds

The time span of each sample for remote fetch quota management. The default value is 1 second.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.fetch.quota.window.size.seconds

## remote.log.manager.follower.thread.pool.size

Size of the thread pool used in scheduling follower tasks to read the highest-uploaded remote-offset for follower partitions.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.follower.thread.pool.size

## remote.log.manager.thread.pool.size

Size of the thread pool used in scheduling follower tasks to read the highest-uploaded remote-offset for follower partitions. This config is deprecated since 4.2, please use `remote.log.manager.follower.thread.pool.size` instead.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.thread.pool.size

## remote.log.metadata.manager.class.name

Fully qualified class name of `RemoteLogMetadataManager` implementation.

- **Type:** string
- **Default:** org.apache.kafka.server.log.remote.metadata.storage.TopicBasedRemoteLogMetadataManager
- **Valid Values:** non-empty string
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.metadata.manager.class.name

## remote.log.metadata.manager.class.path

Class path of the `RemoteLogMetadataManager` implementation. If specified, the RemoteLogMetadataManager implementation and its dependent libraries will be loaded by a dedicated classloader which searches this class path before the Kafka broker class path. The syntax of this parameter is same as the standard Java class path string.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.metadata.manager.class.path

## remote.log.metadata.manager.impl.prefix

Prefix used for properties to be passed to RemoteLogMetadataManager implementation. For example this value can be `rlmm.config.`.

- **Type:** string
- **Default:** rlmm.config.
- **Valid Values:** non-empty string
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.metadata.manager.impl.prefix

## remote.log.metadata.manager.listener.name

Listener name of the local broker to which it should get connected if needed by RemoteLogMetadataManager implementation.

- **Type:** string
- **Default:** null
- **Valid Values:** non-empty string
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.metadata.manager.listener.name

## remote.log.reader.max.pending.tasks

Maximum remote log reader thread pool task queue size. If the task queue is full, fetch requests are served with an error.

- **Type:** int
- **Default:** 100
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.reader.max.pending.tasks

## remote.log.reader.threads

Size of the thread pool that is allocated for handling remote log reads.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.reader.threads

## remote.log.storage.manager.class.name

Fully qualified class name of `RemoteStorageManager` implementation.

- **Type:** string
- **Default:** null
- **Valid Values:** non-empty string
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.storage.manager.class.name

## remote.log.storage.manager.class.path

Class path of the `RemoteStorageManager` implementation. If specified, the RemoteStorageManager implementation and its dependent libraries will be loaded by a dedicated classloader which searches this class path before the Kafka broker class path. The syntax of this parameter is same as the standard Java class path string.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.storage.manager.class.path

## remote.log.storage.manager.impl.prefix

Prefix used for properties to be passed to RemoteStorageManager implementation. For example this value can be `rsm.config.`.

- **Type:** string
- **Default:** rsm.config.
- **Valid Values:** non-empty string
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.storage.manager.impl.prefix

## remote.log.storage.system.enable

Whether to enable tiered storage functionality in a broker or not. When it is true broker starts all the services required for the tiered storage functionality.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.storage.system.enable

## replica.fetch.backoff.ms

The amount of time to sleep when fetch partition error occurs.

- **Type:** int
- **Default:** 1000 (1 second)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.backoff.ms

## replica.fetch.max.bytes

The number of bytes of messages to attempt to fetch for each partition. This is not an absolute maximum, if the first record batch in the first non-empty partition of the fetch is larger than this value, the record batch will still be returned to ensure that progress can be made. The maximum record batch size accepted by the broker is defined via `message.max.bytes` (broker config) or `max.message.bytes` (topic config).

- **Type:** int
- **Default:** 1048576 (1 mebibyte)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.max.bytes

## replica.fetch.response.max.bytes

Maximum bytes expected for the entire fetch response. Records are fetched in batches, and if the first record batch in the first non-empty partition of the fetch is larger than this value, the record batch will still be returned to ensure that progress can be made. As such, this is not an absolute maximum. The maximum record batch size accepted by the broker is defined via `message.max.bytes` (broker config) or `max.message.bytes` (topic config).

- **Type:** int
- **Default:** 10485760 (10 mebibytes)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.response.max.bytes

## replica.selector.class

The fully qualified class name that implements ReplicaSelector. This is used by the broker to find the preferred read replica. By default, we use an implementation that returns the leader.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.selector.class

## sasl.client.callback.handler.class

The fully qualified name of a SASL client callback handler class that implements the AuthenticateCallbackHandler interface.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.client.callback.handler.class

## sasl.enabled.mechanisms

The list of SASL mechanisms enabled in the Kafka server. The list may contain any mechanism for which a security provider is available. Only GSSAPI is enabled by default.

- **Type:** list
- **Default:** GSSAPI
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.enabled.mechanisms

## sasl.jaas.config

JAAS login context parameters for SASL connections in the format used by JAAS configuration files. JAAS configuration file format is described here. The format for the value is: `loginModuleClass controlFlag (optionName=optionValue)*;`. For brokers, the config must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.scram-sha-256.sasl.jaas.config=com.example.ScramLoginModule required;

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.jaas.config

## sasl.kerberos.kinit.cmd

Kerberos kinit command path.

- **Type:** string
- **Default:** /usr/bin/kinit
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.kerberos.kinit.cmd

## sasl.kerberos.min.time.before.relogin

Login thread sleep time between refresh attempts.

- **Type:** long
- **Default:** 60000
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.kerberos.min.time.before.relogin

## sasl.kerberos.principal.to.local.rules

A list of rules for mapping from principal names to short names (typically operating system usernames). The rules are evaluated in order and the first rule that matches a principal name is used to map it to a short name. Any later rules in the list are ignored. By default, principal names of the form `{username}/{hostname}@{REALM}` are mapped to `{username}`. For more details on the format please see security authorization and acls. Note that this configuration is ignored if an extension of `KafkaPrincipalBuilder` is provided by the `principal.builder.class` configuration.

- **Type:** list
- **Default:** DEFAULT
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.kerberos.principal.to.local.rules

## sasl.kerberos.service.name

The Kerberos principal name that Kafka runs as. This can be defined either in Kafka's JAAS config or in Kafka's config.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.kerberos.service.name

## sasl.kerberos.ticket.renew.jitter

Percentage of random jitter added to the renewal time.

- **Type:** double
- **Default:** 0.05
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.kerberos.ticket.renew.jitter

## sasl.kerberos.ticket.renew.window.factor

Login thread will sleep until the specified window factor of time from last refresh to ticket's expiry has been reached, at which time it will try to renew the ticket.

- **Type:** double
- **Default:** 0.8
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.kerberos.ticket.renew.window.factor

## sasl.login.callback.handler.class

The fully qualified name of a SASL login callback handler class that implements the AuthenticateCallbackHandler interface. For brokers, login callback handler config must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.scram-sha-256.sasl.login.callback.handler.class=com.example.CustomScramLoginCallbackHandler

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.callback.handler.class

## sasl.login.class

The fully qualified name of a class that implements the Login interface. For brokers, login config must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.scram-sha-256.sasl.login.class=com.example.CustomScramLogin

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.class

## sasl.login.refresh.buffer.seconds

The amount of buffer time before credential expiration to maintain when refreshing a credential, in seconds. If a refresh would otherwise occur closer to expiration than the number of buffer seconds then the refresh will be moved up to maintain as much of the buffer time as possible. Legal values are between 0 and 3600 (1 hour); a default value of 300 (5 minutes) is used if no value is specified. This value and sasl.login.refresh.min.period.seconds are both ignored if their sum exceeds the remaining lifetime of a credential. Currently applies only to OAUTHBEARER.

- **Type:** short
- **Default:** 300
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.refresh.buffer.seconds

## sasl.login.refresh.min.period.seconds

The desired minimum time for the login refresh thread to wait before refreshing a credential, in seconds. Legal values are between 0 and 900 (15 minutes); a default value of 60 (1 minute) is used if no value is specified. This value and sasl.login.refresh.buffer.seconds are both ignored if their sum exceeds the remaining lifetime of a credential. Currently applies only to OAUTHBEARER.

- **Type:** short
- **Default:** 60
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.refresh.min.period.seconds

## sasl.login.refresh.window.factor

Login refresh thread will sleep until the specified window factor relative to the credential's lifetime has been reached, at which time it will try to refresh the credential. Legal values are between 0.5 (50%) and 1.0 (100%) inclusive; a default value of 0.8 (80%) is used if no value is specified. Currently applies only to OAUTHBEARER.

- **Type:** double
- **Default:** 0.8
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.refresh.window.factor

## sasl.login.refresh.window.jitter

The maximum amount of random jitter relative to the credential's lifetime that is added to the login refresh thread's sleep time. Legal values are between 0 and 0.25 (25%) inclusive; a default value of 0.05 (5%) is used if no value is specified. Currently applies only to OAUTHBEARER.

- **Type:** double
- **Default:** 0.05
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.refresh.window.jitter

## sasl.mechanism.inter.broker.protocol

SASL mechanism used for inter-broker communication. Default is GSSAPI.

- **Type:** string
- **Default:** GSSAPI
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.mechanism.inter.broker.protocol

## sasl.oauthbearer.assertion.algorithm

The algorithm the Apache Kafka client should use to sign the assertion sent to the identity provider. It is also used as the value of the OAuth `alg` (Algorithm) header in the JWT assertion.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** RS256
- **Valid Values:** (case insensitive) [ES256, RS256]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.algorithm

## sasl.oauthbearer.assertion.claim.aud

The JWT `aud` (Audience) claim which will be included in the client JWT assertion created locally.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.claim.aud

## sasl.oauthbearer.assertion.claim.iss

The value to be used as the `iss` (Issuer) claim which will be included in the client JWT assertion created locally.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.claim.iss

## sasl.oauthbearer.assertion.claim.jti.include

Flag that determines if the JWT assertion should generate a unique ID for the JWT and include it in the `jti` (JWT ID) claim.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.claim.jti.include

## sasl.oauthbearer.assertion.claim.sub

The value to be used as the `sub` (Subject) claim which will be included in the client JWT assertion created locally.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.claim.sub

## sasl.oauthbearer.assertion.file



- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.file

## sasl.oauthbearer.assertion.private.key.file

File that contains a private key in the standard PEM format which is used to sign the JWT assertion sent to the identity provider.

The underlying implementation caches the file contents to avoid the performance hit of loading the file on each access. The caching mechanism will detect when the file changes to allow for the file to be reloaded on modifications. This allows for "live" private key rotation without restarting the Kafka client.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.private.key.file

## sasl.oauthbearer.assertion.private.key.passphrase

The optional passphrase to decrypt the private key file specified by `sasl.oauthbearer.assertion.private.key.file`.

Note: If the file referred to by `sasl.oauthbearer.assertion.private.key.file` is modified on the file system at runtime and it was created with a different passphrase than it was previously, the client will not be able to access the private key file because the passphrase is now out of date. For that reason, when using private key passphrases, either use the same passphrase each time, or—for improved security—restart the Kafka client using the new passphrase configuration.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.private.key.passphrase

## sasl.oauthbearer.assertion.template.file

This optional configuration specifies the file containing the JWT headers and/or payload claims to be used when creating the JWT assertion.

Not all identity providers require the same set of claims; some may require a given claim while others may prohibit it. In order to provide the most flexibility, this configuration allows the user to provide the static header values and claims that are to be included in the JWT.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.template.file

## sasl.oauthbearer.client.credentials.client.id



- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.client.credentials.client.id

## sasl.oauthbearer.client.credentials.client.secret



- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.client.credentials.client.secret

## sasl.oauthbearer.jwks.endpoint.url

The OAuth/OIDC provider URL from which the provider's JWKS (JSON Web Key Set) can be retrieved. The URL can be HTTP(S)-based or file-based. If the URL is HTTP(S)-based, the JWKS data will be retrieved from the OAuth/OIDC provider via the configured URL on broker startup. All then-current keys will be cached on the broker for incoming requests. If an authentication request is received for a JWT that includes a "kid" header claim value that isn't yet in the cache, the JWKS endpoint will be queried again on demand. However, the broker polls the URL every sasl.oauthbearer.jwks.endpoint.refresh.ms milliseconds to refresh the cache with any forthcoming keys before any JWT requests that include them are received. If the URL is file-based, the broker will load the JWKS file from a configured location on startup. In the event that the JWT includes a "kid" header value that isn't in the JWKS file, the broker will reject the JWT and authentication will fail.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.jwks.endpoint.url

## sasl.oauthbearer.jwt.retriever.class



- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.jwt.retriever.class

## sasl.oauthbearer.jwt.validator.class



- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.jwt.validator.class

## sasl.oauthbearer.scope



- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.scope

## sasl.oauthbearer.token.endpoint.url

The URL for the OAuth/OIDC identity provider. If the URL is HTTP(S)-based, it is the issuer's token endpoint URL to which requests will be made to login based on the configuration in `sasl.oauthbearer.jwt.retriever.class`. If the URL is file-based, it specifies a file containing an access token (in JWT serialized form) issued by the OAuth/OIDC identity provider to use for authorization.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.token.endpoint.url

## sasl.server.callback.handler.class

The fully qualified name of a SASL server callback handler class that implements the AuthenticateCallbackHandler interface. Server callback handlers must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.plain.sasl.server.callback.handler.class=com.example.CustomPlainCallbackHandler.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.server.callback.handler.class

## sasl.server.max.receive.size

The maximum receive size allowed before and during initial SASL authentication. Default receive size is 512KB. GSSAPI limits requests to 64K, but we allow upto 512KB by default for custom SASL mechanisms. In practice, PLAIN, SCRAM and OAUTH mechanisms can use much smaller limits.

- **Type:** int
- **Default:** 524288
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.server.max.receive.size

## security.inter.broker.protocol

Security protocol used to communicate between brokers. It is an error to set this and inter.broker.listener.name properties at the same time.

- **Type:** string
- **Default:** PLAINTEXT
- **Valid Values:** [PLAINTEXT, SSL, SASL_PLAINTEXT, SASL_SSL]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_security.inter.broker.protocol

## share.coordinator.append.linger.ms

The duration in milliseconds that the share coordinator will wait for writes to accumulate before flushing them to disk. Set to -1 for an adaptive linger time that minimizes latency based on the workload.

- **Type:** int
- **Default:** -1
- **Valid Values:** [-1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.append.linger.ms

## share.coordinator.snapshot.update.records.per.snapshot

The number of update records the share coordinator writes between snapshot records.

- **Type:** int
- **Default:** 500
- **Valid Values:** [0,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.snapshot.update.records.per.snapshot

## share.coordinator.threads

The number of threads used by the share coordinator.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.coordinator.threads

## share.fetch.purgatory.purge.interval.requests

The purge interval (in number of requests) of the share fetch request purgatory

- **Type:** int
- **Default:** 1000
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_share.fetch.purgatory.purge.interval.requests

## socket.connection.setup.timeout.max.ms

The maximum amount of time the client will wait for the socket connection to be established. The connection setup timeout will increase exponentially for each consecutive connection failure up to this maximum. To avoid connection storms, a randomization factor of 0.2 will be applied to the timeout resulting in a random range between 20% below and 20% above the computed value.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.connection.setup.timeout.max.ms

## socket.connection.setup.timeout.ms

The amount of time the client will wait for the socket connection to be established. If the connection is not built before the timeout elapses, clients will close the socket channel. This value is the initial backoff value and will increase exponentially for each consecutive connection failure, up to the `socket.connection.setup.timeout.max.ms` value.

- **Type:** long
- **Default:** 10000 (10 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.connection.setup.timeout.ms

## socket.listen.backlog.size

The maximum number of pending connections on the socket. In Linux, you may also need to configure `somaxconn` and `tcp_max_syn_backlog` kernel parameters accordingly to make the configuration takes effect.

- **Type:** int
- **Default:** 50
- **Valid Values:** [1,...]
- **Importance:** medium
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.listen.backlog.size

## ssl.cipher.suites

A list of cipher suites. This is a named combination of authentication, encryption, MAC and key exchange algorithm used to negotiate the security settings for a network connection using TLS or SSL network protocol. By default all the available cipher suites are supported.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.cipher.suites

## ssl.client.auth

Configures kafka broker to request client authentication. The following settings are common: 

- `ssl.client.auth=required` If set to required client authentication is required. 
- `ssl.client.auth=requested` This means client authentication is optional. unlike required, if this option is set client can choose not to provide authentication information about itself 
- `ssl.client.auth=none` This means client authentication is not needed.

- **Type:** string
- **Default:** none
- **Valid Values:** [required, requested, none]
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.client.auth

## ssl.enabled.protocols

The list of protocols enabled for SSL connections. The default is 'TLSv1.2,TLSv1.3'. This means that clients and servers will prefer TLSv1.3 if both support it and fallback to TLSv1.2 otherwise (assuming both support at least TLSv1.2). This default should be fine for most use cases. If this configuration is set to an empty list, Kafka will use the protocols enabled by default in the underlying SSLEngine, which may include additional protocols depending on the JVM version. Also see the config documentation for `ssl.protocol` to understand how it can impact the TLS version negotiation behavior.

- **Type:** list
- **Default:** TLSv1.2,TLSv1.3
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.enabled.protocols

## ssl.key.password

The password of the private key in the key store file or the PEM key specified in 'ssl.keystore.key'.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.key.password

## ssl.keymanager.algorithm

The algorithm used by key manager factory for SSL connections. Default value is the key manager factory algorithm configured for the Java Virtual Machine.

- **Type:** string
- **Default:** SunX509
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.keymanager.algorithm

## ssl.keystore.certificate.chain

Certificate chain in the format specified by 'ssl.keystore.type'. Default SSL engine factory supports only PEM format with a list of X.509 certificates

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.keystore.certificate.chain

## ssl.keystore.key

Private key in the format specified by 'ssl.keystore.type'. Default SSL engine factory supports only PEM format with PKCS#8 keys. If the key is encrypted, key password must be specified using 'ssl.key.password'

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.keystore.key

## ssl.keystore.location

The location of the key store file. This is optional for client and can be used for two-way authentication for client.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.keystore.location

## ssl.keystore.password

The store password for the key store file. This is optional for client and only needed if 'ssl.keystore.location' is configured. Key store password is not supported for PEM format.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.keystore.password

## ssl.keystore.type

The file format of the key store file. This is optional for client. The values currently supported by the default `ssl.engine.factory.class` are [JKS, PKCS12, PEM].

- **Type:** string
- **Default:** JKS
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.keystore.type

## ssl.protocol

The SSL protocol used to generate the SSLContext. The default is 'TLSv1.3', which should be fine for most use cases. A typical alternative to the default is 'TLSv1.2'. Allowed values for this config are dependent on the JVM. Clients using the defaults for this config and 'ssl.enabled.protocols' will downgrade to 'TLSv1.2' if the server does not support 'TLSv1.3'. If this config is set to 'TLSv1.2', however, clients will not use 'TLSv1.3' even if it is one of the values in `ssl.enabled.protocols` and the server only supports 'TLSv1.3'.

- **Type:** string
- **Default:** TLSv1.3
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.protocol

## ssl.provider

The name of the security provider used for SSL connections. Default value is the default security provider of the JVM.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.provider

## ssl.trustmanager.algorithm

The algorithm used by trust manager factory for SSL connections. Default value is the trust manager factory algorithm configured for the Java Virtual Machine.

- **Type:** string
- **Default:** PKIX
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.trustmanager.algorithm

## ssl.truststore.certificates

Trusted certificates in the format specified by 'ssl.truststore.type'. Default SSL engine factory supports only PEM format with X.509 certificates.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.truststore.certificates

## ssl.truststore.location

The location of the trust store file.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.truststore.location

## ssl.truststore.password

The password for the trust store file. If a password is not set, trust store file configured will still be used, but integrity checking is disabled. Trust store password is not supported for PEM format.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.truststore.password

## ssl.truststore.type

The file format of the trust store file. The values currently supported by the default `ssl.engine.factory.class` are [JKS, PKCS12, PEM].

- **Type:** string
- **Default:** JKS
- **Valid Values:** (empty)
- **Importance:** medium
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.truststore.type

## alter.config.policy.class.name

The alter configs policy class that should be used for validation. The class should implement the `org.apache.kafka.server.policy.AlterConfigPolicy` interface. 

Note: This policy runs on the controller instead of the broker.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_alter.config.policy.class.name

## alter.log.dirs.replication.quota.window.num

The number of samples to retain in memory for alter log dirs replication quotas

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_alter.log.dirs.replication.quota.window.num

## alter.log.dirs.replication.quota.window.size.seconds

The time span of each sample for alter log dirs replication quotas

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_alter.log.dirs.replication.quota.window.size.seconds

## authorizer.class.name

The fully qualified name of a class that implements `org.apache.kafka.server.authorizer.Authorizer` interface, which is used by the broker for authorization.

- **Type:** string
- **Default:** ""
- **Valid Values:** non-null string
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_authorizer.class.name

## client.quota.callback.class

The fully qualified name of a class that implements the ClientQuotaCallback interface, which is used to determine quota limits applied to client requests. By default, the <user> and <client-id> quotas that are stored and applied. For any given request, the most specific quota that matches the user principal of the session and the client-id of the request is applied.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_client.quota.callback.class

## config.providers

Comma-separated alias names for classes implementing the `ConfigProvider` interface. This enables loading configuration data (such as passwords, API keys, and other credentials) from external sources. For example, see Configuration Providers.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_config.providers

## connection.failed.authentication.delay.ms

Connection close delay on failed authentication: this is the time (in milliseconds) by which connection close will be delayed on authentication failure. This must be configured to be less than connections.max.idle.ms to prevent connection timeout.

- **Type:** int
- **Default:** 100
- **Valid Values:** [0,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_connection.failed.authentication.delay.ms

## controller.quorum.auto.join.enable

Controls whether a KRaft controller should automatically join the cluster metadata partition for its cluster id.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.auto.join.enable

## controller.quorum.retry.backoff.ms

The amount of time to wait before attempting to retry a failed request to a given topic partition. This avoids repeatedly sending requests in a tight loop under some failure scenarios. This value is the initial backoff value and will increase exponentially for each failed request, up to the `retry.backoff.max.ms` value.

- **Type:** int
- **Default:** 20
- **Valid Values:** [0,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quorum.retry.backoff.ms

## controller.quota.window.num

The number of samples to retain in memory for controller mutation quotas

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quota.window.num

## controller.quota.window.size.seconds

The time span of each sample for controller mutations quotas

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_controller.quota.window.size.seconds

## create.topic.policy.class.name

The create topic policy class that should be used for validation. The class should implement the `org.apache.kafka.server.policy.CreateTopicPolicy` interface. 

Note: This policy runs on the controller instead of the broker.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_create.topic.policy.class.name

## delegation.token.expiry.check.interval.ms

Scan interval to remove expired delegation tokens.

- **Type:** long
- **Default:** 3600000 (1 hour)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_delegation.token.expiry.check.interval.ms

## kafka.metrics.polling.interval.secs

The metrics polling interval (in seconds) which can be used in kafka.metrics.reporters implementations.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_kafka.metrics.polling.interval.secs

## kafka.metrics.reporters

A list of classes to use as Yammer metrics custom reporters. The reporters should implement `kafka.metrics.KafkaMetricsReporter` trait. If a client wants to expose JMX operations on a custom reporter, the custom reporter needs to additionally implement an MBean trait that extends `kafka.metrics.KafkaMetricsReporterMBean` trait so that the registered MBean is compliant with the standard MBean convention.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_kafka.metrics.reporters

## listener.security.protocol.map

Map between listener names and security protocols. This must be defined for the same security protocol to be usable in more than one port or IP. For example, internal and external traffic can be separated even if SSL is required for both. Concretely, the user could define listeners with names INTERNAL and EXTERNAL and this property as: `INTERNAL:SSL,EXTERNAL:SSL`. As shown, key and value are separated by a colon and map entries are separated by commas. Each listener name should only appear once in the map. Different security (SSL and SASL) settings can be configured for each listener by adding a normalised prefix (the listener name is lowercased) to the config name. For example, to set a different keystore for the INTERNAL listener, a config with name `listener.name.internal.ssl.keystore.location` would be set. If the config for the listener name is not set, the config will fallback to the generic config (i.e. `ssl.keystore.location`). Note that in KRaft a default mapping from the listener names defined by `controller.listener.names` to PLAINTEXT is assumed if no explicit mapping is provided and no other security protocol is in use.

- **Type:** string
- **Default:** SASL_SSL:SASL_SSL,PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_listener.security.protocol.map

## log.dir.failure.timeout.ms

If the broker is unable to successfully communicate to the controller that some log directory has failed for longer than this time, the broker will fail and shut down.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.dir.failure.timeout.ms

## metadata.max.idle.interval.ms

This configuration controls how often the active controller should write no-op records to the metadata partition. If the value is 0, no-op records are not appended to the metadata partition. The default value is 500

- **Type:** int
- **Default:** 500
- **Valid Values:** [0,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metadata.max.idle.interval.ms

## metric.reporters

A list of classes to use as metrics reporters. Implementing the `org.apache.kafka.common.metrics.MetricsReporter` interface allows plugging in classes that will be notified of new metric creation. When custom reporters are set and `org.apache.kafka.common.metrics.JmxReporter` is needed, it has to be explicitly added to the list.

- **Type:** list
- **Default:** org.apache.kafka.common.metrics.JmxReporter
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metric.reporters

## metrics.num.samples

The number of samples maintained to compute metrics.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metrics.num.samples

## metrics.recording.level

The highest recording level for metrics. It has three levels for recording metrics - info, debug, and trace.

INFO level records only essential metrics necessary for monitoring system performance and health. It collects vital data without gathering too much detail, making it suitable for production environments where minimal overhead is desired.

DEBUG level records most metrics, providing more detailed information about the system's operation. It's useful for development and testing environments where you need deeper insights to debug and fine-tune the application.

TRACE level records all possible metrics, capturing every detail about the system's performance and operation. It's best for controlled environments where in-depth analysis is required, though it can introduce significant overhead.

- **Type:** string
- **Default:** INFO
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metrics.recording.level

## metrics.sample.window.ms

The window of time a metrics sample is computed over.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_metrics.sample.window.ms

## producer.id.expiration.ms

The time in ms that a topic partition leader will wait before expiring producer IDs. Producer IDs will not expire while a transaction associated to them is still ongoing. Note that producer IDs may expire sooner if the last write from the producer ID is deleted due to the topic's retention settings. Setting this value the same or higher than `delivery.timeout.ms` can help prevent expiration during retries and protect against message duplication, but the default should be reasonable for most use cases.

- **Type:** int
- **Default:** 86400000 (1 day)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_producer.id.expiration.ms

## quota.window.num

The number of samples to retain in memory for client quotas

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_quota.window.num

## quota.window.size.seconds

The time span of each sample for client quotas

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_quota.window.size.seconds

## remote.log.index.file.cache.total.size.bytes

The total size of the space allocated to store index files fetched from remote storage in the local storage.

- **Type:** long
- **Default:** 1073741824 (1 gibibyte)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.index.file.cache.total.size.bytes

## remote.log.manager.task.interval.ms

Interval at which remote log manager runs the scheduled tasks like copy segments, and clean up remote log segments.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.manager.task.interval.ms

## remote.log.metadata.custom.metadata.max.bytes

The maximum size of custom metadata in bytes that the broker should accept from a remote storage plugin. If custom metadata exceeds this limit, the updated segment metadata will not be stored, the copied data will be attempted to delete, and the remote copying task for this topic-partition will stop with an error.

- **Type:** int
- **Default:** 128
- **Valid Values:** [0,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_remote.log.metadata.custom.metadata.max.bytes

## replication.quota.window.num

The number of samples to retain in memory for replication quotas

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replication.quota.window.num

## replication.quota.window.size.seconds

The time span of each sample for replication quotas

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replication.quota.window.size.seconds

## sasl.login.connect.timeout.ms

The (optional) value in milliseconds for the external authentication provider connection timeout. Currently applies only to OAUTHBEARER.

- **Type:** int
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.connect.timeout.ms

## sasl.login.read.timeout.ms

The (optional) value in milliseconds for the external authentication provider read timeout. Currently applies only to OAUTHBEARER.

- **Type:** int
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.read.timeout.ms

## sasl.login.retry.backoff.max.ms

The (optional) value in milliseconds for the maximum wait between login attempts to the external authentication provider. Login uses an exponential backoff algorithm with an initial wait based on the sasl.login.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.login.retry.backoff.max.ms setting. Currently applies only to OAUTHBEARER.

- **Type:** long
- **Default:** 10000 (10 seconds)
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.retry.backoff.max.ms

## sasl.login.retry.backoff.ms

The (optional) value in milliseconds for the initial wait between login attempts to the external authentication provider. Login uses an exponential backoff algorithm with an initial wait based on the sasl.login.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.login.retry.backoff.max.ms setting. Currently applies only to OAUTHBEARER.

- **Type:** long
- **Default:** 100
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.login.retry.backoff.ms

## sasl.oauthbearer.assertion.claim.exp.seconds

The number of seconds in the future for which the JWT is valid. The value is used to determine the JWT `exp` (Expiration) claim based on the current system time when the JWT is created.

The formula to generate the `exp` claim is very simple:Let:

x = the current timestamp in seconds, on client
y = the value of this configuration

Then:

exp = x + y

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** int
- **Default:** 300
- **Valid Values:** [0,...,86400]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.claim.exp.seconds

## sasl.oauthbearer.assertion.claim.nbf.seconds

The number of seconds in the past from which the JWT is valid. The value is used to determine the JWT `nbf` (Not Before) claim based on the current system time when the JWT is created.

The formula to generate the `nbf` claim is very simple:Let:

x = the current timestamp in seconds, on client
y = the value of this configuration

Then:

nbf = x - y

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** int
- **Default:** 60
- **Valid Values:** [0,...,3600]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.assertion.claim.nbf.seconds

## sasl.oauthbearer.clock.skew.seconds

The (optional) value in seconds to allow for differences between the time of the OAuth/OIDC identity provider and the broker.

- **Type:** int
- **Default:** 30
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.clock.skew.seconds

## sasl.oauthbearer.jwks.endpoint.refresh.ms

The (optional) value in milliseconds for the broker to wait between refreshing its JWKS (JSON Web Key Set) cache that contains the keys to verify the signature of the JWT.

- **Type:** long
- **Default:** 3600000 (1 hour)
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.jwks.endpoint.refresh.ms

## sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms

The (optional) value in milliseconds for the maximum wait between attempts to retrieve the JWKS (JSON Web Key Set) from the external authentication provider. JWKS retrieval uses an exponential backoff algorithm with an initial wait based on the sasl.oauthbearer.jwks.endpoint.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms setting.

- **Type:** long
- **Default:** 10000 (10 seconds)
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms

## sasl.oauthbearer.jwks.endpoint.retry.backoff.ms

The (optional) value in milliseconds for the initial wait between JWKS (JSON Web Key Set) retrieval attempts from the external authentication provider. JWKS retrieval uses an exponential backoff algorithm with an initial wait based on the sasl.oauthbearer.jwks.endpoint.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms setting.

- **Type:** long
- **Default:** 100
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.jwks.endpoint.retry.backoff.ms

## sasl.oauthbearer.scope.claim.name

The OAuth claim for the scope is often named "scope", but this (optional) setting can provide a different name to use for the scope included in the JWT payload's claims if the OAuth/OIDC provider uses a different name for that claim.

- **Type:** string
- **Default:** scope
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.scope.claim.name

## sasl.oauthbearer.sub.claim.name

The OAuth claim for the subject is often named "sub", but this (optional) setting can provide a different name to use for the subject included in the JWT payload's claims if the OAuth/OIDC provider uses a different name for that claim.

- **Type:** string
- **Default:** sub
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.oauthbearer.sub.claim.name

## security.providers

A list of configurable creator classes each returning a provider implementing security algorithms. These classes should implement the `org.apache.kafka.common.security.auth.SecurityProviderCreator` interface.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_security.providers

## ssl.allow.dn.changes

Indicates whether changes to the certificate distinguished name should be allowed during a dynamic reconfiguration of certificates or not.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.allow.dn.changes

## ssl.allow.san.changes

Indicates whether changes to the certificate subject alternative names should be allowed during a dynamic reconfiguration of certificates or not.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.allow.san.changes

## ssl.endpoint.identification.algorithm

The endpoint identification algorithm to validate server hostname using server certificate.

- **Type:** string
- **Default:** https
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.endpoint.identification.algorithm

## ssl.engine.factory.class

The class of type org.apache.kafka.common.security.auth.SslEngineFactory to provide SSLEngine objects. Default value is org.apache.kafka.common.security.ssl.DefaultSslEngineFactory. Alternatively, setting this to org.apache.kafka.common.security.ssl.CommonNameLoggingSslEngineFactory will log the common name of expired SSL certificates used by clients to authenticate at any of the brokers with log level INFO. Note that this will cause a tiny delay during establishment of new connections from mTLS clients to brokers due to the extra code for examining the certificate chain provided by the client. Note further that the implementation uses a custom truststore based on the standard Java truststore and thus might be considered a security risk due to not being as mature as the standard one.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.engine.factory.class

## ssl.principal.mapping.rules

A list of rules for mapping from distinguished name from the client certificate to short name. The rules are evaluated in order and the first rule that matches a principal name is used to map it to a short name. Any later rules in the list are ignored. By default, distinguished name of the X.500 certificate will be the principal. For more details on the format please see security authorization and acls. Note that this configuration is ignored if an extension of KafkaPrincipalBuilder is provided by the `principal.builder.class` configuration.

- **Type:** string
- **Default:** DEFAULT
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.principal.mapping.rules

## ssl.secure.random.implementation

The SecureRandom PRNG implementation to use for SSL cryptography operations.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** per-broker
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.secure.random.implementation

## telemetry.max.bytes

The maximum size (after compression if compression is used) of telemetry metrics pushed from a client to the broker. The default value is 1048576 (1 MB).

- **Type:** int
- **Default:** 1048576 (1 mebibyte)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_telemetry.max.bytes

## transaction.abort.timed.out.transaction.cleanup.interval.ms

The interval at which to rollback transactions that have timed out

- **Type:** int
- **Default:** 10000 (10 seconds)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.abort.timed.out.transaction.cleanup.interval.ms

## transaction.partition.verification.enable

Enable verification that checks that the partition has been added to the transaction before writing transactional records to the partition

- **Type:** boolean
- **Default:** true
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** cluster-wide
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.partition.verification.enable

## transaction.remove.expired.transaction.cleanup.interval.ms

The interval at which to remove transactions that have expired due to `transactional.id.expiration.ms` passing

- **Type:** int
- **Default:** 3600000 (1 hour)
- **Valid Values:** [1,...]
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.remove.expired.transaction.cleanup.interval.ms

## transaction.two.phase.commit.enable

Allow participation in Two-Phase Commit (2PC) transactions with an external transaction coordinator

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** low
- **Update Mode:** read-only
- **Docs:** https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_transaction.two.phase.commit.enable
