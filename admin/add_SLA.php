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
    <form class="form-container" action="./api/create_sla.php" method="POST">
        <label>* Name:</label ><input type="text" name="name">
        <br>
        <label>* Service Time(Hours):</label><input type="number" name="service_time">
        <br>
        <label>* Escalation Time(Hours):</label><input type="number" name="escalation_time">
        <br>
        <label> * Update escalation time(Hours): </label><input type="number" name="escalation_update_time">
        <br>
        <input  class="button" type="submit" value="Save"> or <a href="sla.php">Cancel</a>
    </form>
</div>
</main>
    
</body>
</html>