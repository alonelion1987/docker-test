<?php

namespace App\Backend\Model;

use Webmozart\Assert\Assert as Assert;

class Encoder {

	CONST METHODS = [
		'base64' => 'base64',
		'md5' => 'md5'
	];

	private $message;

	public function __construct($message) {
		Assert::notEmpty($message, 'Message required');
		$this->message = $message;
	}

	public function encodeBase64WithUTF16(): string {
		return base64_encode(mb_convert_encoding($this->message, 'UTF-16LE'));
	}

	public function encodeMD5(): string {
		return md5($this->message);
	}

}