/*
  EC_IT143_W6.4_PerformanceAnalysis.sql
  Author: Wilfrid N'DAMBI
  Date: 13 October 2025
  Description:
  Demonstration of SQL Server performance analysis using execution plans,
  missing index recommendations, and index creation.
  This script includes two separate examples on different tables
  from the AdventureWorks2022 sample database.
*/

------------------------------------------------------------
-- STEP 1: Prepare environment
------------------------------------------------------------
USE AdventureWorks2022;
GO

-- Enable performance statistics
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

------------------------------------------------------------
-- STEP 2: Example 1 – Person.Person table
-- Purpose: Identify a missing index for a character column (LastName)
------------------------------------------------------------

-- Query without index
SELECT *
FROM Person.Person
WHERE LastName = 'Smith';
GO

-- After observing missing index recommendation in Execution Plan,
-- create the suggested index:
CREATE INDEX IX_Person_LastName
ON Person.Person (LastName);
GO

-- Re-run the query to compare performance
SELECT *
FROM Person.Person
WHERE LastName = 'Smith';
GO


------------------------------------------------------------
-- STEP 3: Example 2 – Sales.SalesOrderHeader table
-- Purpose: Identify a missing index for numeric column (ShipMethodID)
------------------------------------------------------------

-- Query without index
SELECT *
FROM Sales.SalesOrderHeader
WHERE ShipMethodID = 3;
GO

-- After observing missing index recommendation in Execution Plan,
-- create the suggested index:
CREATE INDEX IX_Sales_ShipMethodID
ON Sales.SalesOrderHeader (ShipMethodID);
GO

-- Re-run the query to compare performance
SELECT *
FROM Sales.SalesOrderHeader
WHERE ShipMethodID = 3;
GO


------------------------------------------------------------
-- STEP 4: Clean up (optional)
-- Uncomment the lines below if you want to remove the indexes after testing
------------------------------------------------------------
-- DROP INDEX IX_Person_LastName ON Person.Person;
-- DROP INDEX IX_Sales_ShipMethodID ON Sales.SalesOrderHeader;
-- GO
