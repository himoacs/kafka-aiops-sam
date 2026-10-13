---
title: Tiered Storage Configs
source_url: https://kafka.apache.org/42/configuration/tiered-storage-configs/
kafka_version: 4.2
source_path: content/en/42/configuration/tiered-storage-configs.md
---

# Tiered Storage Configs

Docs: https://kafka.apache.org/42/configuration/tiered-storage-configs/

Below is the Tiered Storage configuration. 
> Reference table for this section: see `reference/tiered-storage-configs.md` (search it, do not read whole).
 

## RLMM Configs

Below is the configuration for `TopicBasedRemoteLogMetadataManager`, which is the default implementation of `RemoteLogMetadataManager`.

All configurations here should start with the prefix defined by `remote.log.metadata.manager.impl.prefix`, for example, `rlmm.config.remote.log.metadata.consume.wait.ms`.


 

The implementation of `TopicBasedRemoteLogMetadataManager` needs to create admin, producer, and consumer clients for the internal topic `__remote_log_metadata`.

Additional configurations can be provided for different types of clients using the following configuration properties: 
    
    
    # Configs for admin, producer, and consumer clients
    <rlmm.prefix>.remote.log.metadata.common.client.<kafka.property> = <value>
    
    # Configs only for producer client
    <rlmm.prefix>.remote.log.metadata.producer.<kafka.property> = <value>
    
    # Configs only for consumer client
    <rlmm.prefix>.remote.log.metadata.consumer.<kafka.property> = <value>
