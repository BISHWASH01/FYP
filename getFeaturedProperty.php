<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';




    global $CON; 


    $productList = getProductList();

        if ($productList != null) {

            echo json_encode(
                array(
                    "success" => true,
                    "message" => "product retrival complete",
                    "products"=>$productList

                )
                
                );
        
        
        }
    



function getProductList(){
    global $CON;
    $sql = "select p.propertyID,p.propertyName, p.propertyDescription, p.price, p.isInStock, p.imageURL, p.userID, p.isVerified, c.catID,c.title, u.phoneNumber, u.fullName, u.email from property p  join category c on p.category = c.catID JOIN user u On u.userID = p.userID where p.isInStock = '1' and u.isMember = '1' or p.isVerified= 'verified'";
    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        return null;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $productList[] = $row;


        }

        

        return $productList;
    }




}