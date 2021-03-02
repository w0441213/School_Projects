-- DDL

USE master;
DROP DATABASE IF EXISTS World_Happiness_Report;
GO
CREATE DATABASE World_Happiness_Report;  
GO
ALTER TABLE World_Happiness_Report.dbo.[Country_Year]
DROP CONSTRAINT FK_Regional_ID_CY;
ALTER TABLE World_Happiness_Report.dbo.Dystopia
DROP CONSTRAINT FK_Country_Year_ID_DYS;
ALTER TABLE World_Happiness_Report.dbo.Freedom_of_Choice
DROP CONSTRAINT FK_Country_Year_ID_FC
ALTER TABLE World_Happiness_Report.dbo.GDP
DROP CONSTRAINT FK_Country_Year_ID_GDP;
ALTER TABLE World_Happiness_Report.dbo.Generosity
DROP CONSTRAINT FK_Country_Year_ID_GEN;
ALTER TABLE World_Happiness_Report.dbo.Healthy_Life_Expectancy
DROP CONSTRAINT FK_Country_Year_ID_HLE;
ALTER TABLE World_Happiness_Report.dbo.Perception_of_Corruption
DROP CONSTRAINT FK_Country_Year_ID_PoC;
ALTER TABLE World_Happiness_Report.dbo.[Social Support] 
DROP CONSTRAINT FK_Country_Year_ID_SS;
GO

DROP TABLE IF EXISTS World_Happiness_Report.dbo.Country_Year;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.Dystopia;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.Freedom_of_Choice;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.GDP;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.Generosity;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.Healthy_Life_Expectancy;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.Perception_of_Corruption;  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.[Regional_Indicator];  
DROP TABLE IF EXISTS World_Happiness_Report.dbo.[Social Support];  
GO

-- CREATING THE TABLES 

