# Troubleshooting

## `scripts/apply.sh`

| Symptom | Cause and fix |
|---|---|
| "Could not find the sam CLI" | Install the SAM desktop app and see [get-sam.md](get-sam.md) step 2, or set `SAM_CLI=/path/to/sam`. |
| JSON decode error from `sam config ...` | CLI older or newer than the SAM server. Use the CLI that matches your SAM version (the one bundled with your SAM install). |
| "Fill these in sam/.env first" | Set the listed `LLM_SERVICE_*` (and Slack) variables. |
| Plan shows the same agents as "update" every time | Known quirk with skill references; harmless. |
| Plan wants to delete `Orchestrator` or `Activity Monitor` | Those are SAM's built-ins. Never pass `--prune`; the script does not. |
| "MCP not reachable" warning | The MCP containers are not running or SAM cannot reach them. See below. |

## MCP servers

```bash
cd mcp && docker compose ps && docker compose logs --tail 50 kafka-mcp
mcp/scripts/mcp-smoke.sh http://localhost:9201/mcp          # lists tools
```

| Symptom | Cause and fix |
|---|---|
| Compose says "set KAFKA_BROKERS in mcp/.env" | The three required variables are `KAFKA_BROKERS`, `PROMETHEUS_URL`, `LOKI_URL`. |
| Kafka MCP cannot connect | Brokers not resolvable from the container, or advertised listeners point at a name the container cannot resolve ([connect-kafka.md](connect-kafka.md)). |
| TLS handshake or certificate error | The CA is not trusted: put the PEM in `mcp/certs/` and set `KAFKA_CA_CERT_FILE=/certs/ca.pem`. Remember it replaces the trusted roots. |
| SASL authentication failed | Wrong mechanism (SCRAM-SHA-256 vs 512), user or password. |
| Authorization errors from tools | The principal lacks `Describe` on that resource: [../reference/acl-readonly.md](../reference/acl-readonly.md). |
| Prometheus or Loki 401/403 | Set the auth variables in `mcp/.env` ([connect-metrics.md](connect-metrics.md), [connect-logs.md](connect-logs.md)). |
| SAM cannot reach `localhost:9201` | SAM runs in a container or on another host: set `KAFKA_MCP_URL` (and the others) in `sam/.env` ([get-sam.md](get-sam.md), "MCP URLs"). |

## Answers look wrong or empty

| Symptom | Cause and fix |
|---|---|
| "No data" for metrics that exist in your Prometheus | Metric names differ from the contract: [connect-metrics.md](connect-metrics.md) section 3. Ask the metrics agent to run `list_metrics` with `kafka_`. |
| Log queries return nothing | Labels differ from the contract ([connect-logs.md](connect-logs.md) section 2), or the time window has no lines. |
| Agent says a metric is a problem that is not | Check the judgement rules in `kafka-health-check` and the lessons in [connect-metrics.md](connect-metrics.md) section 4 apply to your data. |
| Long questions end after about two minutes with `sam task send` | Use `--timeout 8m`. The web UI is not affected. |
| Docs answers cite a URL that does not exist | Rebuild the corpus with `docs-corpus/fetch.sh`; the skill derives URLs from file paths. |
