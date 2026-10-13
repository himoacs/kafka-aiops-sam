---
title: Protocol error codes
source_url: https://kafka.apache.org/42/design/protocol/
kafka_version: 4.2
source_path: content/en/42/generated/protocol_errors.html
---

# Protocol error codes (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## UNKNOWN_SERVER_ERROR (code -1)

- **Code:** -1
- **Retriable:** False
- **Description:** The server experienced an unexpected error when processing the request.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NONE (code 0)

- **Code:** 0
- **Retriable:** False
- **Description:** (empty)
- **Docs:** https://kafka.apache.org/42/design/protocol/

## OFFSET_OUT_OF_RANGE (code 1)

- **Code:** 1
- **Retriable:** False
- **Description:** The requested offset is not within the range of offsets maintained by the server.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## CORRUPT_MESSAGE (code 2)

- **Code:** 2
- **Retriable:** True
- **Description:** This message has failed its CRC checksum, exceeds the valid size, has a null key for a compacted topic, or is otherwise corrupt.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_TOPIC_OR_PARTITION (code 3)

- **Code:** 3
- **Retriable:** True
- **Description:** This server does not host this topic-partition.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_FETCH_SIZE (code 4)

- **Code:** 4
- **Retriable:** False
- **Description:** The requested fetch size is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## LEADER_NOT_AVAILABLE (code 5)

- **Code:** 5
- **Retriable:** True
- **Description:** There is no leader for this topic-partition as we are in the middle of a leadership election.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NOT_LEADER_OR_FOLLOWER (code 6)

- **Code:** 6
- **Retriable:** True
- **Description:** For requests intended only for the leader, this error indicates that the broker is not the current leader. For requests intended for any replica, this error indicates that the broker is not a replica of the topic partition.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## REQUEST_TIMED_OUT (code 7)

- **Code:** 7
- **Retriable:** True
- **Description:** The request timed out.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## BROKER_NOT_AVAILABLE (code 8)

- **Code:** 8
- **Retriable:** False
- **Description:** The broker is not available.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## REPLICA_NOT_AVAILABLE (code 9)

- **Code:** 9
- **Retriable:** True
- **Description:** The replica is not available for the requested topic-partition. Produce/Fetch requests and other requests intended only for the leader or follower return NOT_LEADER_OR_FOLLOWER if the broker is not a replica of the topic-partition.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## MESSAGE_TOO_LARGE (code 10)

- **Code:** 10
- **Retriable:** False
- **Description:** The request included a message larger than the max message size the server will accept.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## STALE_CONTROLLER_EPOCH (code 11)

- **Code:** 11
- **Retriable:** False
- **Description:** The controller moved to another broker.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## OFFSET_METADATA_TOO_LARGE (code 12)

- **Code:** 12
- **Retriable:** False
- **Description:** The metadata field of the offset request was too large.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NETWORK_EXCEPTION (code 13)

- **Code:** 13
- **Retriable:** True
- **Description:** The server disconnected before a response was received.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## COORDINATOR_LOAD_IN_PROGRESS (code 14)

- **Code:** 14
- **Retriable:** True
- **Description:** The coordinator is loading and hence can't process requests.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## COORDINATOR_NOT_AVAILABLE (code 15)

- **Code:** 15
- **Retriable:** True
- **Description:** The coordinator is not available.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NOT_COORDINATOR (code 16)

- **Code:** 16
- **Retriable:** True
- **Description:** This is not the correct coordinator.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_TOPIC_EXCEPTION (code 17)

- **Code:** 17
- **Retriable:** False
- **Description:** The request attempted to perform an operation on an invalid topic.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## RECORD_LIST_TOO_LARGE (code 18)

- **Code:** 18
- **Retriable:** False
- **Description:** The request included message batch larger than the configured segment size on the server.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NOT_ENOUGH_REPLICAS (code 19)

- **Code:** 19
- **Retriable:** True
- **Description:** Messages are rejected since there are fewer in-sync replicas than required.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NOT_ENOUGH_REPLICAS_AFTER_APPEND (code 20)

