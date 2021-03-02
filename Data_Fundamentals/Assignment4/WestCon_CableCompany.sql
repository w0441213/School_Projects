DROP DATABASE WestCon_CableCompany;

CREATE DATABASE WestCon_CableCompany;
USE WestCon_CableCompany;

-- CREATE TABLES
CREATE TABLE Customer
(
    CustomerID INT(11) NOT NULL AUTO_INCREMENT,
    CustomerFirstName VARCHAR(32) NOT NULL,
    CustomerLastName VARCHAR(32) NOT NULL,
    CustomerAddress VARCHAR(255) NOT NULL,
    SubscriptionStartDate DATETIME NOT NULL,
    PRIMARY KEY (CustomerID)
);

CREATE TABLE ChannelPackage
(
    ChannelPackageID INT(11) NOT NULL AUTO_INCREMENT,
    ChannelPackageName VARCHAR(32) NOT NULL,
    ChannelPackagePrice FLOAT NOT NULL,
    PRIMARY KEY (ChannelPackageID)
);

CREATE TABLE Channel
(
    ChannelID INT(11) NOT NULL AUTO_INCREMENT,
    ChannelNum INT(11) NOT NULL,
    ChannelName  VARCHAR(32) NOT NULL,
    PRIMARY KEY (ChannelID)
);

CREATE TABLE PayPerViewEvent
(
    PPVEventID INT(11) NOT NULL AUTO_INCREMENT,
    PPVEventDate DATETIME NOT NULL,
    PPVEventName VARCHAR(32) NOT NULL,
    PPVEventPrice FLOAT NOT NULL,
    ChannelID INT(11) NOT NULL,
    PRIMARY KEY (PPVEventID)
);

CREATE TABLE ChannelPackageChannel
(
    ChannelID INT(11) NOT NULL,
    ChannelPackageID INT(11) NOT NULL,
    PRIMARY KEY (ChannelID, ChannelPackageID)
);

CREATE TABLE CustomerChannelPackage
(
    CustomerID INT(11) NOT NULL,
    ChannelPackageID INT(11) NOT NULL,
    PRIMARY KEY (CustomerID, ChannelPackageID)
);

CREATE TABLE CustomerPayPerViewEvent
(
    PPVEventID INT(11) NOT NULL,
    CustomerID INT(11) NOT NULL,
    PaidOrUnpaid TINYINT NOT NULL,
    PPVAmountDue FLOAT NULL,
    PRIMARY KEY (PPVEventID, CustomerID)
);

-- ALTERING TABLES
ALTER TABLE CustomerChannelPackage
    ADD CONSTRAINT FK__CustomerChannelPackage__Customer__CustomerID
    FOREIGN KEY (CustomerID)
    REFERENCES Customer (CustomerID);

ALTER TABLE CustomerChannelPackage
    ADD CONSTRAINT FK__CustomerChannelPackage__ChannelPackage__ChannelPackageID
    FOREIGN KEY (ChannelPackageID)
    REFERENCES ChannelPackage (ChannelPackageID);

ALTER TABLE ChannelPackageChannel
    ADD CONSTRAINT FK__ChannelPackageChannel__Channel__ChannelID
    FOREIGN KEY (ChannelID)
    REFERENCES Channel (ChannelID);

ALTER TABLE ChannelPackageChannel
    ADD CONSTRAINT FK__ChannelPackageChannel__ChannelPackage__ChannelPackageID
    FOREIGN KEY (ChannelPackageID)
    REFERENCES ChannelPackage (ChannelPackageID);

ALTER TABLE CustomerPayPerViewEvent
    ADD CONSTRAINT FK__CustomerPayPerViewEvent__Customer__CustomerID
    FOREIGN KEY (CustomerID)
    REFERENCES Customer (CustomerID);

ALTER TABLE CustomerPayPerViewEvent
    ADD CONSTRAINT FK__PayPerViewEvent__PPVEventID
    FOREIGN KEY (PPVEventID)
    REFERENCES PayPerViewEvent (PPVEventID);

