#!/bin/sh
# Import the prompt-library exports in this directory into a SAM instance.
#
# The *.json files are SAM prompt exports (the shape of GET /api/v1/prompts/groups/{id}/export), written for the
# Kafka agents. Prompts are not a `sam config` resource
# kind, so they are imported over the SAM web API, the same calls the web UI's
# "Import prompt" and prompt editor use.
#
# Idempotent: a new command is imported; an existing command whose text differs
# is updated in place (PATCH initialPrompt, which SAM saves as a new version);
# an identical one is left alone.
#
# Usage: ./import-prompts.sh [SAM_URL]      (default http://127.0.0.1:8800)
set -eu
SAM_URL="${1:-http://127.0.0.1:8800}"
DIR=$(cd "$(dirname "$0")" && pwd)
OUT=$(mktemp)
trap 'rm -f "$OUT"' EXIT

# command <TAB> group id <TAB> current text (JSON-encoded, so it stays on one line)
existing=$(curl -sf "${SAM_URL}/api/v1/prompts/groups/all" | python3 -c '
import json,sys
for g in json.load(sys.stdin).get("data",[]):
    print("\t".join([g.get("command") or "", g["id"], json.dumps((g.get("productionPrompt") or {}).get("promptText",""))]))')

for f in "$DIR"/*.json; do
  cmd=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["prompt"]["command"])' "$f")
  row=$(printf '%s\n' "$existing" | awk -F'\t' -v c="$cmd" '$1==c' | head -1)
  if [ -n "$row" ]; then
    gid=$(printf '%s' "$row" | cut -f2)
    same=$(printf '%s' "$row" | cut -f3- | python3 -c 'import json,sys; print(json.loads(sys.stdin.read())==json.load(open(sys.argv[1]))["prompt"]["promptText"])' "$f")
    if [ "$same" = "True" ]; then
      echo "[exists]   /$cmd"
      continue
    fi
    body=$(python3 -c 'import json,sys; print(json.dumps({"initialPrompt": json.load(open(sys.argv[1]))["prompt"]["promptText"]}))' "$f")
    code=$(curl -s -o "$OUT" -w '%{http_code}' -X PATCH -H 'Content-Type: application/json' \
      --data "$body" "${SAM_URL}/api/v1/prompts/groups/${gid}")
    action=updated
  else
    body=$(python3 -c 'import json,sys; print(json.dumps({"promptData": json.load(open(sys.argv[1])), "options": {"preserveCommand": True, "preserveCategory": True}}))' "$f")
    code=$(curl -s -o "$OUT" -w '%{http_code}' -X POST -H 'Content-Type: application/json' \
      --data "$body" "${SAM_URL}/api/v1/prompts/import")
    action=imported
  fi
  if [ "$code" = "200" ] || [ "$code" = "201" ]; then
    echo "[$action] /$cmd"
  else
    echo "[failed]   /$cmd (HTTP $code): $(cat "$OUT")" >&2
    exit 1
  fi
done
