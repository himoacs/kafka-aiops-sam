#!/usr/bin/env bash
# One command to apply the Kafka AIOps agents, skills and connectors to a running Solace Agent Mesh (SAM).
#
#   scripts/apply.sh                       plan, confirm, apply to the SAM desktop app (--target desktop)
#   scripts/apply.sh --url http://host:8800        any SAM reachable at a URL
#   scripts/apply.sh --target NAME         a named target you created with `sam auth login`
#   scripts/apply.sh --with-slack          also deploy the Slack entrypoint (needs tokens in sam/.env)
#   scripts/apply.sh --with-models         also create the general and planning models (only if your SAM has no LLM configured)
#   scripts/apply.sh --sam-home PATH       the desktop app runs with a custom SAM home (SAM_HOME) instead of the default
#   scripts/apply.sh --plan                show the plan only, change nothing
#   scripts/apply.sh --yes                 skip the confirmation prompt
#
# Never uses --prune (that would delete SAM's built-in agents).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SAMDIR="$ROOT/sam"
TARGET=(--target desktop); SLACK=0; MODELS=0; PLAN_ONLY=0; YES=0; HOMEARG=()
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET=(--target "$2"); shift 2;;
    --url) TARGET=(--url "$2"); shift 2;;
    --sam-home) HOMEARG=(--sam-home "$2"); shift 2;;
    --with-slack) SLACK=1; shift;;
    --with-models) MODELS=1; shift;;
    --plan) PLAN_ONLY=1; shift;;
    --yes|-y) YES=1; shift;;
    -h|--help) sed -n '2,15p' "$0"; exit 0;;
    *) echo "unknown option: $1 (try --help)" >&2; exit 2;;
  esac
done

# 1. Find the sam CLI: $SAM_CLI; for the desktop target the desktop app's own bundled CLI (an older `sam` that happens
#    to be on PATH can be incompatible); then `sam` on PATH; then `solace-agent-mesh` (Linux package).
APP_CLIS=("/Applications/Solace Agent Mesh.app/Contents/MacOS/sam-desktop" "$HOME/Applications/Solace Agent Mesh.app/Contents/MacOS/sam-desktop")
find_cli() {
  if [ -n "${SAM_CLI:-}" ]; then echo "$SAM_CLI"; return; fi
  if [ "${TARGET[1]}" = "desktop" ]; then
    for c in "${APP_CLIS[@]}"; do [ -x "$c" ] && { echo "$c"; return; }; done
  fi
  if command -v sam >/dev/null 2>&1; then command -v sam; return; fi
  for c in "${APP_CLIS[@]}"; do [ -x "$c" ] && { echo "$c"; return; }; done
  command -v solace-agent-mesh 2>/dev/null || true
}
CLI="$(find_cli)"
if [ -z "$CLI" ]; then
  echo "Could not find the sam CLI. It is bundled with the SAM desktop app: see docs/get-sam.md (Step 2)." >&2
  echo "Or set SAM_CLI=/path/to/sam" >&2; exit 1
fi
echo "sam CLI: $CLI"

# 2. Pick the manifest and load sam/.env if present (it is only required for --with-models / --with-slack).
if [ $MODELS -eq 1 ] && [ $SLACK -eq 1 ]; then MANIFEST="manifests/with-models-and-slack.yaml"
elif [ $MODELS -eq 1 ]; then MANIFEST="manifests/with-models.yaml"
elif [ $SLACK -eq 1 ]; then MANIFEST="manifests/with-slack.yaml"
else MANIFEST="manifests/example.yaml"; fi
ENVF="$SAMDIR/.env"; ENVARG=()
if [ -f "$ENVF" ]; then set -a; . "$ENVF"; set +a; ENVARG=(--env-file "$ENVF"); fi
missing=()
if [ $MODELS -eq 1 ]; then
  for v in LLM_SERVICE_PROVIDER LLM_SERVICE_ENDPOINT LLM_SERVICE_API_KEY LLM_SERVICE_GENERAL_MODEL_NAME LLM_SERVICE_PLANNING_MODEL_NAME; do [ -n "${!v:-}" ] || missing+=("$v"); done
fi
if [ $SLACK -eq 1 ]; then
  for v in SLACK_BOT_TOKEN SLACK_APP_TOKEN; do [ -n "${!v:-}" ] || missing+=("$v"); done
fi
if [ ${#missing[@]} -gt 0 ]; then echo "Set these in $ENVF first (copy sam/.env.example): ${missing[*]}" >&2; exit 1; fi

# 3. Warn (do not fail) if the MCP servers are not answering yet.
for pair in "Kafka MCP|${KAFKA_MCP_URL:-http://localhost:9201/mcp}" "Prometheus MCP|${PROMETHEUS_MCP_URL:-http://localhost:9202/mcp}" "Loki MCP|${LOKI_MCP_URL:-http://localhost:9203/mcp}"; do
  name="${pair%%|*}"; url="${pair#*|}"
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "$url" || true)
  case "$code" in 000) echo "warning: $name not reachable at $url (start it: cd mcp && docker compose up -d)";; *) echo "ok: $name answers at $url (HTTP $code)";; esac
done

# 4. Plan, confirm, apply.
cd "$SAMDIR"
echo; echo "== Plan (nothing is changed yet) =="
if ! "$CLI" config apply -m "$MANIFEST" "${TARGET[@]}" ${HOMEARG[@]+"${HOMEARG[@]}"} ${ENVARG[@]+"${ENVARG[@]}"} --dry-run; then
  echo >&2
  echo "The plan failed. If the message says no running SAM desktop app was found:" >&2
  echo "  - open the SAM desktop app and wait until its window has loaded, then retry;" >&2
  echo "  - if the app runs with a custom SAM_HOME, pass it: scripts/apply.sh --sam-home <path>;" >&2
  echo "  - or pass the app's address directly: scripts/apply.sh --url http://127.0.0.1:8800" >&2
  exit 1
fi
if [ $PLAN_ONLY -eq 1 ]; then exit 0; fi
if [ $YES -ne 1 ]; then
  read -r -p "Apply this to SAM? [y/N] " a; case "$a" in y|Y|yes) ;; *) echo "Cancelled."; exit 0;; esac
fi
"$CLI" config apply -m "$MANIFEST" "${TARGET[@]}" ${HOMEARG[@]+"${HOMEARG[@]}"} ${ENVARG[@]+"${ENVARG[@]}"}
echo
echo "Done. Open SAM, choose the agent 'kafka_orchestrator_agent' and ask: \"Give me a quick overview of the Kafka cluster.\""
echo "Optional starter prompts: sam/prompts/import-prompts.sh <SAM URL>"
