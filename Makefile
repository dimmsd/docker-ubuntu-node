#!/usr/bin/make

.DEFAULT_GOAL := help
.PHONY : help config-test set-log-access set-www-access build up down exec-nginx exec-httpd exec-as-root- exec-as-user \
 fpm-status fpm-exec-index

cnf ?= .env

ifneq ("$(wildcard $(cnf))","")
include $(cnf)
else
$(error "ERROR! File .env not found. Rename .env.example => .env")
endif

NODEIP=$(shell docker inspect node-$(MAIN_DOMAIN) | grep '"IPAddress"' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")

CURRENT_TIME=$(shell date +"%d.%m.%Y-%H.%M")

PWD=$(shell pwd)

install-node: run install-node-1
install-demo: run install-demo-1
test: run test-1

help:
	@echo "Help:"
	@echo "\tconfig-test - test docker-compose.yml"
	@echo "\tbuild - build dimmsd/$(NODE_IMAGE):$(UBUNTU_VERSION) image"
	@echo "\tup - up container"
	@echo "\tdown - down container"
	@echo "\tlogs - show logs container"
	@echo "\texec-node - attach to NODE container and start bash session"
	@echo "\tcheck-version - Check version images"
	@echo "\tinstall-node - Install nodejs"
	@echo "\tinstall-demo - Install node modules for demo node application folder ./www/node"
	@echo "\tcheck-demo - Execute for test curl (from container)"
config-test:
	@docker-compose -f docker-compose.yml config
build:
	@docker-compose build
up:
	@docker-compose up -d --build
down:
	@docker-compose down
logs:
	@docker logs node-$(MAIN_DOMAIN)
exec-node:
	@docker exec -u $(OWN_USER) -it node-$(MAIN_DOMAIN) bash
check-version:
	@./utils/check-version.sh docker-ubuntu-node node-$(MAIN_DOMAIN) dimmsd/ubuntu-node:${UBUNTU_VERSION}
check-demo:
	@docker exec -u $(OWN_USER) -it node-$(MAIN_DOMAIN) /tmp/utils_node/demo-check.sh
run:
	@docker run --name node-$(MAIN_DOMAIN) \
                 --env TIMEZONE=$(TIMEZONE) \
                 --env OWN_UID=$(OWN_UID) \
                 --env OWN_GID=$(OWN_GID) \
                 --env OWN_USER=$(OWN_USER) \
                 --env NVM_VERSION=$(NVM_VERSION) \
                 --env NODE_VERSION=$(NODE_VERSION) \
                 --env NO_DAEMON=1 \
                 -v $(PWD)/www/node:/var/www/node \
                 -v $(PWD)/utils:/tmp/utils \
                 -v $(PWD)/node-user:/home/$(OWN_USER) \
                 -td $(NODE_IMAGE):$(UBUNTU_VERSION)
	@sleep 1
install-node-1:
	@docker exec -u $(OWN_USER) -it node-$(MAIN_DOMAIN) /tmp/utils_node/install-nvm.sh || true
	@docker exec -u $(OWN_USER) -it node-$(MAIN_DOMAIN) /tmp/utils_node/install-node.bash || true
	@docker stop node-$(MAIN_DOMAIN) || true && docker rm node-$(MAIN_DOMAIN) || true
install-demo-1:
	@docker exec -u $(OWN_USER) -it node-$(MAIN_DOMAIN) /tmp/utils_node/demo-install.bash || true
	@docker stop node-$(MAIN_DOMAIN) || true && docker rm node-$(MAIN_DOMAIN) || true


