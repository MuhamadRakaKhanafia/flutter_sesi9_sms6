<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Content-Type: application/json");
require "../vendor/autoload.php";

use Firebase\JWT\JWT;

include "../config/koneksi.php";
include "../helper/response.php";
$email = $_POST['email'];
$password = $_POST['password'];
$query = mysqli_query($conn,"
SELECT * FROM user WHERE email='$email'
");
$user = mysqli_fetch_assoc($query);
if(!$user){
response(false,"User tidak ditemukan");
exit;
}
if(!password_verify($password,$user['password'])){
response(false,"Password salah");
exit;
}
$key =
"FLUTTER_NATIVE_PHP_JWT_SECRET_KEY_2026_SUPER_SECURE_1234567
89";
$payload = [
"id" => $user['id'],
"email" => $user['email'],
"exp" => time() + (60 * 60)
];
$jwt = JWT::encode($payload,$key,'HS256');
response(true,"Login berhasil",[
"token" => $jwt,
"user" => [
"id" => $user['id'],
"username" => $user['username'],
"email" => $user['email']
]
]);