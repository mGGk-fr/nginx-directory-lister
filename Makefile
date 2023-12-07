DOCKER_USERNAME ?= mggk
APPLICATION_NAME ?= nginx-directory-lister

build:
	docker build --tag ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest .

release:
	docker buildx build --platform linux/amd64,linux/arm64 --tag ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest . --push

test:
	docker stop ${APPLICATION_NAME}
	docker rm ${APPLICATION_NAME}
	docker run -d -p 80:80 -v ./test_volume:/usr/share/nginx/html --name ${APPLICATION_NAME} ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest