<?php


include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


if (!isset($_POST['token'])) {
    echo json_encode(
        array(
            "success" => false,
            "message" => "not authorized",
        )
    );
    die();
}
// ||!isset($_POST['total'])

// if (!isset($_POST['productID']) || !isset($_POST['total'])|| !isset($_POST['otherData'])) {
//     echo json_encode(
//         array(
//             "success" => false,
//             "message" => "no order id/total/otherData",
//         )
//     );
//     die();
// }

global $CON;


$token = $_POST['token'];


$total = $_POST['total'];
$otherData = $_POST['otherData'];

// $total = getTotal($orderID);
$userID = getUserID($token);



if (isset($_POST['propertyId']) && isset($_POST['token'])) {
    
    $propertyId = $_POST['propertyId'];
    checkPaymentStatus($propertyId);

    $sql = "INSERT INTO propertypayment (userID, propertyId,amount,otherData) VALUES ('$userID','$propertyId','$total','$otherData')";
    $result = mysqli_query($CON,$sql);
    if ($result) {
        $paymentID = mysqli_insert_id($CON);
        // $sql = "UPDATE ordersmade SET status='paid' WHERE orderID = '$orderID'";
        $sql = "UPDATE property SET isVerified = 'pending' WHERE propertyID = '$propertyId'";
        $result = mysqli_query($CON, $sql);
            
     
        if ($result){
            echo json_encode(
                array(
                    
                    "success" => true,
                    "message" => "payment made successfully",
                    "paymentID" => $paymentID
                )
            );
        }else{
            echo json_encode(
                array(
                    "success" => false,
                    "message" => "payment update failed"
                )
            );
    
        }
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message" => "Payment creation failed"
            )
        );
    }


} elseif (isset($_POST['token'])) {

    $sql = "INSERT INTO membershippayment (userID, amount,otherData) VALUES ('$userID','$total','$otherData')";
    // After an INSERT query
$result = mysqli_query($CON, $sql);
if ($result) {
    $paymentID = mysqli_insert_id($CON);
    // Next SQL operation
    $updateSql = "UPDATE user SET isMember = '1' WHERE userID = '$userID'";
    $updateResult = mysqli_query($CON, $updateSql);
    
    // Instead of using mysqli_num_rows(), check if the UPDATE was successful
    if ($updateResult) {
        // The UPDATE query was successful
        echo json_encode([
            "success" => true,
            "message" => "payment made successfully",
            "paymentID" => $paymentID
        ]);
    } else {
        // The UPDATE query failed
        echo json_encode([
            "success" => false,
            "message" => "payment update failed"
        ]);
    }
} else {
    // The INSERT query failed
    echo json_encode([
        "success" => false,
        "message" => "Payment creation failed"
    ]);
}}

    // $result = mysqli_query($CON,$sql);
    // if ($result) {
    //     $paymentID = mysqli_insert_id($CON);
    //     // $sql = "UPDATE ordersmade SET status='paid' WHERE orderID = '$orderID'";
    //     $sql = "UPDATE user SET isMember = '1' WHERE userID = '$userID'";
    //     $result = mysqli_query($CON, $sql);
    //     $num = mysqli_num_rows($result);
    
    //     if ($num == 0) {
    //         return null;
    //     }else{
    //         $row = mysqli_fetch_assoc($result);
    //         return $paymentID;
    //     }
    
    //     if ($result){
    //         echo json_encode(
    //             array(
    //                 "success" => true,
    //                 "message" => "payment made successfully",
    //                 "paymentID" => $paymentID
    //             )
    //         );
    //     }else{
    //         echo json_encode(
    //             array(
    //                 "success" => false,
    //                 "message" => "payment update failed"
    //             )
    //         );
    
    //     }
    // }else{
    //     echo json_encode(
    //         array(
    //             "success" => false,
    //             "message" => "Payment creation failed"
    //         )
    //     );
    // }}





function checkPaymentStatus($propertyId){
global $CON;

    $sql = "SELECT * FROM property where propertyId = '$propertyId'";
$result = mysqli_query($CON,$sql);
$num = mysqli_num_rows($result);


if ($num != 0) {
    $row = mysqli_fetch_assoc($result);
    if ($row['isVerified'] == '1') {
        echo json_encode(
            array(
                "success" => false,
                "message" => "payment already made"
            )
        );
        die();
        }
}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "no order of that ID found"
        )
    );
    die();

}

}
function checkUserStatus($userID){
    global $CON;
    
        $sql = "SELECT * FROM user where userID = '$userID'";
    $result = mysqli_query($CON,$sql);
    $num = mysqli_num_rows($result);
    
    
    if ($num != 0) {
        $row = mysqli_fetch_assoc($result);
        if ($row['isMember'] == '1') {
            echo json_encode(
                array(
                    "success" => false,
                    "message" => "user already a member"
                )
            );
            die();
            }
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message" => "no user of that ID found"
            )
        );
        die();
    
    }
    
    }


// function getTotal($orderID){
//     global $CON;
//     $sql = "SELECT * from ordersmade where orderID = '$orderID'";
//     $result = mysqli_query($CON, $sql);
//     $num = mysqli_num_rows($result);

//     if ($num == 0) {
//         return null;
//     }else{
//         $row = mysqli_fetch_assoc($result);
//         return $row['total'];
//     }


// }