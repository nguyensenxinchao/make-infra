.PHONY: help check-deps list-services
.PHONY: mongodb-up mongodb-down mongodb-logs mongodb-status mongodb-restart mongodb-connection-info
.PHONY: nats-jetstream-up nats-jetstream-down nats-jetstream-logs nats-jetstream-status nats-jetstream-restart nats-jetstream-connection-info
.PHONY: redis-up redis-down redis-logs redis-status redis-restart redis-connection-info
.PHONY: postgres-up postgres-down postgres-logs postgres-status postgres-restart postgres-connection-info
.PHONY: mysql-up mysql-down mysql-logs mysql-status mysql-restart mysql-connection-info
.PHONY: elasticsearch-up elasticsearch-down elasticsearch-logs elasticsearch-status elasticsearch-restart elasticsearch-connection-info
.PHONY: kafka-up kafka-down kafka-logs kafka-status kafka-restart kafka-connection-info
.PHONY: rabbitmq-up rabbitmq-down rabbitmq-logs rabbitmq-status rabbitmq-restart rabbitmq-connection-info
.PHONY: minio-up minio-down minio-logs minio-status minio-restart minio-connection-info
.PHONY: prometheus-up prometheus-down prometheus-logs prometheus-status prometheus-restart prometheus-connection-info
.PHONY: grafana-up grafana-down grafana-logs grafana-status grafana-restart grafana-connection-info
.PHONY: influxdb-up influxdb-down influxdb-logs influxdb-status influxdb-restart influxdb-connection-info
.PHONY: cassandra-up cassandra-down cassandra-logs cassandra-status cassandra-restart cassandra-connection-info
.PHONY: neo4j-up neo4j-down neo4j-logs neo4j-status neo4j-restart neo4j-connection-info
.PHONY: memcached-up memcached-down memcached-logs memcached-status memcached-restart memcached-connection-info
.PHONY: consul-up consul-down consul-logs consul-status consul-restart consul-connection-info
.PHONY: vault-up vault-down vault-logs vault-status vault-restart vault-connection-info
.PHONY: nginx-up nginx-down nginx-logs nginx-status nginx-restart nginx-connection-info
.PHONY: traefik-up traefik-down traefik-logs traefik-status traefik-restart traefik-connection-info
.PHONY: jaeger-up jaeger-down jaeger-logs jaeger-status jaeger-restart jaeger-connection-info
.PHONY: zipkin-up zipkin-down zipkin-logs zipkin-status zipkin-restart zipkin-connection-info
.PHONY: clickhouse-up clickhouse-down clickhouse-logs clickhouse-status clickhouse-restart clickhouse-connection-info
.PHONY: couchdb-up couchdb-down couchdb-logs couchdb-status couchdb-restart couchdb-connection-info
.PHONY: all-up all-down all-status connection-info

# Default target
.DEFAULT_GOAL := help

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Services list
SERVICES := mongodb nats-jetstream redis postgres mysql elasticsearch kafka rabbitmq minio prometheus grafana influxdb cassandra neo4j memcached consul vault nginx traefik jaeger zipkin clickhouse couchdb

help: ## Show this help message
	@echo "$(GREEN)Infrastructure Management Tool$(NC)"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available services:"
	@for service in $(SERVICES); do \
		echo "  $(YELLOW)$$service$(NC)"; \
		echo "    make $$service-up       - Start service"; \
		echo "    make $$service-down     - Stop service"; \
		echo "    make $$service-restart  - Restart service"; \
		echo "    make $$service-status   - Check service status"; \
		echo "    make $$service-logs     - View service logs"; \
		echo "    make $$service-connection-info - Show connection info"; \
		echo ""; \
	done
	@echo "General commands:"
	@echo "  make all-up         - Start all services"
	@echo "  make all-down       - Stop all services"
	@echo "  make all-status     - Check status of all services"
	@echo "  make connection-info - Show connection info for all services"
	@echo "  make list-services  - List all available services"
	@echo "  make check-deps     - Check required dependencies"

