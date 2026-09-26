#!/usr/bin/env bash
# Installs Praxl skills for Claude Code, Cursor and Codex in a cloud agent machine.
# Local machines sync through a logged-in Praxl CLI instead; this is a no-op there.
set -euo pipefail

if [ -z "${PRAXL_TOKEN:-}" ]; then
  echo "agent-setup: PRAXL_TOKEN not set; skipping Praxl skill sync" >&2
  exit 0
fi

npx -y praxl-app@1.3.0 sync \
  --token "$PRAXL_TOKEN" \
  --url https://axiem-praxl.onrender.com \
  --platforms claude-code,cursor,codex
