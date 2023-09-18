-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema helpdesk_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema helpdesk_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `helpdesk_db` ;
USE `helpdesk_db` ;

-- -----------------------------------------------------
-- Table `helpdesk_db`.`acl`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`acl` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `description` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `stop_after_match` SMALLINT NULL DEFAULT NULL,
  `config_match` LONGBLOB NULL DEFAULT NULL,
  `config_change` LONGBLOB NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `acl_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`acl_sync`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`acl_sync` (
  `acl_id` VARCHAR(200) NOT NULL,
  `sync_state` VARCHAR(30) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `change_time` DATETIME NOT NULL);


-- -----------------------------------------------------
-- Table `helpdesk_db`.`valid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`valid` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `valid_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(200) NOT NULL,
  `pw` VARCHAR(128) NOT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_login` (`login` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`user_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`user_preferences` (
  `user_id` INT NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` LONGBLOB NULL DEFAULT NULL,
  INDEX `user_preferences_user_id` (`user_id` ASC),
  CONSTRAINT `FK_user_preferences_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `groups_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`group_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`group_user` (
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `permission_key` VARCHAR(20) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `group_user_group_id` (`group_id` ASC),
  INDEX `group_user_user_id` (`user_id` ASC),
  CONSTRAINT `FK_group_user_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`),
  CONSTRAINT `FK_group_user_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `roles_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`group_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`group_role` (
  `role_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `permission_key` VARCHAR(20) NOT NULL,
  `permission_value` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `group_role_group_id` (`group_id` ASC),
  INDEX `group_role_role_id` (`role_id` ASC),
  CONSTRAINT `FK_group_role_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`),
  CONSTRAINT `FK_group_role_role_id_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `helpdesk_db`.`roles` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`group_customer_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`group_customer_user` (
  `user_id` VARCHAR(100) NOT NULL,
  `group_id` INT NOT NULL,
  `permission_key` VARCHAR(20) NOT NULL,
  `permission_value` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `group_customer_user_group_id` (`group_id` ASC),
  INDEX `group_customer_user_user_id` (`user_id` ASC),
  CONSTRAINT `FK_group_customer_user_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`group_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`group_customer` (
  `customer_id` VARCHAR(150) NOT NULL,
  `group_id` INT NOT NULL,
  `permission_key` VARCHAR(20) NOT NULL,
  `permission_value` SMALLINT NOT NULL,
  `permission_context` VARCHAR(100) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `group_customer_customer_id` (`customer_id` ASC),
  INDEX `group_customer_group_id` (`group_id` ASC),
  CONSTRAINT `FK_group_customer_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`role_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`role_user` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `role_user_role_id` (`role_id` ASC),
  INDEX `role_user_user_id` (`user_id` ASC),
  CONSTRAINT `FK_role_user_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`follow_up_possible`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`follow_up_possible` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `follow_up_possible_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`salutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`salutation` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `text` TEXT NOT NULL,
  `content_type` VARCHAR(250) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `salutation_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`signature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`signature` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `text` TEXT NOT NULL,
  `content_type` VARCHAR(250) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `signature_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`system_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`system_address` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `value0` VARCHAR(200) NOT NULL,
  `value1` VARCHAR(200) NOT NULL,
  `value2` VARCHAR(200) NULL DEFAULT NULL,
  `value3` VARCHAR(200) NULL DEFAULT NULL,
  `queue_id` INT NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`queue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`queue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `group_id` INT NOT NULL,
  `unlock_timeout` INT NULL DEFAULT NULL,
  `first_response_time` INT NULL DEFAULT NULL,
  `first_response_notify` SMALLINT NULL DEFAULT NULL,
  `update_time` INT NULL DEFAULT NULL,
  `update_notify` SMALLINT NULL DEFAULT NULL,
  `solution_time` INT NULL DEFAULT NULL,
  `solution_notify` SMALLINT NULL DEFAULT NULL,
  `system_address_id` SMALLINT NOT NULL,
  `calendar_name` VARCHAR(100) NULL DEFAULT NULL,
  `default_sign_key` VARCHAR(100) NULL DEFAULT NULL,
  `salutation_id` SMALLINT NOT NULL,
  `signature_id` SMALLINT NOT NULL,
  `follow_up_id` SMALLINT NOT NULL,
  `follow_up_lock` SMALLINT NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `queue_name` (`name` ASC),
  INDEX `queue_group_id` (`group_id` ASC),
  INDEX `FK_queue_follow_up_id_id` (`follow_up_id` ASC),
  INDEX `FK_queue_salutation_id_id` (`salutation_id` ASC),
  INDEX `FK_queue_signature_id_id` (`signature_id` ASC),
  INDEX `FK_queue_system_address_id_id` (`system_address_id` ASC),
  CONSTRAINT `FK_queue_follow_up_id_id`
    FOREIGN KEY (`follow_up_id`)
    REFERENCES `helpdesk_db`.`follow_up_possible` (`id`),
  CONSTRAINT `FK_queue_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`),
  CONSTRAINT `FK_queue_salutation_id_id`
    FOREIGN KEY (`salutation_id`)
    REFERENCES `helpdesk_db`.`salutation` (`id`),
  CONSTRAINT `FK_queue_signature_id_id`
    FOREIGN KEY (`signature_id`)
    REFERENCES `helpdesk_db`.`signature` (`id`),
  CONSTRAINT `FK_queue_system_address_id_id`
    FOREIGN KEY (`system_address_id`)
    REFERENCES `helpdesk_db`.`system_address` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`personal_queues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`personal_queues` (
  `user_id` INT NOT NULL,
  `queue_id` INT NOT NULL,
  INDEX `personal_queues_queue_id` (`queue_id` ASC),
  INDEX `personal_queues_user_id` (`user_id` ASC),
  CONSTRAINT `FK_personal_queues_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`),
  CONSTRAINT `FK_personal_queues_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `service_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`personal_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`personal_services` (
  `user_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  INDEX `personal_services_service_id` (`service_id` ASC),
  INDEX `personal_services_user_id` (`user_id` ASC),
  CONSTRAINT `FK_personal_services_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `helpdesk_db`.`service` (`id`),
  CONSTRAINT `FK_personal_services_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`system_maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`system_maintenance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_date` INT NOT NULL,
  `stop_date` INT NOT NULL,
  `comments` VARCHAR(250) NOT NULL,
  `login_message` VARCHAR(250) NULL DEFAULT NULL,
  `show_login_message` SMALLINT NULL DEFAULT NULL,
  `notify_message` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`queue_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`queue_preferences` (
  `queue_id` INT NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` VARCHAR(250) NULL DEFAULT NULL,
  INDEX `queue_preferences_queue_id` (`queue_id` ASC),
  CONSTRAINT `FK_queue_preferences_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_priority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_priority` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_priority_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_lock_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_lock_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_lock_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_state_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_state_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_state_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_state` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `type_id` SMALLINT NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_state_name` (`name` ASC),
  INDEX `FK_ticket_state_type_id_id` (`type_id` ASC),
  CONSTRAINT `FK_ticket_state_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `helpdesk_db`.`ticket_state_type` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sla` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `calendar_name` VARCHAR(100) NULL DEFAULT NULL,
  `first_response_time` INT NOT NULL,
  `first_response_notify` SMALLINT NULL DEFAULT NULL,
  `update_time` INT NOT NULL,
  `update_notify` SMALLINT NULL DEFAULT NULL,
  `solution_time` INT NOT NULL,
  `solution_notify` SMALLINT NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sla_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `tn` VARCHAR(50) NOT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `queue_id` INT NOT NULL,
  `ticket_lock_id` SMALLINT NOT NULL,
  `type_id` SMALLINT NULL DEFAULT NULL,
  `service_id` INT NULL DEFAULT NULL,
  `sla_id` INT NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `responsible_user_id` INT NOT NULL,
  `ticket_priority_id` SMALLINT NOT NULL,
  `ticket_state_id` SMALLINT NOT NULL,
  `customer_id` VARCHAR(150) NULL DEFAULT NULL,
  `customer_user_id` VARCHAR(250) NULL DEFAULT NULL,
  `timeout` INT NOT NULL,
  `until_time` INT NOT NULL,
  `escalation_time` INT NOT NULL,
  `escalation_update_time` INT NOT NULL,
  `escalation_response_time` INT NOT NULL,
  `escalation_solution_time` INT NOT NULL,
  `archive_flag` SMALLINT NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_tn` (`tn` ASC),
  INDEX `ticket_archive_flag` (`archive_flag` ASC),
  INDEX `ticket_create_time` (`create_time` ASC),
  INDEX `ticket_customer_id` (`customer_id` ASC),
  INDEX `ticket_customer_user_id` (`customer_user_id` ASC),
  INDEX `ticket_escalation_response_time` (`escalation_response_time` ASC),
  INDEX `ticket_escalation_solution_time` (`escalation_solution_time` ASC),
  INDEX `ticket_escalation_time` (`escalation_time` ASC),
  INDEX `ticket_escalation_update_time` (`escalation_update_time` ASC),
  INDEX `ticket_queue_id` (`queue_id` ASC),
  INDEX `ticket_queue_view` (`ticket_state_id` ASC, `ticket_lock_id` ASC),
  INDEX `ticket_responsible_user_id` (`responsible_user_id` ASC),
  INDEX `ticket_ticket_lock_id` (`ticket_lock_id` ASC),
  INDEX `ticket_ticket_priority_id` (`ticket_priority_id` ASC),
  INDEX `ticket_ticket_state_id` (`ticket_state_id` ASC),
  INDEX `ticket_timeout` (`timeout` ASC),
  INDEX `ticket_title` (`title` ASC),
  INDEX `ticket_type_id` (`type_id` ASC),
  INDEX `ticket_until_time` (`until_time` ASC),
  INDEX `ticket_user_id` (`user_id` ASC),
  INDEX `FK_ticket_service_id_id` (`service_id` ASC),
  INDEX `FK_ticket_sla_id_id` (`sla_id` ASC),
  CONSTRAINT `FK_ticket_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`),
  CONSTRAINT `FK_ticket_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `helpdesk_db`.`service` (`id`),
  CONSTRAINT `FK_ticket_sla_id_id`
    FOREIGN KEY (`sla_id`)
    REFERENCES `helpdesk_db`.`sla` (`id`),
  CONSTRAINT `FK_ticket_ticket_lock_id_id`
    FOREIGN KEY (`ticket_lock_id`)
    REFERENCES `helpdesk_db`.`ticket_lock_type` (`id`),
  CONSTRAINT `FK_ticket_ticket_priority_id_id`
    FOREIGN KEY (`ticket_priority_id`)
    REFERENCES `helpdesk_db`.`ticket_priority` (`id`),
  CONSTRAINT `FK_ticket_ticket_state_id_id`
    FOREIGN KEY (`ticket_state_id`)
    REFERENCES `helpdesk_db`.`ticket_state` (`id`),
  CONSTRAINT `FK_ticket_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `helpdesk_db`.`ticket_type` (`id`),
  CONSTRAINT `FK_ticket_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`),
  CONSTRAINT `FK_ticket_responsible_user_id_id`
    FOREIGN KEY (`responsible_user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_flag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_flag` (
  `ticket_id` BIGINT NOT NULL,
  `ticket_key` VARCHAR(50) NOT NULL,
  `ticket_value` VARCHAR(50) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  UNIQUE INDEX `ticket_flag_per_user` (`ticket_id` ASC, `ticket_key` ASC, `create_by` ASC),
  INDEX `ticket_flag_ticket_id` (`ticket_id` ASC),
  INDEX `ticket_flag_ticket_id_create_by` (`ticket_id` ASC, `create_by` ASC),
  INDEX `ticket_flag_ticket_id_ticket_key` (`ticket_id` ASC, `ticket_key` ASC),
  CONSTRAINT `FK_ticket_flag_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_sender_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_sender_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `article_sender_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`communication_channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`communication_channel` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `module` VARCHAR(200) NOT NULL,
  `package_name` VARCHAR(200) NOT NULL,
  `channel_data` LONGBLOB NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `communication_channel_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ticket_id` BIGINT NOT NULL,
  `article_sender_type_id` SMALLINT NOT NULL,
  `communication_channel_id` BIGINT NOT NULL,
  `is_for_customer` SMALLINT NOT NULL,
  `search_index_needs_rebuild` SMALLINT NOT NULL DEFAULT 1,
  `insert_fingerprint` VARCHAR(64) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_article_sender_type_id` (`article_sender_type_id` ASC),
  INDEX `article_communication_channel_id` (`communication_channel_id` ASC),
  INDEX `article_search_index_needs_rebuild` (`search_index_needs_rebuild` ASC),
  INDEX `article_ticket_id` (`ticket_id` ASC),
  CONSTRAINT `FK_article_article_sender_type_id_id`
    FOREIGN KEY (`article_sender_type_id`)
    REFERENCES `helpdesk_db`.`article_sender_type` (`id`),
  CONSTRAINT `FK_article_communication_channel_id_id`
    FOREIGN KEY (`communication_channel_id`)
    REFERENCES `helpdesk_db`.`communication_channel` (`id`),
  CONSTRAINT `FK_article_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_history_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_history_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_history_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_history` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `history_type_id` SMALLINT NOT NULL,
  `ticket_id` BIGINT NOT NULL,
  `article_id` BIGINT NULL DEFAULT NULL,
  `type_id` SMALLINT NOT NULL,
  `queue_id` INT NOT NULL,
  `owner_id` INT NOT NULL,
  `priority_id` SMALLINT NOT NULL,
  `state_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ticket_history_article_id` (`article_id` ASC),
  INDEX `ticket_history_create_time` (`create_time` ASC),
  INDEX `ticket_history_history_type_id` (`history_type_id` ASC),
  INDEX `ticket_history_owner_id` (`owner_id` ASC),
  INDEX `ticket_history_priority_id` (`priority_id` ASC),
  INDEX `ticket_history_queue_id` (`queue_id` ASC),
  INDEX `ticket_history_state_id` (`state_id` ASC),
  INDEX `ticket_history_ticket_id` (`ticket_id` ASC),
  INDEX `ticket_history_type_id` (`type_id` ASC),
  CONSTRAINT `FK_ticket_history_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`),
  CONSTRAINT `FK_ticket_history_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`),
  CONSTRAINT `FK_ticket_history_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`),
  CONSTRAINT `FK_ticket_history_history_type_id_id`
    FOREIGN KEY (`history_type_id`)
    REFERENCES `helpdesk_db`.`ticket_history_type` (`id`),
  CONSTRAINT `FK_ticket_history_priority_id_id`
    FOREIGN KEY (`priority_id`)
    REFERENCES `helpdesk_db`.`ticket_priority` (`id`),
  CONSTRAINT `FK_ticket_history_state_id_id`
    FOREIGN KEY (`state_id`)
    REFERENCES `helpdesk_db`.`ticket_state` (`id`),
  CONSTRAINT `FK_ticket_history_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `helpdesk_db`.`ticket_type` (`id`),
  CONSTRAINT `FK_ticket_history_owner_id_id`
    FOREIGN KEY (`owner_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_watcher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_watcher` (
  `ticket_id` BIGINT NOT NULL,
  `user_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `ticket_watcher_ticket_id` (`ticket_id` ASC),
  INDEX `ticket_watcher_user_id` (`user_id` ASC),
  CONSTRAINT `FK_ticket_watcher_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`),
  CONSTRAINT `FK_ticket_watcher_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_index`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_index` (
  `ticket_id` BIGINT NOT NULL,
  `queue_id` INT NOT NULL,
  `queue` VARCHAR(200) NOT NULL,
  `group_id` INT NOT NULL,
  `s_lock` VARCHAR(200) NOT NULL,
  `s_state` VARCHAR(200) NOT NULL,
  `create_time` DATETIME NOT NULL,
  INDEX `ticket_index_group_id` (`group_id` ASC),
  INDEX `ticket_index_queue_id` (`queue_id` ASC),
  INDEX `ticket_index_ticket_id` (`ticket_id` ASC),
  CONSTRAINT `FK_ticket_index_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`),
  CONSTRAINT `FK_ticket_index_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`),
  CONSTRAINT `FK_ticket_index_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_lock_index`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_lock_index` (
  `ticket_id` BIGINT NOT NULL,
  INDEX `ticket_lock_index_ticket_id` (`ticket_id` ASC),
  CONSTRAINT `FK_ticket_lock_index_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_loop_protection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_loop_protection` (
  `sent_to` VARCHAR(250) NOT NULL,
  `sent_date` VARCHAR(150) NOT NULL,
  INDEX `ticket_loop_protection_sent_date` (`sent_date` ASC),
  INDEX `ticket_loop_protection_sent_to` (`sent_to` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_flag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_flag` (
  `article_id` BIGINT NOT NULL,
  `article_key` VARCHAR(50) NOT NULL,
  `article_value` VARCHAR(50) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  INDEX `article_flag_article_id` (`article_id` ASC),
  INDEX `article_flag_article_id_create_by` (`article_id` ASC, `create_by` ASC),
  CONSTRAINT `FK_article_flag_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_data_mime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_data_mime` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `article_id` BIGINT NOT NULL,
  `a_from` MEDIUMTEXT NULL DEFAULT NULL,
  `a_reply_to` MEDIUMTEXT NULL DEFAULT NULL,
  `a_to` MEDIUMTEXT NULL DEFAULT NULL,
  `a_cc` MEDIUMTEXT NULL DEFAULT NULL,
  `a_bcc` MEDIUMTEXT NULL DEFAULT NULL,
  `a_subject` TEXT NULL DEFAULT NULL,
  `a_message_id` TEXT NULL DEFAULT NULL,
  `a_message_id_md5` VARCHAR(32) NULL DEFAULT NULL,
  `a_in_reply_to` MEDIUMTEXT NULL DEFAULT NULL,
  `a_references` MEDIUMTEXT NULL DEFAULT NULL,
  `a_content_type` VARCHAR(250) NULL DEFAULT NULL,
  `a_body` MEDIUMTEXT NULL DEFAULT NULL,
  `incoming_time` INT NOT NULL,
  `content_path` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_data_mime_message_id_md5` (`a_message_id_md5` ASC),
  INDEX `FK_article_data_mime_article_id_id` (`article_id` ASC),
  CONSTRAINT `FK_article_data_mime_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_search_index`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_search_index` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ticket_id` BIGINT NOT NULL,
  `article_id` BIGINT NOT NULL,
  `article_key` VARCHAR(200) NOT NULL,
  `article_value` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_search_index_article_id` (`article_id` ASC, `article_key` ASC),
  INDEX `article_search_index_ticket_id` (`ticket_id` ASC, `article_key` ASC),
  CONSTRAINT `FK_article_search_index_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`),
  CONSTRAINT `FK_article_search_index_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_data_mime_plain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_data_mime_plain` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `article_id` BIGINT NOT NULL,
  `body` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_data_mime_plain_article_id` (`article_id` ASC),
  CONSTRAINT `FK_article_data_mime_plain_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_data_mime_attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_data_mime_attachment` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `article_id` BIGINT NOT NULL,
  `filename` VARCHAR(250) NULL DEFAULT NULL,
  `content_size` VARCHAR(30) NULL DEFAULT NULL,
  `content_type` TEXT NULL DEFAULT NULL,
  `content_id` VARCHAR(250) NULL DEFAULT NULL,
  `content_alternative` VARCHAR(50) NULL DEFAULT NULL,
  `disposition` VARCHAR(15) NULL DEFAULT NULL,
  `content` LONGBLOB NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_data_mime_attachment_article_id` (`article_id` ASC),
  CONSTRAINT `FK_article_data_mime_attachment_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_data_mime_send_error`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_data_mime_send_error` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `article_id` BIGINT NOT NULL,
  `message_id` VARCHAR(200) NULL DEFAULT NULL,
  `log_message` MEDIUMTEXT NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_data_mime_transmission_article_id` (`article_id` ASC),
  INDEX `article_data_mime_transmission_message_id` (`message_id` ASC),
  CONSTRAINT `FK_article_data_mime_send_error_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`article_data_otrs_chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`article_data_otrs_chat` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `article_id` BIGINT NOT NULL,
  `chat_participant_id` VARCHAR(255) NOT NULL,
  `chat_participant_name` VARCHAR(255) NOT NULL,
  `chat_participant_type` VARCHAR(255) NOT NULL,
  `message_text` TEXT NULL DEFAULT NULL,
  `system_generated` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_data_otrs_chat_article_id` (`article_id` ASC),
  CONSTRAINT `FK_article_data_otrs_chat_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`time_accounting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`time_accounting` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ticket_id` BIGINT NOT NULL,
  `article_id` BIGINT NULL DEFAULT NULL,
  `time_unit` DECIMAL(10,2) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `time_accounting_ticket_id` (`ticket_id` ASC),
  INDEX `FK_time_accounting_article_id_id` (`article_id` ASC),
  CONSTRAINT `FK_time_accounting_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`),
  CONSTRAINT `FK_time_accounting_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`standard_template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`standard_template` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `text` TEXT NULL DEFAULT NULL,
  `content_type` VARCHAR(250) NULL DEFAULT NULL,
  `template_type` VARCHAR(100) NOT NULL DEFAULT 'Answer',
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `standard_template_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`queue_standard_template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`queue_standard_template` (
  `queue_id` INT NOT NULL,
  `standard_template_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `FK_queue_standard_template_queue_id_id` (`queue_id` ASC),
  INDEX `FK_queue_standard_template_standard_template_id_id` (`standard_template_id` ASC),
  CONSTRAINT `FK_queue_standard_template_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`),
  CONSTRAINT `FK_queue_standard_template_standard_template_id_id`
    FOREIGN KEY (`standard_template_id`)
    REFERENCES `helpdesk_db`.`standard_template` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`standard_attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`standard_attachment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `content_type` VARCHAR(250) NOT NULL,
  `content` LONGBLOB NOT NULL,
  `filename` VARCHAR(250) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `standard_attachment_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`standard_template_attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`standard_template_attachment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `standard_attachment_id` INT NOT NULL,
  `standard_template_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_standard_template_attachment_standard_attachment_id_id` (`standard_attachment_id` ASC),
  INDEX `FK_standard_template_attachment_standard_template_id_id` (`standard_template_id` ASC),
  CONSTRAINT `FK_standard_template_attachment_standard_attachment_id_id`
    FOREIGN KEY (`standard_attachment_id`)
    REFERENCES `helpdesk_db`.`standard_attachment` (`id`),
  CONSTRAINT `FK_standard_template_attachment_standard_template_id_id`
    FOREIGN KEY (`standard_template_id`)
    REFERENCES `helpdesk_db`.`standard_template` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`auto_response_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`auto_response_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auto_response_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`auto_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`auto_response` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `text0` TEXT NULL DEFAULT NULL,
  `text1` TEXT NULL DEFAULT NULL,
  `type_id` SMALLINT NOT NULL,
  `system_address_id` SMALLINT NOT NULL,
  `content_type` VARCHAR(250) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auto_response_name` (`name` ASC),
  INDEX `FK_auto_response_type_id_id` (`type_id` ASC),
  INDEX `FK_auto_response_system_address_id_id` (`system_address_id` ASC),
  CONSTRAINT `FK_auto_response_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `helpdesk_db`.`auto_response_type` (`id`),
  CONSTRAINT `FK_auto_response_system_address_id_id`
    FOREIGN KEY (`system_address_id`)
    REFERENCES `helpdesk_db`.`system_address` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`queue_auto_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`queue_auto_response` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `queue_id` INT NOT NULL,
  `auto_response_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_queue_auto_response_auto_response_id_id` (`auto_response_id` ASC),
  INDEX `FK_queue_auto_response_queue_id_id` (`queue_id` ASC),
  CONSTRAINT `FK_queue_auto_response_auto_response_id_id`
    FOREIGN KEY (`auto_response_id`)
    REFERENCES `helpdesk_db`.`auto_response` (`id`),
  CONSTRAINT `FK_queue_auto_response_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `helpdesk_db`.`queue` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`service_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`service_preferences` (
  `service_id` INT NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` VARCHAR(250) NULL DEFAULT NULL,
  INDEX `service_preferences_service_id` (`service_id` ASC),
  CONSTRAINT `FK_service_preferences_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `helpdesk_db`.`service` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`service_customer_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`service_customer_user` (
  `customer_user_login` VARCHAR(200) NOT NULL,
  `service_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  INDEX `service_customer_user_customer_user_login` (`customer_user_login`(10) ASC),
  INDEX `service_customer_user_service_id` (`service_id` ASC),
  CONSTRAINT `FK_service_customer_user_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `helpdesk_db`.`service` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sla_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sla_preferences` (
  `sla_id` INT NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` VARCHAR(250) NULL DEFAULT NULL,
  INDEX `sla_preferences_sla_id` (`sla_id` ASC),
  CONSTRAINT `FK_sla_preferences_sla_id_id`
    FOREIGN KEY (`sla_id`)
    REFERENCES `helpdesk_db`.`sla` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`service_sla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`service_sla` (
  `service_id` INT NOT NULL,
  `sla_id` INT NOT NULL,
  UNIQUE INDEX `service_sla_service_sla` (`service_id` ASC, `sla_id` ASC),
  INDEX `FK_service_sla_sla_id_id` (`sla_id` ASC),
  CONSTRAINT `FK_service_sla_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `helpdesk_db`.`service` (`id`),
  CONSTRAINT `FK_service_sla_sla_id_id`
    FOREIGN KEY (`sla_id`)
    REFERENCES `helpdesk_db`.`sla` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sessions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `session_id` VARCHAR(100) NOT NULL,
  `data_key` VARCHAR(100) NOT NULL,
  `data_value` TEXT NULL DEFAULT NULL,
  `serialized` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sessions_data_key` (`data_key` ASC),
  INDEX `sessions_session_id_data_key` (`session_id` ASC, `data_key` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`customer_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`customer_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(200) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `customer_id` VARCHAR(150) NOT NULL,
  `pw` VARCHAR(128) NULL DEFAULT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(150) NULL DEFAULT NULL,
  `fax` VARCHAR(150) NULL DEFAULT NULL,
  `mobile` VARCHAR(150) NULL DEFAULT NULL,
  `street` VARCHAR(150) NULL DEFAULT NULL,
  `zip` VARCHAR(200) NULL DEFAULT NULL,
  `city` VARCHAR(200) NULL DEFAULT NULL,
  `country` VARCHAR(200) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `customer_user_login` (`login` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`customer_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`customer_preferences` (
  `user_id` VARCHAR(250) NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` VARCHAR(250) NULL DEFAULT NULL,
  INDEX `customer_preferences_user_id` (`user_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`customer_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`customer_company` (
  `customer_id` VARCHAR(150) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `street` VARCHAR(200) NULL DEFAULT NULL,
  `zip` VARCHAR(200) NULL DEFAULT NULL,
  `city` VARCHAR(200) NULL DEFAULT NULL,
  `country` VARCHAR(200) NULL DEFAULT NULL,
  `url` VARCHAR(200) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_company_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`customer_user_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`customer_user_customer` (
  `user_id` VARCHAR(100) NOT NULL,
  `customer_id` VARCHAR(150) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  INDEX `customer_user_customer_customer_id` (`customer_id` ASC),
  INDEX `customer_user_customer_user_id` (`user_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`mail_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`mail_account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(200) NOT NULL,
  `pw` VARCHAR(200) NOT NULL,
  `host` VARCHAR(200) NOT NULL,
  `account_type` VARCHAR(20) NOT NULL,
  `queue_id` INT NOT NULL,
  `trusted` SMALLINT NOT NULL,
  `imap_folder` VARCHAR(250) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`postmaster_filter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`postmaster_filter` (
  `f_name` VARCHAR(200) NOT NULL,
  `f_stop` SMALLINT NULL DEFAULT NULL,
  `f_type` VARCHAR(20) NOT NULL,
  `f_key` VARCHAR(200) NOT NULL,
  `f_value` VARCHAR(200) NOT NULL,
  `f_not` SMALLINT NULL DEFAULT NULL,
  INDEX `postmaster_filter_f_name` (`f_name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`generic_agent_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`generic_agent_jobs` (
  `job_name` VARCHAR(200) NOT NULL,
  `job_key` VARCHAR(200) NOT NULL,
  `job_value` VARCHAR(200) NULL DEFAULT NULL,
  INDEX `generic_agent_jobs_job_name` (`job_name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`search_profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`search_profile` (
  `login` VARCHAR(200) NOT NULL,
  `profile_name` VARCHAR(200) NOT NULL,
  `profile_type` VARCHAR(30) NOT NULL,
  `profile_key` VARCHAR(200) NOT NULL,
  `profile_value` VARCHAR(200) NULL DEFAULT NULL,
  INDEX `search_profile_login` (`login` ASC),
  INDEX `search_profile_profile_name` (`profile_name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`process_id`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`process_id` (
  `process_name` VARCHAR(200) NOT NULL,
  `process_id` VARCHAR(200) NOT NULL,
  `process_host` VARCHAR(200) NOT NULL,
  `process_create` INT NOT NULL,
  `process_change` INT NOT NULL);


-- -----------------------------------------------------
-- Table `helpdesk_db`.`web_upload_cache`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`web_upload_cache` (
  `form_id` VARCHAR(250) NULL DEFAULT NULL,
  `filename` VARCHAR(250) NULL DEFAULT NULL,
  `content_id` VARCHAR(250) NULL DEFAULT NULL,
  `content_size` VARCHAR(30) NULL DEFAULT NULL,
  `content_type` VARCHAR(250) NULL DEFAULT NULL,
  `disposition` VARCHAR(15) NULL DEFAULT NULL,
  `content` LONGBLOB NOT NULL,
  `create_time_unix` BIGINT NOT NULL);


-- -----------------------------------------------------
-- Table `helpdesk_db`.`notification_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`notification_event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `notification_event_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`notification_event_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`notification_event_message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `notification_id` INT NOT NULL,
  `subject` VARCHAR(200) NOT NULL,
  `text` TEXT NOT NULL,
  `content_type` VARCHAR(250) NOT NULL,
  `language` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `notification_event_message_notification_id_language` (`notification_id` ASC, `language` ASC),
  INDEX `notification_event_message_language` (`language` ASC),
  INDEX `notification_event_message_notification_id` (`notification_id` ASC),
  CONSTRAINT `FK_notification_event_message_notification_id_id`
    FOREIGN KEY (`notification_id`)
    REFERENCES `helpdesk_db`.`notification_event` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`notification_event_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`notification_event_item` (
  `notification_id` INT NOT NULL,
  `event_key` VARCHAR(200) NOT NULL,
  `event_value` VARCHAR(200) NOT NULL,
  INDEX `notification_event_item_event_key` (`event_key` ASC),
  INDEX `notification_event_item_event_value` (`event_value` ASC),
  INDEX `notification_event_item_notification_id` (`notification_id` ASC),
  CONSTRAINT `FK_notification_event_item_notification_id_id`
    FOREIGN KEY (`notification_id`)
    REFERENCES `helpdesk_db`.`notification_event` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`link_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`link_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `link_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`link_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`link_state` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `link_state_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`link_object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`link_object` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `link_object_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`link_relation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`link_relation` (
  `source_object_id` SMALLINT NOT NULL,
  `source_key` VARCHAR(50) NOT NULL,
  `target_object_id` SMALLINT NOT NULL,
  `target_key` VARCHAR(50) NOT NULL,
  `type_id` SMALLINT NOT NULL,
  `state_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  UNIQUE INDEX `link_relation_view` (`source_object_id` ASC, `source_key` ASC, `target_object_id` ASC, `target_key` ASC, `type_id` ASC),
  INDEX `link_relation_list_source` (`source_object_id` ASC, `source_key` ASC, `state_id` ASC),
  INDEX `link_relation_list_target` (`target_object_id` ASC, `target_key` ASC, `state_id` ASC),
  INDEX `FK_link_relation_state_id_id` (`state_id` ASC),
  INDEX `FK_link_relation_type_id_id` (`type_id` ASC),
  CONSTRAINT `FK_link_relation_source_object_id_id`
    FOREIGN KEY (`source_object_id`)
    REFERENCES `helpdesk_db`.`link_object` (`id`),
  CONSTRAINT `FK_link_relation_target_object_id_id`
    FOREIGN KEY (`target_object_id`)
    REFERENCES `helpdesk_db`.`link_object` (`id`),
  CONSTRAINT `FK_link_relation_state_id_id`
    FOREIGN KEY (`state_id`)
    REFERENCES `helpdesk_db`.`link_state` (`id`),
  CONSTRAINT `FK_link_relation_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `helpdesk_db`.`link_type` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`system_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`system_data` (
  `data_key` VARCHAR(160) NOT NULL,
  `data_value` LONGBLOB NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`data_key`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`xml_storage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`xml_storage` (
  `xml_type` VARCHAR(200) NOT NULL,
  `xml_key` VARCHAR(250) NOT NULL,
  `xml_content_key` VARCHAR(250) NOT NULL,
  `xml_content_value` MEDIUMTEXT NULL DEFAULT NULL,
  INDEX `xml_storage_key_type` (`xml_key`(10) ASC, `xml_type`(10) ASC),
  INDEX `xml_storage_xml_content_key` (`xml_content_key`(100) ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`virtual_fs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`virtual_fs` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `filename` TEXT NOT NULL,
  `backend` VARCHAR(60) NOT NULL,
  `backend_key` VARCHAR(160) NOT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `virtual_fs_backend` (`backend`(60) ASC),
  INDEX `virtual_fs_filename` (`filename`(255) ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`virtual_fs_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`virtual_fs_preferences` (
  `virtual_fs_id` BIGINT NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` TEXT NULL DEFAULT NULL,
  INDEX `virtual_fs_preferences_key_value` (`preferences_key` ASC, `preferences_value`(150) ASC),
  INDEX `virtual_fs_preferences_virtual_fs_id` (`virtual_fs_id` ASC),
  CONSTRAINT `FK_virtual_fs_preferences_virtual_fs_id_id`
    FOREIGN KEY (`virtual_fs_id`)
    REFERENCES `helpdesk_db`.`virtual_fs` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`virtual_fs_db`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`virtual_fs_db` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `filename` TEXT NOT NULL,
  `content` LONGBLOB NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `virtual_fs_db_filename` (`filename`(255) ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`package_repository`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`package_repository` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `version` VARCHAR(250) NOT NULL,
  `vendor` VARCHAR(250) NOT NULL,
  `install_status` VARCHAR(250) NOT NULL,
  `filename` VARCHAR(250) NULL DEFAULT NULL,
  `content_type` VARCHAR(250) NULL DEFAULT NULL,
  `content` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`gi_webservice_config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`gi_webservice_config` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `config` LONGBLOB NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `gi_webservice_config_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`gi_webservice_config_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`gi_webservice_config_history` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `config_id` INT NOT NULL,
  `config` LONGBLOB NOT NULL,
  `config_md5` VARCHAR(32) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `gi_webservice_config_history_config_md5` (`config_md5` ASC),
  INDEX `FK_gi_webservice_config_history_config_id_id` (`config_id` ASC),
  CONSTRAINT `FK_gi_webservice_config_history_config_id_id`
    FOREIGN KEY (`config_id`)
    REFERENCES `helpdesk_db`.`gi_webservice_config` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`gi_debugger_entry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`gi_debugger_entry` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `communication_id` VARCHAR(32) NOT NULL,
  `communication_type` VARCHAR(50) NOT NULL,
  `remote_ip` VARCHAR(50) NULL DEFAULT NULL,
  `webservice_id` INT NOT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `gi_debugger_entry_communication_id` (`communication_id` ASC),
  INDEX `gi_debugger_entry_create_time` (`create_time` ASC),
  INDEX `FK_gi_debugger_entry_webservice_id_id` (`webservice_id` ASC),
  CONSTRAINT `FK_gi_debugger_entry_webservice_id_id`
    FOREIGN KEY (`webservice_id`)
    REFERENCES `helpdesk_db`.`gi_webservice_config` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`gi_debugger_entry_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`gi_debugger_entry_content` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `gi_debugger_entry_id` BIGINT NOT NULL,
  `debug_level` VARCHAR(50) NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `content` LONGBLOB NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `gi_debugger_entry_content_create_time` (`create_time` ASC),
  INDEX `gi_debugger_entry_content_debug_level` (`debug_level` ASC),
  INDEX `FK_gi_debugger_entry_content_gi_debugger_entry_id_id` (`gi_debugger_entry_id` ASC),
  CONSTRAINT `FK_gi_debugger_entry_content_gi_debugger_entry_id_id`
    FOREIGN KEY (`gi_debugger_entry_id`)
    REFERENCES `helpdesk_db`.`gi_debugger_entry` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`smime_signer_cert_relations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`smime_signer_cert_relations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cert_hash` VARCHAR(8) NOT NULL,
  `cert_fingerprint` VARCHAR(59) NOT NULL,
  `ca_hash` VARCHAR(8) NOT NULL,
  `ca_fingerprint` VARCHAR(59) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`dynamic_field`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`dynamic_field` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `internal_field` SMALLINT NOT NULL DEFAULT 0,
  `name` VARCHAR(200) NOT NULL,
  `label` VARCHAR(200) NOT NULL,
  `field_order` INT NOT NULL,
  `field_type` VARCHAR(200) NOT NULL,
  `object_type` VARCHAR(100) NOT NULL,
  `config` LONGBLOB NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dynamic_field_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`dynamic_field_value`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`dynamic_field_value` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `field_id` INT NOT NULL,
  `object_id` BIGINT NOT NULL,
  `value_text` TEXT NULL DEFAULT NULL,
  `value_date` DATETIME NULL DEFAULT NULL,
  `value_int` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `dynamic_field_value_field_values` (`object_id` ASC, `field_id` ASC),
  INDEX `dynamic_field_value_search_date` (`field_id` ASC, `value_date` ASC),
  INDEX `dynamic_field_value_search_int` (`field_id` ASC, `value_int` ASC),
  INDEX `dynamic_field_value_search_text` (`field_id` ASC, `value_text`(150) ASC),
  CONSTRAINT `FK_dynamic_field_value_field_id_id`
    FOREIGN KEY (`field_id`)
    REFERENCES `helpdesk_db`.`dynamic_field` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`dynamic_field_obj_id_name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`dynamic_field_obj_id_name` (
  `object_id` INT NOT NULL AUTO_INCREMENT,
  `object_name` VARCHAR(200) NOT NULL,
  `object_type` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE INDEX `dynamic_field_object_name` (`object_name` ASC, `object_type` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`pm_process`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`pm_process` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `entity_id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `state_entity_id` VARCHAR(50) NOT NULL,
  `layout` LONGBLOB NOT NULL,
  `config` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pm_process_entity_id` (`entity_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`pm_activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`pm_activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `entity_id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `config` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pm_activity_entity_id` (`entity_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`pm_activity_dialog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`pm_activity_dialog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `entity_id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `config` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pm_activity_dialog_entity_id` (`entity_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`pm_transition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`pm_transition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `entity_id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `config` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pm_transition_entity_id` (`entity_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`pm_transition_action`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`pm_transition_action` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `entity_id` VARCHAR(50) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `config` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pm_transition_action_entity_id` (`entity_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`pm_entity_sync`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`pm_entity_sync` (
  `entity_type` VARCHAR(30) NOT NULL,
  `entity_id` VARCHAR(50) NOT NULL,
  `sync_state` VARCHAR(30) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `change_time` DATETIME NOT NULL,
  UNIQUE INDEX `pm_entity_sync_list` (`entity_type` ASC, `entity_id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`scheduler_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`scheduler_task` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ident` BIGINT NOT NULL,
  `name` VARCHAR(150) NULL DEFAULT NULL,
  `task_type` VARCHAR(150) NOT NULL,
  `task_data` LONGBLOB NOT NULL,
  `attempts` SMALLINT NOT NULL,
  `lock_key` BIGINT NOT NULL,
  `lock_time` DATETIME NULL DEFAULT NULL,
  `lock_update_time` DATETIME NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `scheduler_task_ident` (`ident` ASC),
  INDEX `scheduler_task_ident_id` (`ident` ASC, `id` ASC),
  INDEX `scheduler_task_lock_key_id` (`lock_key` ASC, `id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`scheduler_future_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`scheduler_future_task` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ident` BIGINT NOT NULL,
  `execution_time` DATETIME NOT NULL,
  `name` VARCHAR(150) NULL DEFAULT NULL,
  `task_type` VARCHAR(150) NOT NULL,
  `task_data` LONGBLOB NOT NULL,
  `attempts` SMALLINT NOT NULL,
  `lock_key` BIGINT NOT NULL,
  `lock_time` DATETIME NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `scheduler_future_task_ident` (`ident` ASC),
  INDEX `scheduler_future_task_ident_id` (`ident` ASC, `id` ASC),
  INDEX `scheduler_future_task_lock_key_id` (`lock_key` ASC, `id` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`scheduler_recurrent_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`scheduler_recurrent_task` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `task_type` VARCHAR(150) NOT NULL,
  `last_execution_time` DATETIME NOT NULL,
  `last_worker_task_id` BIGINT NULL DEFAULT NULL,
  `last_worker_status` SMALLINT NULL DEFAULT NULL,
  `last_worker_running_time` INT NULL DEFAULT NULL,
  `lock_key` BIGINT NOT NULL,
  `lock_time` DATETIME NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `change_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `scheduler_recurrent_task_name_task_type` (`name` ASC, `task_type` ASC),
  INDEX `scheduler_recurrent_task_lock_key_id` (`lock_key` ASC, `id` ASC),
  INDEX `scheduler_recurrent_task_task_type_name` (`task_type` ASC, `name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`cloud_service_config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`cloud_service_config` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `config` LONGBLOB NOT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cloud_service_config_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sysconfig_default`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sysconfig_default` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `description` LONGBLOB NOT NULL,
  `navigation` VARCHAR(200) NOT NULL,
  `is_i` SMALLINT NOT NULL,
  `is_readonly` SMALLINT NOT NULL,
  `is_required` SMALLINT NOT NULL,
  `is_valid` SMALLINT NOT NULL,
  `has_configlevel` SMALLINT NOT NULL,
  `user_modification_possible` SMALLINT NOT NULL,
  `user_modification_active` SMALLINT NOT NULL,
  `user_preferences_group` VARCHAR(250) NULL DEFAULT NULL,
  `xml_content_raw` LONGBLOB NOT NULL,
  `xml_content_parsed` LONGBLOB NOT NULL,
  `xml_filename` VARCHAR(250) NOT NULL,
  `effective_value` LONGBLOB NOT NULL,
  `is_dirty` SMALLINT NOT NULL,
  `exclusive_lock_guid` VARCHAR(32) NOT NULL,
  `exclusive_lock_user_id` INT NULL DEFAULT NULL,
  `exclusive_lock_expiry_time` DATETIME NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sysconfig_default_name` (`name` ASC),
  INDEX `FK_sysconfig_default_exclusive_lock_user_id_id` (`exclusive_lock_user_id` ASC),
  CONSTRAINT `FK_sysconfig_default_exclusive_lock_user_id_id`
    FOREIGN KEY (`exclusive_lock_user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sysconfig_default_version`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sysconfig_default_version` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sysconfig_default_id` INT NULL DEFAULT NULL,
  `name` VARCHAR(250) NOT NULL,
  `description` LONGBLOB NOT NULL,
  `navigation` VARCHAR(200) NOT NULL,
  `is_i` SMALLINT NOT NULL,
  `is_readonly` SMALLINT NOT NULL,
  `is_required` SMALLINT NOT NULL,
  `is_valid` SMALLINT NOT NULL,
  `has_configlevel` SMALLINT NOT NULL,
  `user_modification_possible` SMALLINT NOT NULL,
  `user_modification_active` SMALLINT NOT NULL,
  `user_preferences_group` VARCHAR(250) NULL DEFAULT NULL,
  `xml_content_raw` LONGBLOB NOT NULL,
  `xml_content_parsed` LONGBLOB NOT NULL,
  `xml_filename` VARCHAR(250) NOT NULL,
  `effective_value` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `scfv_sysconfig_default_id_name` (`sysconfig_default_id` ASC, `name` ASC),
  CONSTRAINT `FK_sysconfig_default_version_sysconfig_default_id_id`
    FOREIGN KEY (`sysconfig_default_id`)
    REFERENCES `helpdesk_db`.`sysconfig_default` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sysconfig_modified`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sysconfig_modified` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sysconfig_default_id` INT NOT NULL,
  `name` VARCHAR(250) NOT NULL,
  `user_id` INT NULL DEFAULT NULL,
  `is_valid` SMALLINT NOT NULL,
  `user_modification_active` SMALLINT NOT NULL,
  `effective_value` LONGBLOB NOT NULL,
  `is_dirty` SMALLINT NOT NULL,
  `reset_to_default` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sysconfig_modified_per_user` (`sysconfig_default_id` ASC, `user_id` ASC),
  INDEX `FK_sysconfig_modified_user_id_id` (`user_id` ASC),
  CONSTRAINT `FK_sysconfig_modified_sysconfig_default_id_id`
    FOREIGN KEY (`sysconfig_default_id`)
    REFERENCES `helpdesk_db`.`sysconfig_default` (`id`),
  CONSTRAINT `FK_sysconfig_modified_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sysconfig_modified_version`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sysconfig_modified_version` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sysconfig_default_version_id` INT NOT NULL,
  `name` VARCHAR(250) NOT NULL,
  `user_id` INT NULL DEFAULT NULL,
  `is_valid` SMALLINT NOT NULL,
  `user_modification_active` SMALLINT NOT NULL,
  `effective_value` LONGBLOB NOT NULL,
  `reset_to_default` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_sysconfig_modified_version_sysconfig_default_version_idaf` (`sysconfig_default_version_id` ASC),
  INDEX `FK_sysconfig_modified_version_user_id_id` (`user_id` ASC),
  CONSTRAINT `FK_sysconfig_modified_version_sysconfig_default_version_idaf`
    FOREIGN KEY (`sysconfig_default_version_id`)
    REFERENCES `helpdesk_db`.`sysconfig_default_version` (`id`),
  CONSTRAINT `FK_sysconfig_modified_version_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sysconfig_deployment_lock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sysconfig_deployment_lock` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `exclusive_lock_guid` VARCHAR(32) NULL DEFAULT NULL,
  `exclusive_lock_user_id` INT NULL DEFAULT NULL,
  `exclusive_lock_expiry_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_sysconfig_deployment_lock_exclusive_lock_user_id_id` (`exclusive_lock_user_id` ASC),
  CONSTRAINT `FK_sysconfig_deployment_lock_exclusive_lock_user_id_id`
    FOREIGN KEY (`exclusive_lock_user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`sysconfig_deployment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`sysconfig_deployment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `user_id` INT NULL DEFAULT NULL,
  `effective_value` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_sysconfig_deployment_user_id_id` (`user_id` ASC),
  CONSTRAINT `FK_sysconfig_deployment_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `helpdesk_db`.`users` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`calendar` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `salt_string` VARCHAR(64) NOT NULL,
  `color` VARCHAR(7) NOT NULL,
  `ticket_appointments` LONGBLOB NULL DEFAULT NULL,
  `valid_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `calendar_name` (`name` ASC),
  INDEX `FK_calendar_group_id_id` (`group_id` ASC),
  CONSTRAINT `FK_calendar_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `helpdesk_db`.`groups` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`calendar_appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`calendar_appointment` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT NULL DEFAULT NULL,
  `calendar_id` BIGINT NOT NULL,
  `unique_id` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `location` VARCHAR(255) NULL DEFAULT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `all_day` SMALLINT NULL DEFAULT NULL,
  `notify_time` DATETIME NULL DEFAULT NULL,
  `notify_template` VARCHAR(255) NULL DEFAULT NULL,
  `notify_custom` VARCHAR(255) NULL DEFAULT NULL,
  `notify_custom_unit_count` BIGINT NULL DEFAULT NULL,
  `notify_custom_unit` VARCHAR(255) NULL DEFAULT NULL,
  `notify_custom_unit_point` VARCHAR(255) NULL DEFAULT NULL,
  `notify_custom_date` DATETIME NULL DEFAULT NULL,
  `team_id` TEXT NULL DEFAULT NULL,
  `resource_id` TEXT NULL DEFAULT NULL,
  `recurring` SMALLINT NULL DEFAULT NULL,
  `recur_type` VARCHAR(20) NULL DEFAULT NULL,
  `recur_freq` VARCHAR(255) NULL DEFAULT NULL,
  `recur_count` INT NULL DEFAULT NULL,
  `recur_interval` INT NULL DEFAULT NULL,
  `recur_until` DATETIME NULL DEFAULT NULL,
  `recur_id` DATETIME NULL DEFAULT NULL,
  `recur_exclude` TEXT NULL DEFAULT NULL,
  `ticket_appointment_rule_id` VARCHAR(32) NULL DEFAULT NULL,
  `create_time` DATETIME NULL DEFAULT NULL,
  `create_by` INT NULL DEFAULT NULL,
  `change_time` DATETIME NULL DEFAULT NULL,
  `change_by` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_calendar_appointment_calendar_id_id` (`calendar_id` ASC),
  INDEX `FK_calendar_appointment_parent_id_id` (`parent_id` ASC),
  CONSTRAINT `FK_calendar_appointment_calendar_id_id`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `helpdesk_db`.`calendar` (`id`),
  CONSTRAINT `FK_calendar_appointment_parent_id_id`
    FOREIGN KEY (`parent_id`)
    REFERENCES `helpdesk_db`.`calendar_appointment` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`calendar_appointment_ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`calendar_appointment_ticket` (
  `calendar_id` BIGINT NOT NULL,
  `ticket_id` BIGINT NOT NULL,
  `rule_id` VARCHAR(32) NOT NULL,
  `appointment_id` BIGINT NOT NULL,
  UNIQUE INDEX `calendar_appointment_ticket_calendar_id_ticket_id_rule_id` (`calendar_id` ASC, `ticket_id` ASC, `rule_id` ASC),
  INDEX `calendar_appointment_ticket_appointment_id` (`appointment_id` ASC),
  INDEX `calendar_appointment_ticket_calendar_id` (`calendar_id` ASC),
  INDEX `calendar_appointment_ticket_rule_id` (`rule_id` ASC),
  INDEX `calendar_appointment_ticket_ticket_id` (`ticket_id` ASC),
  CONSTRAINT `FK_calendar_appointment_ticket_calendar_id_id`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `helpdesk_db`.`calendar` (`id`),
  CONSTRAINT `FK_calendar_appointment_ticket_appointment_id_id`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `helpdesk_db`.`calendar_appointment` (`id`),
  CONSTRAINT `FK_calendar_appointment_ticket_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `helpdesk_db`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`ticket_number_counter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`ticket_number_counter` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `counter` BIGINT NOT NULL,
  `counter_uid` VARCHAR(32) NOT NULL,
  `create_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_number_counter_uid` (`counter_uid` ASC),
  INDEX `ticket_number_counter_create_time` (`create_time` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`mail_queue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`mail_queue` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `insert_fingerprint` VARCHAR(64) NULL DEFAULT NULL,
  `article_id` BIGINT NULL DEFAULT NULL,
  `attempts` INT NOT NULL,
  `sender` VARCHAR(200) NULL DEFAULT NULL,
  `recipient` MEDIUMTEXT NOT NULL,
  `raw_message` LONGBLOB NOT NULL,
  `due_time` DATETIME NULL DEFAULT NULL,
  `last_smtp_code` INT NULL DEFAULT NULL,
  `last_smtp_message` MEDIUMTEXT NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `mail_queue_article_id` (`article_id` ASC),
  UNIQUE INDEX `mail_queue_insert_fingerprint` (`insert_fingerprint` ASC),
  INDEX `mail_queue_attempts` (`attempts` ASC),
  CONSTRAINT `FK_mail_queue_article_id_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `helpdesk_db`.`article` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`communication_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`communication_log` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `insert_fingerprint` VARCHAR(64) NULL DEFAULT NULL,
  `transport` VARCHAR(200) NOT NULL,
  `direction` VARCHAR(200) NOT NULL,
  `status` VARCHAR(200) NOT NULL,
  `account_type` VARCHAR(200) NULL DEFAULT NULL,
  `account_id` VARCHAR(200) NULL DEFAULT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `communication_direction` (`direction` ASC),
  INDEX `communication_status` (`status` ASC),
  INDEX `communication_transport` (`transport` ASC));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`communication_log_object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`communication_log_object` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `insert_fingerprint` VARCHAR(64) NULL DEFAULT NULL,
  `communication_id` BIGINT NOT NULL,
  `object_type` VARCHAR(50) NOT NULL,
  `status` VARCHAR(200) NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `communication_log_object_object_type` (`object_type` ASC),
  INDEX `communication_log_object_status` (`status` ASC),
  INDEX `FK_communication_log_object_communication_id_id` (`communication_id` ASC),
  CONSTRAINT `FK_communication_log_object_communication_id_id`
    FOREIGN KEY (`communication_id`)
    REFERENCES `helpdesk_db`.`communication_log` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`communication_log_object_entry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`communication_log_object_entry` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `communication_log_object_id` BIGINT NOT NULL,
  `log_key` VARCHAR(200) NOT NULL,
  `log_value` MEDIUMTEXT NOT NULL,
  `priority` VARCHAR(50) NOT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `communication_log_object_entry_key` (`log_key` ASC),
  INDEX `FK_communication_log_object_entry_communication_log_objectaa` (`communication_log_object_id` ASC),
  CONSTRAINT `FK_communication_log_object_entry_communication_log_objectaa`
    FOREIGN KEY (`communication_log_object_id`)
    REFERENCES `helpdesk_db`.`communication_log_object` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`communication_log_obj_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`communication_log_obj_lookup` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `communication_log_object_id` BIGINT NOT NULL,
  `object_type` VARCHAR(200) NOT NULL,
  `object_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `communication_log_obj_lookup_target` (`object_type` ASC, `object_id` ASC),
  INDEX `FK_communication_log_obj_lookup_communication_log_object_i0f` (`communication_log_object_id` ASC),
  CONSTRAINT `FK_communication_log_obj_lookup_communication_log_object_i0f`
    FOREIGN KEY (`communication_log_object_id`)
    REFERENCES `helpdesk_db`.`communication_log_object` (`id`));


-- -----------------------------------------------------
-- Table `helpdesk_db`.`form_draft`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `helpdesk_db`.`form_draft` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `object_type` VARCHAR(100) NOT NULL,
  `object_id` INT NOT NULL,
  `action` VARCHAR(200) NOT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `content` LONGBLOB NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `form_draft_object_type_object_id_action` (`object_type` ASC, `object_id` ASC, `action` ASC));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
