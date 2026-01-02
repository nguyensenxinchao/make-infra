# ClickHouse Service

ClickHouse is a column-oriented database management system for online analytical processing.

## Connection Details

- **HTTP URL**: http://localhost:8123
- **Native Port**: 9000
- **Username**: default
- **Password**: (empty by default)

## Management

- Start: `make clickhouse-up`
- Stop: `make clickhouse-down`
- Status: `make clickhouse-status`
- Logs: `make clickhouse-logs`
- Restart: `make clickhouse-restart`
- Connection Info: `make clickhouse-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `CLICKHOUSE_HTTP_PORT`: HTTP port (default: 8123)
- `CLICKHOUSE_NATIVE_PORT`: Native port (default: 9000)
- `CLICKHOUSE_USER`: Username (default: default)
- `CLICKHOUSE_PASSWORD`: Password (default: empty)
