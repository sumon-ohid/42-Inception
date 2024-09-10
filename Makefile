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
	docker network inspect bridge

re: down build up

.PHONY: build up down logs restart network_check remove_images re


# SSL
# sudo mkdir -p /etc/nginx/ssl
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
