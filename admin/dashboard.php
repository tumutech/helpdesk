<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin dashboard</title>
    <?php
    include_once './config/database.php';
    include_once './model/Ticket.php';
    $database = new Database();
    $db = $database->getConnection();
    $item = new Tickets($db);
    $tickets = $item->getTickets();
    include_once("admin_template.php");?>

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Admin Dashboard</h1>
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

      <div class="row">
      <div class="card">
  <div class="card-body">
  <span data-feather="file"></span>
    <h5 class="card-title">Tickets</h5>
    <h6 class="card-subtitle mb-2 text-muted"><?php
    $sql = 'SELECT COUNT(*) AS num_rows FROM open_tickets';
    $result = $db->query($sql);
    $num_rows = $result->fetchColumn();
    echo ($num_rows);    
    
    ?></h6>
  </div>
</div>
<div class="card">
  <div class="card-body">
  <span data-feather="briefcase"></span>
    <h5 class="card-title">Services</h5>
    <h6 class="card-subtitle mb-2 text-muted">
      <?php
    $sql = 'SELECT COUNT(*) AS num_rows FROM service';
    $result = $db->query($sql);
    $num_rows = $result->fetchColumn();
    echo ($num_rows); ?></h6>
  </div>
</div>
<div class="card">
  <div class="card-body">
  <span data-feather="users"></span>
    <h5 class="card-title">Customers</h5>
    <h6 class="card-subtitle mb-2 text-muted"><?php
    $sql = 'SELECT COUNT(*) AS num_rows FROM customers';
    $result = $db->query($sql);
    $num_rows = $result->fetchColumn();
    echo ($num_rows); ?></h6>
  </div>
</div>
<div class="card">
  <div class="card-body">
  <span data-feather="calendar"></span>
    <h5 class="card-title">Queues</h5>
    <h6 class="card-subtitle mb-2 text-muted"><?php
    $sql = 'SELECT COUNT(*) AS num_rows FROM service';
    $result = $db->query($sql);
    $num_rows = $result->fetchColumn();
    echo ($num_rows); ?></h6>
  </div>
</div>
      </div>

      <h2>Pending Tickets</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm" border=1px bordercolor="gray">
          <th>Ticket no</th>
          <th>Customer ID</th>
          <th> Message</th>
          <th>Created</th>
          <th>Actions</th>
        <?php foreach ($tickets as $ticket):?>
<tr>
            <td><?php echo $ticket['ticket_num']; ?></td>
            <td><?php echo $ticket['customer_userID']; ?></td>
            <!-- <td><?php echo $ticket['title']; ?></td> -->
            <td><?php echo $ticket['message']; ?></td>
            <td><?php echo $ticket['create_time']; ?></td>
            <td><a href="#" data-href="reassign.php?id=123"><span data-feather="user"></span>Re-assign</a></td>
            <?php endforeach; ?> </tr>
</table>
        </table>
      </div>
    </main>
  </div>
</div>


    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

      
        <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
        <script src="dashboard.js"></script>
  </body>
</html>
