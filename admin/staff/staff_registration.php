<?php
// Include the necessary files for connection and initialization
include '../initialize.php';

// Check if form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get form input values
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Hash the password before saving it
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // SQL query to insert new staff record
    $sql = "INSERT INTO staff (name, email, password) VALUES ('$name', '$email', '$hashed_password')";

    if ($conn->query($sql) === TRUE) {
        // If query is successful, show success message
        $success_message = "Staff account created successfully.";
    } else {
        // If query fails, show error message
        $error_message = "Error: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Staff Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-top: 30px;
        }

        .form-container {
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            color: #333;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: lightgray; /* Changed from green to light gray */
            color: black; /* Text color for contrast */
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #e0e0e0; /* Slightly darker gray on hover */
        }

        .message {
            text-align: center;
            font-size: 18px;
            padding: 10px;
        }

        .success {
            color: lightgray;
        }

        .error {
            color: red;
        }

        /* Add a responsive layout */
        @media (max-width: 768px) {
            .form-container {
                width: 90%;
            }

            h2 {
                font-size: 24px;
            }

            input[type="text"], input[type="email"], input[type="password"] {
                font-size: 14px;
                padding: 10px;
            }

            input[type="submit"] {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <h2>Register New Staff</h2>

    <div class="form-container">
        <!-- Display success or error message -->
        <?php if (isset($success_message)): ?>
            <p class="message success"><?php echo $success_message; ?></p>
        <?php elseif (isset($error_message)): ?>
            <p class="message error"><?php echo $error_message; ?></p>
        <?php endif; ?>

        <!-- Registration Form -->
        <form method="POST" action="">
            <label for="name">Name:</label><br>
            <input type="text" id="name" name="name" required><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required><br>

            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" required><br>

            <input type="submit" value="Register Staff">
        </form>
    </div>
</body>
</html>