check-deps: ## Check if required dependencies are installed
	@echo "$(GREEN)Checking dependencies...$(NC)"
	@command -v docker >/dev/null 2>&1 || { echo "$(RED)Docker is not installed$(NC)"; exit 1; }
	@command -v docker-compose >/dev/null 2>&1 || { echo "$(RED)Docker Compose is not installed$(NC)"; exit 1; }
	@docker ps >/dev/null 2>&1 || { echo "$(RED)Docker daemon is not running$(NC)"; exit 1; }
	@echo "$(GREEN)All dependencies are installed and ready!$(NC)"

ensure-network: ## Ensure infra-network exists
	@docker network inspect make-infra-network >/dev/null 2>&1 || docker network create make-infra-network || true

list-services: ## List all available services
	@echo "$(GREEN)Available services:$(NC)"
	@for service in $(SERVICES); do \
		echo "  - $$service"; \
	done

# MongoDB targets
mongodb-up: check-deps ensure-network
	@echo "$(GREEN)Starting MongoDB...$(NC)"
	@cd services/mongodb && docker-compose up -d
	@echo "$(GREEN)MongoDB started successfully!$(NC)"

mongodb-down:
	@echo "$(YELLOW)Stopping MongoDB...$(NC)"
	@cd services/mongodb && docker-compose stop || true
	@cd services/mongodb && docker-compose rm -f || true
	@echo "$(GREEN)MongoDB stopped!$(NC)"

mongodb-restart: mongodb-down mongodb-up
	@echo "$(GREEN)MongoDB restarted!$(NC)"

mongodb-status:
	@cd services/mongodb && docker-compose ps || echo "$(RED)MongoDB is not running$(NC)"

mongodb-logs:
	@cd services/mongodb && docker-compose logs -f

mongodb-connection-info:
	@./scripts/get-connection-info.sh mongodb text

# NATS JetStream targets
nats-jetstream-up: check-deps ensure-network
	@echo "$(GREEN)Starting NATS JetStream...$(NC)"
	@cd services/nats-jetstream && docker-compose up -d
	@echo "$(GREEN)NATS JetStream started successfully!$(NC)"

nats-jetstream-down:
	@echo "$(YELLOW)Stopping NATS JetStream...$(NC)"
	@cd services/nats-jetstream && docker-compose stop || true
	@cd services/nats-jetstream && docker-compose rm -f || true
	@echo "$(GREEN)NATS JetStream stopped!$(NC)"

nats-jetstream-restart: nats-jetstream-down nats-jetstream-up
	@echo "$(GREEN)NATS JetStream restarted!$(NC)"

nats-jetstream-status:
	@cd services/nats-jetstream && docker-compose ps || echo "$(RED)NATS JetStream is not running$(NC)"

nats-jetstream-logs:
	@cd services/nats-jetstream && docker-compose logs -f

nats-jetstream-connection-info:
	@./scripts/get-connection-info.sh nats-jetstream text

# Redis targets
redis-up: check-deps ensure-network
	@echo "$(GREEN)Starting Redis...$(NC)"
	@cd services/redis && docker-compose up -d
	@echo "$(GREEN)Redis started successfully!$(NC)"

redis-down:
	@echo "$(YELLOW)Stopping Redis...$(NC)"
	@cd services/redis && docker-compose stop || true
	@cd services/redis && docker-compose rm -f || true
	@echo "$(GREEN)Redis stopped!$(NC)"

redis-restart: redis-down redis-up
	@echo "$(GREEN)Redis restarted!$(NC)"

redis-status:
	@cd services/redis && docker-compose ps || echo "$(RED)Redis is not running$(NC)"

redis-logs:
	@cd services/redis && docker-compose logs -f

redis-connection-info:
	@./scripts/get-connection-info.sh redis text

# PostgreSQL targets
postgres-up: check-deps ensure-network
	@echo "$(GREEN)Starting PostgreSQL...$(NC)"
	@cd services/postgres && docker-compose up -d
	@echo "$(GREEN)PostgreSQL started successfully!$(NC)"

