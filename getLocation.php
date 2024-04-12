<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';



    global $CON; 

    $locationList = getLocationList();

        if ($locationList != null) {

            echo json_encode(
                array(
                    "success" => true,
                    "message" => "list retrival succesfull",
                    "locations"=>$locationList

                )
                
                );
        
        
        }
    



function getLocationList(){
    global $CON;
    $sql="select * from location";
    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        return null;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $locationList[] = $row;


        }

        return $locationList;
    }




}