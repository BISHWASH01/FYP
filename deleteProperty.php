<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


if (

    isset($_POST['token'])

) {
    if (!isset($_POST['propertyID'])) {
        return json_encode(array(
            "success" => false,
            "message" => "PropertyID is required!"
        ));
    }

    $token = $_POST['token'];

    $isAdmin = isAdmin($token);
    global $CON;

    $propertyID = $_POST['propertyID'];
    $userID = getUserID($token);


    if (!$isAdmin) {
        $sql = "select * from property where propertyID = '$propertyID'";

        $result = mysqli_query($CON, $sql);
    
        $property = mysqli_fetch_assoc($result);
        $iselectedUserID = $property['userID'];

        if ($userID != $iselectedUserID) {

            echo json_encode(array(
                "success" => false,
                "message" => "You are not authorized!"
    
            ));
            die();
        }


        
    }


    $sql = "update property set isInStock = '0' where propertyID = $propertyID";

    $result = mysqli_query($CON, $sql);

    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Product deleted successfully!"
        ));
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Product deletion failed!"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required!"

    ));
    die();
}
