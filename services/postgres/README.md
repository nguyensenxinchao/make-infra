# PostgreSQL Service

PostgreSQL is a powerful, open source object-relational database system.

## Connection Details

- **Host**: localhost:5432
- **Username**: postgres (default)
- **Password**: postgres123 (default)
- **Database**: myapp (default)

## Connection String

```
postgresql://postgres:postgres123@localhost:5432/myapp
```

## Management

- Start: `make postgres-up`
- Stop: `make postgres-down`
- Status: `make postgres-status`
- Logs: `make postgres-logs`
- Restart: `make postgres-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `POSTGRES_PORT`: Port to expose (default: 5432)
- `POSTGRES_USER`: Database user (default: postgres)
- `POSTGRES_PASSWORD`: Database password (default: postgres123)
- `POSTGRES_DB`: Initial database name (default: myapp)

