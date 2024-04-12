<?php


include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


if (!isset($_POST['token'])) {
    echo json_encode(
        array(
            "success" => false,
            "message" => "You are not authorized!"
        )
    );
    die();
}

global $CON;

$token = $_POST['token'];

$userId = getUserId($token);

$sql = "SELECT userId,fullName,email,role,phoneNumber, isMember from user where userId='$userId'";

$result = mysqli_query($CON, $sql);

if ($result) {
    $row = mysqli_fetch_assoc($result);
    echo json_encode(
        array(
            "success" => true,
            "message" => "User fetched successfully!",
            "data" => $row
        )
    );
} else {
    echo json_encode(
        array(
            "success" => false,
            "message" => "Fetching user failed!"
        )
    );
}