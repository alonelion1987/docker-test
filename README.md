# docker-test

Custom build WordPress on nginx, php-fpm, mysql and xdebug

Start development: `Makefile::init`

Url: http://localhost:8888

---

Problems with file permissions if install plugins via admin panel, try:

- `sudo chown $(whoami):$(whoami) -R $(pwd)/app/`
- `sudo chown www-data:www-data -R $(pwd)/app/`
- `sudo chmod 777 -R $(pwd)/app/`

Problems with error **file not found**:

![file_not_found](https://i.imgur.com/ITZgnmh.png "file_not_found")

Try `Makefile::restart`
