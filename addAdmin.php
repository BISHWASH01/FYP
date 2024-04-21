<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



// if (!isset($_POST['token'])) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => "Token is required!"

//     ));
// }

// $token = $_POST['token'];
// $isAdmin = isAdmin($token);

// if (!$isAdmin) {
//     echo json_encode(array(
//         "success" => false,
//         "message" => "You are not authorized!"

//     ));
//     die();
// }

// if (
//     isset($_POST['userID']) 
// ) {
//     global $CON;
//     $userID = $_POST['userID'];

//     // $sql = "Select * from user where email ='$email'";
//     // $result = mysqli_query($CON, $sql);
//     // $num = mysqli_num_rows($result);
//     // if ($num > 0) {
//     //     echo json_encode(
//     //         array(
//     //             "success" => false,
//     //             "message" => "Email already exists!"
//     //         )
//     //     );
//     //     return;
//     // } else {
//     //     $hashed_password = password_hash($password, PASSWORD_DEFAULT);
//     //     $sql = "INSERT INTO user (fullName, email, password,role) VALUES ('$fullname', '$email', '$hashed_password','admin')";
//     $sql = "UPDATE ON user role = 'admin' where userId = '$userID'";
//         $result = mysqli_query($CON, $sql);

//         if ($result) {
//             echo json_encode(
//                 array(
//                     "success" => true,
//                     "message" => "Admin registered successfully!"
//                 )
//             );
//         } else {
//             echo json_encode(
//                 array(
//                     "success" => false,
//                     "message" => "Something went wrong!"
//                 )
//             );
//         }

// } else {
//     echo json_encode(
//         array(
//             "success" => false,
//             "message" => "Please fill all the fields!",
//             "required fields" => "UserID"
//         )
//     );
// }

include '../Helpers/DatabaseConfig.php';

if(isset($_POST['fullName']) && 
    isset($_POST['email']) && 
    isset($_POST['password'])&& 
    // isset($_POST['address'])&& 
    isset($_POST['phoneNumber'])
    
    ){

    global $CON; 
    $email = $_POST['email'];
    $fName = $_POST['fullName'];
    $password = $_POST['password'];
    // $address = $_POST['address'];
    $phoneNumber = $_POST['phoneNumber'];
    


    $sql = "select * from user where email = '$email'";
    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if($num > 0){
        echo json_encode(
            array(
                "success" => false,
                "message" => "email already exists!!!"
            )
            );
            return;
    }else{

        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        $insertQuery = "INSERT INTO user (fullName, email, password, role, address, phoneNumber) VALUES ('$fName','$email','$hashed_password','user','ghar','$phoneNumber')";
        $insertResult = mysqli_query($CON,$insertQuery);
        

        if($insertResult){
            echo json_encode(
                array(
                    "success"=> true,
                    "message" => "user registered!!"
                )
                );
        }else {
            echo json_encode(
                array(
                    "success"=> false,
                    "message" => "user  not registered!!"
                )
                );
        }

    }


}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "please fill all the form",
            "required feilds" => "fullname, email, password"
        )
    );

}
