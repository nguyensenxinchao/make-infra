# Jaeger Service

Jaeger is a distributed tracing system.

## Connection Details

- **UI**: http://localhost:16686
- **HTTP Port**: 14268

## Management

- Start: `make jaeger-up`
- Stop: `make jaeger-down`
- Status: `make jaeger-status`
- Logs: `make jaeger-logs`
- Restart: `make jaeger-restart`
- Connection Info: `make jaeger-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `JAEGER_UI_PORT`: UI port (default: 16686)
- `JAEGER_HTTP_PORT`: HTTP port (default: 14268)
