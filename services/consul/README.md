# Consul Service

Consul is a service networking solution for service discovery and configuration.

## Connection Details

- **URL**: http://localhost:8500

## Management

- Start: `make consul-up`
- Stop: `make consul-down`
- Status: `make consul-status`
- Logs: `make consul-logs`
- Restart: `make consul-restart`
- Connection Info: `make consul-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `CONSUL_PORT`: Port to expose (default: 8500)
