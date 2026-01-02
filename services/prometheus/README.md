# Prometheus Service

Prometheus is a monitoring and alerting toolkit.

## Connection Details

- **URL**: http://localhost:9090

## Management

- Start: `make prometheus-up`
- Stop: `make prometheus-down`
- Status: `make prometheus-status`
- Logs: `make prometheus-logs`
- Restart: `make prometheus-restart`
- Connection Info: `make prometheus-connection-info`

## Configuration

Prometheus configuration is in `prometheus.yml`. Edit this file to add scrape targets.

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `PROMETHEUS_PORT`: Port to expose (default: 9090)

