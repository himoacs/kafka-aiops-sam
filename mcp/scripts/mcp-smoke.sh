#!/usr/bin/env bash
# Usage: mcp-smoke.sh <url> [tool-name] [json-args]   -> initialize, list tools, optionally call one.
set -euo pipefail
URL=$1; TOOL=${2:-}; ARGS=${3:-{\}}
H=(-H 'Content-Type: application/json' -H 'Accept: application/json, text/event-stream')
hdr=$(mktemp)
curl -s -D "$hdr" "${H[@]}" "$URL" -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"smoke","version":"1"}}}' >/dev/null
SID=$(grep -i '^mcp-session-id' "$hdr" | awk '{print $2}' | tr -d '\r' || true)
S=(); [ -n "$SID" ] && S=(-H "Mcp-Session-Id: $SID")
curl -s "${H[@]}" "${S[@]}" "$URL" -d '{"jsonrpc":"2.0","method":"notifications/initialized"}' >/dev/null
echo "--- tools"
curl -s "${H[@]}" "${S[@]}" "$URL" -d '{"jsonrpc":"2.0","id":2,"method":"tools/list"}' | grep -o '"name":"[^"]*"' | sort -u | tr '\n' ' '; echo
if [ -n "$TOOL" ]; then
  echo "--- call $TOOL"
  curl -s "${H[@]}" "${S[@]}" "$URL" -d "{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"tools/call\",\"params\":{\"name\":\"$TOOL\",\"arguments\":$ARGS}}" | cut -c1-1500
fi
