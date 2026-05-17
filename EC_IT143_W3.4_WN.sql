/*
Assignment: W3.4 AdventureWorks — Create Answers
Student: Wilfrid N'dambi Mbouilou
Date: 16 May 2026

Description:
This SQL script contains eight AdventureWorks
questions and answers using the AdventureWorks database.

*/

USE AdventureWorks2022;
GO

-- =========================================
-- Question 1
-- Original Author: John Smith
-- Category: Business User — Marginal Complexity
-- Question:
-- List all products with their product numbers and list prices.
-- =========================================

SELECT
    Name AS ProductName,
    ProductNumber,
    ListPrice
FROM Production.Product
ORDER BY Name;
GO


-- =========================================
-- Question 2
-- Original Author: Sarah Johnson
-- Category: Business User — Marginal Complexity
-- Question:
-- Display all employees and their job titles.
-- =========================================

SELECT
    p.FirstName,
    p.LastName,
    e.JobTitle
FROM HumanResources.Employee e
INNER JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY p.LastName;
GO


-- =========================================
-- Question 3
-- Original Author: Michael Brown
-- Category: Business User — Moderate Complexity
-- Question:
-- Which products have generated the highest total sales revenue?
-- =========================================

SELECT
    pr.Name AS ProductName,
    SUM(sd.LineTotal) AS TotalSalesRevenue
FROM Sales.SalesOrderDetail sd
INNER JOIN Production.Product pr
    ON sd.ProductID = pr.ProductID
GROUP BY pr.Name
ORDER BY TotalSalesRevenue DESC;
GO


-- =========================================
-- Question 4
-- Original Author: Emily Davis
-- Category: Business User — Moderate Complexity
-- Question:
-- Show the total number of orders placed by each customer.
-- =========================================

SELECT
    c.CustomerID,
    COUNT(soh.SalesOrderID) AS TotalOrders
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalOrders DESC;
GO


-- =========================================
-- Question 5
-- Original Author: Daniel Wilson
-- Category: Business User — Increased Complexity
-- Question:
-- Which sales representatives generated above-average sales revenue?
-- =========================================

WITH SalesTotals AS
(
    SELECT
        sp.BusinessEntityID,
        p.FirstName,
        p.LastName,
        SUM(soh.TotalDue) AS TotalRevenue
    FROM Sales.SalesPerson sp
    INNER JOIN Sales.SalesOrderHeader soh
        ON sp.BusinessEntityID = soh.SalesPersonID
    INNER JOIN Person.Person p
        ON sp.BusinessEntityID = p.BusinessEntityID
    GROUP BY
        sp.BusinessEntityID,
        p.FirstName,
        p.LastName
)

SELECT
    BusinessEntityID,
    FirstName,
    LastName,
    TotalRevenue
FROM SalesTotals
WHERE TotalRevenue >
(
    SELECT AVG(TotalRevenue)
    FROM SalesTotals
)
ORDER BY TotalRevenue DESC;
GO


-- =========================================
-- Question 6
-- Original Author: Olivia Martinez
-- Category: Business User — Increased Complexity
-- Question:
-- Rank products by total quantity sold within each product category.
-- =========================================

SELECT
    pc.Name AS CategoryName,
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    RANK() OVER
    (
        PARTITION BY pc.Name
        ORDER BY SUM(sod.OrderQty) DESC
    ) AS ProductRank
FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p
    ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pc.Name,
    p.Name
ORDER BY
    pc.Name,
    ProductRank;
GO


-- =========================================
-- Question 7
-- Original Author: James Taylor
-- Category: Metadata Question
-- Question:
-- List all tables available in the AdventureWorks database.
-- =========================================

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA,
         TABLE_NAME;
GO


-- =========================================
-- Question 8
-- Original Author: Sophia Anderson
-- Category: Metadata Question
-- Question:
-- Display all columns and data types for the SalesOrderHeader table.
-- =========================================

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrderHeader'
ORDER BY ORDINAL_POSITION;
GO
