#!/usr/bin/env bash
# Builds sam/skills/kafka-docs/references/ from the Apache Kafka docs at a pinned kafka-site commit.
# Usage: docs-corpus/fetch.sh            (clones into a fresh temp dir, converts, cleans up)
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"; ROOT="$(dirname "$HERE")"
. "$HERE/SOURCE_REF"
OUT="$ROOT/sam/skills/kafka-docs/references"
WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT     # downloaded content is untrusted: fresh dir, never executed
git clone -q --filter=blob:none --sparse "$REPO" "$WORK/src"
git -C "$WORK/src" sparse-checkout set "content/en/$VERSION_DIR"
git -C "$WORK/src" checkout -q "$SHA"
rm -rf "$OUT"; mkdir -p "$OUT"
# -I: isolated mode, so nothing in the cwd or downloaded tree can shadow stdlib modules
python3 -I "$HERE/convert.py" --src "$WORK/src/content/en/$VERSION_DIR" --out "$OUT" \
  --version "$KAFKA_VERSION" --version-dir "$VERSION_DIR" --sha "$SHA"
