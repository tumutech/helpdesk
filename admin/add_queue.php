<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Queue</title>
    <?php 
    include('admin_template.php');
    ?>

</head>
<body>
    <div class="container-fluid">
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
<h5>Add Queue</h5>
    <div class="row">
    <form>
        <label>* Name:</label><input type="text">
        <br>
        <label> * Group: </label><input type="text">
        <br>
        <label> * Follow up Option: </label><input type="text">
        <br>
        <label> * Ticket lock after follow up: </label><input type="text"><br>
        <label> * System address: </label><input type="text">
        <br>
        <label> * Salutation: </label><input type="text">
        <br>
        <label> * Signature: </label><input type="text">
        <br>
        <label> * Validity: </label><input type="text">
        <br>
        <input type="submit" value="Save"> or <a href="queues.php">Cancel</a>
    </form>
</div>
</main>
</div>
</body>
</html>