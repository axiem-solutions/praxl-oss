#!/usr/bin/env bash
set -euo pipefail

export HOSTNAME="${HOSTNAME:-0.0.0.0}"
export PORT="${PORT:-10000}"

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "DATABASE_URL is required" >&2
  exit 1
fi

if [[ -z "${AUTH_SECRET:-}" || "${AUTH_SECRET}" == "change-me-to-a-random-string" ]]; then
  echo "AUTH_SECRET is required and must not be the placeholder value" >&2
  exit 1
fi

echo "Applying Praxl schema with drizzle-kit..."
npx drizzle-kit push --force

echo "Starting Praxl on ${HOSTNAME}:${PORT}"
exec npx next start --hostname "${HOSTNAME}" --port "${PORT}"
