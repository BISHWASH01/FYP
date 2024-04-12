<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';





// Check if propertyID is set
if (!isset($_POST['propertyID'])) {
    echo json_encode(array("success" => false, "message" => "Property ID is missing"));
    exit;
}

    // Get product ID and rating from POST data
    $propertyID = $_POST['propertyID'];
    

    $sql = "SELECT r.*, u.fullName FROM rating r JOIN user u ON r.userID = u.userId WHERE r.propertyID = ?";
    $stmt = $CON->prepare($sql);
    $stmt->bind_param("i", $propertyID);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $ratings = array();
    
    while($row = $result->fetch_assoc()) {
        $ratings[] = $row;
    }

    if (!empty($ratings)) {
        echo json_encode(array("success" => true, "message" => "Rating fetched successfully","ratings" =>$ratings));

    } else {
        echo json_encode(array("success" => false, "message" => "Rating fetching not successful/Nothing to fetch"));

    }





