<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "../config/koneksi.php";
$username = $_POST['username'];
$email = $_POST['email'];
$password = password_hash(
$_POST['password'],
PASSWORD_DEFAULT
);
$query = mysqli_query(
$conn,
"INSERT INTO user (username,email,password)
VALUES('$username','$email','$password')"
);
if($query){
echo json_encode([
"status" => true,
"message" => "Data berhasil ditambahkan"
]);
}else{
echo json_encode([
"status" => false,
"message" => "Data gagal ditambahkan"
]);
}