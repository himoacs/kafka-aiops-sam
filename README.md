# kafka-aiops-sam

AI agents for operating Apache Kafka, built on [Solace Agent Mesh](https://solace.com/products/agent-mesh/) (SAM).
Point them at the Kafka cluster, Prometheus and log store **you already run**, then ask questions in plain English:

- *"How many topics and partitions do we have, and is the cluster healthy?"*
- *"`payments-consumer` fell behind between 11:00 and 11:15 UTC. Slow, stuck, or a rebalance? Show evidence."*
- *"Our producer logged `_MSG_TIMED_OUT`. What happened on the cluster, and why?"*
- *"What does `min.insync.replicas` do, and is ours different from the default?"*
- *"I need access to Kafka for my app. What is the procedure?"* (from your own runbooks, see below)

This repo does **not** deploy Kafka, Prometheus or Loki. It contains only the agents and the MCP servers that
connect them to what you have.

## What gets deployed

```
                  you (SAM web UI, or Slack)
                              |
                   kafka_orchestrator_agent          <- plans, delegates, cites evidence
        ___________________/ |  |  \___________________
       |                     |  |                      |
 kafka_cluster_agent  kafka_metrics_agent  kafka_logs_agent  kafka_expert_agent
       |                     |                  |                  |
  Kafka MCP server    Prometheus MCP server  Loki MCP server   kafka-docs skill
 (tuannvm, read-only)    (pab1it0)           (incu6us)         (Apache Kafka 4.2 docs)
       |                     |                  |
  YOUR Kafka cluster   YOUR Prometheus     YOUR Loki  (or adapt to OpenSearch / Splunk)
```

| Piece | What it is | Where |
|---|---|---|
| 5 SAM agents | an orchestrator and four specialists, one per data source | `sam/agents/` |
| 8 SAM skills | query know-how, health-check and lag playbooks, a Kafka docs corpus, citation rules, and an **example** institutional-knowledge skill | `sam/skills/` |
| 3 MCP servers | read-only access to Kafka, Prometheus and Loki, run with Docker Compose | `mcp/` |
| Reference configs | what the skills assume about your metrics and logs. **Not deployed.** | `reference/` |

You supply: a Kafka cluster, a Prometheus with Kafka metrics, optionally a Loki with Kafka logs, an LLM API key, and SAM.

## Quickstart (about 15 minutes)

Each step ends with how to tell it worked.

**1. Get SAM.** Download the free desktop app (the `sam` CLI is bundled): [docs/get-sam.md](docs/get-sam.md).
*Works when:* `sam --help` prints help and the SAM app opens.

**2. Point the MCP servers at your estate.**
```bash
cp mcp/.env.example mcp/.env      # set KAFKA_BROKERS (+ SASL/TLS), PROMETHEUS_URL, LOKI_URL
```
Kafka details are in [docs/connect-kafka.md](docs/connect-kafka.md), metrics in
[docs/connect-metrics.md](docs/connect-metrics.md), logs in [docs/connect-logs.md](docs/connect-logs.md).
Use a **describe-only** Kafka principal ([reference/acl-readonly.md](reference/acl-readonly.md)).

**3. Start the MCP servers and check them.**
```bash
cd mcp && docker compose up -d --build && cd ..
mcp/scripts/mcp-smoke.sh http://localhost:9201/mcp cluster_overview
```
*Works when:* the tool list shows `cluster_overview`, `list_topics`, ... and the call returns your brokers.

**4. Apply the agents to SAM.**
```bash
cp sam/.env.example sam/.env      # set LLM_SERVICE_* (your model endpoint and key)
scripts/apply.sh                  # shows a plan, asks to continue, then applies
```
*Works when:* it ends with "Done" and SAM lists `kafka_orchestrator_agent`.

**5. Ask.** Open SAM, choose `kafka_orchestrator_agent`, and try: *"Give me a quick overview of the Kafka cluster."*
Starter prompts: `sam/prompts/` (import with `sam/prompts/import-prompts.sh <SAM URL>`).

No logging stack, or you use Splunk or OpenSearch? You can run with metrics and cluster access only, or translate one
skill to your log tool: [docs/connect-logs.md](docs/connect-logs.md).

## Design principles

- **Read-only by construction.** The Kafka MCP runs as a describe-only principal, so Kafka itself refuses writes; the
  connector also hides `produce_message` and `consume_messages`. Message payloads are never read.
- **Advice, not action.** Agents propose exact CLI commands (`kafka-acls.sh`, `kafka-reassign-partitions.sh`,
  `kafka-consumer-groups.sh --dry-run`) for a human to run. They never execute them.
- **Every claim cited** with the tool, query and time range that produced it.
- **Docs are a skill, not a service.** The Apache Kafka 4.2 documentation ships as searchable reference files.

## What was tested

Everything here was exercised against Apache Kafka 4.2.2 (KRaft, SASL_SSL/SCRAM) with SAM 2.385.1,
tuannvm/kafka-mcp-server 2.0.2, pab1it0/prometheus-mcp-server 1.6.2 and incu6us/loki-mcp-server 0.0.4, with
Prometheus and Loki. **Not tested:** other Kafka versions and managed services, Prometheus metric names from
exporters other than the ones in `reference/`, OpenSearch or Splunk, and the SAM desktop installer path. Those
areas are documented as adaptation guides and labeled as such.

## Layout

```
sam/        agents, skills, connectors, models, manifests, prompts   (applied to SAM)
mcp/        Docker Compose for the three MCP servers
scripts/    apply.sh (one-command apply)
reference/  JMX exporter rules, alert rules, log shipper example, read-only ACLs
docs/       get-sam, connect-kafka, connect-metrics, connect-logs, customize-knowledge, security, slack, troubleshooting
docs-corpus/  rebuilds the kafka-docs skill from the Apache Kafka site
```

## Credits and license

The `kafka-docs` skill contains documentation from [apache/kafka-site](https://github.com/apache/kafka-site)
(Apache-2.0); see [NOTICE](NOTICE). MCP servers: [tuannvm/kafka-mcp-server](https://github.com/tuannvm/kafka-mcp-server),
[pab1it0/prometheus-mcp-server](https://github.com/pab1it0/prometheus-mcp-server),
[incu6us/loki-mcp-server](https://github.com/incu6us/loki-mcp-server).

**License: not yet specified.** Until a license file is added, all rights are reserved by the author.
