<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "../config/koneksi.php";
$id = $_POST['id'];
$query = mysqli_query(
$conn,
"DELETE FROM user
WHERE id='$id'"
);
if($query){
echo json_encode([
"status" => true,
"message" => "User berhasil dihapus"
]);
}else{
echo json_encode([
"status" => false,
"message" => mysqli_error($conn)
]);
}