postgres-down:
	@echo "$(YELLOW)Stopping PostgreSQL...$(NC)"
	@cd services/postgres && docker-compose stop || true
	@cd services/postgres && docker-compose rm -f || true
	@echo "$(GREEN)PostgreSQL stopped!$(NC)"

postgres-restart: postgres-down postgres-up
	@echo "$(GREEN)PostgreSQL restarted!$(NC)"

postgres-status:
	@cd services/postgres && docker-compose ps || echo "$(RED)PostgreSQL is not running$(NC)"

postgres-logs:
	@cd services/postgres && docker-compose logs -f

postgres-connection-info:
	@./scripts/get-connection-info.sh postgres text

# MySQL targets
mysql-up: check-deps ensure-network
	@echo "$(GREEN)Starting MySQL...$(NC)"
	@cd services/mysql && docker-compose up -d
	@echo "$(GREEN)MySQL started successfully!$(NC)"

mysql-down:
	@echo "$(YELLOW)Stopping MySQL...$(NC)"
	@cd services/mysql && docker-compose stop || true
	@cd services/mysql && docker-compose rm -f || true
	@echo "$(GREEN)MySQL stopped!$(NC)"

mysql-restart: mysql-down mysql-up
	@echo "$(GREEN)MySQL restarted!$(NC)"

mysql-status:
	@cd services/mysql && docker-compose ps || echo "$(RED)MySQL is not running$(NC)"

mysql-logs:
	@cd services/mysql && docker-compose logs -f

mysql-connection-info:
	@./scripts/get-connection-info.sh mysql text

# Elasticsearch targets
elasticsearch-up: check-deps ensure-network
	@echo "$(GREEN)Starting Elasticsearch...$(NC)"
	@cd services/elasticsearch && docker-compose up -d
	@echo "$(GREEN)Elasticsearch started successfully!$(NC)"

elasticsearch-down:
	@echo "$(YELLOW)Stopping Elasticsearch...$(NC)"
	@cd services/elasticsearch && docker-compose stop || true
	@cd services/elasticsearch && docker-compose rm -f || true
	@echo "$(GREEN)Elasticsearch stopped!$(NC)"

elasticsearch-restart: elasticsearch-down elasticsearch-up
	@echo "$(GREEN)Elasticsearch restarted!$(NC)"

elasticsearch-status:
	@cd services/elasticsearch && docker-compose ps || echo "$(RED)Elasticsearch is not running$(NC)"

elasticsearch-logs:
	@cd services/elasticsearch && docker-compose logs -f

elasticsearch-connection-info:
	@./scripts/get-connection-info.sh elasticsearch text

# Kafka targets
kafka-up: check-deps ensure-network
	@echo "$(GREEN)Starting Kafka...$(NC)"
	@cd services/kafka && docker-compose up -d
	@echo "$(GREEN)Kafka started successfully!$(NC)"

kafka-down:
	@echo "$(YELLOW)Stopping Kafka and Zookeeper...$(NC)"
	@cd services/kafka && docker-compose stop || true
	@cd services/kafka && docker-compose rm -f || true
	@echo "$(GREEN)Kafka and Zookeeper stopped!$(NC)"

kafka-restart: kafka-down kafka-up
	@echo "$(GREEN)Kafka restarted!$(NC)"

kafka-status:
	@echo "$(GREEN)Kafka and Zookeeper Status:$(NC)"
	@cd services/kafka && docker-compose ps || echo "$(RED)Kafka/Zookeeper is not running$(NC)"

kafka-logs:
	@cd services/kafka && docker-compose logs -f

kafka-connection-info:
	@./scripts/get-connection-info.sh kafka text

# RabbitMQ targets
rabbitmq-up: check-deps ensure-network
	@echo "$(GREEN)Starting RabbitMQ...$(NC)"
	@cd services/rabbitmq && docker-compose up -d
	@echo "$(GREEN)RabbitMQ started successfully!$(NC)"

