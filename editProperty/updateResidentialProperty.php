<?php



include '../Helpers/DatabaseConfig.php';
include '../Helpers/Authentication.php';

// Check if the required POST parameters are set
if (isset($_POST['title'], $_POST['description'], $_POST['price'], $_POST['propertyID'], $_POST['bedrooms'], $_POST['bathrooms'], $_POST['size'])) {
    $title = $_POST['title'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $propertyID = $_POST['propertyID'];
    $bedrooms = $_POST['bedrooms'];
    $bathrooms = $_POST['bathrooms'];
    $size = $_POST['size'];

    // Prepare the SQL statement with placeholders
    $sql = "UPDATE property SET propertyName = ?, propertyDescription = ?, price = ? WHERE propertyID = ?";
    
    // Prepare and bind parameters
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("ssdi", $title, $description, $price, $propertyID);
    if (!$stmt->execute()) {
        throw new Exception("Property update failed: " . $stmt->error);
    }
    $stmt->close();

   // Update the ResidentialProperties table
   $sql = "UPDATE residential_properties SET bedrooms = ?, bathrooms = ?, size = ? WHERE propertyID = ?";
   $stmt = $CON->prepare($sql);
   $stmt->bind_param("iidi", $bedrooms, $bathrooms, $size, $propertyID);
   if (!$stmt->execute()) {
       throw new Exception("Property type update failed: " . $stmt->error);
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
