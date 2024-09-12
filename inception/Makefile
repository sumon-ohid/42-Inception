DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml

all: build up

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down --rmi all

rm_images:
	docker-compose -f srcs/docker-compose.yml --rmi all

logs:
	docker-compose -f srcs/docker-compose.yml logs nginx
	docker-compose -f srcs/docker-compose.yml logs wordpress
	#docker-compose -f srcs/docker-compose.yml logs mariadb

restart:
	docker-compose -f srcs/docker-compose.yml restart nginx wordpress mariadb

network_check:
	docker network inspect bridge

clean:			down
				sudo rm -rf ~/Desktop/inception
				${DOCKER_COMPOSE} down -v --rmi all --remove-orphans

fclean: 		clean
				docker system prune -f

re:				fclean all

re: clean fclean down build up

.PHONY: build up down logs restart network_check rm_images re


# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
# docker rmi $(docker images -q)
# docker volume rm $(docker volume ls -q)

# docker build -t my-nginx-image .
# docker run -d -p 80:80 my-nginx-container my-nginx-image