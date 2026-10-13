# Acme Global Bank - Kafka Platform: Cluster Inventory

> **Fictional example data.** People, ids, dates and contract details are invented as an example.

Acme runs Apache Kafka as the **Event Streaming Platform (ESP)**, owned by the Enterprise Messaging Platform organisation (Head of Messaging Platform: Sofia Marques). Kafka is Acme's standard for high-volume event streams between internal applications. Other messaging technologies may be used for other patterns.

## Clusters

| Cluster | Environment | Tier | Datacenter | Kafka version | Topology | Security | Business owner |
|---|---|---|---|---|---|---|---|
| **KAFKA-PRD-01** (`my-cluster`) | PROD | **Tier 1** (business-critical, not payment-switching) | Singapore (SG-DC1), brokers rack-aware across `az-a`, `az-b`, `az-c` | **4.2.2** | KRaft: 3 dedicated controllers (ids 1-3) + 3 brokers (ids 101-103), RF=3, `min.insync.replicas=2` | SASL_SSL, SCRAM-SHA-512, ACLs (StandardAuthorizer), no anonymous access, auto topic creation disabled | Retail Banking Technology |

There is no separate UAT cluster in this example. Non-production use goes through the same cluster under the `*.uat.*` topic prefix only after Platform approval (see `app-onboarding.md`).

## Connection details (for onboarding)

- **Bootstrap servers:** `kafka-1:9092,kafka-2:9092,kafka-3:9092` (client listener, TLS + SASL).
- **Authentication:** SASL/SCRAM-SHA-512. One principal per application (`<app>-svc`). No shared credentials.
- **Trust:** TLS certificates are signed by the **Acme ESP CA**. Clients must trust it; the PEM is distributed through the secrets vault path `kv/esp/ca.pem`. Do not disable certificate or hostname verification.
- **Admin / monitoring principals** (not for applications): `admin` (platform team only), `mcp-reader` (read-only AIOps, describe only), `kafka-exporter` (metrics).

## Topics (live inventory)

| Topic | Partitions | RF | Cleanup / retention | Data class | Owning team |
|---|---|---|---|---|---|
| `orders.order.created` | 6 | 3 | delete, 7 days (default) | Internal | Orders |
| `orders.order.shipped` | 6 | 3 | delete, 7 days | Internal | Orders |
| `orders.order.created.dlq` | 3 | 3 | delete, 7 days | Internal | Orders |
| `payments.payment.authorized` | 6 | 3 | delete, 7 days | **PCI-scope** | Payments Platform |
| `payments.payment.settled` | 6 | 3 | delete, **30 days** (`retention.ms=2592000000`) | **PCI-scope** | Payments Platform |
| `inventory.stock.updated` | 3 | 3 | **compact** (latest value per key kept) | Internal | Inventory |
| `notifications.email.requested` | 3 | 3 | delete, 7 days | Confidential (contains customer email) | Notifications |

## Application principals and consumer groups (live)

| Principal | Application | May write | May read (group) |
|---|---|---|---|
| `orders-producer` | Orders service | `orders.order.created` | - |
| `payments-svc` | Payments service | - | `orders.order.created` (`payments-consumer`) |
| `inventory-svc` | Inventory service | - | `orders.order.created` (`inventory-consumer`) |
| `notifications-svc` | Notifications service | - | `orders.order.created` (`notifications-consumer`) |

ACLs are least-privilege by design: an application can only do what is listed. `inventory-svc` cannot write to `orders.order.created` and that is intentional.

## Certificates and lifecycle

- Broker and controller TLS certificates and the ESP CA **expire 2029-01-11**. Rotation runbook: `RB-KAFKA-007` (`runbooks-and-change.md`). Start rotation at least 90 days before expiry.
- Kafka 4.2.2 is the current approved release. Upgrade to 4.3.x is planned (see `runbooks-and-change.md`, planned changes).
