<?php
/**
 * Created by PhpStorm.
 * User: roman
 * Date: 27.08.19
 * Time: 0:34
 */

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

$app = AppFactory::create();

$app->get('/', function (Request $request, Response $response, $args) {
	$response->getBody()->write("Hello World!");
	return $response;
});

$app->run();