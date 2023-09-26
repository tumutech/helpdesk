<?php
    class Customers{
        // Connection
        private $conn;
        // Table
        private $db_table = "customeuser";
        // Columns
        public $customer_userID;
        public $customerID;
        public $title;
        public $fname;
        public $lname;
        public $email;
        public $phone;
        // Db connection
        public function __construct($db){
            $this->conn = $db;
        }
        // Getting all to do Customers from the database
        public function getCustomers() {
            $sqlQuery = "SELECT customer_userID, customerID, title,fname,lname,email,phone FROM " . $this->db_table . "";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
        
            $Customers = [];
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $Customers[] = $row;
            }
        
            return $Customers;
        }        
        // Creating a new Customer and adding it to the database
        public function createCustomer(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    SET
                        customerID = :customerID, 
                        create_by = :create_by,
                        lname = :lname,
                        email = :email,
                        title = :title";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            // securing data
            $this->customerID=htmlspecialchars(strip_tags($this->customerID));
            $this->title=htmlspecialchars(strip_tags($this->title));
        
            // bind data
            $stmt->bindParam(":customerID", $this->customerID);
            $stmt->bindParam(":title", $this->title);
            $stmt->bindParam(":create_by", $this->create_by);
            $stmt->bindParam(":lname", $this->lname);
            $stmt->bindParam(":email", $this->email);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Reading single Customer from the database
        public function getSingleCustomer(){
            $sqlQuery = "SELECT
                        customer_userID, 
                        name, 
                        title
                      FROM
                        ". $this->db_table ."
                    WHERE 
                       customer_userID = ?
                    LIMIT 0,1";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->customer_userID);
            $stmt->execute();
            $dataRow = $stmt->fetch(PDO::FETCH_ASSOC);
            
            $this->customerID = $dataRow['customerID'];
            $this->title = $dataRow['title'];
        }        
        // Updating a single Customer in the database
        public function updateCustomer(){
            $sqlQuery = "UPDATE
                        ". $this->db_table ."
                    SET
                        customerID = :customerID, 
                        title = :title
                    WHERE 
                        customer_userID = :customer_userID";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->created=htmlspecialchars(strip_tags($this->created));
            $this->customer_userID=htmlspecialchars(strip_tags($this->customer_userID));
        
            // bind data
            $stmt->bindParam(":customerID", $this->customerID);
            $stmt->bindParam(":title", $this->title);
            $stmt->bindParam(":customer_userID", $this->customer_userID);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Deleting a single Customer from the database
        function deleteCustomer($customer_userID){
            $sqlQuery = "DELETE FROM " . $this->db_table . " WHERE customer_userID = ?";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->customer_userID);
        
            if($stmt->execute()){
                return true;
            }
            return false;
        }
    }
?>