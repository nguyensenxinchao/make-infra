.PHONY: help check-deps list-services
.PHONY: mongodb-up mongodb-down mongodb-logs mongodb-status mongodb-restart
.PHONY: nats-jetstream-up nats-jetstream-down nats-jetstream-logs nats-jetstream-status nats-jetstream-restart
.PHONY: redis-up redis-down redis-logs redis-status redis-restart
.PHONY: postgres-up postgres-down postgres-logs postgres-status postgres-restart
.PHONY: mysql-up mysql-down mysql-logs mysql-status mysql-restart
.PHONY: elasticsearch-up elasticsearch-down elasticsearch-logs elasticsearch-status elasticsearch-restart
.PHONY: kafka-up kafka-down kafka-logs kafka-status kafka-restart
.PHONY: rabbitmq-up rabbitmq-down rabbitmq-logs rabbitmq-status rabbitmq-restart
.PHONY: all-up all-down all-status

# Default target
.DEFAULT_GOAL := help

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Docker Compose file
COMPOSE_FILE := docker-compose.yml

# Services list
SERVICES := mongodb nats-jetstream redis postgres mysql elasticsearch kafka rabbitmq

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
		echo ""; \
	done
	@echo "General commands:"
	@echo "  make all-up         - Start all services"
	@echo "  make all-down       - Stop all services"
	@echo "  make all-status     - Check status of all services"
	@echo "  make list-services  - List all available services"
	@echo "  make check-deps     - Check required dependencies"

check-deps: ## Check if required dependencies are installed
	@echo "$(GREEN)Checking dependencies...$(NC)"
	@command -v docker >/dev/null 2>&1 || { echo "$(RED)Docker is not installed$(NC)"; exit 1; }
	@command -v docker-compose >/dev/null 2>&1 || { echo "$(RED)Docker Compose is not installed$(NC)"; exit 1; }
	@docker ps >/dev/null 2>&1 || { echo "$(RED)Docker daemon is not running$(NC)"; exit 1; }
	@echo "$(GREEN)All dependencies are installed and ready!$(NC)"

list-services: ## List all available services
	@echo "$(GREEN)Available services:$(NC)"
	@for service in $(SERVICES); do \
		echo "  - $$service"; \
	done

# MongoDB targets
mongodb-up: check-deps
	@echo "$(GREEN)Starting MongoDB...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d mongodb
	@echo "$(GREEN)MongoDB started successfully!$(NC)"

mongodb-down:
	@echo "$(YELLOW)Stopping MongoDB...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop mongodb || true
	@docker-compose -f $(COMPOSE_FILE) rm -f mongodb || true
	@echo "$(GREEN)MongoDB stopped!$(NC)"

mongodb-restart: mongodb-down mongodb-up
	@echo "$(GREEN)MongoDB restarted!$(NC)"

mongodb-status:
	@docker-compose -f $(COMPOSE_FILE) ps mongodb || echo "$(RED)MongoDB is not running$(NC)"

mongodb-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f mongodb

# NATS JetStream targets
nats-jetstream-up: check-deps
	@echo "$(GREEN)Starting NATS JetStream...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d nats-jetstream
	@echo "$(GREEN)NATS JetStream started successfully!$(NC)"

nats-jetstream-down:
	@echo "$(YELLOW)Stopping NATS JetStream...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop nats-jetstream || true
	@docker-compose -f $(COMPOSE_FILE) rm -f nats-jetstream || true
	@echo "$(GREEN)NATS JetStream stopped!$(NC)"

nats-jetstream-restart: nats-jetstream-down nats-jetstream-up
	@echo "$(GREEN)NATS JetStream restarted!$(NC)"

nats-jetstream-status:
	@docker-compose -f $(COMPOSE_FILE) ps nats-jetstream || echo "$(RED)NATS JetStream is not running$(NC)"

nats-jetstream-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f nats-jetstream

# Redis targets
redis-up: check-deps
	@echo "$(GREEN)Starting Redis...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d redis
	@echo "$(GREEN)Redis started successfully!$(NC)"

redis-down:
	@echo "$(YELLOW)Stopping Redis...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop redis || true
	@docker-compose -f $(COMPOSE_FILE) rm -f redis || true
	@echo "$(GREEN)Redis stopped!$(NC)"

redis-restart: redis-down redis-up
	@echo "$(GREEN)Redis restarted!$(NC)"

redis-status:
	@docker-compose -f $(COMPOSE_FILE) ps redis || echo "$(RED)Redis is not running$(NC)"

