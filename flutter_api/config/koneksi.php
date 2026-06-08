<?php

$host = "localhost";
$user = "root";
$pass = "";
$db   = "flutter_sesi0";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Koneksi Gagal: " . $conn->connect_error);
}