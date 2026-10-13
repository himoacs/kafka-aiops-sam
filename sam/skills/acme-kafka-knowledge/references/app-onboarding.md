# Acme Global Bank - Kafka Access and Application Onboarding

> **Example data (fictional).** Replace with your own process; see `docs/customize-knowledge.md`.

Use this when a team asks for **access to Kafka** for an application, a new topic, or a new consumer group.

## Procedure: request Kafka access for an application

1. **Register the application** in the CMDB (application id, owning team, data classification of the data it will produce/consume, on-call group). *Lead time: same day.*
2. **Raise a Kafka Access Request** in Jira project **ESP-ACCESS** (template "Kafka Access Request") with: application id, environment, topics, **read or write** (separate lines), consumer group name, expected peak messages/s and average message size, data classification, and the on-call group.
3. **Approvals** (ESP routes these automatically from the ownership register in `topic-and-group-ownership.md`):
   - The **topic owner** for every topic requested (read or write).
   - **Risk & Compliance** additionally for **PCI-scope** topics (`payments.*`).
   - **Data Privacy** additionally for topics with customer personal data (`notifications.*`).
   - The **platform team** reviews capacity (partitions, throughput) and naming.
4. **ESP provisions**: the SCRAM principal `<app>-svc`, least-privilege ACLs (topic Read/Write, group Read), a client quota, and delivers credentials **once** through the secrets vault (`kv/esp/<app>`). Credentials are never sent by email or chat.
5. **Test** with the Java reference client (`java-client-standards.md`) against the allocated topics, then request go-live review for PROD.
6. **Go-live**: the owner confirms monitoring (consumer lag alert) and the on-call group; ESP adds the app to the AIOps watch list.

**Lead times:** standard request 3 business days after all approvals; PCI-scope or personal-data topics 7-10 business days (Risk/Privacy review); a new topic adds 1 day for capacity review. P4 questions: 2 business days.

## Naming standards

| Object | Pattern | Example |
|---|---|---|
| Topic | `<domain>.<entity>.<event>` (lowercase, dots, no underscores) | `orders.order.created` |
| Dead-letter topic | `<topic>.dlq` | `orders.order.created.dlq` |
| Principal | `<app>-svc` | `payments-svc` |
| Consumer group | `<app>-consumer` (or `<app>-<purpose>`) | `payments-consumer` |
| Client id | `<app>-<instance>` | `payments-svc-1` |

Topics are created by ESP through the request, **never by an application** (auto topic creation is disabled). Mixing `.` and `_` in topic names is prohibited (metric-name collisions).

## Defaults and limits

- New topics: **6 partitions** (3 for low volume), **replication factor 3**, `min.insync.replicas=2`, retention 7 days unless the owner justifies otherwise. Do not request `min.insync.replicas=1` or RF below 3: ESP will reject it.
- Partition counts can be raised later but never lowered; choose for the peak consumer parallelism you need, and think about key distribution (a skewed key creates a hot partition).
- **Quotas:** each application principal gets a default produce/fetch quota of **10 MB/s** (see known risk RISK-0240 in `runbooks-and-change.md`: quotas are not yet enforced on KAFKA-PRD-01).
- Maximum record size: **1 MB** (broker default). Larger payloads go to object storage with a pointer in the event.

## Security standards

- SASL_SSL with SCRAM-SHA-512 only. **No plaintext listeners, no disabling certificate or hostname verification.**
- Credentials from the vault or environment at runtime; **never in source code, images or logs**.
- PCI-scope and personal data: no payload logging; field-level encryption for card data is the producer's responsibility.
- Approved client library: official Apache `kafka-clients` **4.2.x** (Java) or librdkafka 2.x based clients (`confluent-kafka` for Python/Go/.NET). Other clients need a platform review.
