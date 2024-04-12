<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



if (!isset($_POST['token'])) {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required!"

    ));
}

$token = $_POST['token'];
$isAdmin = isAdmin($token);

if (!$isAdmin) {
    echo json_encode(array(
        "success" => false,
        "message" => "You are not authorized!"

    ));
    die();
}

if (
    isset($_POST['userID']) 
) {
    global $CON;
    $userID = $_POST['userID'];

    // $sql = "Select * from user where email ='$email'";
    // $result = mysqli_query($CON, $sql);
    // $num = mysqli_num_rows($result);
    // if ($num > 0) {
    //     echo json_encode(
    //         array(
    //             "success" => false,
    //             "message" => "Email already exists!"
    //         )
    //     );
    //     return;
    // } else {
    //     $hashed_password = password_hash($password, PASSWORD_DEFAULT);
    //     $sql = "INSERT INTO user (fullName, email, password,role) VALUES ('$fullname', '$email', '$hashed_password','admin')";
    $sql = "UPDATE ON user role = 'admin' where userId = '$userID'";
        $result = mysqli_query($CON, $sql);

        if ($result) {
            echo json_encode(
                array(
                    "success" => true,
                    "message" => "Admin registered successfully!"
                )
            );
        } else {
            echo json_encode(
                array(
                    "success" => false,
                    "message" => "Something went wrong!"
                )
            );
        }

} else {
    echo json_encode(
        array(
            "success" => false,
            "message" => "Please fill all the fields!",
            "required fields" => "UserID"
        )
    );
}
