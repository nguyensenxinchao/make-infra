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

# Function to get connection info for MinIO
get_minio_info() {
    local api_port=9000
    local console_port=9001
    local username=minioadmin
    local password=minioadmin123

    if [ -f "services/minio/.env" ]; then
        source services/minio/.env
        api_port=${MINIO_API_PORT:-9000}
        console_port=${MINIO_CONSOLE_PORT:-9001}
        username=${MINIO_ROOT_USER:-minioadmin}
        password=${MINIO_ROOT_PASSWORD:-minioadmin123}
    fi

    local endpoint="http://localhost:${api_port}"
    local console_url="http://localhost:${console_port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "minio",
  "host": "localhost",
  "port": ${api_port},
  "consolePort": ${console_port},
  "username": "${username}",
  "password": "${password}",
  "database": null,
  "connectionString": "${endpoint}",
  "managementUrl": "${console_url}",
  "environment": {
    "MINIO_API_PORT": "${api_port}",
    "MINIO_CONSOLE_PORT": "${console_port}",
    "MINIO_ROOT_USER": "${username}",
    "MINIO_ROOT_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}MinIO Connection Info:${NC}"
        echo -e "  Endpoint: ${BLUE}${endpoint}${NC}"
        echo -e "  Console: ${BLUE}${console_url}${NC}"
        echo -e "  Access Key: ${BLUE}${username}${NC}"
        echo -e "  Secret Key: ${BLUE}${password}${NC}"
    fi
}

# Function to get connection info for Prometheus
get_prometheus_info() {
    local port=9090

    if [ -f "services/prometheus/.env" ]; then
        source services/prometheus/.env
        port=${PROMETHEUS_PORT:-9090}
    fi

    local url="http://localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "prometheus",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "${url}",
  "managementUrl": "${url}",
  "environment": {
    "PROMETHEUS_PORT": "${port}"
  }
}
EOF
    else
        echo -e "${GREEN}Prometheus Connection Info:${NC}"
        echo -e "  URL: ${BLUE}${url}${NC}"
    fi
}

# Function to get connection info for Grafana
get_grafana_info() {
    local port=3001
    local username=admin
    local password=admin123

    if [ -f "services/grafana/.env" ]; then
        source services/grafana/.env
        port=${GRAFANA_PORT:-3001}
        username=${GRAFANA_USER:-admin}
        password=${GRAFANA_PASSWORD:-admin123}
    fi

    local url="http://localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "grafana",
  "host": "localhost",
  "port": ${port},
  "username": "${username}",
  "password": "${password}",
  "database": null,
  "connectionString": "${url}",
  "managementUrl": "${url}",
  "environment": {
    "GRAFANA_PORT": "${port}",
    "GRAFANA_USER": "${username}",
    "GRAFANA_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}Grafana Connection Info:${NC}"
        echo -e "  URL: ${BLUE}${url}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
    fi
}

# Function to get connection info for InfluxDB
get_influxdb_info() {
    local port=8086
    local username=admin
    local password=admin123
    local org=myorg
    local bucket=mybucket
    local token=my-super-secret-auth-token

    if [ -f "services/influxdb/.env" ]; then
        source services/influxdb/.env
        port=${INFLUXDB_PORT:-8086}
        username=${INFLUXDB_USERNAME:-admin}
        password=${INFLUXDB_PASSWORD:-admin123}
        org=${INFLUXDB_ORG:-myorg}
        bucket=${INFLUXDB_BUCKET:-mybucket}
        token=${INFLUXDB_TOKEN:-my-super-secret-auth-token}
    fi

    local url="http://localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "influxdb",
  "host": "localhost",
  "port": ${port},
  "username": "${username}",
  "password": "${password}",
  "database": "${bucket}",
  "connectionString": "${url}",
  "managementUrl": "${url}",
  "environment": {
    "INFLUXDB_PORT": "${port}",
    "INFLUXDB_USERNAME": "${username}",
    "INFLUXDB_PASSWORD": "${password}",
    "INFLUXDB_ORG": "${org}",
    "INFLUXDB_BUCKET": "${bucket}",
    "INFLUXDB_TOKEN": "${token}"
  }
}
EOF
    else
        echo -e "${GREEN}InfluxDB Connection Info:${NC}"
        echo -e "  URL: ${BLUE}${url}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Organization: ${BLUE}${org}${NC}"
        echo -e "  Bucket: ${BLUE}${bucket}${NC}"
        echo -e "  Token: ${BLUE}${token}${NC}"
    fi
}