- **Code:** 20
- **Retriable:** True
- **Description:** Messages are written to the log, but to fewer in-sync replicas than required.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_REQUIRED_ACKS (code 21)

- **Code:** 21
- **Retriable:** False
- **Description:** Produce request specified an invalid value for required acks.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## ILLEGAL_GENERATION (code 22)

- **Code:** 22
- **Retriable:** False
- **Description:** Specified group generation id is not valid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INCONSISTENT_GROUP_PROTOCOL (code 23)

- **Code:** 23
- **Retriable:** False
- **Description:** The group member's supported protocols are incompatible with those of existing members or first group member tried to join with empty protocol type or empty protocol list.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_GROUP_ID (code 24)

- **Code:** 24
- **Retriable:** False
- **Description:** The group id is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_MEMBER_ID (code 25)

- **Code:** 25
- **Retriable:** False
- **Description:** The coordinator is not aware of this member.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_SESSION_TIMEOUT (code 26)

- **Code:** 26
- **Retriable:** False
- **Description:** The session timeout is not within the range allowed by the broker (as configured by group.min.session.timeout.ms and group.max.session.timeout.ms).
- **Docs:** https://kafka.apache.org/42/design/protocol/

## REBALANCE_IN_PROGRESS (code 27)

- **Code:** 27
- **Retriable:** False
- **Description:** The group is rebalancing, so a rejoin is needed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_COMMIT_OFFSET_SIZE (code 28)

- **Code:** 28
- **Retriable:** False
- **Description:** The committing offset data size is not valid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TOPIC_AUTHORIZATION_FAILED (code 29)

- **Code:** 29
- **Retriable:** False
- **Description:** Topic authorization failed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## GROUP_AUTHORIZATION_FAILED (code 30)

- **Code:** 30
- **Retriable:** False
- **Description:** Group authorization failed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## CLUSTER_AUTHORIZATION_FAILED (code 31)

- **Code:** 31
- **Retriable:** False
- **Description:** Cluster authorization failed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_TIMESTAMP (code 32)

- **Code:** 32
- **Retriable:** False
- **Description:** The timestamp of the message is out of acceptable range.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSUPPORTED_SASL_MECHANISM (code 33)

- **Code:** 33
- **Retriable:** False
- **Description:** The broker does not support the requested SASL mechanism.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## ILLEGAL_SASL_STATE (code 34)

- **Code:** 34
- **Retriable:** False
- **Description:** Request is not valid given the current SASL state.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSUPPORTED_VERSION (code 35)

- **Code:** 35
- **Retriable:** False
- **Description:** The version of API is not supported.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TOPIC_ALREADY_EXISTS (code 36)

- **Code:** 36
- **Retriable:** False
- **Description:** Topic with this name already exists.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_PARTITIONS (code 37)

- **Code:** 37
- **Retriable:** False
- **Description:** Number of partitions is below 1.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_REPLICATION_FACTOR (code 38)

- **Code:** 38
- **Retriable:** False
- **Description:** Replication factor is below 1 or larger than the number of available brokers.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_REPLICA_ASSIGNMENT (code 39)

- **Code:** 39
- **Retriable:** False
- **Description:** Replica assignment is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_CONFIG (code 40)

- **Code:** 40
- **Retriable:** False
- **Description:** Configuration is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NOT_CONTROLLER (code 41)

- **Code:** 41
- **Retriable:** True
- **Description:** This is not the correct controller for this cluster.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_REQUEST (code 42)

- **Code:** 42
- **Retriable:** False
- **Description:** This most likely occurs because of a request being malformed by the client library or the message was sent to an incompatible broker. See the broker logs for more details.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSUPPORTED_FOR_MESSAGE_FORMAT (code 43)

- **Code:** 43
- **Retriable:** False
- **Description:** The message format version on the broker does not support the request.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## POLICY_VIOLATION (code 44)

