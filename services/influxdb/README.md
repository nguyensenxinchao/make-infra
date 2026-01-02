# InfluxDB Service

InfluxDB is a time-series database designed for high-write and query loads.

## Connection Details

- **URL**: http://localhost:8086
- **Username**: admin (default)
- **Password**: admin123 (default)
- **Organization**: myorg (default)
- **Bucket**: mybucket (default)
- **Token**: my-super-secret-auth-token (default)

## Management

- Start: `make influxdb-up`
- Stop: `make influxdb-down`
- Status: `make influxdb-status`
- Logs: `make influxdb-logs`
- Restart: `make influxdb-restart`
- Connection Info: `make influxdb-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `INFLUXDB_PORT`: Port to expose (default: 8086)
- `INFLUXDB_USERNAME`: Username (default: admin)
- `INFLUXDB_PASSWORD`: Password (default: admin123)
- `INFLUXDB_ORG`: Organization name (default: myorg)
- `INFLUXDB_BUCKET`: Bucket name (default: mybucket)
- `INFLUXDB_TOKEN`: Auth token (default: my-super-secret-auth-token)