rabbitmq-down:
	@echo "$(YELLOW)Stopping RabbitMQ...$(NC)"
	@cd services/rabbitmq && docker-compose stop || true
	@cd services/rabbitmq && docker-compose rm -f || true
	@echo "$(GREEN)RabbitMQ stopped!$(NC)"

rabbitmq-restart: rabbitmq-down rabbitmq-up
	@echo "$(GREEN)RabbitMQ restarted!$(NC)"

rabbitmq-status:
	@cd services/rabbitmq && docker-compose ps || echo "$(RED)RabbitMQ is not running$(NC)"

rabbitmq-logs:
	@cd services/rabbitmq && docker-compose logs -f

rabbitmq-connection-info:
	@./scripts/get-connection-info.sh rabbitmq text

# MinIO targets
minio-up: check-deps ensure-network
	@echo "$(GREEN)Starting MinIO...$(NC)"
	@cd services/minio && docker-compose up -d
	@echo "$(GREEN)MinIO started successfully!$(NC)"

minio-down:
	@echo "$(YELLOW)Stopping MinIO...$(NC)"
	@cd services/minio && docker-compose stop || true
	@cd services/minio && docker-compose rm -f || true
	@echo "$(GREEN)MinIO stopped!$(NC)"

minio-restart: minio-down minio-up
	@echo "$(GREEN)MinIO restarted!$(NC)"

minio-status:
	@cd services/minio && docker-compose ps || echo "$(RED)MinIO is not running$(NC)"

minio-logs:
	@cd services/minio && docker-compose logs -f

minio-connection-info:
	@./scripts/get-connection-info.sh minio text

# Prometheus targets
prometheus-up: check-deps ensure-network
	@echo "$(GREEN)Starting Prometheus...$(NC)"
	@cd services/prometheus && docker-compose up -d
	@echo "$(GREEN)Prometheus started successfully!$(NC)"

prometheus-down:
	@echo "$(YELLOW)Stopping Prometheus...$(NC)"
	@cd services/prometheus && docker-compose stop || true
	@cd services/prometheus && docker-compose rm -f || true
	@echo "$(GREEN)Prometheus stopped!$(NC)"

prometheus-restart: prometheus-down prometheus-up
	@echo "$(GREEN)Prometheus restarted!$(NC)"

prometheus-status:
	@cd services/prometheus && docker-compose ps || echo "$(RED)Prometheus is not running$(NC)"

prometheus-logs:
	@cd services/prometheus && docker-compose logs -f

prometheus-connection-info:
	@./scripts/get-connection-info.sh prometheus text

# Grafana targets
grafana-up: check-deps ensure-network
	@echo "$(GREEN)Starting Grafana...$(NC)"
	@cd services/grafana && docker-compose up -d
	@echo "$(GREEN)Grafana started successfully!$(NC)"

grafana-down:
	@echo "$(YELLOW)Stopping Grafana...$(NC)"
	@cd services/grafana && docker-compose stop || true
	@cd services/grafana && docker-compose rm -f || true
	@echo "$(GREEN)Grafana stopped!$(NC)"

grafana-restart: grafana-down grafana-up
	@echo "$(GREEN)Grafana restarted!$(NC)"

grafana-status:
	@cd services/grafana && docker-compose ps || echo "$(RED)Grafana is not running$(NC)"

grafana-logs:
	@cd services/grafana && docker-compose logs -f

grafana-connection-info:
	@./scripts/get-connection-info.sh grafana text

# InfluxDB targets
influxdb-up: check-deps ensure-network
	@echo "$(GREEN)Starting InfluxDB...$(NC)"
	@cd services/influxdb && docker-compose up -d
	@echo "$(GREEN)InfluxDB started successfully!$(NC)"

influxdb-down:
	@echo "$(YELLOW)Stopping InfluxDB...$(NC)"
	@cd services/influxdb && docker-compose stop || true
	@cd services/influxdb && docker-compose rm -f || true
	@echo "$(GREEN)InfluxDB stopped!$(NC)"

