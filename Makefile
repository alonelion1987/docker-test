###
init-containers: docker-down-all-remove app-clear docker-pull docker-build docker-up app-init clear-cache

start-containers: docker-up

stop-containers: docker-down

restart-containers: docker-down docker-up

test-app: app-test

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

app-init: app-composer-install app-assets-install app-wait-db app-ready #app-migrations

app-composer-install:
	docker-compose run --rm app-php-cli composer install

app-wait-db:
	until docker-compose exec -T app-postgres pg_isready --timeout=0 --dbname=app ; do sleep 1 ; done

#app-migrations:
#	docker-compose run --rm app-php-cli php bin/console doctrine:migrations:migrate --no-interaction

app-clear:
	docker run --rm -v ${PWD}/app:/app --workdir=/app alpine rm -f .ready

app-ready:
	docker run --rm -v ${PWD}/app:/app --workdir=/app alpine touch .ready

app-assets-install:
	docker-compose run --rm app-node yarn install
	docker-compose run --rm app-node npm rebuild node-sass

app-test:
	docker-compose run --rm app-php-cli php bin/phpunit

clear-cache:
	docker-compose run --rm app-php-cli php bin/console cache:clear --no-warmup --env=prod

clear-cache-dev:
	docker-compose run --rm app-php-cli php bin/console cache:clear --no-warmup

