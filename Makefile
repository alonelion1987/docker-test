up: docker-up app-start
down: docker-down
restart: docker-down docker-up app-start
init: docker-down-clear docker-pull docker-build docker-up app-npm-install app-start

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

app-init: app-npm-install app-start

app-npm-install:
	docker-compose exec app-node npm install

app-start:
	docker-compose exec app-node npm run dev