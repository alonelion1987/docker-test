up: docker-up
down: docker-down
restart: docker-down docker-up
init: docker-down-clear docker-down docker-up docker-pull docker-build docker-up app-composer-install app-setup restart

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

app-setup:
	# config
	docker-compose run --rm app-php-fpm mv /container-app/wp-config.php /container-app/wordpress/wp-config.php

	# this custom gitignore for custom theme [example:] "developTheme" only https://zharrikov.ru/note/gitignore_wp.html
	docker-compose run --rm app-php-fpm mv /container-app/.gitignore /container-app/wordpress/.gitignore

	# create dir custom theme
	docker-compose run --rm app-php-fpm mkdir -p /container-app/wordpress/wp-content/themes/developTheme

	# create index file custom theme and start development
	docker-compose run --rm app-php-fpm touch /container-app/wordpress/wp-content/themes/developTheme/index.php

app-wait-db:
	until docker-compose exec -T app-mysql mysql_ready --timeout=0 --dbname=webapp ; do sleep 1 ; done
