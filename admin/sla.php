<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Level agreement</title>
</head>
<body>
    <?php include_once("admin_template.php") ?>
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
    <div class="row">
  <div class="col-sm-2">
<div class="actions">
    <h5>Actions</h5>
    <button onclick="location.href='add_SLA.php'"> Add SLA</button>
</div>
<div class="actions">
    <h5>Filter for SLA</h5>
    <input type="text" placeholder="Just start typing here">
</div>
</div>
<div class="col-sm-10">
<div class="list">
    <h5>List</h5>
    <table  class="table table-striped table-sm" border=1px bordercolor="gray">
        <th>SLA</th><th>SERVICE</th><th>COMMENT</th><th>VALIDITY</th><th>CHANGED</th><th>CREATED</th>
        <?php
    include_once './config/database.php';
    include_once './model/SLA.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new SLAs($db);
$attachments = $item->getSLAs();
foreach ($attachments as $attachment):?>
<tr>
            <td><?php echo $attachment['sla_id']; ?></td>
            <td><?php echo $attachment['name']; ?></td>
            <td>Null</td>
            <td><?php echo $attachment['service_time']; ?></td>
            <td><?php echo $attachment['escalation_time']; ?></td>
            <td><?php echo $attachment['escalation_update_time']; ?></td>
            <?php endforeach; ?> </tr>
    </table>
</div>
</div>
</div>
</main>
    
</body>
</html>