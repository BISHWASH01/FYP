<?php

include '../Helpers/DatabaseConfig.php';
include '../Helpers/Authentication.php';



if(
    isset($_POST['token']) &&
    isset($_POST['propertyName'])&&
    isset($_POST['category'])&&
    isset($_POST['type'])&&
    isset($_POST['location'])&&
    isset($_POST['propertyDescription'])&&
    isset($_POST['price'])&&
    isset($_FILES['image'])&&

    isset($_POST['size'])&&
    isset($_POST['clear_height'])&&
    isset($_POST['power_supply'])




){
    global $CON; 
    $token = $_POST['token'];
    $userID = getUserID($token);
    $productName = $_POST['propertyName'];
    $category = $_POST['category'];
    $type = $_POST['type'];
    $location = $_POST['location'];
    $productDescription = $_POST['propertyDescription'];
    $price = $_POST['price'];

    $size = $_POST['size'];
    $clear_height = $_POST['clear_height'];
    $power_supply = $_POST['power_supply'];

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

    $insertQuery = "INSERT INTO property( propertyName,propertyType, category,type,location, propertyDescription, price, imageURL, userID ) VALUES ('$productName','industrial','$category','$type','$location','$productDescription','$price','$pathNameInDb','$userID') ";
    $insertResult = mysqli_query($CON,$insertQuery);
            if($insertResult){
                $propertyID = mysqli_insert_id($CON);
                $sql= "Insert into industrial_properties(propertyID, size, clear_height,power_supply) VALUES ('$propertyID','$size','$clear_height','$power_supply')";
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