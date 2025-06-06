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
3. Visit `http://localhost` in your browser to see the status page.

The status page will list each service and whether it is reachable (online/offline).
