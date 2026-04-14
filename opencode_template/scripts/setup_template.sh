#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "[Bootstrap] Initializing new project from OpenCode template..."

PROJECT_NAME="$(basename "$ROOT_DIR")"

echo "[Bootstrap] Project: $PROJECT_NAME"

if [ ! -d "$ROOT_DIR/.git" ]; then
  echo "[Bootstrap] Initializing git"
  (cd "$ROOT_DIR" && git init && git add . && git commit -m "Bootstrap: initial project from OpenCode template")
fi

echo "[Bootstrap] Replacing placeholders in editable docs..."
REPLACE() {
  local f="$1"
  if [ -f "$f" ]; then
    sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$f" || true
    sed -i "s/{{DATE}}/$(date +%Y-%m-%d)/g" "$f" || true
  fi
}
REPLACE "$ROOT_DIR/docs/requirements.md"
REPLACE "$ROOT_DIR/docs/architecture.md"
REPLACE "$ROOT_DIR/docs/api_spec.md"
REPLACE "$ROOT_DIR/docs/database_schema.md"
REPLACE "$ROOT_DIR/specs/feature_list.md"
REPLACE "$ROOT_DIR/TASK.md"
REPLACE "$ROOT_DIR/PROGRESS.md"
REPLACE "$ROOT_DIR/HANDOFF.md"

echo "[Bootstrap] Done. You can now start your development."
