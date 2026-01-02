# Redis Service

Redis is an in-memory data structure store, used as a database, cache, and message broker.

## Connection Details

- **Host**: localhost:6379
- **Password**: redis123 (default)

## Connection String

```
redis://:redis123@localhost:6379
```

## Management

- Start: `make redis-up`
- Stop: `make redis-down`
- Status: `make redis-status`
- Logs: `make redis-logs`
- Restart: `make redis-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `REDIS_PORT`: Port to expose (default: 6379)
- `REDIS_PASSWORD`: Redis password (default: redis123)

