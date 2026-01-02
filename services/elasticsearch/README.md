# Elasticsearch Service

Elasticsearch is a distributed, RESTful search and analytics engine.

## Connection Details

- **HTTP Port**: localhost:9200
- **Transport Port**: localhost:9300

## API Endpoint

```
http://localhost:9200
```

## Management

- Start: `make elasticsearch-up`
- Stop: `make elasticsearch-down`
- Status: `make elasticsearch-status`
- Logs: `make elasticsearch-logs`
- Restart: `make elasticsearch-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `ELASTICSEARCH_PORT`: HTTP API port (default: 9200)
- `ELASTICSEARCH_TRANSPORT_PORT`: Transport port (default: 9300)
- `ELASTICSEARCH_HEAP_SIZE`: JVM heap size (default: 512m)

