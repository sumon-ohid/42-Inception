DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml

all: build up

build:
	${DOCKER_COMPOSE} build

up:
	${DOCKER_COMPOSE} up -d

down:
	${DOCKER_COMPOSE} down --rmi all

rm_images:
	${DOCKER_COMPOSE} --rmi all

logs:
	${DOCKER_COMPOSE} logs nginx
	${DOCKER_COMPOSE} logs wordpress
	${DOCKER_COMPOSE} logs mariadb

restart:
	${DOCKER_COMPOSE} restart nginx wordpress mariadb

wp_shell:
	${DOCKER_COMPOSE} exec -it wordpress sh 

db_shell:
	${DOCKER_COMPOSE} exec -it mariadb sh

nginx_shell:
	${DOCKER_COMPOSE} exec -it nginx sh

clean:	down
	sudo rm -rf ~/Desktop/DATA_BASE
	${DOCKER_COMPOSE} down -v --rmi all --remove-orphans

fclean: clean
	docker system prune -f

re:	fclean all

.PHONY: build up down logs restart rm_images re fclean clean wp_shell db_shell nginx_shell


# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
# docker rmi $(docker images -q)
# docker volume rm $(docker volume ls -q)

# docker build -t my-nginx-image .
# docker run -d -p 80:80 my-nginx-container my-nginx-image