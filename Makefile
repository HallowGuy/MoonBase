# Makefile for MoonBase Workspace

PROJECT_NAME := moonbase
ENV_FILE := .env.production

# Docker Compose base command
DC := docker compose --env-file $(ENV_FILE)

.PHONY: all build up down restart logs status clean prune

all: build up

build:
	@echo "🔨 Building containers..."
	$(DC) build

up:
	@echo "🚀 Starting all services..."
	$(DC) up -d

down:
	@echo "🛑 Stopping all services..."
	$(DC) down -v

restart:
	@echo "♻️ Restarting services..."
	$(MAKE) down
	$(MAKE) up

logs:
	@echo "📜 Showing logs..."
	$(DC) logs -f --tail=100

status:
	@echo "📊 Showing container status..."
	docker ps --filter name=$(PROJECT_NAME)

clean:
	@echo "🧹 Cleaning up build artifacts..."
	docker image prune -f
	docker volume prune -f

prune:
	@echo "🔥 Full system cleanup (containers, volumes, networks)..."
	docker system prune -af --volumes
