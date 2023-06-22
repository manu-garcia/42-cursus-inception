name = inception

all: up

up:
	@mkdir -p /home/${USER}/data/wordpress
	@mkdir -p /home/${USER}/data/mariadb
	@docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml down

clean: down
	rm -rf /home/${USER}/data/wordpress
	rm -rf /home/${USER}/data/mariadb

re: clean all

fclean: down
	if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa) -f; fi
	if [ -n "$$(docker images -q)" ]; then docker rmi $$(docker images -q) -f; fi
	if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	rm -rf /home/${USER}/data/wordpress
	rm -rf /home/${USER}/data/mariadb

	@echo "fclean successfull"

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