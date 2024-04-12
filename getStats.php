<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';


if (

    isset($_POST['token'])

) {
    $token = $_POST['token'];


    $isAdmin = isAdmin($token);


    if (!$isAdmin) {
        echo json_encode(array(
            "success" => false,
            "message" => "You are not authorized!"

        ));
        die();
    }


    global $CON;

    $sql = 'select count(*) as totalProperty from property';
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $totalProperty = $row['totalProperty'];


    $sql = 'select sum(amount) as total_income from membershippayment';
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $membershipIncome = $row['total_income'];

    $sql = 'select sum(amount) as total_income from propertypayment';
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $propertyIncome = $row['total_income'];


    $sql = 'select count(*) as totalUsers from user';
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $totalUsers = $row['totalUsers'];

    // $sql = 'select count(*) as total_orders from ordersmade';
    // $result = mysqli_query($CON, $sql);
    // $row = mysqli_fetch_assoc($result);
    // $total_orders = $row['total_orders'];

    $sql = "select count(*) as unverifiedProperty from property where isVerified = 'not'";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $unverifiedProperty = $row['unverifiedProperty'];

    $sql = "select count(*) as pendingProperty from property where isVerified = 'pending'";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $pendingProperty = $row['pendingProperty'];


    $sql = "select count(*) as verifiedProperty from property where isVerified = 'verified'";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $verifiedProperty = $row['verifiedProperty'];

    $sql = "select count(*) as totalReviews from rating ";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $totalReviews = $row['totalReviews'];

    $sql = "select count(*) as totalMembers from user where isMember = '1' ";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $totalMembers = $row['totalMembers'];


     // top 5 categories with total property
$sql = "SELECT c.title, COUNT(p.propertyID) AS total_properties
FROM category c
LEFT JOIN property p ON c.catID = p.category
GROUP BY c.catID, c.title
ORDER BY total_properties desc
limit 3
";

$result = mysqli_query($CON,$sql);

if (!$result) {
    echo json_encode(array(
        "success" => false,
        "message" => "Error retrieving stats",
        "error" => mysqli_error($CON)
    ));
    die();
}

$topCategories = mysqli_fetch_all($result, MYSQLI_ASSOC);

$remainingProperty = $totalProperty;
$remainingPercentage = 100;


foreach ($topCategories as $key => $user) {
    $topCategories[$key]['percentage'] = round((($user['total_properties'] / $totalProperty) * 100), 2);
    $remainingPercentage -= $topCategories[$key]['percentage'];
    $remainingProperty -= $topCategories[$key]['total_properties'];
}

$topCategories[] = array(
    "category_id" => 0,
    "category" => "Others",
    "total_properties" => $remainingProperty,
    "percentage" => abs(round($remainingPercentage))
);


    if ($result) {

        echo json_encode(array(
            "success" => true,
            "message" => "Stats fetched successfully!",
            "data" => array(
                "membershipIncome" => $membershipIncome,
                "propertyIncome" => $propertyIncome,
                "totalUsers" => $totalUsers,
                "unverifiedProperty" => $unverifiedProperty,
                "pendingProperty" => $pendingProperty,

                "verifiedProperty" => $verifiedProperty,

                "totalReviews" => $totalReviews,
                "totalMembers" => $totalMembers,
                "topCategories" => $topCategories,




            )

        ));
    } else {

        echo json_encode(array(
            "success" => false,
            "message" => "Fetching total income failed!"

        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required!"

    ));
}
