-- IN CLASS EXERCISE #5
-- Jamie Lu

-- 1) a DML Trigger that will add a Timestamp [getDate()] if any cell in a row is changed or added to the Covid Symptoms table

USE COVID_BackEnd
GO

CREATE OR ALTER TRIGGER SymptomTimestamp ON Symptom
AFTER INSERT, update 
AS  

UPDATE dbo.Symptom
SET SympTimestamp = GETDATE()
FROM Inserted i
WHERE dbo.Symptom.SymptomID = i.SymptomID;

UPDATE dbo.Symptom
SET WHOIdentified_Pry = 'True'
WHERE SymptomName = 'Fever';
GO

-- 2) A non-clustered index that would allow for an Index Seek.
USE AdventureWorks2019
GO

CREATE NONCLUSTERED INDEX ncIndx_SalesOrderHeader_SalesOrderID
ON Sales.SalesOrderHeader(SalesOrderNumber,AccountNumber,TotalDue);
GO

SELECT [AccountNumber],[TotalDue]
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
WHERE SalesOrderNumber='SO43764';