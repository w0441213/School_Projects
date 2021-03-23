-- ICE 4
-- JAMIE LU
-- MARCH 22, 2021

-- QUESTION 1: Create a Scalar UDF that will return the Fiscal Year based on a date parameter. The udf should use the following function: 
-- YEAR(DATEADD(m, 6, [MyDate])) AS [FiscalYear]


CREATE FUNCTION dbo.ufnGetFiscalYear(@Dt date)
RETURNS int
AS

BEGIN
	DECLARE @ret int;
	SELECT @ret = YEAR(DATEADD(m, 6, @Dt));
		IF (@ret IS NULL)
			SET @ret = 0;
		RETURN @ret;
END;


--QUESTION 2: Create an inline table udf that returns a Ranking of SalesYTD for each SalesPerson in a given TerritoryName. The udf should accept the TerritoryName as a parameter. The table udf should use the following sql query to generate a table output. 
-- Hint: You will need to include the TerritoryName parameter in the sql code below.
-- SELECT FirstName, LastName, TerritoryName, ROUND(SalesYTD,2,1) AS SalesYTD, SalesQuota,
-- ROW_NUMBER() OVER(PARTITION BY TerritoryName ORDER BY SalesYTD DESC) 
-- AS [Ranking]
-- FROM Sales.vSalesPerson  
-- WHERE SalesYTD <> 0

CREATE FUNCTION Sales.ufn_SalesPersonRankingByTerritory(@TerritoryName nvarchar(50))
RETURNS TABLE
AS
RETURN
(
	SELECT FirstName, LastName, TerritoryName, ROUND(SalesYTD,2,1) AS SalesYTD, SalesQuota,
ROW_NUMBER() OVER(PARTITION BY TerritoryName ORDER BY SalesYTD DESC)
	AS [Ranking]
FROM Sales.vSalesPerson
WHERE SalesYTD <> 0 AND TerritoryName = @TerritoryName
);

SELECT * FROM Sales.ufn_SalesPersonRankingByTerritory (N'Canada');