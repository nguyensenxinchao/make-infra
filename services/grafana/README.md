# Grafana Service

Grafana is an open-source analytics and visualization platform.

## Connection Details

- **URL**: http://localhost:3001
- **Username**: admin (default)
- **Password**: admin123 (default)

## Management

- Start: `make grafana-up`
- Stop: `make grafana-down`
- Status: `make grafana-status`
- Logs: `make grafana-logs`
- Restart: `make grafana-restart`
- Connection Info: `make grafana-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `GRAFANA_PORT`: Port to expose (default: 3001)
- `GRAFANA_USER`: Admin username (default: admin)
- `GRAFANA_PASSWORD`: Admin password (default: admin123)

