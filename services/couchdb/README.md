# CouchDB Service

CouchDB is a document-oriented NoSQL database.

## Connection Details

- **URL**: http://localhost:5984
- **Management UI**: http://localhost:5984/_utils
- **Username**: admin (default)
- **Password**: admin123 (default)

## Management

- Start: `make couchdb-up`
- Stop: `make couchdb-down`
- Status: `make couchdb-status`
- Logs: `make couchdb-logs`
- Restart: `make couchdb-restart`
- Connection Info: `make couchdb-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `COUCHDB_PORT`: Port to expose (default: 5984)
- `COUCHDB_USER`: Username (default: admin)
- `COUCHDB_PASSWORD`: Password (default: admin123)
