# MinIO Service

MinIO is a high-performance, S3-compatible object storage service.

## Connection Details

- **API Endpoint**: http://localhost:9000
- **Console**: http://localhost:9001
- **Access Key**: minioadmin (default)
- **Secret Key**: minioadmin123 (default)

## Management

- Start: `make minio-up`
- Stop: `make minio-down`
- Status: `make minio-status`
- Logs: `make minio-logs`
- Restart: `make minio-restart`
- Connection Info: `make minio-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `MINIO_API_PORT`: API port (default: 9000)
- `MINIO_CONSOLE_PORT`: Console port (default: 9001)
- `MINIO_ROOT_USER`: Root user (default: minioadmin)
- `MINIO_ROOT_PASSWORD`: Root password (default: minioadmin123)

