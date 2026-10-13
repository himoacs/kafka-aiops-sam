# Security model

## What the agents can and cannot do

- **Read-only by construction.** The Kafka MCP runs as a describe-only principal ([../reference/acl-readonly.md](../reference/acl-readonly.md)).
  Kafka refuses any write regardless of what an agent or caller asks for. The SAM connector additionally hides
  `produce_message` and `consume_messages` ([../sam/connectors/kafka_mcp.yaml](../sam/connectors/kafka_mcp.yaml)).
- **No message payloads.** Nothing grants `Read` on topics and no tool that reads records is exposed. Payloads can
  contain personal data.
- **Advice, not action.** Remediation is always a proposed CLI command labeled as not executed.
- **Prometheus and Loki** are queried read-only through their query APIs. Use read-only credentials where your
  deployment supports them.

## What you must protect

1. **The MCP servers have no authentication.** Anyone who can reach ports 9201 to 9203 can use them with the
   permissions of the configured credentials. The compose file binds them to `127.0.0.1` on purpose. Keep it
   that way, or put an authenticating, TLS-terminating proxy in front. The Kafka MCP server also supports OAuth
   2.1 on its HTTP transport (see its README) if you need it enabled.
2. **Credentials** live in `mcp/.env` and `sam/.env`, both git-ignored. Never commit them. Prefer a secrets manager
   in shared environments.
3. **The LLM sees what the tools return:** topic names, consumer-group names, config values, metric values, log
   lines. Log lines can contain client addresses and, depending on your applications, business data. Decide
   whether your LLM provider is acceptable for that data and filter at the log source if not.
4. **SAM itself:** protect its UI and API as you would any admin console.

## Reporting a problem

Open an issue at <https://github.com/himoacs/kafka-aiops-sam/issues> and do not include credentials, hostnames
or log excerpts you would not post publicly.
