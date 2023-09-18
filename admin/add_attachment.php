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
    <h5 class = "container">Add Attachment</h5>
    <form class = "container" action = "./admin/create_attachment.php" method="post">
        <label>* Name:</label><input type="text">
        <br>
        <label> * Attachment: </label><input type="file">
        <br>
        <label> * Validity: </label><input type="text">
        <br>
        <label disabled>Comment</label><input type="text" disabled>
        <br>
        <input type="submit" value="Save"> or <a href="attachments.php">Cancel</a>
    </form>
    
</body>
</html>