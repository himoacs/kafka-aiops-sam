# Get Solace Agent Mesh (SAM) and apply the agents

SAM is the runtime that hosts the agents. It is a separate Solace product: this repo does not include or
redistribute it. Solace's download page says it is free to try and free for individuals and for companies
under US$25M in revenue ([download page](https://solace.com/products/agent-mesh/download/); check the page for the
current terms).

> **Tested vs documented.** We developed this repo against a SAM 2.385.1 server deployment, and tested `scripts/apply.sh`
> end to end against the SAM desktop app 2.325.2 on macOS (plan, apply, agents deployed). We did not test the
> installation itself, or Windows and Linux. Those steps follow Solace's documentation
> ([Using the SAM CLI with the Desktop Installation](https://docs.solace.com/Agent-Mesh/Framework/installing/desktop.htm)).
> If a step differs on your machine, trust Solace's page and tell us.

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

Open the SAM desktop app and **wait until its window has loaded** (the app can be running without its SAM backend
started; bringing the window forward starts it). Then:

```bash
scripts/apply.sh                  # plan, confirm, apply
```

`scripts/apply.sh` finds the desktop app's own bundled CLI (it prefers that over any older `sam` on your `PATH`),
warns if the MCP servers are not answering, shows a plan (nothing changes yet), asks you to confirm, then applies
`sam/manifests/example.yaml`. The plan is additive: it creates 5 agents, 3 connectors and 8 skills. SAM also
lists your other resources as "delete", which is just SAM reporting what is not in this manifest; they are
**skipped** unless you pass `--prune`, and this script never does. It targets the running desktop app with
`--target desktop`, which Solace documents as resolving to the running desktop app without a URL or login.

| Option | Meaning |
|---|---|
| `--plan` | show the plan only, change nothing |
| `--yes` | skip the confirmation prompt |
| `--with-slack` | also deploy the Slack entrypoint ([slack.md](slack.md)) |
| `--with-models` | also create the `general` and `planning` models (see Models below) |
| `--sam-home PATH` | the desktop app runs with a custom `SAM_HOME` instead of the default |
| `--url http://host:8800` | a SAM reachable at a URL (for example a team-hosted SAM, or the desktop app's own address, usually `http://127.0.0.1:8800`) |
| `--target NAME` | a target you created with `sam auth login` |

Equivalent manual command:
```bash
cd sam && sam config apply -m manifests/example.yaml --target desktop
```

### Models

The agents do not name a model: SAM uses the models called `general` and `planning`. A SAM that already
runs chats has these configured (if you have chatted with agents in the app, one is configured; check the app's
settings). **The default apply does not touch them.** Only if your SAM has no model configured, copy
`sam/.env.example` to `sam/.env`, fill in the `LLM_SERVICE_*` lines, and run `scripts/apply.sh --with-models`.
That creates models named `general` and `planning` and **overwrites any existing models with those names**, so
do not use it on a SAM whose other agents depend on them. Use any provider SAM supports; the agents rely on tool
calling and long skill documents, so choose a capable model.

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
