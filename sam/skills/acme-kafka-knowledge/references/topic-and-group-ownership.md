# Acme Global Bank - Kafka Topic and Consumer Group Ownership

> **Fictional example data.**

Every topic and consumer group has exactly one owning team, accountable for its configuration, retention, access approvals and incident response. Ownership is recorded in the CMDB and mirrored here.

## Ownership register

| Topic / group | Owning team | Line of business | Owner contact | Escalation (paging group) | Approves access |
|---|---|---|---|---|---|
| `orders.*` topics | Orders | Retail Banking - Digital Orders | Ravi Subramanian, ravi.subramanian@acmebank.example | **ORD-ONCALL** | Orders tech lead |
| group `payments-consumer` | Payments Platform | Retail Payments | Lena Fischer, lena.fischer@acmebank.example | **PAY-ONCALL** | Payments Platform lead + Risk (PCI) |
| `payments.*` topics | Payments Platform | Retail Payments | Lena Fischer | **PAY-ONCALL** | Payments Platform lead + **Risk & Compliance** (PCI-scope) |
| group `inventory-consumer`, topic `inventory.stock.updated` | Inventory | Retail Banking - Merchant Services | Hiro Tanaka, hiro.tanaka@acmebank.example | **INV-ONCALL** | Inventory lead |
| group `notifications-consumer`, topic `notifications.email.requested` | Notifications | Customer Engagement | Amara Osei, amara.osei@acmebank.example | **NOT-ONCALL** | Notifications lead + Data Privacy (customer email) |

The **platform team** (ESP) owns the cluster, the ACL mechanism, SCRAM user provisioning, quotas and the platform's own topics (`__consumer_offsets`, internal topics). ESP does not own application data.

## What the owner is responsible for

- Approving or denying access requests to their topics (`app-onboarding.md`).
- Topic configuration changes (partitions, retention, cleanup policy). Reducing retention on a compacted or PCI-scope topic needs a change record.
- Consumer lag and processing health of their groups: **a lagging consumer is the owning team's incident first**; ESP gets involved if the cause is on the platform side (broker down, under-replication, quota).
- Dead-letter topic handling: poison records parked in a `*.dlq` topic are reviewed by the owner.

## Rules that matter during an incident

- **Never delete, truncate or reduce retention on a topic to "clear" a backlog** without the owner's approval. `payments.*` topics are PCI-scope; `payments.payment.settled` feeds finance reconciliation and must not lose data inside its 30-day window; `inventory.stock.updated` is **compacted** (deleting or compaction changes lose the latest state per key).
- **Resetting consumer offsets** (replaying or skipping messages) changes what an application processes. It requires the **group owner's approval** and, for `payments-consumer`, a change record plus Risk notification. Always run `--dry-run` first and record the before/after offsets.
- **Stopping a consumer** is also owner-approved outside an agreed incident bridge.
