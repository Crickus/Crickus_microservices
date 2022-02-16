THIS_FILE := $(lastword $(MAKEFILE_LIST))
USERNAME := crickus
.PHONY: help build up start down destroy stop restart logs logs-api ps login-timescale login-api db-shell
# help:
#         make -pRrq  -f $(THIS_FILE) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
build-ui:
	docker build -f ./docker/src/ui/Dockerfile -t $(USERNAME)/ui:latest .
build-comment:
	docker build -f ./docker/src/comment/Dockerfile -t $(USERNAME)/comment:latest .
build-post:
	docker build -f ./docker/src/post/Dockerfile -t $(USERNAME)/post:latest .
build-prometheus:
	docker build -f ./monitoring/prometheus/Dockerfile -t $(USERNAME)/prometheus:latest	.
build:
	docker-compose -f ./docker/monitoring/compose/docker-compose.yml build $(c)
push:
	docker-compose -f ./docker/src/docker-compose.yml push $(c)
up:
	docker-compose -f ./docker/monitoring/compose/docker-compose.yml up -d $(c)
up-mon:
	docker-compose -f ./docker/monitoring/compose/docker-compose-monitoring.yml up -d $(c)
start:
	docker-compose -f ./docker/src/docker-compose.yml start $(c)
down:
	docker-compose -f ./docker/src/docker-compose.yml down $(c)
destroy:
	docker-compose -f ./docker/src/docker-compose.yml down -v $(c)
stop:
	docker-compose -f ./docker/src/docker-compose.yml stop $(c)
restart:
	docker-compose -f ./docker/src/docker-compose.yml stop $(c)
	docker-compose -f ./docker/src/docker-compose.yml up -d $(c)
logs:
	docker-compose -f ./docker/src/docker-compose.yml logs --tail=100 -f $(c)
ps:
	docker-compose -f ./docker/src/docker-compose.yml ps

