# Zipkin Service

Zipkin is a distributed tracing system.

## Connection Details

- **URL**: http://localhost:9411

## Management

- Start: `make zipkin-up`
- Stop: `make zipkin-down`
- Status: `make zipkin-status`
- Logs: `make zipkin-logs`
- Restart: `make zipkin-restart`
- Connection Info: `make zipkin-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `ZIPKIN_PORT`: Port to expose (default: 9411)
