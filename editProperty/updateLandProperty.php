<?php

include '../Helpers/DatabaseConfig.php';
include '../Helpers/Authentication.php';

// Start transaction
$CON->begin_transaction();

try {
    // Check if all required POST parameters are set
    if (!isset($_POST['title'], $_POST['description'], $_POST['price'], $_POST['propertyID'], $_POST['total_area'])) {
        throw new Exception("Missing required parameters");
    }

    $title = $_POST['title'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $propertyID = $_POST['propertyID'];
    $totalArea = $_POST['total_area'];

    // Update the main property table
    $sql = "UPDATE property SET propertyName = ?, propertyDescription = ?, price = ? WHERE propertyID = ?";
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("ssdi", $title, $description, $price, $propertyID);
    if (!$stmt->execute()) {
        throw new Exception("Property update failed: " . $stmt->error);
    }
    $stmt->close();

    // Update the land property type table
    $sql = "UPDATE land SET total_area = ? WHERE propertyID = ?";
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("di", $totalArea, $propertyID);
    if (!$stmt->execute()) {
        throw new Exception("Land property type update failed: " . $stmt->error);
    }
    $stmt->close();

    // Commit the transaction
    $CON->commit();

    echo json_encode(
        array(
            "success" => true,
            "message" => "Updates made successfully"
        )
    );

} catch (Exception $e) {
    $CON->rollback(); // Rollback any changes if something went wrong
    echo json_encode(
        array(
            "success" => false,
            "message" => $e->getMessage()
        )
    );
}
?>
