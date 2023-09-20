<?php
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: POST");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    include_once '../config/database.php';
    include_once '../model/Services.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Services($db);
    
$serviceID = $_GET['serviceID'];

if ($item->deleteService($serviceID)) {
    echo 'Service deleted successfully.'. $serviceID;
    //header("Location: ../Services.php");
} else {
    echo 'Service could not be deleted.';
}

?>