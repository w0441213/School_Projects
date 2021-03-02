-- remove (if exists), create, and use "DogKennel" database
DROP DATABASE IF EXISTS DogKennel;

CREATE DATABASE DogKennel;

USE DogKennel;

-- remove (if exists) and create the "Dog" table
DROP TABLE IF EXISTS `DOG`;
CREATE TABLE DOG(
    DogID INT(11) PRIMARY KEY,
    DogName VARCHAR(32) NOT NULL,
    Breed VARCHAR(32) NOT NULL,
    Gender VARCHAR(32) NOT NULL,
    Shots TINYINT NOT NULL,
    DateOfBirth datetime NOT NULL,
    DogStatus VARCHAR(255) NOT NULL,
    FatherID INT(11) NULL,
    MotherID INT(11) NULL
);

ALTER TABLE `DOG`
    DROP CONSTRAINT IF EXISTS FK__DOG__FatherID;

ALTER TABLE `DOG`
    ADD CONSTRAINT FK__DOG__FatherID
    FOREIGN KEY (FatherID)
    REFERENCES DOG (DogID);

ALTER TABLE `DOG`
    DROP CONSTRAINT IF EXISTS FK__DOG__MotherID;

ALTER TABLE `DOG`
    ADD CONSTRAINT FK__DOG__MotherID
    FOREIGN KEY (MotherID)
    REFERENCES DOG (DogID);

-- remove (if exists) and create "CLIENT" table
DROP TABLE IF EXISTS `CLIENT`;
CREATE TABLE CLIENT
(
    ClientID      INT(11)     PRIMARY KEY,
    ClientName    VARCHAR(32) NOT NULL,
    ClientAddress VARCHAR(80) NOT NULL,
    PhoneNum      VARCHAR(32) NOT NULL

);

-- remove (if exists) and create "PURCHASE" table
DROP TABLE IF EXISTS `PURCHASE`;
CREATE TABLE PURCHASE(
    PurchaseID INT(11) NOT NULL PRIMARY KEY ,
    DateOfPurchase DATE NOT NULL,
    TimeOfPurchase TIME NOT NULL,
    Subtotal FLOAT NOT NULL,
    Total FLOAT NOT NULL,
    ClientID INT(11) NOT NULL,
    DogID INT(11) NOT NULL
);

ALTER TABLE `PURCHASE`
    DROP CONSTRAINT IF EXISTS FK__CLIENT__ClientID;

ALTER TABLE `PURCHASE`
    ADD CONSTRAINT FK__CLIENT__ClientID
    FOREIGN KEY (ClientID)
    REFERENCES CLIENT (ClientID);

ALTER TABLE `PURCHASE`
    DROP CONSTRAINT IF EXISTS FK__DOG__DogID;

ALTER TABLE `PURCHASE`
    ADD CONSTRAINT FK__DOG__DogID
    FOREIGN KEY (DogID)
    REFERENCES DOG (DogID);