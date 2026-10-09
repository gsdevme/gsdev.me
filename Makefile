.PHONY: start test shell clean
default: start;

export UID := $(shell id -u)
export GID := $(shell id -g)

DOCKER_COMPOSE := docker compose -f infrastructure/docker-compose.yaml --project-directory $(CURDIR)

start:
	$(DOCKER_COMPOSE) up

test:
	$(DOCKER_COMPOSE) run --rm --no-deps jekyll bash -c "bundle install && bash tools/test.sh"

shell:
	$(DOCKER_COMPOSE) run --rm jekyll bash

clean:
	$(DOCKER_COMPOSE) down --remove-orphans
	rm -rf "$(CURDIR)/.bundle" "$(CURDIR)/vendor" "$(CURDIR)/_site" "$(CURDIR)/.jekyll-cache"
