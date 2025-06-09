#!/bin/sh
set -e

# Wait for PostgreSQL to be available
until PGPASSWORD="$KC_DB_PASSWORD" psql "$KC_DB_URL" -U "$KC_DB_USERNAME" -c '\q' >/dev/null 2>&1; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done

SCHEMA="${KC_DB_SCHEMA:-public}"

# Drop and recreate the Keycloak schema
PGPASSWORD="$KC_DB_PASSWORD" psql "$KC_DB_URL" -U "$KC_DB_USERNAME" <<SQL
DROP SCHEMA IF EXISTS "$SCHEMA" CASCADE;
CREATE SCHEMA "$SCHEMA";
SQL

exec /opt/keycloak/bin/kc.sh start-dev --db-schema="$SCHEMA" --import-realm
