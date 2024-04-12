<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



if (!isset($_POST['token'])) {
    echo json_encode(
        array(
            "success" => false,
            "message" => "not authorized"
        )
    );
    die();
}

if (!isset($_POST['propertyID'])) {
    echo json_encode(
        array(
            "success" => false,
            "message" => "propertyID is not passed"
        )
    );
    die();
}
    global $CON; 


    $propertyID = $_POST['propertyID'];


    $productList = getProductList($propertyID);

        if ($productList != null) {

            echo json_encode(
                array(
                    "success" => true,
                    "message" => "property retrival complete",
                    "productDetail"=>$productList

                )
                
                );
        
        
        }
    



function getProductList($propertyID){
    global $CON;
    $sql = "select * from property p  join category c on p.category = c.catID WHERE p.propertyID = '$propertyID'";
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