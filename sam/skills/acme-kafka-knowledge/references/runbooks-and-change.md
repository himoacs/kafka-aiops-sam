# Acme Global Bank - Kafka Runbooks, Known Risks and Change Calendar

> **Fictional example data.**

## Runbooks

| Id | Title | When | Summary |
|---|---|---|---|
| **RB-KAFKA-001** | Consumer lag | A group's lag grows or exceeds its SLA | Classify (no consumers / stuck / rebalancing / slow / producer burst / skew). Owner team acts first (scale, fix processing). ESP checks platform health only if lag is on many groups. **Never delete or truncate the topic.** |
| **RB-KAFKA-002** | Under-replicated / under-min-ISR partitions | URP alert, broker down | Identify the missing broker and cause; restore it; watch ISR expand. If under-min-ISR: P1, producers with `acks=all` are failing **by design**; restore brokers, **do not** lower `min.insync.replicas` or enable unclean leader election without DIM approval. |
| **RB-KAFKA-003** | Access request (ACL) | A team needs Read/Write on a topic | Follow `app-onboarding.md`; ESP applies least-privilege ACLs from the approved request. No wildcard ACLs, no `admin` credential sharing. |
| **RB-KAFKA-004** | Consumer offset reset | Replay or skip messages | Owner approval + change record (PCI: plus Risk). Stop the group, run `kafka-consumer-groups.sh --reset-offsets ... --dry-run`, record before/after offsets, then `--execute` on the bridge. |
| **RB-KAFKA-005** | Retention or cleanup-policy change | Disk pressure or compliance | Owner approval + change record. Never reduce retention on `payments.*` below 30 days or change `inventory.stock.updated` away from compaction. |
| **RB-KAFKA-006** | Broker or controller replacement / rolling restart | Maintenance, upgrade | One node at a time; wait for URP=0 and one active controller between nodes; only in a change window. |
| **RB-KAFKA-007** | TLS certificate and CA rotation | Certificates within 90 days of expiry | Issue new broker/controller certificates from the ESP CA, roll nodes one at a time, distribute the new CA to clients first. |
| **RB-KAFKA-008** | Poison record / DLQ handling | Consumer blocked on one record | Owner moves the record to `<topic>.dlq` or skips its offset (RB-KAFKA-004 approvals), then fixes the producer or parser. |

## Known risks

| Id | Risk | Status |
|---|---|---|
| **RISK-0231** | No UAT Kafka cluster; non-production traffic shares KAFKA-PRD-01 under the `*.uat.*` prefix | Accepted until the UAT cluster is funded (2027-Q1) |
| **RISK-0240** | **Client quotas are not yet enforced** on KAFKA-PRD-01 although the standard is 10 MB/s per application | Open; rollout planned in the 4.3 upgrade window |
| **RISK-0252** | `min.insync.replicas=2` is applied as a **dynamic cluster-wide default** rather than only in static broker config; it can be changed at runtime | Open; add it to static config in the next rolling restart (RB-KAFKA-006) |
| **RISK-0263** | Only one consumer instance per group on the example flows (no standby) | Accepted for non-critical groups; Payments to add a second instance |

## Planned changes and change freezes

| When | What | Impact |
|---|---|---|
| **2026-11-14 (Sat) 02:00-06:00 SGT** | Upgrade KAFKA-PRD-01 from 4.2.2 to 4.3.x (rolling), enable client quotas (RISK-0240) | Brief per-broker restarts; producers/consumers reconnect; no downtime expected |
| **2026-12-15 to 2027-01-05** | **Year-end change freeze** | No platform changes, no new topics or ACLs except P1 fixes; access requests queue until 2027-01-06 |
| **2029-01-11** | ESP CA and broker/controller certificates expire | Start RB-KAFKA-007 at least 90 days earlier (by 2028-10-13) |

Flag any of these when they fall within 90 days of today, or when an incident or request coincides with a freeze.
