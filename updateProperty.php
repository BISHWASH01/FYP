<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';

global $CON;
$title = $_POST['title'];
$description = $_POST['description'];
$price = $_POST['price'];
$productID = $_POST['propertyID'];

$sql = "UPDATE property SET propertyName = '$title', propertyDescription = '$description', price = '$price' WHERE propertyID = '$productID'";
$result = mysqli_query($CON, $sql);
if ($result){
    echo json_encode(
        array(
            "success" => true,
            "message" => "Updates made successfully"
        )
    );
}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "Property update failed"
        )
    );

}