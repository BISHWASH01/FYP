<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



    global $CON; 

    $types = getTypeList();

        if ($types != null) {

            echo json_encode(
                array(
                    "success" => true,
                    "message" => "list retrival succesfull",
                    "types"=>$types

                )
                
                );
        
        
        }
    



function getTypeList(){
    global $CON;
    $sql="select * from types";
    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        return null;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $types[] = $row;


        }

        return $types;
    }




}