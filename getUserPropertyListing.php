<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


$token = $_POST['token'];
$userID = getUserID($token);
$productList=[];

    global $CON; 


    
    $userProductList = getUserProductList($userID);

        if ($userProductList != null) {

            echo json_encode(
                array(
                    "success" => true,
                    "message" => "product retrival complete",
                    "products"=>$userProductList

                )
                
                );
        
        
        }
    



function getUserProductList($userID){
    global $CON;
    // $sql = "select * from product p  join category c on p.category = c.catID where p.userID = '$userID'";
    $sql = "SELECT p.propertyID,p.propertyName, p.propertyDescription, p.price, p.isInStock, p.imageURL, p.userID, p.isVerified, c.catID,c.title, u.phoneNumber, u.fullName, u.email, l.locationID , l.locationName from property p  join category c on p.category = c.catID JOIN user u On u.userID = p.userID JOIN location l on l.locationID = p.location WHERE p.userID = '$userID' AND  p.isInStock = '1' ORDER BY p.propertyID DESC ";

    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        $productList[] = [];
        return $productList;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $productList[] = $row;


        }

        

        return $productList;
    }




}