# Function to get connection info for Cassandra
get_cassandra_info() {
    local port=9042

    if [ -f "services/cassandra/.env" ]; then
        source services/cassandra/.env
        port=${CASSANDRA_PORT:-9042}
    fi

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "cassandra",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "localhost:${port}",
  "managementUrl": null,
  "environment": {
    "CASSANDRA_PORT": "${port}"
  }
}
EOF
    else
        echo -e "${GREEN}Cassandra Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  Connection String: ${YELLOW}localhost:${port}${NC}"
    fi
}

# Function to get connection info for Neo4j
get_neo4j_info() {
    local http_port=7474
    local bolt_port=7687
    local username=neo4j
    local password=neo4j123

    if [ -f "services/neo4j/.env" ]; then
        source services/neo4j/.env
        http_port=${NEO4J_HTTP_PORT:-7474}
        bolt_port=${NEO4J_BOLT_PORT:-7687}
        username=${NEO4J_USER:-neo4j}
        password=${NEO4J_PASSWORD:-neo4j123}
    fi

    local http_url="http://localhost:${http_port}"
    local bolt_url="bolt://localhost:${bolt_port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "neo4j",
  "host": "localhost",
  "port": ${http_port},
  "boltPort": ${bolt_port},
  "username": "${username}",
  "password": "${password}",
  "database": null,
  "connectionString": "${bolt_url}",
  "managementUrl": "${http_url}",
  "environment": {
    "NEO4J_HTTP_PORT": "${http_port}",
    "NEO4J_BOLT_PORT": "${bolt_port}",
    "NEO4J_USER": "${username}",
    "NEO4J_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}Neo4j Connection Info:${NC}"
        echo -e "  HTTP URL: ${BLUE}${http_url}${NC}"
        echo -e "  Bolt URL: ${BLUE}${bolt_url}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
    fi
}

# Function to get connection info for Memcached
get_memcached_info() {
    local port=11211

    if [ -f "services/memcached/.env" ]; then
        source services/memcached/.env
        port=${MEMCACHED_PORT:-11211}
    fi

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "memcached",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "localhost:${port}",
  "managementUrl": null,
  "environment": {
    "MEMCACHED_PORT": "${port}"
  }
}
EOF
    else
        echo -e "${GREEN}Memcached Connection Info:${NC}"
        echo -e "  Host: ${BLUE}localhost${NC}"
        echo -e "  Port: ${BLUE}${port}${NC}"
        echo -e "  Connection String: ${YELLOW}localhost:${port}${NC}"
    fi
}

# Function to get connection info for Consul
get_consul_info() {
    local port=8500

    if [ -f "services/consul/.env" ]; then
        source services/consul/.env
        port=${CONSUL_PORT:-8500}
    fi

    local url="http://localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "consul",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "${url}",
  "managementUrl": "${url}",
  "environment": {
    "CONSUL_PORT": "${port}"
  }
}
EOF
    else
        echo -e "${GREEN}Consul Connection Info:${NC}"
        echo -e "  URL: ${BLUE}${url}${NC}"
    fi
}

