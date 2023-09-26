<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<?php include_once("admin_template.php");?> 
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Manage Users</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
          <div class="btn-group mr-2">
            <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
            <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
          </div>
          <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
            <span data-feather="calendar"></span>
            This week
          </button>
</div>
      </div>
      <table  class="table table-striped table-sm" border=1px bordercolor="gray">
        <th>User ID</th><th>Customer ID</th><th>Title</th><th>Name</th><th>Email</th><th>Phone</th><th>DELETE</th>
        <?php
    include_once './config/database.php';
    include_once './model/Customer.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Customers($db);
$attachments = $item->getCustomers();
foreach ($attachments as $attachment):?>
<tr>
            <td><?php echo $attachment['customer_userID']; ?></td>
            <td><?php echo $attachment['customerID']; ?></td>
            <td><?php echo $attachment['title']; ?></td>
            <td><?php echo $attachment['fname'] . " " .$attachment['lname'] ; ?></td>
            <td><?php echo $attachment['email']; ?></td>
            <td><?php echo $attachment['phone']; ?></td>
            <td><a href="#"><span data-feather="home">Delete</span></a></td>
            <?php endforeach; ?> </tr>
</table>
    </main> 
</body>
</html>