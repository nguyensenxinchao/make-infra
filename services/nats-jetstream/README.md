# NATS JetStream Service

NATS is a high-performance messaging system with JetStream for streaming and persistence.

## Connection Details

- **Client Port**: localhost:4222
- **HTTP Monitoring**: http://localhost:8222
- **Cluster Port**: localhost:6222

## Management

- Start: `make nats-jetstream-up`
- Stop: `make nats-jetstream-down`
- Status: `make nats-jetstream-status`
- Logs: `make nats-jetstream-logs`
- Restart: `make nats-jetstream-restart`

## Monitoring

Access the monitoring endpoint at: http://localhost:8222

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `NATS_PORT`: Client connection port (default: 4222)
- `NATS_HTTP_PORT`: HTTP monitoring port (default: 8222)
- `NATS_CLUSTER_PORT`: Cluster routing port (default: 6222)

