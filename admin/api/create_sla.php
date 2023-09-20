<?php
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: POST");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    include_once '../config/database.php';
    include_once '../model/SLA.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new SLAs($db);
    $data = json_decode(file_get_contents("php://input"));
    $item->name = $_POST['name'];
    $item->service_time = $_POST['service_time'];
    $item->escalation_time = $_POST['escalation_time'];
    $item->escalation_update_time =$_POST['escalation_update_time'];


    
    if($item->createSLA()){
        echo 'SLA added successfully.';
        header("Location: ../SLA.php");
    } else{
        echo 'SLA could not be added.';
    }
?>