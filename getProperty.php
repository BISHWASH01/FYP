<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


    global $CON; 


    
    $resiPropertyList = getUserResidentialList();
    $commercialPropertyList = getUserCommercialList();
    $industrialPropertyList = getUserIndustrialList();
    $landPropertyList = getUserLandList();

    $response = [
        "success" => false,
        "message" => "No data found",
        // "residential" => [],
        // "commercial" => [],
        // "industrial" => [],
        // "land" => []
    ];
    
    // Check if any data was found and adjust the response accordingly
    if ($resiPropertyList || $commercialPropertyList || $industrialPropertyList || $landPropertyList) {
        $response["success"] = true;
        $response["message"] = "Product retrieval complete";
        
        if (!empty($resiPropertyList)) {
            $response["residential"] = $resiPropertyList;
        }
        if (!empty($commercialPropertyList)) {
            $response["commercial"] = $commercialPropertyList;
        }
        if (!empty($industrialPropertyList)) {
            $response["industrial"] = $industrialPropertyList;
        }
        if (!empty($landPropertyList)) {
            $response["land"] = $landPropertyList;
        }
    }
    echo json_encode($response);
    



function getUserResidentialList(){
    global $CON;
    // $sql = "select * from product p  join category c on p.category = c.catID where p.userID = '$userID'";
    $sql = "SELECT p.propertyID,p.propertyName,p.propertyType, p.propertyDescription, p.price, p.isInStock, p.imageURL, p.userID, p.isVerified, 
    c.categoryID,c.categoryname, 
    u.phoneNumber, u.fullName, u.email, 
    l.id , l.name, l.city,
    rp.* 
    from property p  
    join category c on p.category = c.categoryID 
    JOIN user u On u.userID = p.userID 
    JOIN residential_properties rp on p.propertyID = rp.propertyID 
    JOIN locations l on l.id = p.location 
    WHERE  p.isInStock = '1' 
    ORDER BY p.propertyID DESC ";

    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        $resiPropertyList[] = [];
        return $resiPropertyList;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $resiPropertyList[] = $row;
        }
        return $resiPropertyList;
    }
}
function getUserCommercialList(){
    global $CON;
    // $sql = "select * from product p  join category c on p.category = c.catID where p.userID = '$userID'";
    $sql = "SELECT p.propertyID,p.propertyName,p.propertyType, p.propertyDescription, p.price, p.isInStock, p.imageURL, p.userID, p.isVerified, 
    c.categoryID,c.categoryname, 
    u.phoneNumber, u.fullName, u.email, 
    l.*,
    cp.* ,
    t.*
    from property p  
    join category c on p.category = c.categoryID 
    JOIN user u On u.userID = p.userID 
    join types t on p.type = t.typeid
    JOIN commercial_properties cp on p.propertyID = cp.propertyID 
    JOIN locations l on l.id = p.location 
    WHERE p.isInStock = '1' 
    ORDER BY p.propertyID DESC ";

    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        $commercialPropertyList[] = [];
        return $commercialPropertyList;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            $commercialPropertyList[] = $row;
        }
        return $commercialPropertyList;
    }
}
function getUserIndustrialList(){
    global $CON;
    // $sql = "select * from product p  join category c on p.category = c.catID where p.userID = '$userID'";
    $sql = "SELECT p.propertyID,p.propertyName,p.propertyType, p.propertyDescription, p.price, p.isInStock, p.imageURL, p.userID, p.isVerified, 
    c.categoryID,c.categoryname, 
    u.phoneNumber, u.fullName, u.email, 
    l.*,
    ip.* 
    from property p  
    join category c on p.category = c.categoryID 
    JOIN user u On u.userID = p.userID 
    JOIN industrial_properties ip on p.propertyID = ip.propertyID 
    JOIN locations l on l.id = p.location 
    WHERE p.isInStock = '1' 
    ORDER BY p.propertyID DESC ";

    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        $industrialPropertyList[] = [];
        return $industrialPropertyList;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $industrialPropertyList[] = $row;
        }
        return $industrialPropertyList;
    }
}
function getUserLandList(){
    global $CON;
    // $sql = "select * from product p  join category c on p.category = c.catID where p.userID = '$userID'";
    $sql = "SELECT p.propertyID,p.propertyName,p.propertyType, p.propertyDescription, p.price, p.isInStock, p.imageURL, p.userID, p.isVerified, 
    c.categoryID,c.categoryname, 
    u.phoneNumber, u.fullName, u.email, 
    l.*,
    la.* 
    from property p  
    join category c on p.category = c.categoryID 
    JOIN user u On u.userID = p.userID 
    JOIN land la on p.propertyID = la.propertyID 
    JOIN locations l on l.id = p.location 
    WHERE p.isInStock = '1' 
    ORDER BY p.propertyID DESC ";

    $result = mysqli_query($CON, $sql);
    $num = mysqli_num_rows($result);

    if ($num == 0) {
        $resiPropertyList[] = [];
        return $resiPropertyList;
    }else{
        while ($row = mysqli_fetch_assoc($result)) {
            
            
            $resiPropertyList[] = $row;
        }
        return $resiPropertyList;
    }
}