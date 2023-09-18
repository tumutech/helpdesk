<?php 
include('./config/database.php');
$email = $_POST['email'];
$password = $_POST['password'];
$database = new Database();
$conn = $database->getConnection();
// Prepare the SQL statement to select the user account information
$sql = 'SELECT login, pw FROM users WHERE login = :email && pw = :password';
$stmt = $conn->prepare($sql);

// Bind the username parameter to the prepared statement
$stmt->bindValue(':email', $email);
$stmt->bindValue(':password',$password);

// Execute the prepared statement
$stmt->execute();

// Fetch the user account information
$user = $stmt->fetch(PDO::FETCH_ASSOC);

// If the user account information is not found, or the password is incorrect, display an error message
if (!$user) {
    echo 'Invalid username or password.';
} else {
    // The user has successfully logged in. Start a session and redirect them to the dashboard.
    session_start();
    $_SESSION['user'] = $user;
    header('Location: attachments.php');
}