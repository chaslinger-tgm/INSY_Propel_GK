
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- user
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user`
(
    `uname` VARCHAR(20) NOT NULL,
    `rname` VARCHAR(50) NOT NULL,
    `pw` VARCHAR(50) NOT NULL,
    `alter` SMALLINT NOT NULL,
    PRIMARY KEY (`uname`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- message
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message`
(
    `mid` INTEGER NOT NULL AUTO_INCREMENT,
    `body` VARCHAR(2000) NOT NULL,
    `subject` VARCHAR(30) NOT NULL,
    `priority` SMALLINT NOT NULL,
    `uname` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`mid`),
    INDEX `message_fi_fc67f6` (`uname`),
    CONSTRAINT `message_fk_fc67f6`
        FOREIGN KEY (`uname`)
        REFERENCES `user` (`uname`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- receiver
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `receiver`;

CREATE TABLE `receiver`
(
    `uname` VARCHAR(20) NOT NULL,
    `mid` INTEGER NOT NULL AUTO_INCREMENT,
    `timestamp` DATETIME NOT NULL,
    PRIMARY KEY (`mid`,`uname`,`timestamp`),
    INDEX `receiver_fi_c3ecfe` (`mid`),
    CONSTRAINT `receiver_fk_fc67f6`
        FOREIGN KEY (`uname`)
        REFERENCES `user` (`uname`),
    CONSTRAINT `receiver_fk_c3ecfe`
        FOREIGN KEY (`mid`)
        REFERENCES `message` (`mid`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- ressource
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `ressource`;

CREATE TABLE `ressource`
(
    `rid` INTEGER NOT NULL AUTO_INCREMENT,
    `mid` INTEGER NOT NULL,
    `url` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`rid`),
    INDEX `ressource_fi_c3ecfe` (`mid`),
    CONSTRAINT `ressource_fk_c3ecfe`
        FOREIGN KEY (`mid`)
        REFERENCES `message` (`mid`)
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
