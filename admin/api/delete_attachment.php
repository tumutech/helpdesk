<?php
    include_once '../config/database.php';
    include_once '../model/Attachments.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Attachments($db);
    
$article_id = $_GET['article_id'];

if ($item->deleteAttachment($article_id)) {
    echo 'Attachment deleted successfully.';
} else {
    echo 'Attachment could not be deleted.';
}

?>