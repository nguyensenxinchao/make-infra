# MySQL Service

MySQL is an open-source relational database management system.

## Connection Details

- **Host**: localhost:3306
- **Root Password**: root123 (default)
- **Database**: myapp (default)
- **User**: appuser (default)
- **User Password**: apppass123 (default)

## Connection String

```
mysql://appuser:apppass123@localhost:3306/myapp
```

## Management

- Start: `make mysql-up`
- Stop: `make mysql-down`
- Status: `make mysql-status`
- Logs: `make mysql-logs`
- Restart: `make mysql-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `MYSQL_PORT`: Port to expose (default: 3306)
- `MYSQL_ROOT_PASSWORD`: Root password (default: root123)
- `MYSQL_DATABASE`: Initial database name (default: myapp)
- `MYSQL_USER`: Application user (default: appuser)
- `MYSQL_PASSWORD`: Application user password (default: apppass123)

