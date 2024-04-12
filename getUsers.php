<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



if (

    isset($_POST['token'])

) {
    $token = $_POST['token'];

    $isAdmin = isAdmin($token);


    if (!$isAdmin) {
        echo json_encode(array(
            "success" => false,
            "message" => "You are not authorized!"

        ));
        die();
    }


    global $CON;


    $sql = 'select userId,email, fullName,role from user';

    $result = mysqli_query($CON, $sql);


    if ($result) {

        $users = [];

        while ($row = mysqli_fetch_assoc($result)) {
            $users[] = $row;
        }

        echo json_encode(array(
            "success" => true,
            "message" => "Ussers fetched successfully!",
            "data" => $users

        ));
    } else {

        echo json_encode(array(
            "success" => false,
            "message" => "Fetching users failed!"

        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required!"

    ));
}