# Function to get connection info for Vault
get_vault_info() {
    local port=8200
    local token=myroot

    if [ -f "services/vault/.env" ]; then
        source services/vault/.env
        port=${VAULT_PORT:-8200}
        token=${VAULT_TOKEN:-myroot}
    fi

    local url="http://localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "vault",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "${url}",
  "managementUrl": "${url}",
  "environment": {
    "VAULT_PORT": "${port}",
    "VAULT_TOKEN": "${token}"
  }
}
EOF
    else
        echo -e "${GREEN}Vault Connection Info:${NC}"
        echo -e "  URL: ${BLUE}${url}${NC}"
        echo -e "  Token: ${BLUE}${token}${NC}"
    fi
}

# Function to get connection info for Nginx
get_nginx_info() {
    local http_port=80
    local https_port=443

    if [ -f "services/nginx/.env" ]; then
        source services/nginx/.env
        http_port=${NGINX_HTTP_PORT:-80}
        https_port=${NGINX_HTTPS_PORT:-443}
    fi

    local http_url="http://localhost:${http_port}"
    local https_url="https://localhost:${https_port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "nginx",
  "host": "localhost",
  "port": ${http_port},
  "httpsPort": ${https_port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "${http_url}",
  "managementUrl": "${http_url}",
  "environment": {
    "NGINX_HTTP_PORT": "${http_port}",
    "NGINX_HTTPS_PORT": "${https_port}"
  }
}
EOF
    else
        echo -e "${GREEN}Nginx Connection Info:${NC}"
        echo -e "  HTTP: ${BLUE}${http_url}${NC}"
        echo -e "  HTTPS: ${BLUE}${https_url}${NC}"
    fi
}

# Function to get connection info for Traefik
get_traefik_info() {
    local dashboard_port=8080
    local http_port=80
    local https_port=443

    if [ -f "services/traefik/.env" ]; then
        source services/traefik/.env
        dashboard_port=${TRAEFIK_DASHBOARD_PORT:-8080}
        http_port=${TRAEFIK_HTTP_PORT:-80}
        https_port=${TRAEFIK_HTTPS_PORT:-443}
    fi

    local dashboard_url="http://localhost:${dashboard_port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "traefik",
  "host": "localhost",
  "port": ${http_port},
  "dashboardPort": ${dashboard_port},
  "httpsPort": ${https_port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "http://localhost:${http_port}",
  "managementUrl": "${dashboard_url}",
  "environment": {
    "TRAEFIK_DASHBOARD_PORT": "${dashboard_port}",
    "TRAEFIK_HTTP_PORT": "${http_port}",
    "TRAEFIK_HTTPS_PORT": "${https_port}"
  }
}
EOF
    else
        echo -e "${GREEN}Traefik Connection Info:${NC}"
        echo -e "  Dashboard: ${BLUE}${dashboard_url}${NC}"
        echo -e "  HTTP Port: ${BLUE}${http_port}${NC}"
        echo -e "  HTTPS Port: ${BLUE}${https_port}${NC}"
    fi
}

# Function to get connection info for Jaeger
get_jaeger_info() {
    local ui_port=16686
    local http_port=14268

    if [ -f "services/jaeger/.env" ]; then
        source services/jaeger/.env
        ui_port=${JAEGER_UI_PORT:-16686}
        http_port=${JAEGER_HTTP_PORT:-14268}
    fi

    local ui_url="http://localhost:${ui_port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "jaeger",
  "host": "localhost",
  "port": ${http_port},
  "uiPort": ${ui_port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "http://localhost:${http_port}",
  "managementUrl": "${ui_url}",
  "environment": {
    "JAEGER_UI_PORT": "${ui_port}",
    "JAEGER_HTTP_PORT": "${http_port}"
  }
}
EOF
    else
        echo -e "${GREEN}Jaeger Connection Info:${NC}"
        echo -e "  UI: ${BLUE}${ui_url}${NC}"
        echo -e "  HTTP Port: ${BLUE}${http_port}${NC}"
    fi
}

