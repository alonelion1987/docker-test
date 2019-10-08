# docker-test

Custom build WordPress on nginx, php-fpm, mysql and xdebug

Start development: `Makefile::init`

---

Problems with file permissions if install plugins via admin panel, try:

- `sudo chown $(whoami):$(whoami) -R $(pwd)/app/`
- `sudo chown www-data:www-data -R $(pwd)/app/`
- `sudo chmod 777 -R $(pwd)/app/`
