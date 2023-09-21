<?php
    class Services{
        // Connection
        private $conn;
        // Table
        private $db_table = "service";
        // Columns
        public $num_rows;
        public $serviceID;
        public $name;
        public $comment;
        public $valid;
        public $create_date;
        public $sla_id;
        // Db connection
        public function __construct($db){
            $this->conn = $db;
        }
        // Getting all to do Services from the database
        public function getServices() {
            $sqlQuery = "SELECT serviceID, name, comment,valid,create_date,sla_id FROM " . $this->db_table . "";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
        
            $Services = [];
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $Services[] = $row;
            }
        
            return $Services;
        }        
        // Creating a new Service and adding it to the database
        public function createService(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    SET
                        name = :name, 
                        valid = :valid,
                        create_date = :create_date,
                        sla_id = :sla_id,
                        comment = :comment";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            // securing data
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->comment=htmlspecialchars(strip_tags($this->comment));
        
            // bind data
            $stmt->bindParam(":name", $this->name);
            $stmt->bindParam(":comment", $this->comment);
            $stmt->bindParam(":valid", $this->valid);
            $stmt->bindParam(":create_date", $this->create_date);
            $stmt->bindParam(":sla_id", $this->sla_id);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Reading single Service from the database
        public function getSingleService(){
            $sqlQuery = "SELECT
                        serviceID, 
                        name, 
                        comment
                      FROM
                        ". $this->db_table ."
                    WHERE 
                       serviceID = ?
                    LIMIT 0,1";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->serviceID);
            $stmt->execute();
            $dataRow = $stmt->fetch(PDO::FETCH_ASSOC);
            
            $this->name = $dataRow['name'];
            $this->comment = $dataRow['comment'];
        }        
        // Updating a single Service in the database
        public function updateService(){
            $sqlQuery = "UPDATE
                        ". $this->db_table ."
                    SET
                        name = :name, 
                        comment = :comment
                    WHERE 
                        serviceID = :serviceID";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->created=htmlspecialchars(strip_tags($this->created));
            $this->serviceID=htmlspecialchars(strip_tags($this->serviceID));
        
            // bind data
            $stmt->bindParam(":name", $this->name);
            $stmt->bindParam(":comment", $this->comment);
            $stmt->bindParam(":serviceID", $this->serviceID);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Deleting a single Service from the database
        function deleteService($serviceID){
            $sqlQuery = "DELETE FROM " . $this->db_table . " WHERE serviceID = ?";
            $stmt1 = $this->conn->prepare($sqlQuery);
            $stmt1->bindParam(1, $this->serviceID);
            echo($serviceID);
          
            if (!$stmt1->execute()) {
              // Handle the case where the query fails
              echo 'Service could not be deleted.';
              return false;
            }
            else{
                return true;
            }
          }
          
    }
?>