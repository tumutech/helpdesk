-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `otrs`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`users` (
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
-- Table `otrs`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `groups_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `otrs`.`group_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`group_user` (
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
    REFERENCES `otrs`.`groups` (`id`),
  CONSTRAINT `FK_group_user_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `otrs`.`users` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`roles` (
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
-- Table `otrs`.`group_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`group_role` (
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
    REFERENCES `otrs`.`groups` (`id`),
  CONSTRAINT `FK_group_role_role_id_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `otrs`.`roles` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`customer_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`customer_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(150) NOT NULL,
  `pw` VARCHAR(128) NULL DEFAULT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(150) NULL DEFAULT NULL,
  `mobile` VARCHAR(150) NULL DEFAULT NULL,
  `street` VARCHAR(150) NULL DEFAULT NULL,
  `city` VARCHAR(200) NULL DEFAULT NULL,
  `country` VARCHAR(200) NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`group_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`group_customer` (
  `customer_id` INT NOT NULL,
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
    REFERENCES `otrs`.`groups` (`id`),
  CONSTRAINT `FK_customer_usersz`
    FOREIGN KEY (`customer_id`)
    REFERENCES `otrs`.`customer_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `otrs`.`follow_up_possible`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`follow_up_possible` (
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
-- Table `otrs`.`queue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`queue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `group_id` INT NOT NULL,
  `first_response_time` INT NULL DEFAULT NULL,
  `first_response_notify` SMALLINT NULL DEFAULT NULL,
  `update_time` INT NULL DEFAULT NULL,
  `update_notify` SMALLINT NULL DEFAULT NULL,
  `solution_time` INT NULL DEFAULT NULL,
  `solution_notify` SMALLINT NULL DEFAULT NULL,
  `follow_up_id` SMALLINT NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `queue_name` (`name` ASC),
  INDEX `queue_group_id` (`group_id` ASC),
  INDEX `FK_queue_follow_up_id_id` (`follow_up_id` ASC),
  CONSTRAINT `FK_queue_follow_up_id_id`
    FOREIGN KEY (`follow_up_id`)
    REFERENCES `otrs`.`follow_up_possible` (`id`),
  CONSTRAINT `FK_queue_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `otrs`.`groups` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`personal_queues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`personal_queues` (
  `user_id` INT NOT NULL,
  `queue_id` INT NOT NULL,
  INDEX `personal_queues_queue_id` (`queue_id` ASC),
  INDEX `personal_queues_user_id` (`user_id` ASC),
  CONSTRAINT `FK_personal_queues_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `otrs`.`queue` (`id`),
  CONSTRAINT `FK_personal_queues_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `otrs`.`users` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `service_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `otrs`.`personal_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`personal_services` (
  `user_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  INDEX `personal_services_service_id` (`service_id` ASC),
  INDEX `personal_services_user_id` (`user_id` ASC),
  CONSTRAINT `FK_personal_services_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `otrs`.`service` (`id`),
  CONSTRAINT `FK_personal_services_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `otrs`.`users` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`queue_preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`queue_preferences` (
  `queue_id` INT NOT NULL,
  `preferences_key` VARCHAR(150) NOT NULL,
  `preferences_value` VARCHAR(250) NULL DEFAULT NULL,
  INDEX `queue_preferences_queue_id` (`queue_id` ASC),
  CONSTRAINT `FK_queue_preferences_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `otrs`.`queue` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_priority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_priority` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_priority_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_state_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_state_type` (
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
-- Table `otrs`.`ticket_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_state` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `type_id` SMALLINT NOT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_state_name` (`name` ASC),
  INDEX `FK_ticket_state_type_id_id` (`type_id` ASC),
  CONSTRAINT `FK_ticket_state_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `otrs`.`ticket_state_type` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`sla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`sla` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `first_response_time` INT NOT NULL,
  `first_response_notify` SMALLINT NULL DEFAULT NULL,
  `update_time` INT NOT NULL,
  `update_notify` SMALLINT NULL DEFAULT NULL,
  `solution_time` INT NOT NULL,
  `solution_notify` SMALLINT NULL DEFAULT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sla_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `otrs`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `tn` VARCHAR(50) NOT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `queue_id` INT NOT NULL,
  `type_id` SMALLINT NULL DEFAULT NULL,
  `service_id` INT NULL DEFAULT NULL,
  `sla_id` INT NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `responsible_user_id` INT NOT NULL,
  `ticket_priority_id` SMALLINT NOT NULL,
  `ticket_state_id` SMALLINT NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
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
  INDEX `ticket_escalation_response_time` (`escalation_response_time` ASC),
  INDEX `ticket_escalation_solution_time` (`escalation_solution_time` ASC),
  INDEX `ticket_escalation_time` (`escalation_time` ASC),
  INDEX `ticket_escalation_update_time` (`escalation_update_time` ASC),
  INDEX `ticket_queue_id` (`queue_id` ASC),
  INDEX `ticket_queue_view` (`ticket_state_id` ASC),
  INDEX `ticket_responsible_user_id` (`responsible_user_id` ASC),
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
    REFERENCES `otrs`.`queue` (`id`),
  CONSTRAINT `FK_ticket_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `otrs`.`service` (`id`),
  CONSTRAINT `FK_ticket_sla_id_id`
    FOREIGN KEY (`sla_id`)
    REFERENCES `otrs`.`sla` (`id`),
  CONSTRAINT `FK_ticket_ticket_priority_id_id`
    FOREIGN KEY (`ticket_priority_id`)
    REFERENCES `otrs`.`ticket_priority` (`id`),
  CONSTRAINT `FK_ticket_ticket_state_id_id`
    FOREIGN KEY (`ticket_state_id`)
    REFERENCES `otrs`.`ticket_state` (`id`),
  CONSTRAINT `FK_ticket_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `otrs`.`ticket_type` (`id`),
  CONSTRAINT `FK_ticket_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `otrs`.`users` (`id`),
  CONSTRAINT `FK_ticket_responsible_user_id_id`
    FOREIGN KEY (`responsible_user_id`)
    REFERENCES `otrs`.`users` (`id`),
  CONSTRAINT `FK_ticket_customersz`
    FOREIGN KEY (`customer_id`)
    REFERENCES `otrs`.`customer_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `otrs`.`ticket_flag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_flag` (
  `ticket_id` BIGINT NOT NULL,
  `ticket_value` VARCHAR(50) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  UNIQUE INDEX `ticket_flag_per_user` (`ticket_id` ASC, `create_by` ASC),
  INDEX `ticket_flag_ticket_id` (`ticket_id` ASC),
  INDEX `ticket_flag_ticket_id_create_by` (`ticket_id` ASC, `create_by` ASC),
  INDEX `ticket_flag_ticket_id_ticket_key` (`ticket_id` ASC),
  CONSTRAINT `FK_ticket_flag_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `otrs`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`article_sender_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`article_sender_type` (
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
-- Table `otrs`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`article` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ticket_id` BIGINT NOT NULL,
  `article_sender_type_id` SMALLINT NOT NULL,
  `communication_channel_id` BIGINT NOT NULL,
  `is_for_customer` SMALLINT NOT NULL,
  `search_index_needs_rebuild` SMALLINT NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_article_sender_type_id` (`article_sender_type_id` ASC),
  INDEX `article_search_index_needs_rebuild` (`search_index_needs_rebuild` ASC),
  INDEX `article_ticket_id` (`ticket_id` ASC),
  CONSTRAINT `FK_article_article_sender_type_id_id`
    FOREIGN KEY (`article_sender_type_id`)
    REFERENCES `otrs`.`article_sender_type` (`id`),
  CONSTRAINT `FK_article_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `otrs`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_history_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_history_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `comments` VARCHAR(250) NULL DEFAULT NULL,
  `create_time` DATETIME NOT NULL,
  `create_by` INT NOT NULL,
  `change_time` DATETIME NOT NULL,
  `change_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ticket_history_type_name` (`name` ASC));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_history` (
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
    REFERENCES `otrs`.`article` (`id`),
  CONSTRAINT `FK_ticket_history_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `otrs`.`queue` (`id`),
  CONSTRAINT `FK_ticket_history_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `otrs`.`ticket` (`id`),
  CONSTRAINT `FK_ticket_history_history_type_id_id`
    FOREIGN KEY (`history_type_id`)
    REFERENCES `otrs`.`ticket_history_type` (`id`),
  CONSTRAINT `FK_ticket_history_priority_id_id`
    FOREIGN KEY (`priority_id`)
    REFERENCES `otrs`.`ticket_priority` (`id`),
  CONSTRAINT `FK_ticket_history_state_id_id`
    FOREIGN KEY (`state_id`)
    REFERENCES `otrs`.`ticket_state` (`id`),
  CONSTRAINT `FK_ticket_history_type_id_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `otrs`.`ticket_type` (`id`),
  CONSTRAINT `FK_ticket_history_owner_id_id`
    FOREIGN KEY (`owner_id`)
    REFERENCES `otrs`.`users` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_watcher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_watcher` (
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
    REFERENCES `otrs`.`ticket` (`id`),
  CONSTRAINT `FK_ticket_watcher_user_id_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `otrs`.`users` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`ticket_index`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`ticket_index` (
  `ticket_id` BIGINT NOT NULL,
  `queue_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `s_state` VARCHAR(200) NOT NULL,
  `create_time` DATETIME NOT NULL,
  INDEX `ticket_index_group_id` (`group_id` ASC),
  INDEX `ticket_index_queue_id` (`queue_id` ASC),
  INDEX `ticket_index_ticket_id` (`ticket_id` ASC),
  CONSTRAINT `FK_ticket_index_group_id_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `otrs`.`groups` (`id`),
  CONSTRAINT `FK_ticket_index_queue_id_id`
    FOREIGN KEY (`queue_id`)
    REFERENCES `otrs`.`queue` (`id`),
  CONSTRAINT `FK_ticket_index_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `otrs`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`article_search_index`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`article_search_index` (
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
    REFERENCES `otrs`.`article` (`id`),
  CONSTRAINT `FK_article_search_index_ticket_id_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `otrs`.`ticket` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`article_data_mime_plain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`article_data_mime_plain` (
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
    REFERENCES `otrs`.`article` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`service_sla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`service_sla` (
  `service_id` INT NOT NULL,
  `sla_id` INT NOT NULL,
  UNIQUE INDEX `service_sla_service_sla` (`service_id` ASC, `sla_id` ASC),
  INDEX `FK_service_sla_sla_id_id` (`sla_id` ASC),
  CONSTRAINT `FK_service_sla_service_id_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `otrs`.`service` (`id`),
  CONSTRAINT `FK_service_sla_sla_id_id`
    FOREIGN KEY (`sla_id`)
    REFERENCES `otrs`.`sla` (`id`));


-- -----------------------------------------------------
-- Table `otrs`.`notification_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`notification_event` (
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
-- Table `otrs`.`notification_event_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otrs`.`notification_event_message` (
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
    REFERENCES `otrs`.`notification_event` (`id`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
