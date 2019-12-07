# docker-test

![screen-frontend](http://i.imgur.com/zgbif2y.png "app-encoder")

Example of the simplest application divided into frontend and backend parts working in a docker container.

Frontend pure JS. Backend on Slim microframework (PHP)

Frontend open http://localhost:8888

Backend listen http://localhost:8889 and handle one route API **/api/encode_message** with request params POST **message** and **method**