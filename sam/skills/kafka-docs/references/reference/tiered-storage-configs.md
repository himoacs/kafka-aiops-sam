---
title: Tiered storage (remote log manager) configs
source_url: https://kafka.apache.org/42/configuration/tiered-storage-configs/
kafka_version: 4.2
source_path: content/en/42/generated/remote_log_manager_config.html
---

# Tiered storage (remote log manager) configs (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## log.local.retention.bytes

The maximum size of local log segments that can grow for a partition before it gets eligible for deletion. Default value is -2, it represents `log.retention.bytes` value to be used. The effective value should always be less than or equal to `log.retention.bytes` value.

- **Type:** long
- **Default:** -2
- **Valid Values:** [-2,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_log.local.retention.bytes

## log.local.retention.ms

The number of milliseconds to keep the local log segments before it gets eligible for deletion. Default value is -2, it represents `log.retention.ms` value is to be used. The effective value should always be less than or equal to `log.retention.ms` value.

- **Type:** long
- **Default:** -2
- **Valid Values:** [-2,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_log.local.retention.ms

## remote.fetch.max.wait.ms

The maximum amount of time the server will wait before answering the fetch request containing remote fetch partitions. It's important to be aware that the request will only be responded after all remote partitions have been successfully fetched, have failed, or this timeout is exceeded.

- **Type:** int
- **Default:** 500
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.fetch.max.wait.ms

## remote.list.offsets.request.timeout.ms

The maximum amount of time the server will wait for the remote list offsets request to complete.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.list.offsets.request.timeout.ms

## remote.log.manager.copier.thread.pool.size

Size of the thread pool used in scheduling tasks to copy segments.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.copier.thread.pool.size

## remote.log.manager.copy.max.bytes.per.second

The maximum number of bytes that can be copied from local storage to remote storage per second. This is a global limit for all the partitions that are being copied from local storage to remote storage. The default value is Long.MAX_VALUE, which means there is no limit on the number of bytes that can be copied per second.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.copy.max.bytes.per.second

## remote.log.manager.copy.quota.window.num

The number of samples to retain in memory for remote copy quota management. The default value is 11, which means there are 10 whole windows + 1 current window.

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.copy.quota.window.num

## remote.log.manager.copy.quota.window.size.seconds

The time span of each sample for remote copy quota management. The default value is 1 second.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.copy.quota.window.size.seconds

## remote.log.manager.expiration.thread.pool.size

Size of the thread pool used in scheduling tasks to clean up the expired remote log segments.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.expiration.thread.pool.size

## remote.log.manager.fetch.max.bytes.per.second

The maximum number of bytes that can be fetched from remote storage to local storage per second. This is a global limit for all the partitions that are being fetched from remote storage to local storage. The default value is Long.MAX_VALUE, which means there is no limit on the number of bytes that can be fetched per second.

- **Type:** long
- **Default:** 9223372036854775807
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.fetch.max.bytes.per.second

## remote.log.manager.fetch.quota.window.num

The number of samples to retain in memory for remote fetch quota management. The default value is 11, which means there are 10 whole windows + 1 current window.

- **Type:** int
- **Default:** 11
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.fetch.quota.window.num

## remote.log.manager.fetch.quota.window.size.seconds

The time span of each sample for remote fetch quota management. The default value is 1 second.

- **Type:** int
- **Default:** 1
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.fetch.quota.window.size.seconds

## remote.log.manager.follower.thread.pool.size

Size of the thread pool used in scheduling follower tasks to read the highest-uploaded remote-offset for follower partitions.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.follower.thread.pool.size

## remote.log.manager.thread.pool.size

Size of the thread pool used in scheduling follower tasks to read the highest-uploaded remote-offset for follower partitions. This config is deprecated since 4.2, please use `remote.log.manager.follower.thread.pool.size` instead.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.thread.pool.size

## remote.log.metadata.manager.class.name

Fully qualified class name of `RemoteLogMetadataManager` implementation.

- **Type:** string
- **Default:** org.apache.kafka.server.log.remote.metadata.storage.TopicBasedRemoteLogMetadataManager
- **Valid Values:** non-empty string
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.metadata.manager.class.name

## remote.log.metadata.manager.class.path

Class path of the `RemoteLogMetadataManager` implementation. If specified, the RemoteLogMetadataManager implementation and its dependent libraries will be loaded by a dedicated classloader which searches this class path before the Kafka broker class path. The syntax of this parameter is same as the standard Java class path string.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.metadata.manager.class.path

## remote.log.metadata.manager.impl.prefix

Prefix used for properties to be passed to RemoteLogMetadataManager implementation. For example this value can be `rlmm.config.`.

- **Type:** string
- **Default:** rlmm.config.
- **Valid Values:** non-empty string
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.metadata.manager.impl.prefix

## remote.log.metadata.manager.listener.name

Listener name of the local broker to which it should get connected if needed by RemoteLogMetadataManager implementation.

- **Type:** string
- **Default:** null
- **Valid Values:** non-empty string
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.metadata.manager.listener.name

## remote.log.reader.max.pending.tasks

Maximum remote log reader thread pool task queue size. If the task queue is full, fetch requests are served with an error.

- **Type:** int
- **Default:** 100
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.reader.max.pending.tasks

## remote.log.reader.threads

Size of the thread pool that is allocated for handling remote log reads.

- **Type:** int
- **Default:** 10
- **Valid Values:** [1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.reader.threads

## remote.log.storage.manager.class.name

Fully qualified class name of `RemoteStorageManager` implementation.

- **Type:** string
- **Default:** null
- **Valid Values:** non-empty string
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.storage.manager.class.name

## remote.log.storage.manager.class.path

Class path of the `RemoteStorageManager` implementation. If specified, the RemoteStorageManager implementation and its dependent libraries will be loaded by a dedicated classloader which searches this class path before the Kafka broker class path. The syntax of this parameter is same as the standard Java class path string.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.storage.manager.class.path

## remote.log.storage.manager.impl.prefix

Prefix used for properties to be passed to RemoteStorageManager implementation. For example this value can be `rsm.config.`.

- **Type:** string
- **Default:** rsm.config.
- **Valid Values:** non-empty string
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.storage.manager.impl.prefix

## remote.log.storage.system.enable

Whether to enable tiered storage functionality in a broker or not. When it is true broker starts all the services required for the tiered storage functionality.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.storage.system.enable

## remote.log.index.file.cache.total.size.bytes

The total size of the space allocated to store index files fetched from remote storage in the local storage.

- **Type:** long
- **Default:** 1073741824 (1 gibibyte)
- **Valid Values:** [1,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.index.file.cache.total.size.bytes

## remote.log.manager.task.interval.ms

Interval at which remote log manager runs the scheduled tasks like copy segments, and clean up remote log segments.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [1,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.manager.task.interval.ms

## remote.log.metadata.custom.metadata.max.bytes

The maximum size of custom metadata in bytes that the broker should accept from a remote storage plugin. If custom metadata exceeds this limit, the updated segment metadata will not be stored, the copied data will be attempted to delete, and the remote copying task for this topic-partition will stop with an error.

- **Type:** int
- **Default:** 128
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/tiered-storage-configs/#remote_log_manager_remote.log.metadata.custom.metadata.max.bytes
