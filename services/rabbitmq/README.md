# RabbitMQ Service

RabbitMQ is a message broker that implements the Advanced Message Queuing Protocol (AMQP).

## Connection Details

- **AMQP Port**: localhost:5672
- **Management UI**: http://localhost:15672
- **Username**: admin (default)
- **Password**: admin123 (default)

## Management UI

Access the management interface at: http://localhost:15672

## Management

- Start: `make rabbitmq-up`
- Stop: `make rabbitmq-down`
- Status: `make rabbitmq-status`
- Logs: `make rabbitmq-logs`
- Restart: `make rabbitmq-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `RABBITMQ_PORT`: AMQP port (default: 5672)
- `RABBITMQ_MANAGEMENT_PORT`: Management UI port (default: 15672)
- `RABBITMQ_USER`: Default user (default: admin)
- `RABBITMQ_PASSWORD`: Default password (default: admin123)

