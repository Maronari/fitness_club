-- MySQL Script generated by MySQL Workbench
-- Sat Oct 21 10:54:55 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fitness_club_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `fitness_club_db` ;

-- -----------------------------------------------------
-- Schema fitness_club_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fitness_club_db` DEFAULT CHARACTER SET utf8 ;
USE `fitness_club_db` ;

-- -----------------------------------------------------
-- Table `fitness_club_db`.`membership_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`membership_role` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`clubs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`clubs` (
  `club_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`club_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members` (
  `id_member` INT NOT NULL AUTO_INCREMENT,
  `id_role` INT NOT NULL,
  `clubs_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `second_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `birth_date` DATE NOT NULL,
  `start_trial_date` DATE NOT NULL,
  `end_trial_date` DATE NULL,
  `gender` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_member`),
  INDEX `fk_members_Roles1_idx` (`id_role` ASC) VISIBLE,
  INDEX `fk_members_clubs1_idx` (`clubs_name` ASC) VISIBLE,
  CONSTRAINT `fk_members_Roles1`
    FOREIGN KEY (`id_role`)
    REFERENCES `fitness_club_db`.`membership_role` (`id_role`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_members_clubs1`
    FOREIGN KEY (`clubs_name`)
    REFERENCES `fitness_club_db`.`clubs` (`club_name`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`position` (
  `id_position` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_position`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`staff` (
  `id_staff` INT NOT NULL AUTO_INCREMENT,
  `id_position` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `second_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `hire_date` DATE NOT NULL,
  `staff_about` VARCHAR(100) NULL,
  `gender` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_staff`),
  INDEX `fk_staff_Position1_idx` (`id_position` ASC) VISIBLE,
  CONSTRAINT `fk_staff_Position1`
    FOREIGN KEY (`id_position`)
    REFERENCES `fitness_club_db`.`position` (`id_position`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`equipment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`equipment_type` (
  `id_equipment_type` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_equipment_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`equipment` (
  `id_equipment` INT NOT NULL AUTO_INCREMENT,
  `id_equipment_type` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`id_equipment`),
  INDEX `fk_equipment_equipment_type1_idx` (`id_equipment_type` ASC) VISIBLE,
  CONSTRAINT `fk_equipment_equipment_type1`
    FOREIGN KEY (`id_equipment_type`)
    REFERENCES `fitness_club_db`.`equipment_type` (`id_equipment_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`trainers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`trainers` (
  `id_trainer` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `second_name` VARCHAR(45) NOT NULL,
  `speciality` VARCHAR(45) NULL,
  `experience` INT NULL,
  `certifications` INT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `hire_date` DATE NOT NULL,
  PRIMARY KEY (`id_trainer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`gyms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`gyms` (
  `id_gym` INT NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(45) NOT NULL,
  `amount_of_equipment` INT NULL,
  PRIMARY KEY (`id_gym`, `club_name`),
  INDEX `fk_gyms_clubs1_idx` (`club_name` ASC) VISIBLE,
  CONSTRAINT `fk_gyms_clubs1`
    FOREIGN KEY (`club_name`)
    REFERENCES `fitness_club_db`.`clubs` (`club_name`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`activity_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`activity_type` (
  `id_activity` INT NOT NULL AUTO_INCREMENT,
  `activity_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_activity`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`equipment_statistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`equipment_statistics` (
  `id_statistics` INT NOT NULL AUTO_INCREMENT,
  `id_activity` INT NOT NULL,
  `approaches` INT NULL,
  `kilocalories` INT NULL,
  PRIMARY KEY (`id_statistics`, `id_activity`),
  INDEX `fk_equipment_statistics_activity_type1_idx` (`id_activity` ASC) VISIBLE,
  CONSTRAINT `fk_equipment_statistics_activity_type1`
    FOREIGN KEY (`id_activity`)
    REFERENCES `fitness_club_db`.`activity_type` (`id_activity`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`inbody_analyses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`inbody_analyses` (
  `id_inbody_analys` INT NOT NULL AUTO_INCREMENT,
  `height` FLOAT NULL,
  `weight` FLOAT NULL,
  `bmi` FLOAT NULL,
  `fat_percent` FLOAT NULL,
  `muscle_persent` FLOAT NULL,
  PRIMARY KEY (`id_inbody_analys`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`training_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`training_type` (
  `id_training_type` INT NOT NULL AUTO_INCREMENT,
  `training_type_name` VARCHAR(45) NOT NULL,
  `workout_description` VARCHAR(300) NULL,
  PRIMARY KEY (`id_training_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`training_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`training_schedule` (
  `id_session` INT NOT NULL AUTO_INCREMENT,
  `id_trainer` INT NOT NULL,
  `id_training_type` INT NOT NULL,
  `session_date` DATE NOT NULL,
  `session_time` INT(90) NOT NULL,
  PRIMARY KEY (`id_session`),
  INDEX `fk_personal_training_sessions_trainers1_idx` (`id_trainer` ASC) VISIBLE,
  INDEX `fk_training_schedule_training_type1_idx` (`id_training_type` ASC) VISIBLE,
  CONSTRAINT `fk_personal_training_sessions_trainers1`
    FOREIGN KEY (`id_trainer`)
    REFERENCES `fitness_club_db`.`trainers` (`id_trainer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_training_schedule_training_type1`
    FOREIGN KEY (`id_training_type`)
    REFERENCES `fitness_club_db`.`training_type` (`id_training_type`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`users_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`users_photo` (
  `id_photo` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(100) NULL,
  PRIMARY KEY (`id_photo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members_accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members_accounts` (
  `username` VARCHAR(45) NOT NULL,
  `id_member` INT NOT NULL,
  `id_photo` INT NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `account_creation_date` DATE NOT NULL,
  `last_login` DATE NOT NULL,
  `user_role` VARCHAR(45) NOT NULL,
  INDEX `fk_accounts_members1_idx` (`id_member` ASC) VISIBLE,
  INDEX `fk_members_accounts_users_photo1_idx` (`id_photo` ASC) VISIBLE,
  PRIMARY KEY (`username`),
  CONSTRAINT `fk_accounts_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_members_accounts_users_photo1`
    FOREIGN KEY (`id_photo`)
    REFERENCES `fitness_club_db`.`users_photo` (`id_photo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`feedback` (
  `id_feedback` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `feedback_text` VARCHAR(45) NULL,
  `feedback_date` DATE NULL,
  `rating` INT(10) NULL,
  PRIMARY KEY (`id_feedback`, `username`),
  INDEX `fk_feedback_members_accounts1_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_feedback_members_accounts1`
    FOREIGN KEY (`username`)
    REFERENCES `fitness_club_db`.`members_accounts` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members_have_equipment_statistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members_have_equipment_statistics` (
  `id_member` INT NOT NULL,
  `id_statistics` INT NOT NULL,
  PRIMARY KEY (`id_member`, `id_statistics`),
  INDEX `fk_members_has_equipment_statistics_equipment_statistics1_idx` (`id_statistics` ASC) VISIBLE,
  INDEX `fk_members_has_equipment_statistics_members1_idx` (`id_member` ASC) VISIBLE,
  CONSTRAINT `fk_members_has_equipment_statistics_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_members_has_equipment_statistics_equipment_statistics1`
    FOREIGN KEY (`id_statistics`)
    REFERENCES `fitness_club_db`.`equipment_statistics` (`id_statistics`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members_have_inbody_analyses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members_have_inbody_analyses` (
  `id_member` INT NOT NULL,
  `id_inbody_analys` INT NOT NULL,
  PRIMARY KEY (`id_member`, `id_inbody_analys`),
  INDEX `fk_members_has_inbody_analyses_inbody_analyses1_idx` (`id_inbody_analys` ASC) VISIBLE,
  INDEX `fk_members_has_inbody_analyses_members1_idx` (`id_member` ASC) VISIBLE,
  CONSTRAINT `fk_members_has_inbody_analyses_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_members_has_inbody_analyses_inbody_analyses1`
    FOREIGN KEY (`id_inbody_analys`)
    REFERENCES `fitness_club_db`.`inbody_analyses` (`id_inbody_analys`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`nutrition_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`nutrition_plan` (
  `id_plan` INT NOT NULL AUTO_INCREMENT,
  `id_member` INT NOT NULL,
  `nutrition_description` VARCHAR(100) NULL,
  `start_date` DATE NULL,
  PRIMARY KEY (`id_plan`),
  INDEX `fk_nutrition_plan_members1_idx` (`id_member` ASC) VISIBLE,
  CONSTRAINT `fk_nutrition_plan_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`achievements` (
  `id_achievement` INT NOT NULL AUTO_INCREMENT,
  `achievement_description` VARCHAR(45) NOT NULL,
  `achievement_title` VARCHAR(45) NOT NULL,
  `achievement_icon_url` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_achievement`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members_have_achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members_have_achievements` (
  `id_member` INT NOT NULL,
  `id_achievement` INT NOT NULL,
  `receipt_date` DATE NOT NULL,
  PRIMARY KEY (`id_member`, `id_achievement`),
  INDEX `fk_members_has_achivements_achivements1_idx` (`id_achievement` ASC) VISIBLE,
  INDEX `fk_members_has_achivements_members1_idx` (`id_member` ASC) VISIBLE,
  CONSTRAINT `fk_members_has_achivements_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_members_has_achivements_achivements1`
    FOREIGN KEY (`id_achievement`)
    REFERENCES `fitness_club_db`.`achievements` (`id_achievement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`news`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`news` (
  `id_news` INT NOT NULL AUTO_INCREMENT,
  `news_title` VARCHAR(45) NOT NULL,
  `news_text` VARCHAR(200) NULL,
  PRIMARY KEY (`id_news`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`visits_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`visits_history` (
  `id_visit` INT NOT NULL AUTO_INCREMENT,
  `visit_date` DATE NOT NULL,
  PRIMARY KEY (`id_visit`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members_have_visits_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members_have_visits_history` (
  `id_visit` INT NOT NULL,
  `id_member` INT NOT NULL,
  PRIMARY KEY (`id_visit`, `id_member`),
  INDEX `fk_visits_history_has_members_members1_idx` (`id_member` ASC) VISIBLE,
  INDEX `fk_visits_history_has_members_visits_history1_idx` (`id_visit` ASC) VISIBLE,
  CONSTRAINT `fk_visits_history_has_members_visits_history1`
    FOREIGN KEY (`id_visit`)
    REFERENCES `fitness_club_db`.`visits_history` (`id_visit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_visits_history_has_members_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`clubs_have_news`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`clubs_have_news` (
  `id_news` INT NOT NULL,
  `club_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_news`, `club_name`),
  INDEX `fk_clubs_has_news_news1_idx` (`id_news` ASC) VISIBLE,
  INDEX `fk_clubs_has_news_clubs1_idx` (`club_name` ASC) VISIBLE,
  CONSTRAINT `fk_clubs_has_news_news1`
    FOREIGN KEY (`id_news`)
    REFERENCES `fitness_club_db`.`news` (`id_news`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_clubs_has_news_clubs1`
    FOREIGN KEY (`club_name`)
    REFERENCES `fitness_club_db`.`clubs` (`club_name`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`members_have_training_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`members_have_training_schedule` (
  `id_member` INT NOT NULL,
  `id_session` INT NOT NULL,
  PRIMARY KEY (`id_member`, `id_session`),
  INDEX `fk_members_has_training_schedule_training_schedule1_idx` (`id_session` ASC) VISIBLE,
  INDEX `fk_members_has_training_schedule_members1_idx` (`id_member` ASC) VISIBLE,
  CONSTRAINT `fk_members_has_training_schedule_members1`
    FOREIGN KEY (`id_member`)
    REFERENCES `fitness_club_db`.`members` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_members_has_training_schedule_training_schedule1`
    FOREIGN KEY (`id_session`)
    REFERENCES `fitness_club_db`.`training_schedule` (`id_session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`staff_accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`staff_accounts` (
  `id_staff` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `last_login` DATE NOT NULL,
  `account_creation_date` DATE NOT NULL,
  `user_role` VARCHAR(45) NOT NULL,
  INDEX `fk_staff_accounts_staff1_idx` (`id_staff` ASC) VISIBLE,
  PRIMARY KEY (`username`),
  CONSTRAINT `fk_staff_accounts_staff1`
    FOREIGN KEY (`id_staff`)
    REFERENCES `fitness_club_db`.`staff` (`id_staff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`staff_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`staff_schedule` (
  `id_schedule` INT NOT NULL AUTO_INCREMENT,
  `id_staff` INT NOT NULL,
  `clubs_name` VARCHAR(45) NOT NULL,
  `weekday` INT(6) NULL,
  `shift` INT(3) NULL,
  PRIMARY KEY (`id_schedule`),
  INDEX `fk_staff_shedule_staff1_idx` (`id_staff` ASC) VISIBLE,
  INDEX `fk_staff_shedule_clubs1_idx` (`clubs_name` ASC) VISIBLE,
  CONSTRAINT `fk_staff_shedule_staff1`
    FOREIGN KEY (`id_staff`)
    REFERENCES `fitness_club_db`.`staff` (`id_staff`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_shedule_clubs1`
    FOREIGN KEY (`clubs_name`)
    REFERENCES `fitness_club_db`.`clubs` (`club_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`trainers_accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`trainers_accounts` (
  `id_trainer` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `last_login` DATE NOT NULL,
  `account_creation_date` DATE NOT NULL,
  `user_role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`),
  INDEX `fk_trainers_accounts_trainers1_idx` (`id_trainer` ASC) VISIBLE,
  CONSTRAINT `fk_trainers_accounts_trainers1`
    FOREIGN KEY (`id_trainer`)
    REFERENCES `fitness_club_db`.`trainers` (`id_trainer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_club_db`.`gyms_have_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_club_db`.`gyms_have_equipment` (
  `id_gym` INT NOT NULL,
  `id_equipment` INT NOT NULL,
  PRIMARY KEY (`id_gym`, `id_equipment`),
  INDEX `fk_gyms_has_equipment_equipment1_idx` (`id_equipment` ASC) VISIBLE,
  INDEX `fk_gyms_has_equipment_gyms1_idx` (`id_gym` ASC) VISIBLE,
  CONSTRAINT `fk_gyms_has_equipment_gyms1`
    FOREIGN KEY (`id_gym`)
    REFERENCES `fitness_club_db`.`gyms` (`id_gym`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gyms_has_equipment_equipment1`
    FOREIGN KEY (`id_equipment`)
    REFERENCES `fitness_club_db`.`equipment` (`id_equipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