CREATE TABLE World_Happiness_Report.dbo.[Regional_Indicator] ( 
    Regional_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    Regional_Indicator varchar(50) NOT NULL 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Country_Year] ( 
    Country_Year_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,   
    Country_Name varchar(50) NOT NULL,   
    [Year] int NOT NULL, 
    Regional_ID int, 
    CONSTRAINT FK_Regional_ID_CY FOREIGN KEY (Regional_ID) 
    REFERENCES World_Happiness_Report.dbo.[Regional_Indicator](Regional_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Dystopia] ( 
    Dystopia_Code int IDENTITY(1,1) NOT NULL PRIMARY KEY,   
    Dystopia_log_residual float(10) NOT NULL,   
--	Dystopia_value float(10), 
    Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_DYS FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.Country_Year(Country_Year_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Freedom_of_Choice] ( 
    FoC_Code int IDENTITY(1,1) NOT NULL PRIMARY KEY,  
    Freedom_log_value float(10) NOT NULL,   
    Freedom_value float(10),   
	Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_FC FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.Country_Year(Country_Year_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[GDP] ( 
    GDP_code int IDENTITY(1,1) NOT NULL PRIMARY KEY,   
    GDP_log_value float(10) NOT NULL,   
    GDP_Value float(10),   
    Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_GDP FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.Country_Year(Country_Year_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Generosity] ( 
    Generosity_Code int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    Generosity_log_value float(10) NOT NULL, 
    Generosity_Score float(10) , 
    Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_GEN FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.Country_Year(Country_Year_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Healthy_Life_Expectancy] ( 
    HLE_code int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    HLE_log_value float(6) NOT NULL,  
    Healthy_Life_Expectancy float(10) , 
    Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_HLE FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.Country_Year(Country_Year_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Perception_of_Corruption] ( 
    PoC_Code int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    Corruption_log_value float(10) NOT NULL, 
    Corruption_Score float(10) , 
    Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_PoC FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.Country_Year(Country_Year_ID) 
);  
GO
CREATE TABLE World_Happiness_Report.dbo.[Social Support] ( 
    SS_code int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    SS_log_value float(10) NOT NULL, 
    Social_Score float(10) , 
    Country_Year_ID int NOT NULL, 
    CONSTRAINT FK_Country_Year_ID_SS FOREIGN KEY (Country_Year_ID) 
    REFERENCES World_Happiness_Report.dbo.[Country_Year](Country_Year_ID) 
); 


-- DML

-- Copy Regional data
INSERT INTO World_Happiness_Report.dbo.[Regional_Indicator]
SELECT DISTINCT Regional_indicator 
FROM World_Happiness_Raw.dbo.WHRFull
WHERE Regional_Indicator IS NOT NULL;
GO

--Copying Country data from each year to database
INSERT INTO World_Happiness_Report.dbo.Country_Year 
SELECT fl.Country_Name, fl.[Year], NULL
FROM World_Happiness_Raw.dbo.[WHRFull] fl;
--INNER JOIN World_Happiness_Report.dbo.[Regional_Indicator] r ON fl.[Regional_Indicator] = r.[Regional_Indicator]
GO
/*INSERT INTO World_Happiness_Report.dbo.Country_Year 
SELECT r.[Regional_ID]
FROM World_Happiness_Report.dbo.[Regional_Indicator] r
INNER JOIN World_Happiness_Report.dbo.[Regional_Indicator] r ON fl.[Regional_Indicator] = r.[Regional_Indicator];
GO
*/

--Copying Metrics data
INSERT INTO World_Happiness_Report.dbo.[GDP]
--SELECT fl.GDP_log_value, fl.GDP_Value, cy.Country_Year_ID INTO World_Happiness_Report.dbo.[GDP] 
SELECT fl.GDP_log_value, fl.GDP_Value, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
--WHERE fl.[Year] LIKE cy.[Year];
WHERE fl.[Year] = cy.[Year];
GO
INSERT INTO World_Happiness_Report.dbo.[Freedom_of_Choice]
SELECT fl.Freedom_log_value, fl.Freedom_value, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
WHERE fl.[Year] = cy.[Year];
GO
INSERT INTO World_Happiness_Report.dbo.[Generosity]
SELECT fl.Generosity_log_value, fl.Generosity_Score, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
WHERE fl.[Year] = cy.[Year];
GO
INSERT INTO World_Happiness_Report.dbo.[Healthy_Life_Expectancy]
SELECT fl.HLE_log_value, fl.Healthy_Life_Expectancy, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
WHERE fl.[Year] = cy.[Year];
GO
INSERT INTO World_Happiness_Report.dbo.[Perception_of_Corruption]
SELECT fl.Corruption_log_value, fl.Corruption_Score, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
WHERE fl.[Year] = cy.[Year];
GO
INSERT INTO World_Happiness_Report.dbo.[Social Support]
SELECT fl.SS_log_value, fl.Social_Score, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
WHERE fl.[Year] = cy.[Year];
GO
INSERT INTO World_Happiness_Report.dbo.[Dystopia] 
SELECT fl.Dystopia_log_residual, cy.Country_Year_ID
FROM World_Happiness_Raw.dbo.[WHRFull] fl
LEFT JOIN World_Happiness_Report.dbo.Country_Year cy
ON fl.Country_Name = cy.Country_Name
WHERE fl.[Year] = cy.[Year];
GO

--Create View that calculates Happiness Ladder Score
DROP VIEW IF EXISTS vwHappinessScore;
GO

CREATE VIEW vwHappinessScore AS 
SELECT cy.Country_Name AS Country, cy.[Year] AS [Year], (d.Dystopia_log_residual +
f.Freedom_log_value+p.GDP_log_value+g.Generosity_log_value+h.HLE_log_value+c.Corruption_log_value+s.SS_log_value) AS Happiness_Score
FROM World_Happiness_Report.dbo.[Country_Year] cy 
FULL OUTER JOIN World_Happiness_Report.dbo.[Dystopia] d
ON cy.Country_Year_ID = d.Country_Year_ID
FULL OUTER JOIN World_Happiness_Report.dbo.[Freedom_of_Choice] f
ON d.Country_Year_ID = f.Country_Year_ID
FULL OUTER JOIN World_Happiness_Report.dbo.[GDP] p
ON f.Country_Year_ID = p.Country_Year_ID
FULL OUTER JOIN World_Happiness_Report.dbo.[Generosity] g
ON p.Country_Year_ID = g.Country_Year_ID
FULL OUTER JOIN World_Happiness_Report.dbo.[Healthy_Life_Expectancy] h
ON g.Country_Year_ID = h.Country_Year_ID
FULL OUTER JOIN World_Happiness_Report.dbo.[Perception_of_Corruption] c
ON h.Country_Year_ID = c.Country_Year_ID
FULL OUTER JOIN World_Happiness_Report.dbo.[Social Support] s
ON c.Country_Year_ID = s.Country_Year_ID;
GO

SELECT * FROM vwHappinessScore
ORDER BY Happiness_Score;