redis-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f redis

# PostgreSQL targets
postgres-up: check-deps
	@echo "$(GREEN)Starting PostgreSQL...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d postgres
	@echo "$(GREEN)PostgreSQL started successfully!$(NC)"

postgres-down:
	@echo "$(YELLOW)Stopping PostgreSQL...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop postgres || true
	@docker-compose -f $(COMPOSE_FILE) rm -f postgres || true
	@echo "$(GREEN)PostgreSQL stopped!$(NC)"

postgres-restart: postgres-down postgres-up
	@echo "$(GREEN)PostgreSQL restarted!$(NC)"

postgres-status:
	@docker-compose -f $(COMPOSE_FILE) ps postgres || echo "$(RED)PostgreSQL is not running$(NC)"

postgres-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f postgres

# MySQL targets
mysql-up: check-deps
	@echo "$(GREEN)Starting MySQL...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d mysql
	@echo "$(GREEN)MySQL started successfully!$(NC)"

mysql-down:
	@echo "$(YELLOW)Stopping MySQL...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop mysql || true
	@docker-compose -f $(COMPOSE_FILE) rm -f mysql || true
	@echo "$(GREEN)MySQL stopped!$(NC)"

mysql-restart: mysql-down mysql-up
	@echo "$(GREEN)MySQL restarted!$(NC)"

mysql-status:
	@docker-compose -f $(COMPOSE_FILE) ps mysql || echo "$(RED)MySQL is not running$(NC)"

mysql-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f mysql

# Elasticsearch targets
elasticsearch-up: check-deps
	@echo "$(GREEN)Starting Elasticsearch...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d elasticsearch
	@echo "$(GREEN)Elasticsearch started successfully!$(NC)"

elasticsearch-down:
	@echo "$(YELLOW)Stopping Elasticsearch...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop elasticsearch || true
	@docker-compose -f $(COMPOSE_FILE) rm -f elasticsearch || true
	@echo "$(GREEN)Elasticsearch stopped!$(NC)"

elasticsearch-restart: elasticsearch-down elasticsearch-up
	@echo "$(GREEN)Elasticsearch restarted!$(NC)"

elasticsearch-status:
	@docker-compose -f $(COMPOSE_FILE) ps elasticsearch || echo "$(RED)Elasticsearch is not running$(NC)"

elasticsearch-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f elasticsearch

# Kafka targets
kafka-up: check-deps
	@echo "$(GREEN)Starting Kafka...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d kafka
	@echo "$(GREEN)Kafka started successfully!$(NC)"

kafka-down:
	@echo "$(YELLOW)Stopping Kafka and Zookeeper...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop kafka zookeeper || true
	@docker-compose -f $(COMPOSE_FILE) rm -f kafka zookeeper || true
	@echo "$(GREEN)Kafka and Zookeeper stopped!$(NC)"

kafka-restart: kafka-down kafka-up
	@echo "$(GREEN)Kafka restarted!$(NC)"

kafka-status:
	@echo "$(GREEN)Kafka and Zookeeper Status:$(NC)"
	@docker-compose -f $(COMPOSE_FILE) ps kafka zookeeper || echo "$(RED)Kafka/Zookeeper is not running$(NC)"

kafka-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f kafka zookeeper

# RabbitMQ targets
rabbitmq-up: check-deps
	@echo "$(GREEN)Starting RabbitMQ...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d rabbitmq
	@echo "$(GREEN)RabbitMQ started successfully!$(NC)"

rabbitmq-down:
	@echo "$(YELLOW)Stopping RabbitMQ...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop rabbitmq || true
	@docker-compose -f $(COMPOSE_FILE) rm -f rabbitmq || true
	@echo "$(GREEN)RabbitMQ stopped!$(NC)"

rabbitmq-restart: rabbitmq-down rabbitmq-up
	@echo "$(GREEN)RabbitMQ restarted!$(NC)"

rabbitmq-status:
	@docker-compose -f $(COMPOSE_FILE) ps rabbitmq || echo "$(RED)RabbitMQ is not running$(NC)"

rabbitmq-logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f rabbitmq

# Bulk operations
all-up: check-deps
	@echo "$(GREEN)Starting all services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)All services started!$(NC)"

all-down:
	@echo "$(YELLOW)Stopping all services...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)All services stopped!$(NC)"

all-status:
	@echo "$(GREEN)Service Status:$(NC)"
	@docker-compose -f $(COMPOSE_FILE) ps

