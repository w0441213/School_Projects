-- move to default database
USE master;
GO

-- create a new database
DROP DATABASE IF EXISTS  SpeedingTicket;
CREATE DATABASE SpeedingTicket;
GO

-- switch to new database
USE SpeedingTicket;
GO

-- CREATE TABLES
-- table: User
DROP TABLE IF EXISTS [User]
CREATE TABLE [User]
(
    UserID INT IDENTITY NOT NULL,
    UserFirstName VARCHAR(32) NOT NULL,
    UserLastName VARCHAR(32) NOT NULL,
    UserAddress  VARCHAR(255) NOT NULL,
    UserPhoneNum VARCHAR(32) NOT NULL,
    PRIMARY KEY (UserID)
);
GO

-- table: Staff
DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
    StaffID INT IDENTITY NOT NULL,
    StaffFirstName VARCHAR(32) NOT NULL,
    StaffLastName VARCHAR(32) NOT NULL,
    StaffPhoneNum VARCHAR(32) NOT NULL,
    StaffAddress VARCHAR(255) NOT NULL,
    PRIMARY KEY (StaffID)
);
GO

-- table: Ticket
DROP TABLE IF EXISTS Ticket;
CREATE TABLE Ticket (
    TicketID INT IDENTITY NOT NULL,
    Issue VARCHAR(1024) NOT NULL,
    DateIssued DATETIME NOT NULL,
    DateResolved DATETIME NULL,
    UserID INT NULL,
    StaffID INT NULL,
    TicketCategoryID INT NOT NULL,
    PRIMARY KEY (TicketID)
);
GO

-- table: TicketCategory
DROP TABLE IF EXISTS TicketCategory;
CREATE TABLE TicketCategory (
    TicketCategoryID INT IDENTITY NOT NULL,
    CategoryName VARCHAR(32) NOT NULL,
    CategoryDescription VARCHAR(255) NOT NULL,
    PRIMARY KEY (TicketCategoryID)
);
GO

-- table: Comment
DROP TABLE IF EXISTS Comment;
CREATE TABLE Comment (
    CommentID INT IDENTITY NOT NULL,
    CommentMade VARCHAR(1024) NOT NULL,
    TicketID INT NOT NULL,
    UserID INT NULL,
    StaffID INT NULL,
    PRIMARY KEY (CommentID)
);
GO

-- table: Task
DROP TABLE IF EXISTS Task;
CREATE TABLE Task (
    TaskID INT IDENTITY NOT NULL,
    TaskName VARCHAR(32) NOT NULL,
    TaskInformation VARCHAR(255) NOT NULL,
    TicketID INT NOT NULL,
    StaffID INT NOT NULL,
    PRIMARY KEY (TaskID)
);
GO

-- table: Hardware
DROP TABLE IF EXISTS Hardware;
CREATE TABLE Hardware (
    HardwareID INT IDENTITY NOT NULL,
    HardwareName VARCHAR(32) NOT NULL,
    HardwareDescription VARCHAR(80) NOT NULL,
    PurchaseDate DATETIME NOT NULL,
    SerialNumber VARCHAR(32) NOT NULL
    PRIMARY KEY (HardwareID)
);
GO

-- table: HardwareTicket
DROP TABLE IF EXISTS HardwareTicket;
CREATE TABLE HardwareTicket (
    TicketID INT NOT NULL,
    HardwareID INT NOT NULL,
    PRIMARY KEY (TicketID, HardwareID)
);
GO


-- ALTER TABLES
-- foreign key constraints
-- table: Ticket
ALTER TABLE Ticket
ADD CONSTRAINT FK__Ticket__UserID
FOREIGN KEY (UserID)
REFERENCES [User] (UserID) ON DELETE SET NULL ON UPDATE SET NULL;
GO

ALTER TABLE Ticket
ADD CONSTRAINT FK__Ticket__StaffID
FOREIGN KEY (StaffID)
REFERENCES Staff (StaffID) ON DELETE SET NULL ON UPDATE SET NULL;
GO

