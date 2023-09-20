<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Settings</title>
        <!-- Bootstrap core CSS -->
        <link href="../dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap core CSS -->
</head>
<body>
  <?php include_once("admin_template.php") ?>
  <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="row">
  <div class="col-sm-2">
    <div class="container" id="side">
<div class="actions">
    <h5>Actions</h5>
    <button><a href="add_attachment.php"> Add attachment</a></button>
</div>
<div class="actions">
    <h5>Filter for Attachments</h5>
    <input type="text" placeholder="Just start typing here">
</div>
</div>
  </div>
  <div class="col-sm-10">
    <div class="container">
    <h5>List</h5>
    <table class="table table-striped table-sm" border=1px bordercolor="gray">
        <th>NAME</th><th>FILENAME</th><th>COMMENT</th><th>VALIDITY</th><th>CHANGED</th><th>CREATED</th><th>DELETE</th>
        <?php
    include_once './config/database.php';
    include_once './model/Attachments.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Attachments($db);
$attachments = $item->getAttachments();

foreach ($attachments as $attachment):?>
   <tr>
            <td><?php echo $attachment['article_id']; ?></td>
            <td><?php echo $attachment['filename']; ?></td>
            <td>Null</td>
            <td>Null</td>
            <td><?php echo $attachment['change_time']; ?></td>
            <td><?php echo $attachment['create_time']; ?></td>
            <td><a href="./api/delete_attachment.php?article_id=<?php echo $attachment['article_id']; ?>"><span data-feather="home">Delete</span></a></td>
            <?php endforeach; ?> </tr>
    </table>
</div>
  </div>
</div>
</main>
    
</body>
</html>