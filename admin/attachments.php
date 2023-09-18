<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Settings</title>
        <!-- Bootstrap core CSS -->
        <link href="../dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<?php
    include_once './config/database.php';
    include_once './model/Attachments.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Attachments($db);
  
    if($item->getAttachments()){
        echo 'Attachments fetched successfully.';
    echo '</table>';
    } else{
        echo 'Attachemnt could not be fetched.';
    }
?>
<body>
    <div class="row">
  <div class="col-sm-2">
    <div class="container">
<div class="actions">
    <h5>Actions</h5>
    <button><a href="add_attachment.php"> Add attachment</a></button>
</div>
<div class="filter">
    <h5>Filter for Attachments</h5>
    <input type="text" placeholder="Just start typing here">
</div>
</div>
  </div>
  <div class="col-sm-10">
    <div class="container">
    <h5>List</h5>
    <table border="1px" cellspacing="0px">
        <th>NAME</th><th>FILENAME</th><th>COMMENT</th><th>VALIDITY</th><th>CHANGED</th><th>CREATED</th><th>DELETE</th>
    </table>
</div>
  </div>
</div>
    
</body>
</html>