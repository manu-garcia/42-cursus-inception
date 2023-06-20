name = inception

all: up

up:
	@docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml down

clean: down

re: clean all

fclean: down
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@if [ -n "$$(docker images -q)" ]; then docker rmi $$(docker images -q) -f; fi
	@if [ -n "$$(docker ps -aq)" ]; then docker rm $$(docker ps -aq) -f; fi
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

sh_mariadb:
	@docker exec -it mariadb sh

logs:
	@echo "nginx logs:"
	@docker logs nginx
	@echo ""

	@echo "wordpress logs:"
	@docker logs wordpress
	@echo ""

	@echo "mariadb logs:"
	@docker logs mariadb
	@echo ""

.PHONY: all up down clean re fclean sh_mariadb logs