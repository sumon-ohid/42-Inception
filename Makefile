build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down --rmi all

logs:
	docker-compose -f srcs/docker-compose.yml logs nginx
	docker-compose -f srcs/docker-compose.yml logs wordpress
	docker-compose -f srcs/docker-compose.yml logs mariadb

restart:
	docker-compose -f srcs/docker-compose.yml restart nginx wordpress mariadb

network_check:
	docker network inspect srcs_mynetwork

remove_images:
	# docker stop $(docker ps -q)
	# docker rm $(docker ps -a -q)
	docker rmi -f $$(docker images -q)

re: down build up

.PHONY: build up down logs restart network_check remove_images re
