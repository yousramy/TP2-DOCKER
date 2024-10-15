<?php
$servername = "data-container";
$username = "user";
$password = "password";
$dbname = "testdb";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Create table if not exists
    $conn->exec("CREATE TABLE IF NOT EXISTS visits (id INT AUTO_INCREMENT PRIMARY KEY, visit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

    // Insert a new visit
    $conn->exec("INSERT INTO visits (id) VALUES (NULL)");

    // Query the number of visits
    $stmt = $conn->prepare("SELECT COUNT(*) AS visit_count FROM visits");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    echo "Number of visits: " . $result['visit_count'];
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
