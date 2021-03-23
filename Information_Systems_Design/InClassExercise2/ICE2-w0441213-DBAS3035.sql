-- ICE 2
-- JAMIE LU
-- 02/24/2021

--1. Please provide a sql CTE command that will produce the following result (SalesPerson, Total SalesTransactions, TotalSales and SalesYear):

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear, TotalDue)  
AS  

(  
	SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear, TotalDue
	FROM AdventureWorks2019.Sales.SalesOrderHeader  
	WHERE SalesPersonID IS NOT NULL  
)  

SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSalesTransactions, SUM(TotalDue) AS TotalSales, SalesYear  
FROM Sales_CTE  
GROUP BY SalesYear, SalesPersonID  
ORDER BY SalesPersonID, SalesYear; 


--2. Please provide a sql command that uses RowNumber() and Partition By to produce the following results (Ranking the Sales Person by SalesQuota in a DESC order):

SELECT FirstName, LastName, TerritoryName, ROUND(SalesYTD,2,1) AS SalesYTD,
SalesQuota, ROW_NUMBER() OVER(PARTITION BY TerritoryName ORDER BY SalesQuota DESC)
  AS Ranking
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL AND SalesYTD <> 0
ORDER BY TerritoryName;