ALTER TABLE Ticket
WITH CHECK ADD CONSTRAINT FK__Ticket__TicketCategoryID
FOREIGN KEY (TicketCategoryID)
REFERENCES TicketCategory (TicketCategoryID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

-- table: Comment
ALTER TABLE Comment
ADD CONSTRAINT FK__Comment__TicketID
FOREIGN KEY (TicketID)
REFERENCES Ticket (TicketID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE Comment
ADD CONSTRAINT FK__Comment__UserID
FOREIGN KEY (UserID)
REFERENCES [User] (UserID);
GO

ALTER TABLE Comment
WITH CHECK ADD CONSTRAINT FK__User__UserID
FOREIGN KEY (UserID)
REFERENCES [User] (UserID);
GO

-- table: Task
ALTER TABLE Task
ADD CONSTRAINT FK__Task__TicketID
FOREIGN KEY (TicketID)
REFERENCES Ticket (TicketID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE Task
ADD CONSTRAINT FK__Task__StaffID
FOREIGN KEY (StaffID)
REFERENCES Staff (StaffID);
GO

-- table: HardwareTicket
ALTER TABLE HardwareTicket
ADD CONSTRAINT FK__HardwareTicket__HardwareID
FOREIGN KEY (TicketID)
REFERENCES Ticket (TicketID);
GO

ALTER TABLE HardwareTicket
WITH CHECK ADD CONSTRAINT FK__Item__ItemID
FOREIGN KEY (HardwareID)
REFERENCES Hardware (HardwareID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

-- CHECK CONSTRAINTS
-- table: User
-- checks that the value of UserFirstName does not contain numbers
ALTER TABLE [User]
ADD CONSTRAINT CK__User__UserFirstName
CHECK (UserFirstName NOT LIKE '%[0-9]%');
GO
-- checks that the values of UserPhoneNum are numbers
ALTER TABLE [User]
ADD CONSTRAINT CK__User__UserPhoneNum
CHECK (UserPhoneNum LIKE '%[0-9]%');
GO
-- checks that the UserLastName contains a value and does not contain numbers
ALTER TABLE [User]
ADD CONSTRAINT CK__User__UserLastName
CHECK (LEN(UserLastName) > 0 AND UserLastname NOT LIKE '%[0-9]%');
GO

-- table: Staff
-- checks that the value of StaffFirstName does not contain numbers
ALTER TABLE Staff
ADD CONSTRAINT CK__Staff__StaffFirstName
CHECK (StaffFirstName NOT LIKE '%[0-9]%');
GO
-- checks that StaffLastName contains a value and does not contain numbers
ALTER TABLE Staff
ADD CONSTRAINT CK__Staff__StaffLastName
CHECK (LEN(StaffLastName) > 0 AND StaffLastname NOT LIKE '%[0-9]%');
GO

-- table: TicketCategory
-- checks that CategoryName contains a value
ALTER TABLE TicketCategory
ADD CONSTRAINT CK__TicketCategory__CategoryName
CHECK (LEN(CategoryName) > 0 AND CategoryName NOT LIKE '%[0-9]%');
GO

-- table: Task
-- checks that TaskInformation contains a value
ALTER TABLE Task
ADD CONSTRAINT CK__Task__TaskInformation
CHECK (LEN(TaskInformation) > 0);
GO


-- UNIQUE CONSTRAINTS
-- table: User
ALTER TABLE [User]
ADD CONSTRAINT AK__User__UserPhoneNum
UNIQUE (UserPhoneNum);
GO

-- table: Hardware
ALTER TABLE Hardware
ADD CONSTRAINT AK__Hardware__SerialNumber
UNIQUE (SerialNumber);
GO


-- DEFAULT CONSTRAINTS
-- table: User
ALTER TABLE [User]
ADD CONSTRAINT DF__User__UserFirstName
DEFAULT ('UserFirstName') FOR UserFirstName;
GO

-- table: Staff
ALTER TABLE Staff
ADD CONSTRAINT DF__Staff__StaffFirstName
DEFAULT ('StaffFirstName') FOR StaffFirstName;
GO
-- adding the CommentDate
ALTER TABLE Comment
ADD CommentDate DATE NOT NULL DEFAULT (GETDATE());
GO
-- setting the CommentMade's default value
ALTER TABLE Comment
ADD CONSTRAINT DF__Comment__CommentMade
DEFAULT ('') FOR CommentMade;
GO
-- setting the DateSolved's default value
ALTER TABLE Task
ADD DateSolved DATE NOT NULL DEFAULT (GETDATE());
GO

-- CREATE INDEX
-- table: User
CREATE INDEX IX__User__UserLastName
ON [User] (UserLastName);
CREATE INDEX IX__User__UserFirstName__UserLastName
ON [User] (UserLastName DESC, UserFirstName ASC);

-- table: Staff
CREATE INDEX IX__Staff__StaffLastName
ON Staff (StaffLastName);
CREATE INDEX IX__Staff__FirstName__LastName
ON Staff (StaffLastName DESC, StaffFirstName ASC)
GO

-- table: Ticket
CREATE INDEX IX__Ticket__Issue
ON Ticket (Issue);

-- table: TicketCategory
CREATE INDEX IX__TicketCategory__CategoryDescription
ON TicketCategory (CategoryDescription);

-- table: Task
CREATE INDEX IX__Task__TaskInformation
ON Task (TaskInformation);

-- table: Hardware
CREATE INDEX IX__Hardware__ModelNumber
ON Hardware (SerialNumber);

