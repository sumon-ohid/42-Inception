docker_ps = docker ps
docker_rm = docker ps
docker_rmi = docker images
docker_volume_rm = docker volume ls

all: build run

build: 
	docker build -t alpineos .

run:
	docker run -it -p 9000:9000 alpineos
	
fclean:
	docker system prune -f

re : fclean all

.PHONY: all build run clean fclean re
