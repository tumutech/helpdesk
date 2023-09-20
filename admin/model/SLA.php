<?php
    class SLAs{
        // Connection
        private $conn;
        // Table
        private $db_table = "sla";
        // Columns
        public $sla_id;
        public $name;
        public $service_time;
        public $escalation_time;
        public $escalation_update_time;
        // Db connection
        public function __construct($db){
            $this->conn = $db;
        }
        // Getting all to do SLAs from the database
        public function getSLAs() {
            $sqlQuery = "SELECT sla_id, name, service_time,escalation_time,escalation_update_time FROM " . $this->db_table . "";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
        
            $SLAs = [];
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $SLAs[] = $row;
            }
        
            return $SLAs;
        }        
        // Creating a new SLA and adding it to the database
        public function createSLA(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    SET
                        name = :name, 
                        escalation_time = :escalation_time,
                        escalation_update_time = :escalation_update_time,
                        service_time = :service_time";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            // // securing data
            // $this->name=htmlspecialchars(strip_tags($this->name));
            // $this->service_time=htmlspecialchars(strip_tags($this->service_time));
        
            // bind data
            $stmt->bindParam(":name", $this->name);
            $stmt->bindParam(":service_time", $this->service_time);
            $stmt->bindParam(":escalation_time", $this->escalation_time);
            $stmt->bindParam(":escalation_update_time", $this->escalation_update_time);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Reading single SLA from the database
        public function getSingleSLA(){
            $sqlQuery = "SELECT
                        sla_id, 
                        name, 
                        service_time
                      FROM
                        ". $this->db_table ."
                    WHERE 
                       sla_id = ?
                    LIMIT 0,1";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->sla_id);
            $stmt->execute();
            $dataRow = $stmt->fetch(PDO::FETCH_ASSOC);
            
            $this->name = $dataRow['name'];
            $this->service_time = $dataRow['service_time'];
        }        
        // Updating a single SLA in the database
        public function updateSLA(){
            $sqlQuery = "UPDATE
                        ". $this->db_table ."
                    SET
                        name = :name, 
                        service_time = :service_time
                    WHERE 
                        sla_id = :sla_id";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->created=htmlspecialchars(strip_tags($this->created));
            $this->sla_id=htmlspecialchars(strip_tags($this->sla_id));
        
            // bind data
            $stmt->bindParam(":name", $this->name);
            $stmt->bindParam(":service_time", $this->service_time);
            $stmt->bindParam(":sla_id", $this->sla_id);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Deleting a single SLA from the database
        function deleteSLA($sla_id){
            $sqlQuery = "DELETE FROM " . $this->db_table . " WHERE sla_id = ?";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->sla_id);
        
            if($stmt->execute()){
                return true;
            }
            return false;
        }
    }
?>