influxdb-restart: influxdb-down influxdb-up
	@echo "$(GREEN)InfluxDB restarted!$(NC)"

influxdb-status:
	@cd services/influxdb && docker-compose ps || echo "$(RED)InfluxDB is not running$(NC)"

influxdb-logs:
	@cd services/influxdb && docker-compose logs -f

influxdb-connection-info:
	@./scripts/get-connection-info.sh influxdb text

# Cassandra targets
cassandra-up: check-deps ensure-network
	@echo "$(GREEN)Starting Cassandra...$(NC)"
	@cd services/cassandra && docker-compose up -d
	@echo "$(GREEN)Cassandra started successfully!$(NC)"

cassandra-down:
	@echo "$(YELLOW)Stopping Cassandra...$(NC)"
	@cd services/cassandra && docker-compose stop || true
	@cd services/cassandra && docker-compose rm -f || true
	@echo "$(GREEN)Cassandra stopped!$(NC)"

cassandra-restart: cassandra-down cassandra-up
	@echo "$(GREEN)Cassandra restarted!$(NC)"

cassandra-status:
	@cd services/cassandra && docker-compose ps || echo "$(RED)Cassandra is not running$(NC)"

cassandra-logs:
	@cd services/cassandra && docker-compose logs -f

cassandra-connection-info:
	@./scripts/get-connection-info.sh cassandra text

# Neo4j targets
neo4j-up: check-deps ensure-network
	@echo "$(GREEN)Starting Neo4j...$(NC)"
	@cd services/neo4j && docker-compose up -d
	@echo "$(GREEN)Neo4j started successfully!$(NC)"

neo4j-down:
	@echo "$(YELLOW)Stopping Neo4j...$(NC)"
	@cd services/neo4j && docker-compose stop || true
	@cd services/neo4j && docker-compose rm -f || true
	@echo "$(GREEN)Neo4j stopped!$(NC)"

neo4j-restart: neo4j-down neo4j-up
	@echo "$(GREEN)Neo4j restarted!$(NC)"

neo4j-status:
	@cd services/neo4j && docker-compose ps || echo "$(RED)Neo4j is not running$(NC)"

neo4j-logs:
	@cd services/neo4j && docker-compose logs -f

neo4j-connection-info:
	@./scripts/get-connection-info.sh neo4j text

# Memcached targets
memcached-up: check-deps ensure-network
	@echo "$(GREEN)Starting Memcached...$(NC)"
	@cd services/memcached && docker-compose up -d
	@echo "$(GREEN)Memcached started successfully!$(NC)"

memcached-down:
	@echo "$(YELLOW)Stopping Memcached...$(NC)"
	@cd services/memcached && docker-compose stop || true
	@cd services/memcached && docker-compose rm -f || true
	@echo "$(GREEN)Memcached stopped!$(NC)"

memcached-restart: memcached-down memcached-up
	@echo "$(GREEN)Memcached restarted!$(NC)"

memcached-status:
	@cd services/memcached && docker-compose ps || echo "$(RED)Memcached is not running$(NC)"

memcached-logs:
	@cd services/memcached && docker-compose logs -f

memcached-connection-info:
	@./scripts/get-connection-info.sh memcached text

# Consul targets
consul-up: check-deps ensure-network
	@echo "$(GREEN)Starting Consul...$(NC)"
	@cd services/consul && docker-compose up -d
	@echo "$(GREEN)Consul started successfully!$(NC)"

consul-down:
	@echo "$(YELLOW)Stopping Consul...$(NC)"
	@cd services/consul && docker-compose stop || true
	@cd services/consul && docker-compose rm -f || true
	@echo "$(GREEN)Consul stopped!$(NC)"

consul-restart: consul-down consul-up
	@echo "$(GREEN)Consul restarted!$(NC)"

consul-status:
	@cd services/consul && docker-compose ps || echo "$(RED)Consul is not running$(NC)"