- **Code:** 44
- **Retriable:** False
- **Description:** Request parameters do not satisfy the configured policy.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## OUT_OF_ORDER_SEQUENCE_NUMBER (code 45)

- **Code:** 45
- **Retriable:** False
- **Description:** The broker received an out of order sequence number.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DUPLICATE_SEQUENCE_NUMBER (code 46)

- **Code:** 46
- **Retriable:** False
- **Description:** The broker received a duplicate sequence number.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_PRODUCER_EPOCH (code 47)

- **Code:** 47
- **Retriable:** False
- **Description:** Producer attempted to produce with an old epoch.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_TXN_STATE (code 48)

- **Code:** 48
- **Retriable:** False
- **Description:** The producer attempted a transactional operation in an invalid state.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_PRODUCER_ID_MAPPING (code 49)

- **Code:** 49
- **Retriable:** False
- **Description:** The producer attempted to use a producer id which is not currently assigned to its transactional id.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_TRANSACTION_TIMEOUT (code 50)

- **Code:** 50
- **Retriable:** False
- **Description:** The transaction timeout is larger than the maximum value allowed by the broker (as configured by transaction.max.timeout.ms).
- **Docs:** https://kafka.apache.org/42/design/protocol/

## CONCURRENT_TRANSACTIONS (code 51)

- **Code:** 51
- **Retriable:** True
- **Description:** The producer attempted to update a transaction while another concurrent operation on the same transaction was ongoing.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TRANSACTION_COORDINATOR_FENCED (code 52)

- **Code:** 52
- **Retriable:** False
- **Description:** Indicates that the transaction coordinator sending a WriteTxnMarker is no longer the current coordinator for a given producer.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TRANSACTIONAL_ID_AUTHORIZATION_FAILED (code 53)

- **Code:** 53
- **Retriable:** False
- **Description:** Transactional Id authorization failed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## SECURITY_DISABLED (code 54)

- **Code:** 54
- **Retriable:** False
- **Description:** Security features are disabled.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## OPERATION_NOT_ATTEMPTED (code 55)

- **Code:** 55
- **Retriable:** False
- **Description:** The broker did not attempt to execute this operation. This may happen for batched RPCs where some operations in the batch failed, causing the broker to respond without trying the rest.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## KAFKA_STORAGE_ERROR (code 56)

- **Code:** 56
- **Retriable:** True
- **Description:** Disk error when trying to access log file on the disk.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## LOG_DIR_NOT_FOUND (code 57)

- **Code:** 57
- **Retriable:** False
- **Description:** The user-specified log directory is not found in the broker config.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## SASL_AUTHENTICATION_FAILED (code 58)

- **Code:** 58
- **Retriable:** False
- **Description:** SASL Authentication failed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_PRODUCER_ID (code 59)

- **Code:** 59
- **Retriable:** False
- **Description:** This exception is raised by the broker if it could not locate the producer metadata associated with the producerId in question. This could happen if, for instance, the producer's records were deleted because their retention time had elapsed. Once the last records of the producerId are removed, the producer's metadata is removed from the broker, and future appends by the producer will return this exception.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## REASSIGNMENT_IN_PROGRESS (code 60)

- **Code:** 60
- **Retriable:** False
- **Description:** A partition reassignment is in progress.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DELEGATION_TOKEN_AUTH_DISABLED (code 61)

- **Code:** 61
- **Retriable:** False
- **Description:** Delegation Token feature is not enabled.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DELEGATION_TOKEN_NOT_FOUND (code 62)

- **Code:** 62
- **Retriable:** False
- **Description:** Delegation Token is not found on server.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DELEGATION_TOKEN_OWNER_MISMATCH (code 63)

- **Code:** 63
- **Retriable:** False
- **Description:** Specified Principal is not valid Owner/Renewer.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DELEGATION_TOKEN_REQUEST_NOT_ALLOWED (code 64)

