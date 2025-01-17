<?php
// Ensure correct paths for the included files
require_once('../config.php');
require_once('../classes/DBConnection.php'); // Correct path for DBConnection.php

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitize input and retrieve data
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Create a DB connection
    $db = new DBConnection();
    $conn = $db->conn;

    // Query the database for staff login
    $sql = "SELECT * FROM teachers WHERE email = ?"; // Adjust this to match your table and column names
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $staff = $result->fetch_assoc();

        // Verify password
        if (password_verify($password, $staff['password'])) {
            $_SESSION['staff_id'] = $staff['id'];
            $_SESSION['staff_name'] = $staff['first_name'] . ' ' . $staff['last_name']; // Adjust name format as needed
            
            // Redirect to the teacher's dashboard or relevant page
            header('Location: ../teacher/dashboard.php'); // Adjust the path to the teacher's dashboard
            exit();
        } else {
            $error = "Invalid password.";
        }
    } else {
        $error = "No staff member found with that email.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Login</title>
</head>
<body>
    <h2>Teacher Login</h2>
    <?php if (isset($error)): ?>
        <div style="color: red;"><?php echo $error; ?></div>
    <?php endif; ?>
    <form action="" method="POST">
        <label for="email">Email:</label>
        <input type="email" name="username" id="email" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>
        <br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
