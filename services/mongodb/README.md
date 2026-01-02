# MongoDB Service

MongoDB is a NoSQL document database.

## Connection Details

- **Host**: localhost:27017
- **Username**: admin (default)
- **Password**: admin123 (default)
- **Database**: myapp (default)

## Connection String

```
mongodb://admin:admin123@localhost:27017/myapp?authSource=admin
```

## Management

- Start: `make mongodb-up`
- Stop: `make mongodb-down`
- Status: `make mongodb-status`
- Logs: `make mongodb-logs`
- Restart: `make mongodb-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `MONGODB_PORT`: Port to expose (default: 27017)
- `MONGODB_ROOT_USERNAME`: Root username (default: admin)
- `MONGODB_ROOT_PASSWORD`: Root password (default: admin123)
- `MONGODB_DATABASE`: Initial database name (default: myapp)

