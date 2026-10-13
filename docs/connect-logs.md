# Connect your logs (Loki, or adapt to OpenSearch, Splunk and others)

The logs agent reads Kafka broker, KRaft controller and client logs. The tested path is **Grafana Loki** through
[incu6us/loki-mcp-server](https://github.com/incu6us/loki-mcp-server) (pinned at v0.0.4). If you use something
else, you keep the agent and **translate one skill** (section 4). Logs are optional: the cluster, metrics and expert
agents work without them. To run without logs, remove `kafka_logs_agent` and the `loki` connector from the manifest
and delete the logs-agent lines from the orchestrator prompt (`sam/agents/kafka_orchestrator_agent.yaml`) so it does not try to delegate there.

## 1. Point the MCP at your Loki

In `mcp/.env`:

| Variable | Meaning |
|---|---|
| `LOKI_URL` | base URL, for example `http://host.docker.internal:3100` |
| `LOKI_USERNAME`, `LOKI_PASSWORD` | basic auth (mutually exclusive with the bearer token) |
| `LOKI_BEARER_TOKEN` | bearer token alternative |
| `LOKI_TENANT_ID` | sets `X-Scope-OrgID` for multi-tenant Loki (Grafana Cloud, Mimir-style tenancy) |

```bash
cd mcp && docker compose up -d --build loki-mcp && cd ..
mcp/scripts/mcp-smoke.sh http://localhost:9203/mcp labels
```

## 2. The label contract

The skill (`sam/skills/kafka-log-queries/SKILL.md`) writes queries against four labels:

| Label | Values |
|---|---|
| `cluster` | a name for your cluster (default in the skill: `my-cluster`) |
| `role` | `broker`, `controller` or `client` |
| `service` | the node or application (one value per broker, controller and client app) |
| `level` | `INFO`, `WARN`, `ERROR`, ... (parsed from the line) |

and expects Kafka's own line shape: `[2025-01-01 05:50:36,375] INFO message (kafka.package.Class)` for brokers
and controllers. `reference/alloy/config.alloy` is an example of producing these labels with Grafana Alloy from
Docker containers. Promtail, Fluent Bit, Vector or Kubernetes pod labels work equally well; what matters is that
the four labels exist. If yours are named differently, edit the **Labels** section and the queries in the skill.

Check what you actually have before editing: ask the logs agent to run `labels` and `label_values`, or call them
through `mcp-smoke.sh`.

Two broker-side logging settings the skills rely on (both are Kafka defaults you may have changed):
- Authorization denials (`... is Denied operation ...`) are written by the `kafka.authorizer.logger`. Some default
  log4j configurations send it to a separate file that your shipper never sees. Route it to stdout or ship that file.
- Authentication failures (`Failed authentication with ...`) come from the SocketServer at INFO level.

## 3. What the skill looks for

The query table in the skill covers: problems per node, ISR changes and `NotEnoughReplicas`, leader changes,
broker lifecycle, KRaft elections, consumer-group rebalances (the authoritative history, since metrics only count
new-protocol groups), client errors, authentication failures, ACL denials, producer failures (`delivery failed`,
timeouts, `RecordTooLarge`) and disk or log-directory errors. These are plain-text searches over Kafka's log
messages, so they translate to any engine.

## 4. Adapting to OpenSearch, Splunk or another log tool

**Untested.** The steps are the same for any backend; we list the known MCP servers.

1. **Pick an MCP server for your tool and run it.** Known options:
   - **Splunk:** the official [MCP Server for Splunk Platform](https://help.splunk.com/en/splunk-enterprise/mcp-server-for-splunk-platform/1.3/mcp-server-tools)
     (an app for Splunk Enterprise and Cloud). Its main tool runs SPL searches.
   - **OpenSearch:** [opensearch-project/opensearch-mcp-server-py](https://github.com/opensearch-project/opensearch-mcp-server-py).
     Its search tool takes query DSL; PPL and other observability tools are opt-in. Check the project's README
     for transports and authentication.
   - Others (Elasticsearch, Datadog Logs, CloudWatch Logs, Graylog): search for the vendor's MCP server.
   Run it however it is documented, and prefer a **read-only** credential scoped to the Kafka indexes.
2. **Replace the connector.** Copy `sam/connectors/loki.yaml` to a new connector (for example `splunk.yaml`),
   set `server_url` to your MCP server, set `allow_list` to its search and discovery tools only, and replace
   `loki` with it in `sam/manifests/example.yaml`. Remove `loki-mcp` from `mcp/docker-compose.yaml` if unused.
3. **Point the agent at it.** In `sam/agents/kafka_logs_agent.yaml` change `connectors: [loki]` to the new name
   and replace "Loki", "LogQL" and the label wording in the system prompt with your tool's names. Do the same in
   the logs-agent paragraph of `sam/agents/kafka_orchestrator_agent.yaml`.
4. **Translate the skill.** Rewrite `sam/skills/kafka-log-queries/SKILL.md`: the **Tools** table (your MCP's
   tool names and parameters), the **Labels** section (your field names, such as `index`, `sourcetype`, `host`,
   `log.level`), and every row of the query table. Keep the Rules section and the "Reading auth lines" note.
   Illustrative translations of one row (not verified):

   | Question | Loki | Splunk SPL | OpenSearch query DSL |
   |---|---|---|---|
   | Authentication failures | `{role="broker"} \|~ "Failed authentication"` | `index=kafka role=broker "Failed authentication" \| head 50` | `{"query":{"bool":{"filter":[{"term":{"role":"broker"}},{"match_phrase":{"message":"Failed authentication"}}]}}}` |

5. **Check the citation format.** `sam/skills/response-citations/SKILL.md` shows the logs citation with a `logql=`
   field; rename it to your language so citations show the query that was run.
6. `scripts/apply.sh`, then ask: *"Any authentication or authorization problems on the brokers in the last hour?"*
   and compare the quoted lines with what you see in your log tool.

## No Kafka logs centralised yet?

Ship the broker and controller logs first (container stdout, or the files under the broker's `kafka.logs.dir`); client application logs are a bonus. A single Loki plus Alloy (or Promtail) is the lightest way to
try this repo; see `reference/alloy/config.alloy`.
