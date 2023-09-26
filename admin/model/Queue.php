<?php
    class Queues{
        // Connection
        private $conn;
        // Table
        private $db_table = "queue";
        // Columns
        public $queueID;
        public $agentID;
        // Db connection
        public function __construct($db){
            $this->conn = $db;
        }
        // Getting all to do Queues from the database
        public function getQueues() {
            $sqlQuery = "SELECT * FROM " . $this->db_table . "";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
        
            $Queues = [];
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $Queues[] = $row;
            }
        
            return $Queues;
        }        
        // Creating a new Queue and adding it to the database
        public function createQueue(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    SET
                        queueID = :queueID, 
                        agentID = :agentID";
        
            $stmt = $this->conn->prepare($sqlQuery);
            // bind data
            $stmt->bindParam(":queueID", $this->queueID);
            $stmt->bindParam(":agentID", $this->agentID);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }        
        // Updating a single Queue in the database
        public function updateQueue(){
            $sqlQuery = "UPDATE
                        ". $this->db_table ."
                    SET
                        queueID = :queueID, 
                        agentID = :agentID
                    WHERE 
                        queueID = :queueID";
        
            $stmt = $this->conn->prepare($sqlQuery);

            // bind data
            $stmt->bindParam(":queueID", $this->queueID);
            $stmt->bindParam(":agentID", $this->agentID);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Deleting a single Queue from the database
        function deleteQueue($queueID){
            $sqlQuery = "DELETE FROM " . $this->db_table . " WHERE queueID = ?";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->queueID);
        
            if($stmt->execute()){
                return true;
            }
            return false;
        }
    }
?>