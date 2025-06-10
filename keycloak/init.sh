#!/bin/sh
# Simple initialization script for Keycloak.
# Resolves database parameters from environment variables and
# starts Keycloak in development mode importing realms.
set -e

# Build phase required by newer Keycloak versions
/opt/keycloak/bin/kc.sh build

# Start the server and import the provided realm
exec /opt/keycloak/bin/kc.sh start-dev --import-realm
