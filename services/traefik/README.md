# Traefik Service

Traefik is a modern reverse proxy and load balancer.

## Connection Details

- **Dashboard**: http://localhost:8080
- **HTTP Port**: 80
- **HTTPS Port**: 443

## Management

- Start: `make traefik-up`
- Stop: `make traefik-down`
- Status: `make traefik-status`
- Logs: `make traefik-logs`
- Restart: `make traefik-restart`
- Connection Info: `make traefik-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `TRAEFIK_DASHBOARD_PORT`: Dashboard port (default: 8080)
- `TRAEFIK_HTTP_PORT`: HTTP port (default: 80)
- `TRAEFIK_HTTPS_PORT`: HTTPS port (default: 443)
