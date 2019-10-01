up: docker-up
down: docker-down
restart: docker-down docker-up
init: docker-down-clear docker-down docker-up docker-pull docker-build docker-up #app-composer-install

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

app-composer-install:
	docker-compose run --rm app-php-cli composer install

app-wait-db:
	until docker-compose exec -T app-mysql mysql_ready --timeout=0 --dbname=webapp ; do sleep 1 ; done