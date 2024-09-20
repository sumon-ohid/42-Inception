DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
DATA_DIR = /home/msumon/data
WORDPRESS_DIR = ${DATA_DIR}/wordpress
MARIADB_DIR = ${DATA_DIR}/mariadb

all: create_dirs build up

create_dirs:
	@mkdir -p ${WORDPRESS_DIR}
	@mkdir -p ${MARIADB_DIR}

build: create_dirs
	${DOCKER_COMPOSE} build

up: create_dirs
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

clean: down
	${DOCKER_COMPOSE} down -v --rmi all --remove-orphans

fclean: clean
	docker system prune -f

re: fclean all

.PHONY: build up down logs restart rm_images re fclean clean wp_shell db_shell nginx_shell create_dirs

# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
# docker rmi $(docker images -q)
# docker volume rm $(docker volume ls -q)

# docker build -t my-nginx-image .
# docker run -d -p 80:80 my-nginx-container my-nginx-image

# echo "127.0.0.1 msumon.42.fr" | sudo tee -a /etc/hosts
# echo "127.0.0.1 www.msumon.42.fr" | sudo tee -a /etc/hosts
# sudo ss -tuln