<?php

include '../Helpers/DatabaseConfig.php';
include '../Helpers/Authentication.php';



if(
    isset($_POST['token']) &&
    isset($_POST['propertyName'])&&
    // isset($_POST['propertyType'])&&
    isset($_POST['category'])&&
    isset($_POST['type'])&&
    isset($_POST['location'])&&
    isset($_POST['propertyDescription'])&&
    isset($_POST['price'])&&
    isset($_FILES['image'])&&

    isset($_POST['floor_area'])&&
    isset($_POST['building_class'])&&
    isset($_POST['tenant_capacity'])&&
    isset($_POST['parking_spaces'])




){
    global $CON; 
    $token = $_POST['token'];
    $userID = getUserID($token);
    $productName = $_POST['propertyName'];
    // $propertyType = $_POST['propertyType'];
    $category = $_POST['category'];
    $type = $_POST['type'];
    $location = $_POST['location'];
    $productDescription = $_POST['propertyDescription'];
    $price = $_POST['price'];

    $floor_area = $_POST['floor_area'];
    $building_class = $_POST['building_class'];
    $tenant_capacity = $_POST['tenant_capacity'];
    $parking_spaces = $_POST['parking_spaces'];

    $isVerified = 0;
    


    if (isAdmin($token)) { 
        $isVerified = 1;
     }



        $image_name = $_FILES['image']['name'];
        $image_tmp_name = $_FILES['image']['tmp_name'];
        $image_size = $_FILES['image']['size'];
        $image_extention = pathinfo($image_name, PATHINFO_EXTENSION);



        // if($image_extention != "jpg" &&$image_extention != "jpeg" &&$image_extention != "png" ){
        //     echo json_encode(
        //         array(
        //             "success"=> false,
        //             "message" => "this extension not allowed!!!"
        //         )
        //         );
        //         die();

        // }
        if ($image_size > 5000000) {
            echo json_encode(
                array(
                    "success"=> false,
                    "message" => "File size too large!!!"
                )
                );
                die();

        }

        $image_new_name = time().'_'.$image_name;
        $upload_path = '../images/'.$image_new_name;
        $pathNameInDb = 'images/'.$image_new_name;

        if (!move_uploaded_file($image_tmp_name,$upload_path)) {
            echo json_encode(
                array(
                    "success"=> false,
                    "message" => "file not saved!!!"
                )
                );
                die();

        }

    $insertQuery = "INSERT INTO property( propertyName,propertyType, category,type,location, propertyDescription, price, imageURL, userID ) VALUES ('$productName','commercial','$category','$type','$location','$productDescription','$price','$pathNameInDb','$userID') ";
    $insertResult = mysqli_query($CON,$insertQuery);
            if($insertResult){
                $propertyID = mysqli_insert_id($CON);
                $sql= "Insert into commercial_properties(propertyID, floor_area, building_class,tenant_capacity,parking_spaces) VALUES ('$propertyID','$floor_area','$building_class','$tenant_capacity','$parking_spaces')";
                $result = mysqli_query($CON,$sql);
                if($result){
            echo json_encode(
                array(
                    "success"=> true,
                    "message" => "property added successfully!!"
                )
                );
        }else {
            echo json_encode(
                array(
                    "success"=> false,
                    "message" => "residential property not added!!"
                )
                );
        }}else{

            echo json_encode(
                array(
                    "success"=> false,
                    "message" => "property not added!!"
                )
                );
        }




}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "please fill all the form",
            "required feilds" => "title,token,description,price,category and image"
        )
    );

}