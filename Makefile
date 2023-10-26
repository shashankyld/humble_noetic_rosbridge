
IM_NAME=ros2_humble
CONT_NAME=humble-container # You will need to apply the exact same name to container_name in orb-container/docker-compose.yml

default: up enter

up:
	docker compose up -d

run:
	docker run -it --privileged --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  -v  --network=host --name ${CONT_NAME} ${IM_NAME} bash

enter:
	clear && docker exec -it ${CONT_NAME} bash

down:
	docker compose down

build_without_cache:
	docker build --no-cache -t ${IM_NAME} .

build:
	docker build -t ${IM_NAME} .
delete_hesai:
	docker rmi ${IM_NAME}
