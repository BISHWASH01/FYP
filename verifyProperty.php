<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';

// Check if the required POST parameters are set
if ($_POST['propertyID']) {
    $title = $_POST['title'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $propertyID = $_POST['propertyID'];

    // Prepare the SQL statement with placeholders
    $sql = "UPDATE property SET propertyName = ?, propertyDescription = ?, price = ? WHERE propertyID = ?";
    
    // Prepare and bind parameters
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("ssdi", $title, $description, $price, $propertyID);

    // Execute the statement
    if ($stmt->execute()) {
        echo json_encode(
            array(
                "success" => true,
                "message" => "Updates made successfully"
            )
        );
    } else {
        // Provide detailed error message
        echo json_encode(
            array(
                "success" => false,
                "message" => "Property update failed: " . $stmt->error
            )
        );
    }

    // Close statement
    $stmt->close();
} else {
    // Handle case where required parameters are not set
    echo json_encode(
        array(
            "success" => false,
            "message" => "Missing required parameters"
        )
    );
}

?>
