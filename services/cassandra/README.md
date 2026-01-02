# Cassandra Service

Apache Cassandra is a distributed NoSQL database.

## Connection Details

- **Host**: localhost:9042

## Management

- Start: `make cassandra-up`
- Stop: `make cassandra-down`
- Status: `make cassandra-status`
- Logs: `make cassandra-logs`
- Restart: `make cassandra-restart`
- Connection Info: `make cassandra-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `CASSANDRA_PORT`: Port to expose (default: 9042)
