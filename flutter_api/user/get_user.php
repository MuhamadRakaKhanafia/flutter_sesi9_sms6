<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "../config/koneksi.php";
$query = mysqli_query(
$conn,
"SELECT id, username, email FROM user"
);
$data = [];
while ($row = mysqli_fetch_assoc($query)) {
$data[] = $row;
}
echo json_encode([
"status" => true,
"data" => $data
]);