-- MySQL Script generated by MySQL Workbench
-- 01/05/17 17:46:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Match` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Match` (
  `idMatch` INT NOT NULL AUTO_INCREMENT,
  `nbPlaces` INT NULL,
  PRIMARY KEY (`idMatch`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Competition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Competition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Competition` (
  `idCompetition` INT NOT NULL AUTO_INCREMENT,
  `nomC` VARCHAR(45) NULL,
  PRIMARY KEY (`idCompetition`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Joueur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Joueur` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Joueur` (
  `numéro` INT NULL,
  `nomJ` VARCHAR(45) NOT NULL,
  `prenomJ` VARCHAR(45) NOT NULL,
  `dateNaiss` DATETIME NULL,
  `lieuNaiss` VARCHAR(45) NULL,
  `poids` INT NULL,
  `taille` INT NULL,
  `poste` VARCHAR(45) NULL,
  `photo` VARCHAR(45) NULL,
  PRIMARY KEY (`nomJ`, `prenomJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipe` (
  `code` INT NOT NULL,
  `nomE` VARCHAR(45) NULL,
  `pays` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `entrairneur` INT NULL,
  PRIMARY KEY (`code`),
  INDEX `Equipe_Joueur_Entraineur_idx` (`entrairneur` ASC),
  CONSTRAINT `Equipe_Joueur_Entraineur`
    FOREIGN KEY (`entrairneur`)
    REFERENCES `mydb`.`Joueur` (`numéro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StatsEquipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StatsEquipe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StatsEquipe` (
  `idCompetition` INT NOT NULL,
  `codeEquipe` INT NOT NULL,
  `nbGagnes` INT NULL,
  `nbPerdus` INT NULL,
  `nbNuls` INT NULL,
  PRIMARY KEY (`idCompetition`, `codeEquipe`),
  INDEX `StatsEquipe_Equipe_Code_idx` (`codeEquipe` ASC),
  CONSTRAINT `StatsEquipe_Competition_idCompetition`
    FOREIGN KEY (`idCompetition`)
    REFERENCES `mydb`.`Competition` (`idCompetition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `StatsEquipe_Equipe_Code`
    FOREIGN KEY (`codeEquipe`)
    REFERENCES `mydb`.`Equipe` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Composition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Composition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Composition` (
  `numéroJoueur` INT NOT NULL,
  `codeEquipe` INT NOT NULL,
  `idMatch` INT NOT NULL,
  `titulaire` TINYINT(1) NULL,
  `entree` INT NULL,
  `sortie` INT NULL,
  PRIMARY KEY (`numéroJoueur`, `codeEquipe`, `idMatch`),
  INDEX `Composition_Equipe_CodeEquipe_idx` (`codeEquipe` ASC),
  INDEX `Composition_Match_idMatch_idx` (`idMatch` ASC),
  CONSTRAINT `Composition_Joueur_NumeroJoueur`
    FOREIGN KEY (`numéroJoueur`)
    REFERENCES `mydb`.`Joueur` (`numéro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Composition_Equipe_CodeEquipe`
    FOREIGN KEY (`codeEquipe`)
    REFERENCES `mydb`.`Equipe` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Composition_Match_idMatch`
    FOREIGN KEY (`idMatch`)
    REFERENCES `mydb`.`Match` (`idMatch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Saison`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Saison` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Saison` (
  `idSaison` INT NOT NULL,
  `nomS` VARCHAR(45) NULL,
  PRIMARY KEY (`idSaison`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NbCarton`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NbCarton` ;

CREATE TABLE IF NOT EXISTS `mydb`.`NbCarton` (
  `idSaison` INT NOT NULL,
  `numéroJoueur` INT NOT NULL,
  `rouge` INT NULL,
  `jaune` INT NULL,
  PRIMARY KEY (`idSaison`, `numéroJoueur`),
  INDEX `NbCarton_Joueur_NumeroJoueur_idx` (`numéroJoueur` ASC),
  CONSTRAINT `NbCarton_Saison_idSaison`
    FOREIGN KEY (`idSaison`)
    REFERENCES `mydb`.`Saison` (`idSaison`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `NbCarton_Joueur_NumeroJoueur`
    FOREIGN KEY (`numéroJoueur`)
    REFERENCES `mydb`.`Joueur` (`numéro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ButMarque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ButMarque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ButMarque` (
  `numeroJoueur` INT NOT NULL,
  `idMatch` INT NOT NULL,
  `minute` INT NULL,
  `contreCamp` TINYINT(1) NULL,
  PRIMARY KEY (`numeroJoueur`, `idMatch`),
  INDEX `Match_idMatch_idx` (`idMatch` ASC),
  CONSTRAINT `Joueur_numeroJoueur`
    FOREIGN KEY (`numeroJoueur`)
    REFERENCES `mydb`.`Joueur` (`numéro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Match_idMatch`
    FOREIGN KEY (`idMatch`)
    REFERENCES `mydb`.`Match` (`idMatch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Journee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Journee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Journee` (
  `idJournee` INT NOT NULL AUTO_INCREMENT,
  `idSaison` INT NULL,
  `numéro` INT NULL,
  PRIMARY KEY (`idJournee`),
  INDEX `Journee_Saison_idSaison_idx` (`idSaison` ASC),
  CONSTRAINT `Journee_Saison_idSaison`
    FOREIGN KEY (`idSaison`)
    REFERENCES `mydb`.`Saison` (`idSaison`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ville`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ville` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ville` (
  `idVille` INT NOT NULL AUTO_INCREMENT,
  `nomV` VARCHAR(45) NULL,
  PRIMARY KEY (`idVille`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Stade` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Stade` (
  `idStade` INT NOT NULL AUTO_INCREMENT,
  `nomS` VARCHAR(45) NULL,
  `capacite` INT NULL,
  `ville` INT NULL,
  PRIMARY KEY (`idStade`),
  INDEX `Stade_Ville_ville_idx` (`ville` ASC),
  CONSTRAINT `Stade_Ville_ville`
    FOREIGN KEY (`ville`)
    REFERENCES `mydb`.`Ville` (`idVille`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ALieu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ALieu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ALieu` (
  `idMatch` INT NOT NULL,
  `idJournee` INT NOT NULL,
  `idStade` INT NOT NULL,
  `date` DATETIME NULL,
  `receveur` INT NOT NULL,
  `exterieur` INT NOT NULL,
  PRIMARY KEY (`idMatch`, `idJournee`, `idStade`, `receveur`, `exterieur`),
  INDEX `ALieu_Journee_idJournee_idx` (`idJournee` ASC),
  INDEX `ALieu_Equipe_idx` (`receveur` ASC),
  INDEX `ALieu_Equipe_exterieur_idx` (`exterieur` ASC),
  INDEX `ALieu_Stade_idStade_idx` (`idStade` ASC),
  CONSTRAINT `ALieu_Match_idMatch`
    FOREIGN KEY (`idMatch`)
    REFERENCES `mydb`.`Match` (`idMatch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ALieu_Journee_idJournee`
    FOREIGN KEY (`idJournee`)
    REFERENCES `mydb`.`Journee` (`idJournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ALieu_Equipe_receveur`
    FOREIGN KEY (`receveur`)
    REFERENCES `mydb`.`Equipe` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ALieu_Equipe_exterieur`
    FOREIGN KEY (`exterieur`)
    REFERENCES `mydb`.`Equipe` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ALieu_Stade_idStade`
    FOREIGN KEY (`idStade`)
    REFERENCES `mydb`.`Stade` (`idStade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Arbitre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Arbitre` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Arbitre` (
  `numeroA` INT NOT NULL,
  `nomA` VARCHAR(45) NULL,
  `prenomA` VARCHAR(45) NULL,
  `nationalite` VARCHAR(45) NULL,
  PRIMARY KEY (`numeroA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Arbitrage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Arbitrage` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Arbitrage` (
  `idMatch` INT NOT NULL,
  `champs` INT NOT NULL,
  `touche1` INT NOT NULL,
  `touche2` INT NOT NULL,
  `remplacant` INT NOT NULL,
  PRIMARY KEY (`idMatch`, `remplacant`, `touche2`, `touche1`, `champs`),
  INDEX `Arbitrage_Arbitre_champs_idx` (`champs` ASC),
  INDEX `Arbitrage_Arbitre_touche1_idx` (`touche1` ASC),
  INDEX `Arbitrage_Arbitre_touche2_idx` (`touche2` ASC),
  INDEX `Arbitre_Arbitre_remplacant_idx` (`remplacant` ASC),
  CONSTRAINT `Artbitrage_Match_idMatch`
    FOREIGN KEY (`idMatch`)
    REFERENCES `mydb`.`Match` (`idMatch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Arbitrage_Arbitre_champs`
    FOREIGN KEY (`champs`)
    REFERENCES `mydb`.`Arbitre` (`numeroA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Arbitrage_Arbitre_touche1`
    FOREIGN KEY (`touche1`)
    REFERENCES `mydb`.`Arbitre` (`numeroA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Arbitrage_Arbitre_touche2`
    FOREIGN KEY (`touche2`)
    REFERENCES `mydb`.`Arbitre` (`numeroA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Arbitre_Arbitre_remplacant`
    FOREIGN KEY (`remplacant`)
    REFERENCES `mydb`.`Arbitre` (`numeroA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
