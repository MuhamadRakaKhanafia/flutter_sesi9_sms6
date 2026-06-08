<?php
require "../vendor/autoload.php";
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
$headers = apache_request_headers();
if(!isset($headers['Authorization'])){
echo json_encode([
"status" => false,
"message" => "Token tidak ada"
]);
exit;
}
$token = str_replace(
"Bearer ",
"",
$headers['Authorization']
);
$key =
"FLUTTER_NATIVE_PHP_JWT_SECRET_KEY_2026_SUPER_SECURE_1234567
89";
try {
$decoded = JWT::decode(
$token,
new Key($key,'HS256')
);
} catch(Exception $e){
echo json_encode([
"status" => false,
"message" => "Token invalid"
]);
exit;
}