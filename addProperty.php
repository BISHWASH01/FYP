<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



if(
    isset($_POST['token']) &&
    isset($_POST['propertyName'])&&
    isset($_POST['category'])&&
    isset($_POST['propertyDescription'])&&
    isset($_POST['price'])&&
    isset($_POST['location'])&&
    isset($_FILES['image'])
    // isset($_POST['isInStock'])


){
    global $CON; 
    $token = $_POST['token'];
    $userID = getUserID($token);
    $productName = $_POST['propertyName'];
    $category = $_POST['category'];
    $productDescription = $_POST['propertyDescription'];
    $price = $_POST['price'];
    $location = $_POST['location'];

    $isVerified = 0;
    // $isInStock = $_POST['isInStock'];
    


    if (isAdmin($token)) { 
        $isVerified = 1;
     }

    //     $sql = "select * from category where title = '$category'";
    // $result = mysqli_query($CON, $sql);
    // // $num = mysqli_num_rows($result);

    // $row = mysqli_fetch_assoc($result);

    // $categoryID = $row['catID'];

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
        $upload_path = 'images/'.$image_new_name;

        if (!move_uploaded_file($image_tmp_name,$upload_path)) {
            echo json_encode(
                array(
                    "success"=> false,
                    "message" => "file not saved!!!"
                )
                );
                die();

        }

    $insertQuery = "INSERT INTO property( propertyName, category, propertyDescription, price, imageURL, userID, isVerified, location) VALUES ('$productName','$category','$productDescription','$price','$upload_path','$userID','$isVerified','$location') ";
    $insertResult = mysqli_query($CON,$insertQuery);
            if($insertResult){
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
                    "message" => "property not added!!"
                )
                );
        }


    

    // if($num > 0){

    //     echo json_encode(
    //         array(
    //             "success" => false,
    //             "message" => "Category title already exists!!!"
    //         )
    //         );
    //         return;
    // }else{

    //     $insertQuery = "INSERT INTO category (title) VALUES ('$title')";
    //     $insertResult = mysqli_query($CON,$insertQuery);
        

    //     if($insertResult){
    //         echo json_encode(
    //             array(
    //                 "success"=> true,
    //                 "message" => "Category added successfully!!"
    //             )
    //             );
    //     }else {
    //         echo json_encode(
    //             array(
    //                 "success"=> false,
    //                 "message" => "Category title not added!!"
    //             )
    //             );
    //     }

    // }
    
    

    


    


}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "please fill all the form",
            "required feilds" => "title,token,description,price,category and image"
        )
    );

}