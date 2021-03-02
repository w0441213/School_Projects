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
        -- checking constraint for phone number
        CHECK (UserPhoneNum LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    PRIMARY KEY (UserID)
);
GO

-- default constraint for User's First Name
ALTER TABLE [User]
    DROP CONSTRAINT IF EXISTS DF__User__UserFirstName;
ALTER TABLE [User]
    ADD CONSTRAINT DF__User__UserFirstName DEFAULT ('') FOR UserFirstName;

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
    StaffAssignedID INT NULL,
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
    CommentDate DATETIME NOT NULL,
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
    DateTaskFinished DATETIME NULL,
    TicketID INT NOT NULL,
    StaffID INT NULL,
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
    SerialNumber VARCHAR(32) NOT NULL,
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
ADD CONSTRAINT FK__Ticket__StaffAssignedID
FOREIGN KEY (StaffAssignedID)
REFERENCES Staff (StaffID) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

ALTER TABLE Ticket
WITH CHECK ADD CONSTRAINT FK__Ticket__TicketCategoryID
FOREIGN KEY (TicketCategoryID)
REFERENCES TicketCategory (TicketCategoryID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

-- table: Comment
ALTER TABLE Comment
    DROP CONSTRAINT IF EXISTS FK__Comment__UserID;
ALTER TABLE Comment
    ADD CONSTRAINT FK__Comment__User__UserID
    FOREIGN KEY (UserID)
    REFERENCES [User] (UserID);
GO

ALTER TABLE Comment
    DROP CONSTRAINT IF EXISTS FK__Comment__TicketID;
ALTER TABLE Comment
    ADD CONSTRAINT FK__Comment__TicketID
    FOREIGN KEY (TicketID)
    REFERENCES Ticket (TicketID);
GO

ALTER TABLE Comment
    DROP CONSTRAINT IF EXISTS FK__Comment__StaffID;
ALTER TABLE Comment
    WITH CHECK ADD CONSTRAINT FK__Comment__StaffID
    FOREIGN KEY (StaffID)
    REFERENCES [Staff] (StaffID);
GO

-- table: Task
ALTER TABLE Task
    DROP CONSTRAINT IF EXISTS FK__Task__TicketID;
ALTER TABLE Task
    ADD CONSTRAINT FK__Task__TicketID
    FOREIGN KEY (TicketID)
    REFERENCES Ticket (TicketID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE Task
    DROP CONSTRAINT IF EXISTS FK__Task__StaffID;
ALTER TABLE Task
    ADD CONSTRAINT FK__Task__StaffID
    FOREIGN KEY (StaffID)
    REFERENCES Staff (StaffID);
GO

-- table: HardwareTicket
ALTER TABLE HardwareTicket
    DROP CONSTRAINT IF EXISTS FK__HardwareTicket__HardwareID;
ALTER TABLE HardwareTicket
    ADD CONSTRAINT FK__HardwareTicket__HardwareID
    FOREIGN KEY (TicketID)
    REFERENCES Ticket (TicketID);
GO

ALTER TABLE HardwareTicket
    DROP CONSTRAINT IF EXISTS FK__Item__ItemID;
ALTER TABLE HardwareTicket
WITH CHECK ADD CONSTRAINT FK__Item__ItemID
FOREIGN KEY (HardwareID)
REFERENCES Hardware (HardwareID) ON DELETE CASCADE ON UPDATE CASCADE;
GO

-- INDEX STATEMENTS
CREATE INDEX IX__User__UserFirstNameLastName ON [User] (UserFirstName, UserLastName);
CREATE INDEX IX__Staff__StaffFirstNameLastName ON Staff (StaffFirstName, StaffLastName);
GO

CREATE INDEX IX_TicketCategory_CategoryDescription
ON TicketCategory (CategoryDescription);
GO

-- INSERT STATEMENTS
INSERT INTO [User] (UserFirstName, UserLastName, UserAddress, UserPhoneNum)
VALUES ('Chandler', 'Bing', '25 Place Avenue', '9024021111'),
       ('Monica', 'Gellar-Bing', '77 Heavenly Way', '9021777171'),
       ('Ross', 'Gellar', '123 Dinosaur Parke', '9025558888'),
       ('Rachel', 'Green', '02 Fashion Avenue', '9024447777'),
       ('Joseph', 'Tribianni', '12 Howyoudoin court', '9028557354'),
       ('Phoebe', 'Buffay', '74 Smelly Cat Lane', '9021458877');

INSERT INTO [Staff] (StaffFirstName, StaffLastName, StaffPhoneNum, StaffAddress)
VALUES ('Matthew', 'Perry', '9025587789', '123 Address Road'),
       ('Courtney', 'Cox', '9021478526', '456 Location Drive'),
       ('David', 'Schwimmer', '9023114587', '789 Destination Highway'),
       ('Jennifer', 'Anniston', '9021257448', '321 Area Village'),
       ('Matt', 'LeBlanc', '9021236547', '654 Pizza Road'),
       ('Lisa', 'Kudrow', '9024715544', '987 Music Way');

-- USING IDENTITY_INSERT TO OVERRIDE THE AUTOMATIC IDENTITY GENERATION
SET IDENTITY_INSERT TicketCategory ON;
INSERT INTO TicketCategory (TicketCategoryID, CategoryName, CategoryDescription)
VALUES (701, 'Hardware', 'There is an issue with hardware or physical components'),
       (702, 'Software', 'There is an issue with software components'),
       (703, 'Account', 'There is an issue with the user account'),
       (704, 'Internet', 'There is an issue with the network connection'),
       (705, 'General Questions', 'User needs help with multiple general questions');
SET IDENTITY_INSERT TicketCategory OFF;

INSERT INTO Hardware (HardwareName, HardwareDescription, PurchaseDate, SerialNumber)
VALUES ('MSI Optix', 'PC Monitor, Resolution: 1920x1080, Refresh Rate: 144Hz, Aspect Ratio: 16:9', '2020-04-11 02:30:00', 'MAH241C'),
       ('Asus ROG Swift', 'PC Monitor, Resolution: 3840x2160, Refresh Rate 144Hz, Aspect Ratio: 16:9', '2020-04-02 07:00:00', 'PG65UQ'),
       ('Asus TUF Gaming', 'PC Monitor, Resolution: 3840x2160, Refresh rate: 144Hz, Aspect Ratio: 16:9', '2020-01-20 02:00:00', 'VG279QM'),
       ('Asus ROG Strix', 'PC Monitor, Resolution: 1920x1080 Refresh Rate: 75Hz, Aspect Ratio: 16:9', '2020-02-14 02:00:00', 'XG279Q'),
       ('Logitech Hero', 'Mouse, Connection Type: Wired, Maximum DPI: 16000, Color: Black', '2020-02-09 09:00:00', 'G502'),
       ('Logitech Lightspeed', 'Mouse, Connection Type: Wired, Maximum DPI: 16000, Color: Black', '2020-03-20 08:00:00', 'G702'),
       ('Corsair Harpoon', 'Mouse, Connection Type: Wired, Maximum DPI: 16000, Color: Black', '2020-02-02 04:00:00', 'AX213'),
       ('Razer Naga Trinity', 'Mouse, Connection Type: Wireless, Maximum DPI: 14000, Color: White', '2020-02-21 01:00:00', 'RZ123'),
       ('SteelSeries Rival', 'Mouse, Connection Type: Wireless, Maximum DPI: 6000, Color: Pink', '2020-04-02 04:00:00', 'SS321'),
       ('Razer Basilisk', 'Mouse, Connection Type: Wireless, Maximum DPI: 12000, Color: Blue', '2020-01-12 02:04:00', 'RZB744');

INSERT INTO Ticket (Issue, DateIssued, DateResolved, UserID, StaffID, StaffAssignedID, TicketCategoryID)
VALUES ('Mouse does not function', '2020-02-23 02:00:00', NULL, 1, NULL, 1, 701),
       ('Applications keep crashing', '2020-01-02 04:00:00', '2020-01-12 02:00:00', NULL, 2, 2, 702),
       ('Applications are very slow', '2020-03-01 02:30:00', '2020-03-07 02:00:00', NULL, 3, 3, 702),
       ('Monitor is cracked', '2020-01-24 05:30:00', NULL, NULL, 4, NULL, 701),
       ('User forgot password and security questions', '2020-01-03 05:00:00', '2020-01-04 02:00:00', 3, NULL, 4, 703),
       ('Internet Connection is down, says connected but no internet', '2020-04-02 07:00:00', NULL, 5, NULL, 5, 704),
       ('User forgot password', '2020-03-30 02:00:00', '2020-04-10 05:30:00', 6, NULL, 6, 703),
       ('Monitor fell and screen is cracked', '2020-02-01 01:00:00', NULL, 2, NULL, 4, 701),
       ('User is confused how to change desktop background and customizing the desktop', '2020-04-15 02:00:00', '2020-04-16 08:00:00', 1, NULL, 2, 705),
       ('User has questions about computer set up', '2020-03-20 02:10:00', '2020-03-21 04:00:00', 2, NULL, 1, 705);

INSERT INTO Task (TaskName, TaskInformation, DateTaskFinished, TicketID, StaffID)
VALUES ('Check hardware', 'Check the user mouse', '2020-02-25 02:00:00', 1, 1),
       ('Replace hardware', 'Order mouse for user and replace it', NULL, 1, NULL),
       ('Check software', 'Check user software', '2020-01-07 04:00:00', 2, 2),
       ('Fix software', 'Uninstall and reinstall software', '2020-01-12 02:00:00', 2, 2),
       ('Check Software', 'Check user software', '2020-03-04 04:00:00', 3, 3),
       ('Fix Software', 'Update software', '2020-03-07 02:00:00', 3, 3),
       ('Replace hardware', 'Order monitor for user and replace it', NULL, 4, NULL),
       ('Reset account', 'reset user account', '2020-01-04 04:00:00', 5, 4),
       ('Check connection', 'Check internet connection', NULL, 6, 5),
       ('Reset account', 'reset user account', '2020-04-10 05:00:00', 7, 6),
       ('Replace hardware', 'Order monitor for user and replace it', NULL, 8, 4),
       ('Contact user', 'Send comment to user to get info and help,', '2020-04-16 01:00:00', 9, 2),
       ('Contact user', 'Send comment to user to get info and help,', '2020-03-21 02:00:00', 10, 1);

INSERT INTO Comment (CommentDate, CommentMade, TicketID, UserID, StaffID)
VALUES ('2020-03-02 02:00:00', 'What color do you want for the mouse?', 1, NULL, 1),
       ('2020-03-02 02:00:00', 'Pink please, or violet', 1, 1, NULL),
       ('2020-01-04 03:00:00', 'I forgot my security questions', 5, 3, NULL),
       ('2020-04-04 04:00:00', 'Did you try to unplug then plug back the modem?', 6, NULL, 5),
       ('2020-04-16 05:00:00', 'How do I change or customize my desktop?', 9, 1, NULL),
       ('2020-03-21 07:00:00', 'What do you need help with?', 10, NULL, 1);

INSERT INTO HardwareTicket (TicketID, HardwareID)
VALUES (1, 7),
       (4, 2),
       (8, 2);


-- SELECT STATEMENTS
-- Display a list of all tickets submitted within a given month of the current year.
-- The month will be supplied to the routine as a word (e.g. April)
DROP PROCEDURE IF EXISTS usp_GetAprilTickets;
GO
CREATE PROCEDURE usp_GetAprilTickets
    @month VARCHAR(32) , @year INT OUTPUT
AS
BEGIN
    SELECT *,  DATENAME(month, DateIssued) AS AprilTickets
    FROM Ticket
    WHERE DATENAME(month, DateIssued) LIKE @month
    AND DATEPART(year, DateIssued) LIKE @year;
END;
GO

EXEC usp_GetAprilTickets April , 2020 ;
GO

-- Display a list of the top 10 tickets that have had the most activity in the form
-- of comments. A start date and end date will be supplied to the routine in the
-- form ‘yyyy-mm-dd’.
DROP PROCEDURE IF EXISTS usp_GetMostCommentedTickets;
GO
CREATE PROCEDURE usp_GetMostCommentedTickets
@startDate DATETIME2, @endDate DATETIME2
AS BEGIN
    SELECT TOP 10 t.TicketID, Issue, DateIssued,
                  DateResolved, COUNT(c.TicketID) AS CountComments
    FROM Comment c
    INNER JOIN Ticket t ON c.TicketID = t.TicketID
    WHERE @startDate < DateIssued AND @endDate > DateIssued AND DateResolved IS NULL
    GROUP BY t.TicketID, Issue, DateIssued, DateResolved
    ORDER BY COUNT(c.TicketID) DESC;
END;
GO

EXEC usp_GetMostCommentedTickets '2019-04-02', '2020-04-26';
GO

-- Display a list of tickets for a particular category, ordered by descending date,
-- with the corresponding date displayed in the format (Month dddd, yyyy) e.g.
-- November 21st, 2009. A category name will be supplied to the routine.
DROP PROCEDURE IF EXISTS usp_DisplayTicketsForSpecifiedCategory;
GO
CREATE PROCEDURE usp_DisplayTicketsForSpecifiedCategory
@TicketCategory VARCHAR(32)
AS
BEGIN
    SELECT Issue, DATENAME(MM, DateIssued) + RIGHT(CONVERT(VARCHAR(12), DateIssued, 107), 9)
    AS [Month DDDD, YYYY], Issue, UserID TicketCategoryID FROM Ticket
    WHERE TicketCategoryID = (SELECT TicketCategoryID FROM TicketCategory
                              WHERE CategoryName=@TicketCategory) ORDER BY DateIssued DESC;
END;
GO

EXEC usp_DisplayTicketsForSpecifiedCategory Hardware

-- Display a “page” of ticket information by passing, to the routine, a page
-- number and the number of tickets per page. For example, passing “1,10” will
-- return the first ten tickets (ordered by ticket id), but passing “2,10” will
-- return next ten tickets (i.e. page 2).
DROP PROCEDURE IF EXISTS usp_TicketPage;
GO
CREATE PROCEDURE usp_TicketPage
    @PageNumber INT,
    @TicketsPerPage INT
AS
    BEGIN
        SELECT * FROM Ticket ORDER BY TicketID
        OFFSET ((@PageNumber-1)*@TicketsPerPage) ROWS
        FETCH NEXT @TicketsPerPage ROWS ONLY
    END;
GO

EXEC usp_TicketPage 1,5;