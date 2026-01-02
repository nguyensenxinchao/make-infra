# Memcached Service

Memcached is a distributed memory caching system.

## Connection Details

- **Host**: localhost:11211

## Management

- Start: `make memcached-up`
- Stop: `make memcached-down`
- Status: `make memcached-status`
- Logs: `make memcached-logs`
- Restart: `make memcached-restart`
- Connection Info: `make memcached-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `MEMCACHED_PORT`: Port to expose (default: 11211)
