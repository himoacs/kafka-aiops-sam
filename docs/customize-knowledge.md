# Add your own institutional knowledge

Live data says what is happening. Institutional knowledge says what it **means for your organisation**: who owns
a topic, who approves access, what the escalation path is, which standards apply, what is frozen next month.

`sam/skills/acme-kafka-knowledge` is a worked **example** using a fictional bank ("Acme Global Bank"). It shows
the pattern: a short routing `SKILL.md` plus focused reference files the agent searches and reads only when needed.
Replace the content with yours, or remove the skill if you do not want it.

## What is in the example

| File under `references/` | Answers |
|---|---|
| `cluster-inventory.md` | which clusters exist, tiers, bootstrap servers, principals |
| `topic-and-group-ownership.md` | who owns a topic or consumer group, who approves access, data classification |
| `app-onboarding.md` | the procedure to get Kafka access, naming standards, lead times |
| `java-client-standards.md` | required client settings and a tested sample producer and consumer |
| `escalation-process.md` | severities, on-call groups, who to page |
| `runbooks-and-change.md` | runbooks, known risks, planned changes and freezes |

All names, people, phone numbers and dates are invented.

## Make it yours

1. Copy the folder: `cp -R sam/skills/acme-kafka-knowledge sam/skills/<your-org>-kafka-knowledge`.
2. Replace each file under `references/` with extracts of your real documents. Keep files small and focused;
   a table the agent can search beats a 40-page PDF. Keep the "fictional" banner out and add a "last reviewed"
   line instead.
3. Edit the new `SKILL.md`: the `name` and `description` (the description is how the orchestrator decides
   when to load it, so list the question types), and the routing table that maps question types to files.
4. Reference it: in `sam/agents/kafka_orchestrator_agent.yaml` replace `acme-kafka-knowledge` in `skillRefs`
   and in the prompt text; in `sam/manifests/*.yaml` replace it under `skills:`.
5. `scripts/apply.sh`, then ask a question only your documents can answer, for example *"Who approves access to
   the payments topics?"*

## Do not put secrets or personal data in it

The skill content is loaded into the model's context and appears in answers. Use role names and group aliases
rather than personal phone numbers, and never include credentials. Reference where secrets live (a vault path),
not the secrets.

## Remove it entirely

Delete the skill from `sam/manifests/*.yaml`, remove it from the orchestrator's `skillRefs`, and delete the
sentences that mention it in `sam/agents/kafka_orchestrator_agent.yaml`.