- **Code:** 64
- **Retriable:** False
- **Description:** Delegation Token requests are not allowed on PLAINTEXT/1-way SSL channels and on delegation token authenticated channels.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DELEGATION_TOKEN_AUTHORIZATION_FAILED (code 65)

- **Code:** 65
- **Retriable:** False
- **Description:** Delegation Token authorization failed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DELEGATION_TOKEN_EXPIRED (code 66)

- **Code:** 66
- **Retriable:** False
- **Description:** Delegation Token is expired.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_PRINCIPAL_TYPE (code 67)

- **Code:** 67
- **Retriable:** False
- **Description:** Supplied principalType is not supported.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NON_EMPTY_GROUP (code 68)

- **Code:** 68
- **Retriable:** False
- **Description:** The group is not empty.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## GROUP_ID_NOT_FOUND (code 69)

- **Code:** 69
- **Retriable:** False
- **Description:** The group id does not exist.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FETCH_SESSION_ID_NOT_FOUND (code 70)

- **Code:** 70
- **Retriable:** True
- **Description:** The fetch session ID was not found.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_FETCH_SESSION_EPOCH (code 71)

- **Code:** 71
- **Retriable:** True
- **Description:** The fetch session epoch is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## LISTENER_NOT_FOUND (code 72)

- **Code:** 72
- **Retriable:** True
- **Description:** There is no listener on the leader broker that matches the listener on which metadata request was processed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TOPIC_DELETION_DISABLED (code 73)

- **Code:** 73
- **Retriable:** False
- **Description:** Topic deletion is disabled.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FENCED_LEADER_EPOCH (code 74)

- **Code:** 74
- **Retriable:** True
- **Description:** The leader epoch in the request is older than the epoch on the broker.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_LEADER_EPOCH (code 75)

- **Code:** 75
- **Retriable:** True
- **Description:** The leader epoch in the request is newer than the epoch on the broker.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSUPPORTED_COMPRESSION_TYPE (code 76)

- **Code:** 76
- **Retriable:** False
- **Description:** The requesting client does not support the compression type of given partition.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## STALE_BROKER_EPOCH (code 77)

- **Code:** 77
- **Retriable:** False
- **Description:** Broker epoch has changed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## OFFSET_NOT_AVAILABLE (code 78)

- **Code:** 78
- **Retriable:** True
- **Description:** The leader high watermark has not caught up from a recent leader election so the offsets cannot be guaranteed to be monotonically increasing.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## MEMBER_ID_REQUIRED (code 79)

- **Code:** 79
- **Retriable:** False
- **Description:** The group member needs to have a valid member id before actually entering a consumer group.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## PREFERRED_LEADER_NOT_AVAILABLE (code 80)

- **Code:** 80
- **Retriable:** True
- **Description:** The preferred leader was not available.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## GROUP_MAX_SIZE_REACHED (code 81)

- **Code:** 81
- **Retriable:** False
- **Description:** The group has reached its maximum size.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FENCED_INSTANCE_ID (code 82)

- **Code:** 82
- **Retriable:** False
- **Description:** The broker rejected this static consumer since another consumer with the same group.instance.id has registered with a different member.id.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## ELIGIBLE_LEADERS_NOT_AVAILABLE (code 83)

- **Code:** 83
- **Retriable:** True
- **Description:** Eligible topic partition leaders are not available.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## ELECTION_NOT_NEEDED (code 84)

- **Code:** 84
- **Retriable:** True
- **Description:** Leader election not needed for topic partition.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NO_REASSIGNMENT_IN_PROGRESS (code 85)

- **Code:** 85
- **Retriable:** False
- **Description:** No partition reassignment is in progress.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## GROUP_SUBSCRIBED_TO_TOPIC (code 86)

- **Code:** 86
- **Retriable:** False
- **Description:** Deleting offsets of a topic is forbidden while the consumer group is actively subscribed to it.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_RECORD (code 87)

- **Code:** 87
- **Retriable:** False
- **Description:** This record has failed the validation on broker and hence will be rejected.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSTABLE_OFFSET_COMMIT (code 88)

