<?php
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: POST");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    include_once '../config/database.php';
    include_once '../model/Attachments.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Attachments($db);
    $data = json_decode(file_get_contents("php://input"));
    $item->filename = $_POST['filename'];
    $item->create_time = date('Y-m-d H:i:s');
    $item->create_by = $_POST['change_by'];
    $item->change_time = date('Y-m-d H:i:s');
    $item->change_by = $_POST['change_by'];

    
    if($item->createAttachment()){
        echo 'Attachment added successfully.';
        header("Location: ../attachments.php");
    } else{
        echo 'Attachemnt could not be added.';
    }
?>