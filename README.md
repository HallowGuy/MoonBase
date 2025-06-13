# MoonBase

This project provides a docker-compose stack with the following services:

- **PostgreSQL** – database with schemas: `keycloak` for Keycloak, `app` for the
  application tables and `grafana` for Grafana's own data.
- **Keycloak** – authentication. The `keycloak` schema is reset on each start
  and the realms from `keycloak/keycloak-realm.json`, `keycloak/realm-t1.json`
  and `keycloak/realm-t2.json` are re-imported automatically. The additional
  realm files create tenants **T1** and **T2** with a single user each.
- **OpenSearch** and **OpenSearch Dashboards** – logging and search
- **Prometheus** and **Grafana** – monitoring. Grafana stores its dashboards in
  the `grafana` schema.
- **NGINX** – reverse proxy
- **Status page** – simple web page displaying service status
- **Backend** – Go service powered by Echo
- **Frontend** – React/Next.js UI styled with Tailwind CSS
- **FileGator** – web file manager served from `/filegator/`
- **Outline** – knowledge base accessible at `/outline/`
- **Answer** – community Q&A at `/answer/`
- **Typesense** – search engine used by Outline and Answer, API available at `/typesense/`
- **Metabase** – analytics UI served from `/metabase/`
- **Redis** – cache for Outline
- The PostgreSQL instance initializes a database named `system_database`.
  Application tables live under the `app` schema, Keycloak stores its data in
  the `keycloak` schema and Grafana uses the `grafana` schema.

## Usage

1. Ensure Docker and Docker Compose are installed.
2. Run the stack. Docker Compose will build a small Keycloak image using
   `keycloak/Dockerfile`. The container launches our `init.sh` script first
   which now resolves database parameters from `KC_DB_URL` and calls Keycloak
   via a relative path, so the setup works regardless of the installation
   location:

   ```bash
   docker compose up -d
   ```
 Keycloak will reset its schema and then import the realm definitions from
  `./keycloak/keycloak-realm.json`, `./keycloak/realm-t1.json` and
  `./keycloak/realm-t2.json`. These files register the `frontend` and `backend`
  clients and create one user in each tenant.
3. Open `http://localhost` in your browser. You will be redirected to the
   Keycloak login page. After authentication you can reach the simple
   confirmation page at `/online` which displays `TU ES ONLINE`.
   The example user credentials are `T1`/`password` for realm **T1** and
   `T2`/`password` for realm **T2**.
4. The service status table is available at `http://localhost/status/` and lists
   each service with a link to its interface. `OpenSearch` can be reached at `/opensearch/` (alias `/elastic/`).
   Grafana, Prometheus and OpenSearch Dashboards are served from `/grafana/`, `/prometheus/`
   and `/dashboards/` respectively after logging into Keycloak.
5. The application UI is served from `/app/` and the API endpoint returning
"Welcome to the home page" is available at `/api/home`.

Additional modules are available once you clone the optional submodules:

```bash
git submodule update --init
```

They are served from the following paths after starting the stack:

- FileGator: `http://localhost/filegator/`
- Outline: `http://localhost/outline/`
- Answer: `http://localhost/answer/`
- Typesense API: `http://localhost/typesense/`
- Metabase: `http://localhost/metabase/`

Outline and Answer automatically connect to Typesense using the shared
`TYPESENSE_API_KEY` environment variable defined in `docker-compose.yml`.

## Integrating OpenSearch with Keycloak

OpenSearch runs with the security plugin disabled by default. To enable
Keycloak authentication for both OpenSearch and OpenSearch Dashboards:

1. In Keycloak create a new confidential client named `opensearch` and set its
   redirect URI to `http://localhost/dashboards/auth/openid/login`.
2. Remove `plugins.security.disabled: true` from `opensearch/opensearch.yml` and
   configure the security plugin for OpenID Connect:

   ```yaml
   plugins.security.auth.type: openid
   plugins.security.openid.connect_url: http://keycloak:8080/realms/moonbase/.well-known/openid-configuration
   plugins.security.openid.client_id: opensearch
   plugins.security.openid.client_secret: <client-secret>
   plugins.security.openid.base_redirect_url: http://localhost/dashboards
   ```
3. Add the same OpenID details in
   `opensearch-dashboards/opensearch_dashboards.yml` using the
   `opensearch_security.openid.*` keys.
4. Restart the containers with `docker compose up -d` and open `/dashboards/`.
   You will be redirected to Keycloak and then back to OpenSearch Dashboards
   after authentication.

