<?php
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'perfume';  // Make sure the database is 'perfume'

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