- **Code:** 88
- **Retriable:** True
- **Description:** There are unstable offsets that need to be cleared.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## THROTTLING_QUOTA_EXCEEDED (code 89)

- **Code:** 89
- **Retriable:** True
- **Description:** The throttling quota has been exceeded.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## PRODUCER_FENCED (code 90)

- **Code:** 90
- **Retriable:** False
- **Description:** There is a newer producer with the same transactionalId which fences the current one.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## RESOURCE_NOT_FOUND (code 91)

- **Code:** 91
- **Retriable:** False
- **Description:** A request illegally referred to a resource that does not exist.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DUPLICATE_RESOURCE (code 92)

- **Code:** 92
- **Retriable:** False
- **Description:** A request illegally referred to the same resource twice.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNACCEPTABLE_CREDENTIAL (code 93)

- **Code:** 93
- **Retriable:** False
- **Description:** Requested credential would not meet criteria for acceptability.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INCONSISTENT_VOTER_SET (code 94)

- **Code:** 94
- **Retriable:** False
- **Description:** Indicates that the either the sender or recipient of a voter-only request is not one of the expected voters.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_UPDATE_VERSION (code 95)

- **Code:** 95
- **Retriable:** False
- **Description:** The given update version was invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FEATURE_UPDATE_FAILED (code 96)

- **Code:** 96
- **Retriable:** False
- **Description:** Unable to update finalized features due to an unexpected server error.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## PRINCIPAL_DESERIALIZATION_FAILURE (code 97)

- **Code:** 97
- **Retriable:** False
- **Description:** Request principal deserialization failed during forwarding. This indicates an internal error on the broker cluster security setup.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## SNAPSHOT_NOT_FOUND (code 98)

- **Code:** 98
- **Retriable:** False
- **Description:** Requested snapshot was not found.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## POSITION_OUT_OF_RANGE (code 99)

- **Code:** 99
- **Retriable:** False
- **Description:** Requested position is not greater than or equal to zero, and less than the size of the snapshot.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_TOPIC_ID (code 100)

- **Code:** 100
- **Retriable:** True
- **Description:** This server does not host this topic ID.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DUPLICATE_BROKER_REGISTRATION (code 101)

- **Code:** 101
- **Retriable:** False
- **Description:** This broker ID is already in use.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## BROKER_ID_NOT_REGISTERED (code 102)

- **Code:** 102
- **Retriable:** False
- **Description:** The given broker ID was not registered.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INCONSISTENT_TOPIC_ID (code 103)

- **Code:** 103
- **Retriable:** True
- **Description:** The log's topic ID did not match the topic ID in the request.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INCONSISTENT_CLUSTER_ID (code 104)

- **Code:** 104
- **Retriable:** False
- **Description:** The clusterId in the request does not match that found on the server.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TRANSACTIONAL_ID_NOT_FOUND (code 105)

- **Code:** 105
- **Retriable:** False
- **Description:** The transactionalId could not be found.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FETCH_SESSION_TOPIC_ID_ERROR (code 106)

- **Code:** 106
- **Retriable:** True
- **Description:** The fetch session encountered inconsistent topic ID usage.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INELIGIBLE_REPLICA (code 107)

- **Code:** 107
- **Retriable:** False
- **Description:** The new ISR contains at least one ineligible replica.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## NEW_LEADER_ELECTED (code 108)

- **Code:** 108
- **Retriable:** False
- **Description:** The AlterPartition request successfully updated the partition state but the leader has changed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## OFFSET_MOVED_TO_TIERED_STORAGE (code 109)

- **Code:** 109
- **Retriable:** False
- **Description:** The requested offset is moved to tiered storage.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FENCED_MEMBER_EPOCH (code 110)

- **Code:** 110
- **Retriable:** False
- **Description:** The member epoch is fenced by the group coordinator. The member must abandon all its partitions and rejoin.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNRELEASED_INSTANCE_ID (code 111)

