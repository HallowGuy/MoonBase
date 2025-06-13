#!/bin/sh
flyway \
  -url=jdbc:postgresql://postgres:${POSTGRES_PORT:-5432}/${POSTGRES_DB:-system_database} \
  -user=$(cat /run/secrets/postgres_user) \
  -password=$(cat /run/secrets/postgres_password) \
  -connectRetries=10 \
  -schemas=public,keycloak,app,grafana \
  migrate