consul-logs:
	@cd services/consul && docker-compose logs -f

consul-connection-info:
	@./scripts/get-connection-info.sh consul text

# Vault targets
vault-up: check-deps ensure-network
	@echo "$(GREEN)Starting Vault...$(NC)"
	@cd services/vault && docker-compose up -d
	@echo "$(GREEN)Vault started successfully!$(NC)"

vault-down:
	@echo "$(YELLOW)Stopping Vault...$(NC)"
	@cd services/vault && docker-compose stop || true
	@cd services/vault && docker-compose rm -f || true
	@echo "$(GREEN)Vault stopped!$(NC)"

vault-restart: vault-down vault-up
	@echo "$(GREEN)Vault restarted!$(NC)"

vault-status:
	@cd services/vault && docker-compose ps || echo "$(RED)Vault is not running$(NC)"

vault-logs:
	@cd services/vault && docker-compose logs -f

vault-connection-info:
	@./scripts/get-connection-info.sh vault text

# Nginx targets
nginx-up: check-deps ensure-network
	@echo "$(GREEN)Starting Nginx...$(NC)"
	@cd services/nginx && docker-compose up -d
	@echo "$(GREEN)Nginx started successfully!$(NC)"

nginx-down:
	@echo "$(YELLOW)Stopping Nginx...$(NC)"
	@cd services/nginx && docker-compose stop || true
	@cd services/nginx && docker-compose rm -f || true
	@echo "$(GREEN)Nginx stopped!$(NC)"

nginx-restart: nginx-down nginx-up
	@echo "$(GREEN)Nginx restarted!$(NC)"

nginx-status:
	@cd services/nginx && docker-compose ps || echo "$(RED)Nginx is not running$(NC)"

nginx-logs:
	@cd services/nginx && docker-compose logs -f

nginx-connection-info:
	@./scripts/get-connection-info.sh nginx text

# Traefik targets
traefik-up: check-deps ensure-network
	@echo "$(GREEN)Starting Traefik...$(NC)"
	@cd services/traefik && docker-compose up -d
	@echo "$(GREEN)Traefik started successfully!$(NC)"

traefik-down:
	@echo "$(YELLOW)Stopping Traefik...$(NC)"
	@cd services/traefik && docker-compose stop || true
	@cd services/traefik && docker-compose rm -f || true
	@echo "$(GREEN)Traefik stopped!$(NC)"

traefik-restart: traefik-down traefik-up
	@echo "$(GREEN)Traefik restarted!$(NC)"

traefik-status:
	@cd services/traefik && docker-compose ps || echo "$(RED)Traefik is not running$(NC)"

traefik-logs:
	@cd services/traefik && docker-compose logs -f

traefik-connection-info:
	@./scripts/get-connection-info.sh traefik text

# Jaeger targets
jaeger-up: check-deps ensure-network
	@echo "$(GREEN)Starting Jaeger...$(NC)"
	@cd services/jaeger && docker-compose up -d
	@echo "$(GREEN)Jaeger started successfully!$(NC)"

jaeger-down:
	@echo "$(YELLOW)Stopping Jaeger...$(NC)"
	@cd services/jaeger && docker-compose stop || true
	@cd services/jaeger && docker-compose rm -f || true
	@echo "$(GREEN)Jaeger stopped!$(NC)"

jaeger-restart: jaeger-down jaeger-up
	@echo "$(GREEN)Jaeger restarted!$(NC)"

jaeger-status:
	@cd services/jaeger && docker-compose ps || echo "$(RED)Jaeger is not running$(NC)"

jaeger-logs:
	@cd services/jaeger && docker-compose logs -f

jaeger-connection-info:
	@./scripts/get-connection-info.sh jaeger text

# Zipkin targets
zipkin-up: check-deps ensure-network
	@echo "$(GREEN)Starting Zipkin...$(NC)"
	@cd services/zipkin && docker-compose up -d
	@echo "$(GREEN)Zipkin started successfully!$(NC)"