# Function to get connection info for Zipkin
get_zipkin_info() {
    local port=9411

    if [ -f "services/zipkin/.env" ]; then
        source services/zipkin/.env
        port=${ZIPKIN_PORT:-9411}
    fi

    local url="http://localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "zipkin",
  "host": "localhost",
  "port": ${port},
  "username": null,
  "password": null,
  "database": null,
  "connectionString": "${url}",
  "managementUrl": "${url}",
  "environment": {
    "ZIPKIN_PORT": "${port}"
  }
}
EOF
    else
        echo -e "${GREEN}Zipkin Connection Info:${NC}"
        echo -e "  URL: ${BLUE}${url}${NC}"
    fi
}

# Function to get connection info for ClickHouse
get_clickhouse_info() {
    local http_port=8123
    local native_port=9000
    local username=default
    local password=""

    if [ -f "services/clickhouse/.env" ]; then
        source services/clickhouse/.env
        http_port=${CLICKHOUSE_HTTP_PORT:-8123}
        native_port=${CLICKHOUSE_NATIVE_PORT:-9000}
        username=${CLICKHOUSE_USER:-default}
        password=${CLICKHOUSE_PASSWORD:-""}
    fi

    local http_url="http://localhost:${http_port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "clickhouse",
  "host": "localhost",
  "port": ${http_port},
  "nativePort": ${native_port},
  "username": "${username}",
  "password": "${password}",
  "database": null,
  "connectionString": "${http_url}",
  "managementUrl": "${http_url}",
  "environment": {
    "CLICKHOUSE_HTTP_PORT": "${http_port}",
    "CLICKHOUSE_NATIVE_PORT": "${native_port}",
    "CLICKHOUSE_USER": "${username}",
    "CLICKHOUSE_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}ClickHouse Connection Info:${NC}"
        echo -e "  HTTP URL: ${BLUE}${http_url}${NC}"
        echo -e "  Native Port: ${BLUE}${native_port}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        if [ -n "$password" ]; then
            echo -e "  Password: ${BLUE}${password}${NC}"
        fi
    fi
}

# Function to get connection info for CouchDB
get_couchdb_info() {
    local port=5984
    local username=admin
    local password=admin123

    if [ -f "services/couchdb/.env" ]; then
        source services/couchdb/.env
        port=${COUCHDB_PORT:-5984}
        username=${COUCHDB_USER:-admin}
        password=${COUCHDB_PASSWORD:-admin123}
    fi

    local url="http://${username}:${password}@localhost:${port}"

    if [ "$FORMAT" = "json" ]; then
        cat <<EOF
{
  "service": "couchdb",
  "host": "localhost",
  "port": ${port},
  "username": "${username}",
  "password": "${password}",
  "database": null,
  "connectionString": "${url}",
  "managementUrl": "http://localhost:${port}/_utils",
  "environment": {
    "COUCHDB_PORT": "${port}",
    "COUCHDB_USER": "${username}",
    "COUCHDB_PASSWORD": "${password}"
  }
}
EOF
    else
        echo -e "${GREEN}CouchDB Connection Info:${NC}"
        echo -e "  URL: ${BLUE}http://localhost:${port}${NC}"
        echo -e "  Username: ${BLUE}${username}${NC}"
        echo -e "  Password: ${BLUE}${password}${NC}"
        echo -e "  Connection String: ${YELLOW}${url}${NC}"
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
    minio)
        get_minio_info
        ;;
    prometheus)
        get_prometheus_info
        ;;
    grafana)
        get_grafana_info
        ;;
    influxdb)
        get_influxdb_info
        ;;
    cassandra)
        get_cassandra_info
        ;;
    neo4j)
        get_neo4j_info
        ;;
    memcached)
        get_memcached_info
        ;;
    consul)
        get_consul_info
        ;;
    vault)
        get_vault_info
        ;;
    nginx)
        get_nginx_info
        ;;
    traefik)
        get_traefik_info
        ;;
    jaeger)
        get_jaeger_info
        ;;
    zipkin)
        get_zipkin_info
        ;;
    clickhouse)
        get_clickhouse_info
        ;;
    couchdb)
        get_couchdb_info
        ;;
    *)
        echo "Unknown service: $SERVICE" >&2
        exit 1
        ;;
esac

