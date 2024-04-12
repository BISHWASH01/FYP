<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';





// Check if propertyID is set
if (!isset($_POST['propertyID'])) {
    echo json_encode(array("success" => false, "message" => "Property ID is missing"));
    exit;
}

// Check if rating is set
if (!isset($_POST['rating'])) {
    echo json_encode(array("success" => false, "message" => "Rating is missing"));
    exit;
}

// Check if review is set
if (!isset($_POST['review'])) {
    echo json_encode(array("success" => false, "message" => "Review is missing"));
    exit;
}
// Check if token is set
if (!isset($_POST['token'])) {
    echo json_encode(array("success" => false, "message" => "Token is missing"));
    exit;
}

    // Get user ID from token
    $userID = getUserID($_POST['token']);

    // Get product ID and rating from POST data
    $propertyID = $_POST['propertyID'];
    $rating = $_POST['rating'];
    $review = $_POST['review'];

    // Check if the user has already rated the product
    $sql = "SELECT * FROM rating WHERE userID = '$userID' AND propertyID = '$propertyID'";
    $result = mysqli_query($CON, $sql);

    if (mysqli_num_rows($result) > 0) {
        // If user has already rated, update the existing rating
        $sql_update = "UPDATE rating SET rating = '$rating', review = '$review' WHERE userID = '$userID' AND propertyID = '$propertyID'";
        mysqli_query($CON, $sql_update);
    } else {
        // If user has not rated yet, insert a new rating
        $sql_insert = "INSERT INTO rating (userID, propertyID, rating, review) VALUES ('$userID', '$propertyID', '$rating','$review')";
        mysqli_query($CON, $sql_insert);
    }

    // Calculate average rating for the product and update the product table
    $sql_avg = "SELECT AVG(rating) AS avg_rating FROM rating WHERE propertyID = '$propertyID'";
    $result_avg = mysqli_query($CON, $sql_avg);
    $row_avg = mysqli_fetch_assoc($result_avg);
    $avg_rating = $row_avg['avg_rating'];

    // Update product table with the average rating
    $sql_update_product = "UPDATE property SET rating = '$avg_rating' WHERE propertyID = '$propertyID'";
    mysqli_query($CON, $sql_update_product);

    echo json_encode(array("success" => true, "message" => "Rating submitted successfully"));

