#!/bin/bash

# Script to get connection information for a service
# Usage: ./get-connection-info.sh <service-name> [format]
# Format: json (default) or text

SERVICE=$1
FORMAT=${2:-json}

# Colors for text output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to get connection info for MongoDB
get_mongodb_info() {
    local port=27017
    local username=admin
    local password=admin123
    local database=myapp

    # Try to read from .env file if exists
    if [ -f "services/mongodb/.env" ]; then
        source services/mongodb/.env
        port=${MONGODB_PORT:-27017}
        username=${MONGODB_ROOT_USERNAME:-admin}
        password=${MONGODB_ROOT_PASSWORD:-admin123}
        database=${MONGODB_DATABASE:-myapp}
    fi

    local conn_str="mongodb://${username}:${password}@localhost:${port}/${database}?authSource=admin"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "mongodb",
  "host": "localhost",
  "port": ${port},
  "username": "${username}",
  "password": "${password}",
  "database": "${database}",
  "connectionString": "${conn_str}",
  "managementUrl": null,
  "environment": {
    "MONGODB_PORT": "${port}",
    "MONGODB_ROOT_USERNAME": "${username}",
    "MONGODB_ROOT_PASSWORD": "${password}",
    "MONGODB_DATABASE": "${database}"
  }
}
EOF
    else
        echo -e "${GREEN}MongoDB Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Database: ${BLUE}${database}${NC}"
        echo -e "  Connection String: ${YELLOW}${conn_str}${NC}"
    fi
}

# Function to get connection info for NATS JetStream
get_nats_info() {
    local port=4222
    local http_port=8222

    if [ -f "services/nats-jetstream/.env" ]; then
        source services/nats-jetstream/.env
        port=${NATS_PORT:-4222}
        http_port=${NATS_HTTP_PORT:-8222}
    fi

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "nats-jetstream",
  "host": "localhost",
  "port": ${port},
  "httpPort": ${http_port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "nats://localhost:${port}",
  "managementUrl": "http://localhost:${http_port}",
  "environment": {
    "NATS_PORT": "${port}",
    "NATS_HTTP_PORT": "${http_port}"
  }
}
EOF
    else
        echo -e "${GREEN}NATS JetStream Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  HTTP Monitoring: ${BLUE}http://localhost:${http_port}${NC}"
        echo -e "  Connection String: ${YELLOW}nats://localhost:${port}${NC}"
    fi
}

# Function to get connection info for Redis
get_redis_info() {
    local port=6379
    local password=redis123

    if [ -f "services/redis/.env" ]; then
        source services/redis/.env
        port=${REDIS_PORT:-6379}
        password=${REDIS_PASSWORD:-redis123}
    fi

    local conn_str="redis://:${password}@localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "redis",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": "${password}",
  "database": null,
  "connectionString": "${conn_str}",
  "managementUrl": null,
  "environment": {
    "REDIS_PORT": "${port}",
    "REDIS_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}Redis Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Connection String: ${YELLOW}${conn_str}${NC}"
    fi
}

# Function to get connection info for PostgreSQL
get_postgres_info() {
    local port=5432
    local username=postgres
    local password=postgres123
    local database=myapp

    if [ -f "services/postgres/.env" ]; then
        source services/postgres/.env
        port=${POSTGRES_PORT:-5432}
        username=${POSTGRES_USER:-postgres}
        password=${POSTGRES_PASSWORD:-postgres123}
        database=${POSTGRES_DB:-myapp}
    fi

    local conn_str="postgresql://${username}:${password}@localhost:${port}/${database}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "postgres",
  "host": "localhost",
  "port": ${port},
  "username": "${username}",
  "password": "${password}",
  "database": "${database}",
  "connectionString": "${conn_str}",
  "managementUrl": null,
  "environment": {
    "POSTGRES_PORT": "${port}",
    "POSTGRES_USER": "${username}",
    "POSTGRES_PASSWORD": "${password}",
    "POSTGRES_DB": "${database}"
  }
}
EOF
    else
        echo -e "${GREEN}PostgreSQL Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Database: ${BLUE}${database}${NC}"
        echo -e "  Connection String: ${YELLOW}${conn_str}${NC}"
    fi
}

