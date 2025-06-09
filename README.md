# MoonBase

This project provides a docker-compose stack with the following services:

- **PostgreSQL** – database with two schemas: `keycloak` for Keycloak and
  `app` for the application tables.
- **Keycloak** – authentication. The `keycloak` schema is reset on each start
  and the realm from `keycloak/keycloak-realm.json` is re-imported
  automatically.
- **Elasticsearch** and **Kibana** – logging and search
- **Prometheus** and **Grafana** – monitoring
- **NGINX** – reverse proxy
- **Status page** – simple web page displaying service status
- **Backend** – Go service powered by Echo
- **Frontend** – React/Next.js UI styled with Tailwind CSS
- The PostgreSQL instance initializes a database named `system_database`.
  Application tables live under the `app` schema and Keycloak stores its data
  in the `keycloak` schema.

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
   Keycloak will reset its schema and then import the realm definition from
   `./keycloak/keycloak-realm.json`, which registers the `frontend` and
   `backend` clients.
3. Open `http://localhost` in your browser. You will be redirected to the
   Keycloak login page. After authentication you can reach the simple
   confirmation page at `/online` which displays `TU ES ONLINE`.
4. The service status table is available at `http://localhost/status/` and lists
   each service with a link to its interface. `Elasticsearch` can now also be
   reached via `/elastic/` in addition to `/elasticsearch/`.
   Grafana, Prometheus and Kibana are served from `/grafana/`, `/prometheus/`
   and `/kibana/` respectively after logging into Keycloak.
5. The application UI is served from `/app/` and the API endpoint returning
   "Welcome to the home page" is available at `/api/home`.
