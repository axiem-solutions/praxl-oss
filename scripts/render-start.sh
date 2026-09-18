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

if [[ -z "${ADMIN_USER_IDS:-}" ]]; then
  echo "ADMIN_USER_IDS unset; promoting the first user if one exists..."
  FIRST_ID="$(node --input-type=module -e '
import postgres from "postgres";
const sql = postgres(process.env.DATABASE_URL, { max: 1, connect_timeout: 10 });
try {
  const rows = await sql`select id, email from users order by created_at asc limit 1`;
  if (rows[0]) {
    process.stdout.write(String(rows[0].id));
    console.error("PRAXL_FIRST_USER " + JSON.stringify({ id: rows[0].id, email: rows[0].email }));
  }
} finally {
  await sql.end({ timeout: 2 });
}
' || true)"
  if [[ -n "${FIRST_ID}" ]]; then
    export ADMIN_USER_IDS="${FIRST_ID}"
    echo "Promoted first user to admin"
  fi
fi

echo "Starting Praxl on ${HOSTNAME}:${PORT}"
exec npx next start --hostname "${HOSTNAME}" --port "${PORT}"