# Function to get connection info for MySQL
get_mysql_info() {
    local port=3306
    local root_password=root123
    local database=myapp
    local username=appuser
    local password=apppass123

    if [ -f "services/mysql/.env" ]; then
        source services/mysql/.env
        port=${MYSQL_PORT:-3306}
        root_password=${MYSQL_ROOT_PASSWORD:-root123}
        database=${MYSQL_DATABASE:-myapp}
        username=${MYSQL_USER:-appuser}
        password=${MYSQL_PASSWORD:-apppass123}
    fi

    local conn_str="mysql://${username}:${password}@localhost:${port}/${database}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "mysql",
  "host": "localhost",
  "port": ${port},
  "username": "${username}",
  "password": "${password}",
  "rootPassword": "${root_password}",
  "database": "${database}",
  "connectionString": "${conn_str}",
  "managementUrl": null,
  "environment": {
    "MYSQL_PORT": "${port}",
    "MYSQL_ROOT_PASSWORD": "${root_password}",
    "MYSQL_DATABASE": "${database}",
    "MYSQL_USER": "${username}",
    "MYSQL_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}MySQL Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  Root Password: ${BLUE}${root_password}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Database: ${BLUE}${database}${NC}"
        echo -e "  Connection String: ${YELLOW}${conn_str}${NC}"
    fi
}

# Function to get connection info for Elasticsearch
get_elasticsearch_info() {
    local port=9200
    local transport_port=9300

    if [ -f "services/elasticsearch/.env" ]; then
        source services/elasticsearch/.env
        port=${ELASTICSEARCH_PORT:-9200}
        transport_port=${ELASTICSEARCH_TRANSPORT_PORT:-9300}
    fi

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "elasticsearch",
  "host": "localhost",
  "port": ${port},
  "transportPort": ${transport_port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "http://localhost:${port}",
  "managementUrl": "http://localhost:${port}",
  "environment": {
    "ELASTICSEARCH_PORT": "${port}",
    "ELASTICSEARCH_TRANSPORT_PORT": "${transport_port}"
  }
}
EOF
    else
        echo -e "${GREEN}Elasticsearch Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  HTTP Port: ${BLUE}${port}${NC}"
        echo -e "  Transport Port: ${BLUE}${transport_port}${NC}"
        echo -e "  Connection String: ${YELLOW}http://localhost:${port}${NC}"
    fi
}

# Function to get connection info for Kafka
get_kafka_info() {
    local kafka_port=9092
    local zookeeper_port=2181

    if [ -f "services/kafka/.env" ]; then
        source services/kafka/.env
        kafka_port=${KAFKA_PORT:-9092}
        zookeeper_port=${ZOOKEEPER_PORT:-2181}
    fi

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "kafka",
  "host": "localhost",
  "port": ${kafka_port},
  "zookeeperPort": ${zookeeper_port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "localhost:${kafka_port}",
  "managementUrl": null,
  "environment": {
    "KAFKA_PORT": "${kafka_port}",
    "ZOOKEEPER_PORT": "${zookeeper_port}"
  }
}
EOF
    else
        echo -e "${GREEN}Kafka Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Kafka Port: ${BLUE}${kafka_port}${NC}"
        echo -e "  Zookeeper Port: ${BLUE}${zookeeper_port}${NC}"
        echo -e "  Connection String: ${YELLOW}localhost:${kafka_port}${NC}"
    fi
}

# Function to get connection info for RabbitMQ
get_rabbitmq_info() {
    local port=5672
    local management_port=15672
    local username=admin
    local password=admin123

    if [ -f "services/rabbitmq/.env" ]; then
        source services/rabbitmq/.env
        port=${RABBITMQ_PORT:-5672}
        management_port=${RABBITMQ_MANAGEMENT_PORT:-15672}
        username=${RABBITMQ_USER:-admin}
        password=${RABBITMQ_PASSWORD:-admin123}
    fi

    local conn_str="amqp://${username}:${password}@localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "rabbitmq",
  "host": "localhost",
  "port": ${port},
  "managementPort": ${management_port},
  "username": "${username}",
  "password": "${password}",
  "database": null,
  "connectionString": "${conn_str}",
  "managementUrl": "http://localhost:${management_port}",
  "environment": {
    "RABBITMQ_PORT": "${port}",
    "RABBITMQ_MANAGEMENT_PORT": "${management_port}",
    "RABBITMQ_USER": "${username}",
    "RABBITMQ_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}RabbitMQ Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  AMQP Port: ${BLUE}${port}${NC}"
        echo -e "  Management UI: ${BLUE}http://localhost:${management_port}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Connection String: ${YELLOW}${conn_str}${NC}"
    fi
}

# Main logic
case "$SERVICE" in
    mongodb)
        get_mongodb_info
        ;;
    nats-jetstream)
        get_nats_info
        ;;
    redis)
        get_redis_info
        ;;
    postgres)
        get_postgres_info
        ;;
    mysql)
        get_mysql_info
        ;;
    elasticsearch)
        get_elasticsearch_info
        ;;
    kafka)
        get_kafka_info
        ;;
    rabbitmq)
        get_rabbitmq_info
        ;;
    *)
        echo "Unknown service: $SERVICE" >&2
        exit 1
        ;;
esac

