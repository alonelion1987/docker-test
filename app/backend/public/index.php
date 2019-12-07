<?php

use Zend\Diactoros\Response\JsonResponse;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use App\Backend\Model\Encoder;
use Webmozart\Assert\Assert as Assert;

require __DIR__ . '/../vendor/autoload.php';

$app = AppFactory::create();

// Routes API
$app->post( '/api/encode_message', function (Request $request) {
	try {
		$parsedBody = $request->getParsedBody();
		$message = $parsedBody['message'];
		$encodeMethod = $parsedBody['method'];
		$encoder = new Encoder($message);

		if ($encodeMethod) {
			$allowedMethods = Encoder::METHODS;
			Assert::oneOf($encodeMethod, $allowedMethods);
			$message = ($encodeMethod === $allowedMethods['base64'])
				? $encoder->encodeBase64WithUTF16()
				: $encoder->encodeMD5();
		} else {
			$message = $encoder->encodeBase64WithUTF16();
		}

		return new JsonResponse(['encodedMessage' => $message]);

	} catch ( Exception $exception ) {
		return new JsonResponse(['error' => $exception->getMessage()]);
	}

});

// Run
$app->run();