---
name: kafka-docs
description: >-
  Official Apache Kafka 4.2 documentation as searchable reference files -
  broker, topic, group, producer, consumer, admin and Connect configuration
  (defaults, valid values, dynamic update mode), protocol error codes, JMX
  metrics (broker, KRaft controller, group coordinator, producer, consumer,
  Connect), operations, KRaft, consumer rebalance protocol, eligible leader
  replicas, transactions, tiered storage, security (SASL, SSL, ACLs, listeners),
  upgrade and ZooKeeper-to-KRaft migration. Loaded by the Kafka expert
  knowledge agent whenever an answer depends on what Kafka documents - a config
  default, an error code, a metric, a procedure or a version change.
tags: [kafka, docs, reference, configs, error-codes, metrics, kraft]
---

# Kafka Documentation (Apache Kafka 4.2)

The other agents tell you what is happening on the cluster right now. This skill tells you what Kafka *documents*: what a setting does and defaults to, what an error code means, which metric measures what, and how an official procedure works.

Source: `apache/kafka-site` (Apache-2.0), commit pinned in `references/MANIFEST.md`. The demo cluster runs Kafka 4.2.x, so this is the matching version.

---

## 1. How to look things up

Search first, read second. The files are large (monitoring.md is ~128 KB, broker-configs.md ~150 KB); **never read a whole reference file**.

1. `grep_skill_resources` with `skill_name: kafka-docs`, `case_insensitive: true`, and `context_lines: 12` (use 25 for prose pages). Reference entries are `## <name>` blocks, so a hit with 12 context lines is the complete entry.
2. If a prose page matches, `read_skill_resource` on that file only when the grep context is not enough. Prefer a second, narrower grep over reading a whole page.
3. Try synonyms before concluding something is undocumented (see the table).

Every file starts with a frontmatter `source_url`; every reference entry ends with a `Docs:` line holding its URL. Use those URLs in citations.

---

## 2. Where to look

| Question involves | Search in | Typical grep pattern |
|---|---|---|
| A **broker** config: meaning, default, valid values, dynamic update mode | `references/reference/broker-configs.md` | `^## min.insync.replicas`, `^## unclean.leader` |
| A **topic** config (retention, cleanup, compaction, segment, min ISR overrides) | `references/reference/topic-configs.md` | `^## retention.ms`, `^## cleanup.policy` |
| A **consumer group** config (new protocol: heartbeat, session timeout, assignor) | `references/reference/group-configs.md` | `^## consumer.session` |
| A **producer** config (acks, idempotence, batching, delivery timeout, compression) | `references/reference/producer-configs.md` | `^## acks`, `^## enable.idempotence` |
| A **consumer** config (poll interval, offset reset, isolation level, fetch sizes) | `references/reference/consumer-configs.md` | `^## max.poll.interval`, `^## auto.offset.reset` |
| An **admin client** config | `references/reference/admin-client-configs.md` | |
| **Connect** worker config / Connect metrics | `references/reference/connect-configs.md`, `metrics-connect.md` | |
| **Tiered storage** configs | `references/reference/tiered-storage-configs.md` | `^## remote.log` |
| An **error code** seen in a log line or client exception | `references/reference/error-codes.md` | `^## NOT_ENOUGH`, `^## OFFSET_OUT_OF_RANGE`; also try without underscores, e.g. `NotEnoughReplicas` maps to `NOT_ENOUGH_REPLICAS` |
| A **metric** (JMX name, what it measures, MBean) for broker, KRaft, coordinator, tiered storage | `references/operations/monitoring.md` | `UnderReplicatedPartitions`, `ActiveControllerCount`, `IsrShrinksPerSec`, `kafka.server:type=raft-metrics` |
| A **client** metric (producer, consumer, connect) | `references/reference/metrics-producer.md`, `metrics-consumer.md`, `metrics-connect.md` | `records-lag-max`, `record-error-rate`, `rebalance-latency` |
| **KRaft** (quorum, controllers, voters, metadata, adding/removing controllers) | `references/operations/kraft.md` | `voter`, `quorum`, `bootstrap` |
| **Consumer rebalance** protocol (KIP-848) vs classic, group states | `references/operations/consumer-rebalance-protocol.md` | `rebalance`, `server-side` |
| **ISR / ELR** (eligible leader replicas) semantics | `references/operations/eligible-leader-replicas.md` | `ELR`, `min.insync` |
| **Transactions**, hung transactions, producer fencing | `references/operations/transaction-protocol.md` | `abort`, `LSO`, `transaction` |
| Day-to-day **operations**: topics, partitions, reassignment, retention, quotas, decommissioning, mirroring, leader election, throttling | `references/operations/basic-kafka-operations.md` | `kafka-reassign-partitions`, `kafka-leader-election`, `throttle`, `quota` |
| **Capacity, hardware, OS, disk, JVM**, page cache, file descriptors | `references/operations/hardware-and-os.md` | `page cache`, `flush`, `file descriptor` |
| **Multi-tenancy**, quotas | `references/operations/multi-tenancy.md` | `quota` |
| **Geo-replication / MirrorMaker 2**, datacenters | `references/operations/geo-replication-cross-cluster-data-mirroring.md`, `datacenters.md` | |
| **Tiered storage** | `references/operations/tiered-storage.md` | |
| **Security**: SASL (SCRAM, PLAIN, OAUTHBEARER), TLS, ACLs and the authorizer, listeners | `references/security/` (`authentication-using-sasl.md`, `authorization-and-acls.md`, `encryption-and-authentication-using-ssl.md`, `listener-configuration.md`) | `kafka-acls`, `super.users`, `SCRAM` |
| **Upgrade** between versions, rolling upgrade, removed or deprecated configs and APIs, client compatibility | `references/getting-started/upgrade.md`, `compatibility.md` | `Notable changes`, `removed`, `deprecated`, `4.0` |
| **ZooKeeper to KRaft** migration | `references/getting-started/zk2kraft.md` | `migration`, `dual-write` |
| **Log internals**: segments, retention, compaction, record format, replication | `references/implementation/` and `references/design/design.md` | `compaction`, `high watermark`, `leader epoch` |
| **Kafka Connect** usage and administration | `references/kafka-connect/` | `restart`, `task`, `converter` |
| Wire **protocol** | `references/design/protocol.md` | |

