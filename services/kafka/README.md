# Kafka Service

Apache Kafka is a distributed event streaming platform.

## Connection Details

- **Kafka Broker**: localhost:9092
- **Zookeeper**: localhost:2181

## Management

- Start: `make kafka-up`
- Stop: `make kafka-down`
- Status: `make kafka-status`
- Logs: `make kafka-logs`
- Restart: `make kafka-restart`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `KAFKA_PORT`: Kafka broker port (default: 9092)
- `ZOOKEEPER_PORT`: Zookeeper port (default: 2181)

## Note

Kafka requires Zookeeper to run. Both services will be started when you run `make kafka-up`.