ALTER TABLE PayPerViewEvent
    ADD CONSTRAINT FK__PayPerViewEvent__Channel__ChannelID
    FOREIGN KEY (ChannelID)
    REFERENCES Channel (ChannelID);

-- INSERTING INTO THE DATABASE
-- add three customers
INSERT INTO Customer
    (CustomerFirstName, CustomerLastName, CustomerAddress, SubscriptionStartDate)
VALUES
    ('John', 'Buck', '123 Somewhere Road', '2017-07-11T12:02:07.000');

INSERT INTO Customer
    (CustomerFirstName, CustomerLastName, CustomerAddress, SubscriptionStartDate)
VALUES
    ('Jane', 'Doe', '777 Heavenly Drive', '2014-11-06T09:07:17.000');

INSERT INTO Customer
    (CustomerFirstName, CustomerLastName, CustomerAddress, SubscriptionStartDate)
VALUES
    ('Jack', 'Sprat', '0711 Everywhere Lane', '2018-03-18T14:22:07.002');

-- add three channels
INSERT INTO Channel
    (ChannelName, ChannelNum)
VALUES
    ('ABC', '100');

INSERT INTO Channel
    (ChannelName, ChannelNum)
VALUES
    ('Spike', '106');

INSERT INTO Channel
    (ChannelName, ChannelNum)
VALUES
    ('TSN', '110');

-- add channel packages
INSERT INTO ChannelPackage
    (ChannelPackageName, ChannelPackagePrice)
VALUES
    ('Basic', '100');

INSERT INTO ChannelPackage
    (ChannelPackageName, ChannelPackagePrice)
VALUES
    ('Action', '150');

INSERT INTO ChannelPackage
    (ChannelPackageName, ChannelPackagePrice)
VALUES
    ('Sports', '150');

-- adding channels to the packages
INSERT INTO ChannelPackageChannel
    (ChannelID, ChannelPackageID)
VALUES
    (1, 1);

INSERT INTO ChannelPackageChannel
    (ChannelID, ChannelPackageID)
VALUES
    (2, 2);

INSERT INTO ChannelPackageChannel
    (ChannelID, ChannelPackageID)
VALUES
    (3, 3);

-- adding BASIC Channel Package to all customer subscriptions
INSERT INTO CustomerChannelPackage
    (CustomerID, ChannelPackageID)
VALUES
    (1, 1);

INSERT INTO CustomerChannelPackage
    (CustomerID, ChannelPackageID)
VALUES
    (2, 1);

INSERT INTO CustomerChannelPackage
    (CustomerID, ChannelPackageID)
VALUES
    (3, 1);

-- adding Action package to Jane Doe's subscription
INSERT INTO CustomerChannelPackage
    (CustomerID, ChannelPackageID)
VALUES
    (2, 2);

-- adding The Prize Fight to PayPerView Event
INSERT INTO PayPerViewEvent
    (PPVEventDate, PPVEventName, PPVEventPrice, ChannelID)
VALUES
    ('2019-11-30T20:00:00.000', 'The Prize Fight', '9.95', 3);

-- adding John Buck to the list of people who want to watch The Prize Fight PayPerView Event
INSERT INTO CustomerPayPerViewEvent
    (CustomerID, PPVEventID, PaidOrUnpaid, PPVAmountDue)
VALUES
    (1, 1, 0, NULL);

-- updating John Buck's big fight record to complete his payment of 9.95
UPDATE CustomerPayPerViewEvent
SET PaidOrUnpaid = 1, PPVAmountDue = '9.95'
WHERE CustomerID = 1 AND PPVEventID = 1;

-- deleting Jane Doe's subscription to the Action package
DELETE FROM CustomerChannelPackage
    WHERE CustomerID = 2 AND ChannelPackageID = 2;

-- displaying a list of all customer information alphabetically by last name
SELECT CustomerLastName FROM Customer
ORDER BY CustomerLastName ASC;

-- displaying all information for the Spike channel
SELECT * FROM Channel
WHERE ChannelName = 'Spike';

-- displaying the title and date of all future Pay-Per-View events
SELECT PPVEventName, PPVEventDate FROM PayPerViewEvent
WHERE PPVEventDate > NOW();