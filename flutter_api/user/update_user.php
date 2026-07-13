<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "../config/koneksi.php";
$id = $_POST['id'];
$username = $_POST['username'];
$email = $_POST['email'];
$query = mysqli_query(
$conn,
"UPDATE user
SET username='$username',
email='$email'
WHERE id='$id'"
);
if($query){
echo json_encode([
"status" => true,
"message" => "User berhasil diupdate"
]);
}else{
echo json_encode([
"status" => false,
"message" => mysqli_error($conn)
]);
}
