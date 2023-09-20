<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add attachment</title>
    
    <!-- Bootstrap core CSS -->
    <link href="../dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<?php include_once("admin_template.php") ?>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <h5 class = "container">Add Attachment</h5>
    <form class = "container" action = "./api/create_attachment.php" method="post">
        <label>* Name:</label><input type="text" name="create_by">
        <br>
        <label> * Attachment: </label><input type="text" name="filename">
        <br>
        <label> * Validity: </label><input type="text" name="change_by">
        <br>
        <label disabled>Comment</label><input type="text" name="article_id">
        <br>
        <input type="submit" value="Save"> or <a href="attachments.php">Cancel</a>
    </form>
</main>
</body>
</html>