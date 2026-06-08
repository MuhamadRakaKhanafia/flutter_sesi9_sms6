<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Content-Type: application/json");

include "../config/koneksi.php";
include "../helper/response.php";

error_reporting(E_ALL);
ini_set('display_errors', 1);

$username = isset($_POST['username'])
    ? $_POST['username']
    : '';

$email = isset($_POST['email'])
    ? $_POST['email']
    : '';

$password = isset($_POST['password'])
    ? $_POST['password']
    : '';

if(empty($username) || empty($email) || empty($password)){
response(false,"Semua field wajib diisi");
exit;
}

$check = mysqli_query($conn,"SELECT * FROM user WHERE email='$email'");
if(mysqli_num_rows($check) > 0){
response(false,"Email sudah digunakan");
exit;
}

$hashPassword = password_hash($password,PASSWORD_BCRYPT);
$query = mysqli_query($conn,"
INSERT INTO user(username,email,password)
VALUES('$username','$email','$hashPassword')
");
if($query){
    response(true,"Register berhasil");
}else{
    response(false,mysqli_error($conn));
}