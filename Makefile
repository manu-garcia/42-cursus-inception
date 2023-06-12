name = inception

all: up

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

containers:
	@docker container ls

images:
	@docker images

clean: down

re: clean all

fclean: down
	@docker stop $$(docker ps -qa)
	@docker rmi $$(docker images -q)
	@docker rm $$(docker ps -aq)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all up down 