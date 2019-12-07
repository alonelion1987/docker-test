###
init-containers: docker-down-all-remove docker-pull docker-build docker-up app-init

start-containers: docker-up

stop-containers: docker-down

restart-containers: stop-containers start-containers

###
docker-up:
	docker-compose up -d

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

docker-down:
	docker-compose down --remove-orphans

docker-down-all-remove:
	docker-compose down -v --remove-orphans

app-init: app-composer-install

app-composer-install:
	docker-compose run --rm app-php-cli composer install