zipkin-down:
	@echo "$(YELLOW)Stopping Zipkin...$(NC)"
	@cd services/zipkin && docker-compose stop || true
	@cd services/zipkin && docker-compose rm -f || true
	@echo "$(GREEN)Zipkin stopped!$(NC)"

zipkin-restart: zipkin-down zipkin-up
	@echo "$(GREEN)Zipkin restarted!$(NC)"

zipkin-status:
	@cd services/zipkin && docker-compose ps || echo "$(RED)Zipkin is not running$(NC)"

zipkin-logs:
	@cd services/zipkin && docker-compose logs -f

zipkin-connection-info:
	@./scripts/get-connection-info.sh zipkin text

# ClickHouse targets
clickhouse-up: check-deps ensure-network
	@echo "$(GREEN)Starting ClickHouse...$(NC)"
	@cd services/clickhouse && docker-compose up -d
	@echo "$(GREEN)ClickHouse started successfully!$(NC)"

clickhouse-down:
	@echo "$(YELLOW)Stopping ClickHouse...$(NC)"
	@cd services/clickhouse && docker-compose stop || true
	@cd services/clickhouse && docker-compose rm -f || true
	@echo "$(GREEN)ClickHouse stopped!$(NC)"

clickhouse-restart: clickhouse-down clickhouse-up
	@echo "$(GREEN)ClickHouse restarted!$(NC)"

clickhouse-status:
	@cd services/clickhouse && docker-compose ps || echo "$(RED)ClickHouse is not running$(NC)"

clickhouse-logs:
	@cd services/clickhouse && docker-compose logs -f

clickhouse-connection-info:
	@./scripts/get-connection-info.sh clickhouse text

# CouchDB targets
couchdb-up: check-deps ensure-network
	@echo "$(GREEN)Starting CouchDB...$(NC)"
	@cd services/couchdb && docker-compose up -d
	@echo "$(GREEN)CouchDB started successfully!$(NC)"

couchdb-down:
	@echo "$(YELLOW)Stopping CouchDB...$(NC)"
	@cd services/couchdb && docker-compose stop || true
	@cd services/couchdb && docker-compose rm -f || true
	@echo "$(GREEN)CouchDB stopped!$(NC)"

couchdb-restart: couchdb-down couchdb-up
	@echo "$(GREEN)CouchDB restarted!$(NC)"

couchdb-status:
	@cd services/couchdb && docker-compose ps || echo "$(RED)CouchDB is not running$(NC)"

couchdb-logs:
	@cd services/couchdb && docker-compose logs -f

couchdb-connection-info:
	@./scripts/get-connection-info.sh couchdb text

# Bulk operations
all-up: check-deps ensure-network
	@echo "$(GREEN)Starting all services...$(NC)"
	@for service in $(SERVICES); do \
		echo "$(YELLOW)Starting $$service...$(NC)"; \
		cd services/$$service && docker-compose up -d && cd ../..; \
	done
	@echo "$(GREEN)All services started!$(NC)"

all-down:
	@echo "$(YELLOW)Stopping all services...$(NC)"
	@for service in $(SERVICES); do \
		echo "$(YELLOW)Stopping $$service...$(NC)"; \
		cd services/$$service && docker-compose stop || true && docker-compose rm -f || true && cd ../..; \
	done
	@echo "$(GREEN)All services stopped!$(NC)"

all-status:
	@echo "$(GREEN)Service Status:$(NC)"
	@for service in $(SERVICES); do \
		echo "$(YELLOW)$$service:$(NC)"; \
		cd services/$$service && docker-compose ps 2>/dev/null || echo "$(RED)  Not running$(NC)"; \
		cd ../..; \
	done

connection-info: ## Show connection info for all services
	@echo "$(GREEN)Connection Information for All Services:$(NC)"
	@echo ""
	@for service in $(SERVICES); do \
		./scripts/get-connection-info.sh $$service text; \
		echo ""; \
	done

