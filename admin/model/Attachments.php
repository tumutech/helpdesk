<?php
    class Attachments{
        // Connection
        private $conn;
        // Table
        private $db_table = "article_data_mime_attachment";
        // Columns
        public $article_article_id;
        public $filename;
        public $create_time;
        public $create_by;
        public $change_time;
        public $change_by;
        // Db connection
        public function __construct($db){
            $this->conn = $db;
        }
        // Getting all to do Attachments from the database
        public function getAttachments(){
            $sqlQuery = "SELECT article_id, filename, create_time FROM " . $this->db_table . "";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->execute();
            return $stmt;
        }
        // Creating a new Attachment and adding it to the database
        public function createAttachment(){
            $sqlQuery = "INSERT INTO
                        ". $this->db_table ."
                    SET
                        filename = :filename, 
                        create_by = :create_by,
                        change_time = :change_time,
                        change_by = :change_by,
                        create_time = :create_time";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            // securing data
            $this->filename=htmlspecialchars(strip_tags($this->filename));
            $this->create_time=htmlspecialchars(strip_tags($this->create_time));
        
            // bind data
            $stmt->bindParam(":filename", $this->filename);
            $stmt->bindParam(":create_time", $this->create_time);
            $stmt->bindParam(":create_by", $this->create_by);
            $stmt->bindParam(":change_time", $this->change_time);
            $stmt->bindParam(":change_by", $this->change_by);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Reading single Attachment from the database
        public function getSingleAttachment(){
            $sqlQuery = "SELECT
                        article_article_id, 
                        name, 
                        create_time
                      FROM
                        ". $this->db_table ."
                    WHERE 
                       article_id = ?
                    LIMIT 0,1";
            $stmt = $this->conn->prepare($sqlQuery);
            $stmt->bindParam(1, $this->article_id);
            $stmt->execute();
            $dataRow = $stmt->fetch(PDO::FETCH_ASSOC);
            
            $this->filename = $dataRow['filename'];
            $this->create_time = $dataRow['create_time'];
        }        
        // Updating a single Attachment in the database
        public function updateAttachment(){
            $sqlQuery = "UPDATE
                        ". $this->db_table ."
                    SET
                        filename = :filename, 
                        create_time = :create_time
                    WHERE 
                        article_id = :article_id";
        
            $stmt = $this->conn->prepare($sqlQuery);
        
            $this->name=htmlspecialchars(strip_tags($this->name));
            $this->created=htmlspecialchars(strip_tags($this->created));
            $this->article_id=htmlspecialchars(strip_tags($this->article_id));
        
            // bind data
            $stmt->bindParam(":filename", $this->filename);
            $stmt->bindParam(":create_time", $this->create_time);
            $stmt->bindParam(":article_id", $this->article_id);
        
            if($stmt->execute()){
               return true;
            }
            return false;
        }
        // Deleting a single Attachment from the database
        function deleteAttachment($article_id){
            $sqlQuery = "DELETE FROM " . $this->db_table . " WHERE article_article_id = ?";
            $stmt = $this->conn->prepare($sqlQuery);
        
            $this->article_id=htmlspecialchars(strip_tags($this->article_article_id));
        
            $stmt->bindParam(1, $this->article_article_id);
        
            if($stmt->execute()){
                return true;
            }
            return false;
        }
    }
?>