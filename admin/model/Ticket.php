<?php
    class Tickets{
        // Connection
        private $conn;
        // Table
        private $db_table = "open_tickets";
        // Columns
        public $ticket_num;
        public $customer_userID;
        public $title;
        public $message;
        public $attachement;
        public $create_time;
        public $valid;
        // Db connection
        public function __construct($db){
            $this->conn = $db;
        }
        // Getting all to do Tickets from the database
        public function getTickets() {
            $sqlQuery = "SELECT ticket_num, customer_userID, title,message,body,create_time,valid FROM " . $this->db_table . "";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
        
            $Tickets = [];
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $Tickets[] = $row;
            }
        
            return $Tickets;
        }        
        // Creating a new Ticket and adding it to the database
        public function createTicket(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    SET
                        customer_userID = :customer_userID, 
                        message = :message,
                        attachement = :attachement,
                        create_time = :create_time,
                        title = :title";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            // securing data
            $this->customer_userID=htmlspecialchars(strip_tags($this->customer_userID));
            $this->title=htmlspecialchars(strip_tags($this->title));
        
            // bind data
            $stmt->bindParam(":customer_userID", $this->customer_userID);
            $stmt->bindParam(":title", $this->title);
            $stmt->bindParam(":message", $this->message);
            $stmt->bindParam(":attachement", $this->attachement);
            $stmt->bindParam(":create_time", $this->create_time);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Reading single Ticket from the database
        public function getSingleTicket(){
            $sqlQuery = "SELECT
                        ticket_num, 
                        name, 
                        title
                      FROM
                        ". $this->db_table ."
                    WHERE 
                       article_id = ?
                    LIMIT 0,1";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->article_id);
            $stmt->execute();
            $dataRow = $stmt->fetch(PDO::FETCH_ASSOC);
            
            $this->customer_userID = $dataRow['customer_userID'];
            $this->title = $dataRow['title'];
        }        
        // Updating a single Ticket in the database
        public function updateTicket(){
            $sqlQuery = "UPDATE
                        ". $this->db_table ."
                    SET
                        customer_userID = :customer_userID, 
                        title = :title
                    WHERE 
                        article_id = :article_id";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->created=htmlspecialchars(strip_tags($this->created));
            $this->article_id=htmlspecialchars(strip_tags($this->article_id));
        
            // bind data
            $stmt->bindParam(":customer_userID", $this->customer_userID);
            $stmt->bindParam(":title", $this->title);
            $stmt->bindParam(":article_id", $this->article_id);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Deleting a single Ticket from the database
        function deleteTicket($article_id){
            $sqlQuery = "DELETE FROM " . $this->db_table . " WHERE article_id = ?";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->article_id);
        
            if($stmt->execute()){
                return true;
            }
            return false;
        }
    }
?>