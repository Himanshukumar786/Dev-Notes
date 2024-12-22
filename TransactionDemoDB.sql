-- Active: 1726293091240@@127.0.0.1@3306@TransactionDemoDB

DESC `ACCOUNTS`;

INSERT INTO `ACCOUNTS` (`ACCOUNT_HOLDER`, `BALANCE`) VALUES ('ABC', 1000), ('XYZ', 2000);

SELECT * FROM `ACCOUNTS`;

START TRANSACTION;

UPDATE `ACCOUNTS` SET `BALANCE` = `BALANCE` - 200 WHERE `ACCOUNT_HOLDER` = 'ABC';


UPDATE `ACCOUNTS` SET `BALANCE` = `BALANCE` + 200 WHERE `ACCOUNT_HOLDER` = 'XYZ';

COMMIT;

DROP TABLE `ACCOUNTS`;

create database TransactionDemoDB;

USE TransactionDemoDB;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE ACCOUNTS (
	BALANCE INT NOT NULL,
    ACCOUNT_ID INT PRIMARY KEY AUTO_INCREMENT,
    ACCOUNT_HOLDER VARCHAR(50) NOT NULL
);

DESC ACCOUNTS;

DELIMITER $$
CREATE PROCEDURE TRANSFER()
BEGIN
	START TRANSACTION;
    
    IF (SELECT BALANCE FROM ACCOUNTS WHERE ACCOUNT_HOLDER = 'ABC') <= 0 THEN
		ROLLBACK;
	ELSE
		UPDATE `ACCOUNTS` SET `BALANCE` = `BALANCE` - 200 WHERE `ACCOUNT_HOLDER` = 'ABC';


		UPDATE `ACCOUNTS` SET `BALANCE` = `BALANCE` + 200 WHERE `ACCOUNT_HOLDER` = 'XYZ';
		
        SELECT * FROM ACCOUNTS;
		COMMIT;
    END IF;
END$$
DROP PROCEDURE TRANSFER;
CALL TRANSFER();

SELECT * FROM ACCOUNTS;