- **Code:** 111
- **Retriable:** False
- **Description:** The instance ID is still used by another member in the consumer group. That member must leave first.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSUPPORTED_ASSIGNOR (code 112)

- **Code:** 112
- **Retriable:** False
- **Description:** The assignor or its version range is not supported by the consumer group.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## STALE_MEMBER_EPOCH (code 113)

- **Code:** 113
- **Retriable:** False
- **Description:** The member epoch is stale. The member must retry after receiving its updated member epoch via the ConsumerGroupHeartbeat API.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## MISMATCHED_ENDPOINT_TYPE (code 114)

- **Code:** 114
- **Retriable:** False
- **Description:** The request was sent to an endpoint of the wrong type.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNSUPPORTED_ENDPOINT_TYPE (code 115)

- **Code:** 115
- **Retriable:** False
- **Description:** This endpoint type is not supported yet.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_CONTROLLER_ID (code 116)

- **Code:** 116
- **Retriable:** False
- **Description:** This controller ID is not known.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## UNKNOWN_SUBSCRIPTION_ID (code 117)

- **Code:** 117
- **Retriable:** False
- **Description:** Client sent a push telemetry request with an invalid or outdated subscription ID.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TELEMETRY_TOO_LARGE (code 118)

- **Code:** 118
- **Retriable:** False
- **Description:** Client sent a push telemetry request larger than the maximum size the broker will accept.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_REGISTRATION (code 119)

- **Code:** 119
- **Retriable:** False
- **Description:** The controller has considered the broker registration to be invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## TRANSACTION_ABORTABLE (code 120)

- **Code:** 120
- **Retriable:** False
- **Description:** The server encountered an error with the transaction. The client can abort the transaction to continue using this transactional ID.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_RECORD_STATE (code 121)

- **Code:** 121
- **Retriable:** False
- **Description:** The record state is invalid. The acknowledgement of delivery could not be completed.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## SHARE_SESSION_NOT_FOUND (code 122)

- **Code:** 122
- **Retriable:** True
- **Description:** The share session was not found.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_SHARE_SESSION_EPOCH (code 123)

- **Code:** 123
- **Retriable:** True
- **Description:** The share session epoch is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## FENCED_STATE_EPOCH (code 124)

- **Code:** 124
- **Retriable:** False
- **Description:** The share coordinator rejected the request because the share-group state epoch did not match.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_VOTER_KEY (code 125)

- **Code:** 125
- **Retriable:** False
- **Description:** The voter key doesn't match the receiving replica's key.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## DUPLICATE_VOTER (code 126)

- **Code:** 126
- **Retriable:** False
- **Description:** The voter is already part of the set of voters.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## VOTER_NOT_FOUND (code 127)

- **Code:** 127
- **Retriable:** False
- **Description:** The voter is not part of the set of voters.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## INVALID_REGULAR_EXPRESSION (code 128)

- **Code:** 128
- **Retriable:** False
- **Description:** The regular expression is not valid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## REBOOTSTRAP_REQUIRED (code 129)

- **Code:** 129
- **Retriable:** False
- **Description:** Client metadata is stale. The client should rebootstrap to obtain new metadata.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## STREAMS_INVALID_TOPOLOGY (code 130)

- **Code:** 130
- **Retriable:** False
- **Description:** The supplied topology is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## STREAMS_INVALID_TOPOLOGY_EPOCH (code 131)

- **Code:** 131
- **Retriable:** False
- **Description:** The supplied topology epoch is invalid.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## STREAMS_TOPOLOGY_FENCED (code 132)

- **Code:** 132
- **Retriable:** False
- **Description:** The supplied topology epoch is outdated.
- **Docs:** https://kafka.apache.org/42/design/protocol/

## SHARE_SESSION_LIMIT_REACHED (code 133)

- **Code:** 133
- **Retriable:** True
- **Description:** The limit of share sessions has been reached.
- **Docs:** https://kafka.apache.org/42/design/protocol/
