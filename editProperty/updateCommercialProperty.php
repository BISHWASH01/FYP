<?php



include '../Helpers/DatabaseConfig.php';
include '../Helpers/Authentication.php';



$CON->begin_transaction();


try {
    // Check if all required POST parameters are set
    if (!isset($_POST['title'], $_POST['description'], $_POST['price'], $_POST['propertyID'], $_POST['floor_area'], $_POST['parking_spaces'], $_POST['building_class'], $_POST['tenant_capacity'])) {
        throw new Exception("Missing required parameters");
    }

    $title = $_POST['title'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $propertyID = $_POST['propertyID'];
    $floorArea = $_POST['floor_area'];
    $parkingSpaces = $_POST['parking_spaces'];
    $buildingClass = $_POST['building_class'];
    $tenantCapacity = $_POST['tenant_capacity'];

    // Update the main property table
    $sql = "UPDATE property SET propertyName = ?, propertyDescription = ?, price = ? WHERE propertyID = ?";
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("ssdi", $title, $description, $price, $propertyID);
    if (!$stmt->execute()) {
        throw new Exception("Property update failed: " . $stmt->error);
    }
    $stmt->close();

    // Update the commercial property type table
    $sql = "UPDATE commercial_properties SET floor_area = ?, parking_spaces = ?, building_class = ?, tenant_capacity = ? WHERE propertyID = ?";
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("disii", $floorArea, $parkingSpaces, $buildingClass, $tenantCapacity, $propertyID);
    if (!$stmt->execute()) {
        throw new Exception("Commercial property type update failed: " . $stmt->error);
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
