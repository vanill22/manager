up: docker-up
init: docker-down docker-pull docker-build docker-up

docker-up:
	docker-compose up --build -d

docker-down:
	docker-compose down --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

cli:
	docker-compose run --rm manager-php-cli php bin/app.php

build-production:
    docker build --pull --file=manager/docker/production/nginx.docker --tag ${REGISTRY_ADDRESS}/manager-nginx:${IMAGE_TAG} manager
    docker build --pull --file=manager/docker/production/php-fpm.docker --tag ${REGISTRY_ADDRESS}/manager-php-fpm:${IMAGE_TAG} manager
    docker build --pull --file=manager/docker/production/php-cli.docker --tag ${REGISTRY_ADDRESS}/manager-php-cli:${IMAGE_TAG} manager

push-production:
    docker push ${REGISTRY_ADDRESS}/manager-nginx:${IMAGE_TAG}
    docker push ${REGISTRY_ADDRESS}/manager-php-fpm:${IMAGE_TAG}
    docker push ${REGISTRY_ADDRESS}/manager-php-cli:${IMAGE_TAG}
