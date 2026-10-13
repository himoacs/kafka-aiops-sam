---
name: acme-kafka-knowledge
description: >-
  Acme Global Bank's institutional knowledge about its Kafka estate - cluster
  inventory (KAFKA-PRD-01), topic and consumer-group ownership and approvers,
  the procedure to request Kafka access for an application, naming and security
  standards, the Java client standards with a tested sample producer/consumer,
  common client errors mapped to Acme causes, severity and escalation, runbooks,
  known risks, planned changes and freezes. Loaded by the Kafka Monitoring
  Orchestrator whenever a question involves who owns something, how to get
  access, how to onboard, which standards apply, sample code, who to call, or
  what Acme policy limits a fix. Fictional example data.
tags: [acme, cmdb, ownership, access, onboarding, standards, java, runbooks, escalation]
---

# Acme Global Bank Kafka Institutional Knowledge

The specialists say what is happening on the cluster. This skill says what it **means for Acme**: who owns it, which policy applies, how to get access, which standard to follow, and who to call.

All data here is **fictional example content** that shows the pattern. Replace the files under `references/` with your own CMDB extracts, ownership tables, runbooks, onboarding and escalation process (see `docs/customize-knowledge.md`); keep the `SKILL.md` routing table in step with your files.

---

## 1. Where to look

Documents are in `references/`. Search with `grep_skill_resources` (`skill_name: acme-kafka-knowledge`, `case_insensitive: true`, `context_lines: 10` or more) or read with `read_skill_resource`. `cluster-inventory.md` and `topic-and-group-ownership.md` are short enough to read whole. For the others, search first.

| Question involves | Read | Typical pattern |
|---|---|---|
| The cluster, version, topology, security model, bootstrap servers, certificates, a topic's partitions/retention/data class, which principal may do what | `references/cluster-inventory.md` | `KAFKA-PRD-01`, a topic name, `Certificates` |
| Who owns a topic or consumer group, who approves access, who to contact, what NOT to do during an incident (delete, reset offsets) | `references/topic-and-group-ownership.md` | the topic/group name, `Rules that matter` |
| **"I need access to Kafka for my app" / onboarding / new topic / naming / quotas / limits / lead times** | `references/app-onboarding.md` | `Procedure`, `Naming standards`, `Which platform` |
| **Java sample code**, client standards (acks, idempotence, commits, DLQ), Spring settings, **what a client exception means at Acme** | `references/java-client-standards.md` | `OrderProducer`, `OrderConsumer`, `TopicAuthorization` |
| Incident severity, who to page, who owns first response, P1 checklist | `references/escalation-process.md` | `P1`, `ESP-SRE-L2`, a paging group |
| A runbook, a known risk, planned changes, change freeze, certificate expiry | `references/runbooks-and-change.md` | `RB-KAFKA`, `RISK-`, `freeze` |

---

## 2. Rules

1. **The documents are authoritative for Acme facts** (ownership, process, standards, contacts, dates). The live cluster is authoritative for current state. Join them; if they disagree (for example a topic exists on the cluster but is not in the inventory), say so.
2. **Only state what the documents say.** Never invent a contact, phone number, ticket id, date or process step. If something is not documented, say so.
3. **Sample code:** give the code from `java-client-standards.md` as written. You may adapt topic, group and client ids to the user's request, but keep the Acme standards (SASL_SSL + SCRAM + PEM truststore, `acks=all`, idempotence, manual commits, DLQ). Credentials always come from environment or vault, never inline. Say that the sample is tested against KAFKA-PRD-01 and which principal it needs ACLs for.
4. **Access requests:** present the numbered procedure, the approvers for the **specific topics asked about** (look them up in the ownership register, including the extra Risk/Privacy approval for PCI-scope or personal-data topics), and the lead time that applies. Do not claim you can create the request or grant access; you are read-only and cannot change ACLs.
5. **Join knowledge with live data.** If a specialist found a problem, map it to Acme's severity and escalation path, the owning team's paging group, and the runbook id. If a document records a known risk or planned change relevant to the finding (for example RISK-0252, RISK-0240), mention it.
6. **Policy limits the fix.** Before proposing a remedy, check the ownership rules: no deleting/truncating/reducing retention on PCI-scope or compacted topics, and offset resets and consumer stops need the owner's approval. Say which approval applies.
7. **Flag time-sensitive facts:** a change freeze in effect or within 90 days, a planned change that touches the cluster, certificates within 90 days of expiry.
8. **Proportionate.** Pull only the facts that matter for this question.

---

## 3. Answer format: "Acme context"

Answer the question as usual, keeping specialists' citations verbatim, then end with a section headed **Acme context**, containing only what is relevant:

- **Topic or group:** owning team, data class, approvers, owner contact and paging group
- **For an access or onboarding request:** the procedure, approvers, lead time and the Jira project; naming standard; where to get the CA
- **For a problem:** the severity it maps to, who owns the first response, the paging group, the runbook id
- **For code:** the standards applied and the principal/ACLs the code needs
- **Policy and time-sensitive flags:** approvals required for the proposed fix, known risks, planned changes, freezes

Cite facts from these documents with the file they came from:

```
[Source: acme-kafka-knowledge · read_skill_resource | references/topic-and-group-ownership.md]
```

Use `grep_skill_resources` as the tool name when the fact came from a search.
