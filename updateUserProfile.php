<?php

include './Helpers/DatabaseConfig.php';
include './Helpers/Authentication.php';

// Initialized response array
$response = [
    "success" => false,
    "message" => "Unknown error"
];

// Check if there's an update for full name or phone number
if (isset($_POST['fullName']) || isset($_POST['phoneNumber'])) {
    $fullName = $_POST['fullName'] ?? null;
    $phoneNumber = $_POST['phoneNumber'] ?? null;
    $userID = getUserID($_POST['token']) ; // Ensure userID is provided

    // Prepare SQL based on input provided
    $sql = "UPDATE user SET ";
    $fields = [];
    $params = [];

    if ($fullName !== null) {
        $fields[] = "fullName = ?";
        $params[] = $fullName;
    }

    if ($phoneNumber !== null) {
        $fields[] = "phoneNumber = ?";
        $params[] = $phoneNumber;
    }

    $sql .= implode(", ", $fields) . " WHERE userID = ?";
    $params[] = $userID;

    $stmt = $CON->prepare($sql);
    $stmt->bind_param(str_repeat("s", count($params)), ...$params);
    
    if ($stmt->execute()) {
        $response["success"] = true;
        $response["message"] = "Profile updated successfully.";
    } else {
        $response["message"] = "Failed to update profile: " . $stmt->error;
    }

    $stmt->close();
}

// Check if there's a password update request
if (isset($_POST['oldPassword'], $_POST['newPassword'])) {
    $oldPassword = $_POST['oldPassword'];
    $newPassword = $_POST['newPassword'];
    $userID = getUserID($_POST['token']) ; // Ensure userID is provided

    // First, fetch the existing password from the database
    $stmt = $CON->prepare("SELECT password FROM user WHERE userID = ?");
    $stmt->bind_param("s", $userID);
    $stmt->execute();
    $stmt->bind_result($currentPassword);
    $stmt->fetch();
    $stmt->close();

    // Verify the old password
    if (password_verify($oldPassword, $currentPassword)) {
        // Update to the new password
        $newHashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
        $stmt = $CON->prepare("UPDATE user SET password = ? WHERE userID = ?");
        $stmt->bind_param("ss", $newHashedPassword, $userID);

        if ($stmt->execute()) {
            $response["success"] = true;
            $response["message"] = "Password updated successfully.";
        } else {
            $response["message"] = "Failed to update password: " . $stmt->error;
        }
        $stmt->close();
    } else {
        $response["message"] = "Old password does not match.";
    }
}

// Return the response in JSON format
echo json_encode($response);

?>
