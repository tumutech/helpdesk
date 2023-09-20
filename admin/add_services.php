<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add SLA</title>

</head>
<body>
    <?php include_once("admin_template.php");?>
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
        <div class = "container">
    <h5>Add SLA</h5>
    <form class="form-container" action="./api/create_services.php" method="post">
        <label>* Service:</label><input type="text" name="service">
        <br>
        <label>* SLA:</label><input  type="number" name="sla_id">
        <br>
        <label>* Comment:</label><input type="text" name="comment">
        <br>
        <label> * Validity: </label><input type="number" name="validity">
        <br>
        <input  class="button" type="submit" value="Save"> or <a href="services.php">Cancel</a>
    </form>
</div>
</main>
    
</body>
</html>