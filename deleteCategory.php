<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


if (

    isset($_POST['token']) &&
    isset($_POST['catID'])

) {
    $token = $_POST['token'];
    $catID = $_POST['catID'];

    $isAdmin = isAdmin($token);


    if (!$isAdmin) {
        echo json_encode(array(
            "success" => false,
            "message" => "You are not authorized!"

        ));
        die();
    }


    global $CON;


    $sql = "delete from category where catID = '$catID'";

    $result = mysqli_query($CON, $sql);


    if ($result) {

        echo json_encode(array(
            "success" => true,
            "message" => "Category deleted successfully!"    

        ));
    } else {

        echo json_encode(array(
            "success" => false,
            "message" => "deleting Category failed!"

        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required!"

    ));
}
