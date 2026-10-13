# Get Solace Agent Mesh (SAM) and apply the agents

SAM is the runtime that hosts the agents. It is a separate Solace product: this repo does not include or
redistribute it. Solace's download page says it is free to try and free for individuals and for companies
under US$25M in revenue ([download page](https://solace.com/products/agent-mesh/download/); check the page for the
current terms).

> **Tested vs documented.** We developed and tested this repo against a SAM 2.385.1 server deployment. The desktop
> installer steps below follow Solace's documentation ([Using the SAM CLI with the Desktop Installation](https://docs.solace.com/Agent-Mesh/Framework/installing/desktop.htm))
> but we did not run the installer ourselves. If a step differs on your machine, trust Solace's page and tell us.

Solace's page says the desktop app runs entirely on your machine. This repo asks nothing more of you to run SAM itself.

## Step 1. Install the desktop app

1. Open <https://solace.com/products/agent-mesh/download/>, fill in the short form, and download the installer for
   your OS (macOS, Windows or Linux).
2. Install and start it. *Works when:* the SAM web UI opens.

## Step 2. Make the `sam` CLI available

The CLI comes bundled with the desktop app. `scripts/apply.sh` looks for it automatically, so this step is only
needed if you also want to run `sam` yourself.

**macOS** (the app binary is the CLI):
```bash
echo "alias sam='/Applications/Solace\ Agent\ Mesh.app/Contents/MacOS/sam-desktop'" >> ~/.zshrc && source ~/.zshrc
```
**Windows** (PowerShell, no admin needed): add `%LOCALAPPDATA%\Programs\Solace Agent Mesh\cli` to your user `Path`
(see Solace's page for the script).
**Linux:** the package puts `solace-agent-mesh` on your `PATH` (optionally `alias sam='solace-agent-mesh'`).

*Works when:* `sam --help` in a **new** terminal prints help. (On macOS and Linux, running `sam` with no arguments
opens the app instead.)

## Step 3. Apply the agents, skills and connectors

```bash
cp sam/.env.example sam/.env      # fill in LLM_SERVICE_* (see below)
scripts/apply.sh                  # plan, confirm, apply
```

`scripts/apply.sh` finds the CLI, checks that your variables are set, warns if the MCP servers are not answering,
shows a plan (nothing changes yet), asks you to confirm, then applies `sam/manifests/example.yaml`. It targets the
running desktop app with `--target desktop`, which Solace documents as resolving to the running desktop app
without a URL or login. Useful options:

| Option | Meaning |
|---|---|
| `--plan` | show the plan only, change nothing |
| `--yes` | skip the confirmation prompt |
| `--with-slack` | also deploy the Slack entrypoint ([slack.md](slack.md)) |
| `--url http://host:8800` | a SAM reachable at a URL (for example a team-hosted SAM) |
| `--target NAME` | a target you created with `sam auth login` |

The script never uses `--prune`, which would delete SAM's built-in agents.

Equivalent manual command:
```bash
cd sam && sam config apply -m manifests/example.yaml --target desktop --env-file .env
```

### The LLM settings

`LLM_SERVICE_*` in `sam/.env` tell SAM which model the agents use: provider, endpoint, API key and the two model
names (`general` and `planning`; they may be the same model). Use whatever provider your SAM supports. The agents
use tool calling and long skill documents, so choose a capable model.

### MCP URLs

The connectors default to `http://localhost:9201|9202|9203/mcp`, which is where `mcp/docker-compose.yaml`
publishes the MCP servers. That works when SAM runs on the same machine as the MCP containers (the desktop app
case). If SAM runs in a container, on another host or in Kubernetes, set `KAFKA_MCP_URL`, `PROMETHEUS_MCP_URL`
and `LOKI_MCP_URL` in `sam/.env` to addresses SAM can reach (for example `http://host.docker.internal:9201/mcp`
from a container), and remember the servers have no authentication ([security.md](security.md)).

## Step 4. Try it

Open SAM, select `kafka_orchestrator_agent` and ask: *"Give me a quick overview of the Kafka cluster."* A good
answer lists brokers, topics and partitions from the Kafka MCP, firing alerts and replication health from
Prometheus, and ends with the sources it used.

Starter prompts are in `sam/prompts/`; load them into SAM's prompt library with
`sam/prompts/import-prompts.sh <SAM URL>`.

## Self-hosted SAM (containers, Kubernetes)

Out of scope for this repo; follow Solace's documentation for those deployments. `scripts/apply.sh --url <SAM URL>`
applies the same resources to any SAM you can reach, as long as your `sam` CLI version matches the server (see
[troubleshooting.md](troubleshooting.md)).
