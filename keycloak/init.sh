#!/bin/sh
set -e

# Wait for PostgreSQL to be available. The JDBC connection string is
# converted to parameters that `psql` understands so we don't depend on
# absolute paths or a particular URL format.
URL_NO_PREFIX="${KC_DB_URL#jdbc:postgresql://}"
HOST_PORT="${URL_NO_PREFIX%%/*}"
DB_NAME="${URL_NO_PREFIX#*/}"
DB_NAME="${DB_NAME%%\?*}"
DB_HOST="${HOST_PORT%%:*}"
DB_PORT="${HOST_PORT##*:}"
[ "$DB_PORT" = "$HOST_PORT" ] && DB_PORT=5432

PSQL_CMD="psql -h $DB_HOST -p $DB_PORT -U $KC_DB_USERNAME $DB_NAME"

until PGPASSWORD="$KC_DB_PASSWORD" $PSQL_CMD -c '\q' >/dev/null 2>&1; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done

SCHEMA="${KC_DB_SCHEMA:-public}"

# Drop and recreate the Keycloak schema
PGPASSWORD="$KC_DB_PASSWORD" $PSQL_CMD <<SQL
DROP SCHEMA IF EXISTS "$SCHEMA" CASCADE;
CREATE SCHEMA "$SCHEMA";
SQL

# Start Keycloak using a relative path so the script works regardless of the
# absolute installation location.
exec ./bin/kc.sh start-dev --db-schema="$SCHEMA" --import-realm
