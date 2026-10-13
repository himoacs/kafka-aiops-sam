# Acme Global Bank - Kafka Incident Severity and Escalation Process

> **Fictional example data.** People, phone numbers and paging groups are invented. 

This process applies to incidents on **KAFKA-PRD-01** and the applications using it. Severities are P1 (critical) to P4 (low).

## Severity matrix

| Severity | Definition | Examples | First response | Updates | Restore target |
|---|---|---|---|---|---|
| **P1 - Critical** | Data loss risk, or a PROD Tier 1 flow is down for all consumers/producers | Producers failing (`min.insync.replicas` violated, 2 brokers down); no active KRaft controller / quorum lost; offline partitions; a PCI-scope topic stopped | 15 minutes | 30 min | 1 hour |
| **P2 - High** | Redundancy lost or one team's flow badly degraded, no business outage yet | One broker or controller down (RF/quorum intact); under-replicated partitions; consumer group stuck or lagging past SLA on a Tier 1 flow; sustained produce errors | 30 minutes | Hourly | 4 hours |
| **P3 - Moderate** | A single consumer/application issue, or a non-urgent platform issue | One consumer slow or in a rebalance loop; authorization errors for one app; disk above 85% with days of headroom | 4 business hours | Daily | 3 business days |
| **P4 - Low** | Question or request | Access requests, sample code, onboarding, capacity planning | 2 business days | - | Best effort |

Raise the severity by one level if the incident hits during a change freeze, or affects a PCI-scope topic.

## Who owns the first response

1. **Application symptom** (a consumer lagging, an app getting authorization or timeout errors): the **owning team's on-call** (see `topic-and-group-ownership.md`: ORD-ONCALL, PAY-ONCALL, INV-ONCALL, NOT-ONCALL). They engage ESP if the evidence points to the platform.
2. **Platform symptom** (broker/controller down, under-replicated or offline partitions, quorum, disk, certificates): **ESP SRE on-call**, paging group **ESP-SRE-L2**. Primary engineers: Arjun Mehta (Mumbai, +91 22 4000 1182) and Chen Wei Lim (Singapore, +65 6000 4452).
3. **Escalation timer:** P1 not acknowledged within 15 minutes: page the ESP SRE Manager, Daniel Okafor (+65 6000 4400).
4. **Duty Incident Manager (DIM):** rota via ext. 5999. Runs the major-incident bridge for every P1 (Slack **#acme-mi-bridge**) and is the only person who may authorise failover or data-affecting actions.
5. **Kafka is open source.** There is no vendor support contract; L3 is the ESP engineering lead plus the Apache Kafka community (mailing lists, JIRA). Quote the cluster id and broker versions when escalating internally.
6. **Management:** Head of Messaging Platform, Sofia Marques (sofia.marques@acmebank.example), informed of every P1 and of any P2 over 4 hours. **Risk & Compliance** (Grace Mbeki, risk.tech@acmebank.example) is notified within 1 hour of any P1, and of any incident touching a PCI-scope topic.

## P1 checklist

1. Page ESP-SRE-L2 and the DIM; open **#acme-mi-bridge**.
2. Confirm scope with metrics, logs and cluster state (AIOps assistant): which brokers, which partitions, which topics.
3. Notify owning teams of affected topics; for `payments.*` also Payments Operations and Risk & Compliance.
4. Capture evidence before changing anything: under-replicated/offline counts, ISR of affected partitions, consumer group states, broker logs from the incident start.
5. Actions that change data or membership (restart brokers, offset resets, leader elections, ACL or retention changes) are decided on the bridge and logged in the change record.
6. After restore: confirm ISR is full, lag is draining, and write the incident review within 5 business days.

## Always labeled as not executed

The AIOps assistant is **read-only**. It proposes exact commands for a human to run. Anything it proposes still follows the approvals above.
