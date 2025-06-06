# MoonBase

This project provides a docker-compose stack with the following services:

- **PostgreSQL** – database
- **Keycloak** – authentication
- **Elasticsearch** and **Kibana** – logging and search
- **Prometheus** and **Grafana** – monitoring
- **NGINX** – reverse proxy
- **Status page** – simple web page displaying service status

## Usage

1. Ensure Docker and Docker Compose are installed.
2. Run the stack:
   ```bash
   docker compose up -d
   ```
3. Open `http://localhost` in your browser. You will be redirected to the
   Keycloak login page. After authentication you can reach the simple
   confirmation page at `/online` which displays `TU ES ONLINE`.
4. The service status table is available at `http://localhost/status/` and lists
   each service with a link to its interface. `Elasticsearch` can now also be
   reached via `/elastic/` in addition to `/elasticsearch/`.
