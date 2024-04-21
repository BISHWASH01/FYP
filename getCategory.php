<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



    global $CON; 

    $categoryList = getCategoryList();

        if ($categoryList != null) {

            echo json_encode(
                array(
                    "success" => true,
                    "message" => "list retrival succesfull",
                    "categories"=>$categoryList

                )
                
                );
        
        
        }
    



function getCategoryList(){
    global $CON;
    $sql="select * from category";
    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        return null;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $categoryList[] = $row;


        }

        return $categoryList;
    }




}