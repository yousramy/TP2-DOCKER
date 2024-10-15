<?php
$servername = "data";  
$username = "user";
$password = "password";
$dbname = "testdb";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Créer la table si elle n'existe pas
    $conn->exec("CREATE TABLE IF NOT EXISTS visits (id INT AUTO_INCREMENT PRIMARY KEY, visit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

    // Insérer une nouvelle visite
    $conn->exec("INSERT INTO visits (id) VALUES (NULL)");

    // Interroger le nombre de visites
    $stmt = $conn->prepare("SELECT COUNT(*) AS visit_count FROM visits");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    echo "Number of visits: " . $result['visit_count'];
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
