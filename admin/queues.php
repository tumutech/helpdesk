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
    <button onclick="location.href='add_Queue.php'"> Add Queue</button>
</div>
<div class="actions">
    <h5>Filter for Queue</h5>
    <input type="text" placeholder="Just start typing here">
</div>
</div>
<div class="col-sm-10">
<div class="list">
    <h5>List</h5>
    <table  class="table table-striped table-sm" border=1px bordercolor="gray">
        <th>Queue ID</th><th>Agent ID</th>
        <?php
    include_once './config/database.php';
    include_once './model/Queue.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Queues($db);
$queues = $item->getQueues();
foreach ($queues as $queue):?>
<tr>
            <td><?php echo $queue['queueID']; ?></td>
            <td><?php echo $queue['agentID']; ?></td>
            <?php endforeach; ?> </tr>
</table>
</div>
</div>
</div>
</main>
    
</body>
</html>