Synonyms: "ISR", "in-sync", "under replicated", "min isr", "under min isr" all point at `UnderReplicatedPartitions`, `UnderMinIsrPartitionCount`, `min.insync.replicas`. "Lag" is a consumer-side concept (`records-lag-max`, committed offset vs log end offset). "Controller" in KRaft means a quorum voter; `ActiveControllerCount` is reported by the active one.

---

## 3. Rules

1. **Never state a default, valid value, or error-code meaning from memory.** Confirm it in `references/reference/` first. Defaults change between releases.
2. **Say which version.** All content here is Apache Kafka **4.2**. If the question concerns another version (3.x, 4.3) or a feature not in these files, say so and use the live-web layer (section 5).
3. **Docs vs. this cluster.** The docs give the *default*. The live value on this cluster comes from the cluster-query agent. When they differ (for example, a broker or dynamic override), say so explicitly; do not present the default as the cluster's value.
4. **Quote precisely, keep it short.** Give the setting or metric name in backticks, the relevant sentence or two, and the URL. Do not paste whole entries.
5. **Distinguish documentation from advice.** If you recommend a value that the docs do not state, label it as a recommendation.
6. **If a grep finds nothing after synonyms, say it is not in the indexed docs** and offer the live-web layer; do not guess.

---

## 4. Citation format

**The URL must be copied or derived, never invented.** Two cases:

- **Reference entries** (`references/reference/*.md`): copy the entry's own `Docs:` line.
- **Prose pages** (everything else): the URL is `https://kafka.apache.org/42/` + the file's path under `references/` without the `.md` + `/`. A grep hit may not show the page's header, so derive it from the path:

| File | URL |
|---|---|
| `operations/monitoring.md` | `https://kafka.apache.org/42/operations/monitoring/` |
| `operations/kraft.md` | `https://kafka.apache.org/42/operations/kraft/` |
| `getting-started/zk2kraft.md` | `https://kafka.apache.org/42/getting-started/zk2kraft/` |
| `getting-started/upgrade.md` | `https://kafka.apache.org/42/getting-started/upgrade/` |
| `security/authorization-and-acls.md` | `https://kafka.apache.org/42/security/authorization-and-acls/` |

Never use `/ops/`, `/documentation/#...` or any URL you did not copy or derive this way. Each prose page also has a `Docs:` line right under its title.

Cite each documented fact with the file and the URL it came from:

```
[Source: kafka-docs 4.2 · grep_skill_resources | file=reference/topic-configs.md, pattern=^## min.insync.replicas | url=https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.insync.replicas]
```

Use `read_skill_resource` as the tool name when you read the file instead of searching it. Follow the general rules in `kafka-response-citations`.

---

## 5. Live web layer (what is not indexed)

Not in these files: KIPs, JIRA tickets, release notes, the Apache blog, Kafka Streams documentation, and any version other than 4.2. For those, use the built-in web request tool, restricted to:

- KIPs: `https://cwiki.apache.org/confluence/display/KAFKA/` (for example KIP-848, KIP-966)
- JIRA: `https://issues.apache.org/jira/browse/KAFKA-<n>`
- Docs for another version: `https://kafka.apache.org/<version>/...` (for example `/39/` for 3.9)
- Release notes and blog: `https://kafka.apache.org/blog`, `https://downloads.apache.org/kafka/<version>/RELEASE_NOTES.html`

When you use the web, **say so**: cite it as `[Source: live web · <url> | fetched: <ISO8601 UTC>]` and mark the claim as coming from live web rather than the indexed 4.2 docs.
