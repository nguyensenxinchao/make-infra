# Neo4j Service

Neo4j is a graph database management system.

## Connection Details

- **HTTP URL**: http://localhost:7474
- **Bolt URL**: bolt://localhost:7687
- **Username**: neo4j (default)
- **Password**: neo4j123 (default)

## Management

- Start: `make neo4j-up`
- Stop: `make neo4j-down`
- Status: `make neo4j-status`
- Logs: `make neo4j-logs`
- Restart: `make neo4j-restart`
- Connection Info: `make neo4j-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `NEO4J_HTTP_PORT`: HTTP port (default: 7474)
- `NEO4J_BOLT_PORT`: Bolt port (default: 7687)
- `NEO4J_USER`: Username (default: neo4j)
- `NEO4J_PASSWORD`: Password (default: neo4j123)
