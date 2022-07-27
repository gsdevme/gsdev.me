.PHONY: start
default: start;

DOCKER_COMPOSE := docker-compose -f infrastructure/docker-compose.yml --project-directory $(CURDIR)

start:
	${DOCKER_COMPOSE} up

clean:
	${DOCKER_COMPOSE} down --remove-orphans
	if [ -d "$(CURDIR)/.bundle" ]; then rm -Rf "$(CURDIR)/.bundle"; fi
