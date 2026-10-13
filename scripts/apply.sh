#!/usr/bin/env bash
# One command to apply the Kafka AIOps agents, skills and connectors to a running Solace Agent Mesh (SAM).
#
#   scripts/apply.sh                       plan, confirm, apply to the SAM desktop app (--target desktop)
#   scripts/apply.sh --url http://host:8800        any SAM reachable at a URL
#   scripts/apply.sh --target NAME         a named target you created with `sam auth login`
#   scripts/apply.sh --with-slack          also deploy the Slack entrypoint (needs tokens in sam/.env)
#   scripts/apply.sh --plan                show the plan only, change nothing
#   scripts/apply.sh --yes                 skip the confirmation prompt
#
# Never uses --prune (that would delete SAM's built-in agents).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SAMDIR="$ROOT/sam"
TARGET=(--target desktop); MANIFEST="manifests/example.yaml"; PLAN_ONLY=0; YES=0
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET=(--target "$2"); shift 2;;
    --url) TARGET=(--url "$2"); shift 2;;
    --with-slack) MANIFEST="manifests/with-slack.yaml"; shift;;
    --plan) PLAN_ONLY=1; shift;;
    --yes|-y) YES=1; shift;;
    -h|--help) sed -n '2,12p' "$0"; exit 0;;
    *) echo "unknown option: $1 (try --help)" >&2; exit 2;;
  esac
done

# 1. Find the sam CLI: $SAM_CLI, `sam` on PATH, the macOS desktop app binary, or `solace-agent-mesh` (Linux package).
find_cli() {
  if [ -n "${SAM_CLI:-}" ]; then echo "$SAM_CLI"; return; fi
  if command -v sam >/dev/null 2>&1; then command -v sam; return; fi
  for c in "/Applications/Solace Agent Mesh.app/Contents/MacOS/sam-desktop" "$HOME/Applications/Solace Agent Mesh.app/Contents/MacOS/sam-desktop"; do
    [ -x "$c" ] && { echo "$c"; return; }
  done
  command -v solace-agent-mesh 2>/dev/null || true
}
CLI="$(find_cli)"
if [ -z "$CLI" ]; then
  echo "Could not find the sam CLI. It is bundled with the SAM desktop app: see docs/get-sam.md (Step 2)." >&2
  echo "Or set SAM_CLI=/path/to/sam" >&2; exit 1
fi
echo "sam CLI: $CLI"

# 2. Check sam/.env exists and the required variables are filled in.
ENVF="$SAMDIR/.env"
[ -f "$ENVF" ] || { echo "Missing $ENVF. Run: cp sam/.env.example sam/.env  and fill in the LLM_SERVICE_* values." >&2; exit 1; }
set -a; . "$ENVF"; set +a
missing=()
for v in LLM_SERVICE_PROVIDER LLM_SERVICE_ENDPOINT LLM_SERVICE_API_KEY LLM_SERVICE_GENERAL_MODEL_NAME LLM_SERVICE_PLANNING_MODEL_NAME; do
  [ -n "${!v:-}" ] || missing+=("$v")
done
if [ "$MANIFEST" = "manifests/with-slack.yaml" ]; then
  for v in SLACK_BOT_TOKEN SLACK_APP_TOKEN; do [ -n "${!v:-}" ] || missing+=("$v"); done
fi
if [ ${#missing[@]} -gt 0 ]; then echo "Fill these in $ENVF first: ${missing[*]}" >&2; exit 1; fi

# 3. Warn (do not fail) if the MCP servers are not answering yet.
for pair in "Kafka MCP|${KAFKA_MCP_URL:-http://localhost:9201/mcp}" "Prometheus MCP|${PROMETHEUS_MCP_URL:-http://localhost:9202/mcp}" "Loki MCP|${LOKI_MCP_URL:-http://localhost:9203/mcp}"; do
  name="${pair%%|*}"; url="${pair#*|}"
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "$url" || true)
  case "$code" in 000) echo "warning: $name not reachable at $url (start it: cd mcp && docker compose up -d)";; *) echo "ok: $name answers at $url (HTTP $code)";; esac
done

# 4. Plan, confirm, apply.
cd "$SAMDIR"
echo; echo "== Plan (nothing is changed yet) =="
"$CLI" config apply -m "$MANIFEST" "${TARGET[@]}" --env-file "$ENVF" --dry-run
if [ $PLAN_ONLY -eq 1 ]; then exit 0; fi
if [ $YES -ne 1 ]; then
  read -r -p "Apply this to SAM? [y/N] " a; case "$a" in y|Y|yes) ;; *) echo "Cancelled."; exit 0;; esac
fi
"$CLI" config apply -m "$MANIFEST" "${TARGET[@]}" --env-file "$ENVF"
echo
echo "Done. Open SAM, choose the agent 'kafka_orchestrator_agent' and ask: \"Give me a quick overview of the Kafka cluster.\""
echo "Optional starter prompts: sam/prompts/import-prompts.sh <SAM URL>"
