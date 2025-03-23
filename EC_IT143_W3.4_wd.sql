/*****************************************************************************************************************
NAME:    Wilfrid Elvis N'DAMBI MBOUILOU
PURPOSE: This script answers 8 user-submitted questions related to 
the AdventureWorks database using SQL queries.


MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     05/23/2022   JJAUSSI       1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This script contains SQL queries that answer 8 questions from the AdventureWorks database. Each query is preceded by a comment containing the corresponding question and author. 
   The purpose of this script is to demonstrate SQL proficiency in working with databases using real-world business-related queries.

 
******************************************************************************************************************/

-- Q1: What should go here?
-- A1: Question goes on the previous line, intoduction to the answer goes on this line...
USE AdventureWorks2022;  
GO 
SELECT GETDATE() AS my_date;


-- Q1: Who are the employees whose pay rate is 50 or more?
-- This query retrieves employees with a pay rate of 50 or more.

SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    eph.Rate
FROM 
    HumanResources.Employee e
JOIN 
    HumanResources.EmployeePayHistory eph ON e.EmployeeID = eph.EmployeeID
WHERE 
    eph.Rate >= 50;




-- Q2: Which product has the highest list price?
-- This query will return the product with the highest list price.

SELECT TOP 1 p.ProductName, p.ListPrice
FROM Product p
ORDER BY p.ListPrice DESC;


-- Q3: Which salesperson has processed the highest number of orders in the last 10 months?
-- This query will return the salesperson with the highest number of orders in the last 10 months.

SELECT s.SalesPersonID, COUNT(o.OrderID) AS NumberOfOrders
FROM SalesOrder o
JOIN SalesPerson s ON o.SalesPersonID = s.SalesPersonID
WHERE o.OrderDate >= DATEADD(MONTH, -10, GETDATE())
GROUP BY s.SalesPersonID
ORDER BY NumberOfOrders DESC
LIMIT 1;




-- Q4: Which supplier provides the highest number of unique products, and how many do they supply?
-- This query finds the supplier providing the most unique products and the number of products they supply.

SELECT 
    v.Name AS SupplierName,
    COUNT(DISTINCT pv.ProductID) AS NumberOfUniqueProducts
FROM 
    Purchasing.Vendor v
JOIN 
    Production.ProductVendor pv ON v.BusinessEntityID = pv.VendorID
GROUP BY 
    v.Name
ORDER BY 
    NumberOfUniqueProducts DESC
LIMIT 1; 


-- Q5: What is the total sales for each salesperson in the last year?
-- This query calculates the total sales for each salesperson in the past year.

SELECT 
    soh.SalesPersonID, 
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader soh
WHERE 
    soh.OrderDate >= DATEADD(YEAR, -1, GETDATE()) -- filtering orders in the last year
GROUP BY 
    soh.SalesPersonID
ORDER BY 
    TotalSales DESC;




-- Q6: How many products are there in each product category?
-- This query counts the number of products in each product category.

SELECT 
    pc.Name AS CategoryName, 
    COUNT(p.ProductID) AS NumberOfProducts
FROM 
    Production.Product p
JOIN 
    Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN 
    Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY 
    pc.Name
ORDER BY 
    NumberOfProducts DESC;



-- Q7: What are the columns in the SalesOrder table?
-- This query retrieves the column names and data types for the SalesOrder table.

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrder';


-- Q8: What are the foreign keys in the Product table?
-- This query retrieves the foreign key relationships in the Product table.

SELECT fk.name AS ForeignKeyName,
       tp.name AS TableName,
       ref.name AS ReferenceTable,
       c1.name AS ColumnName,
       c2.name AS ReferenceColumn
FROM sys.foreign_keys AS fk
JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables AS tp ON fkc.parent_object_id = tp.object_id
JOIN sys.tables AS ref ON fkc.referenced_object_id = ref.object_id
JOIN sys.columns AS c1 ON fkc.parent_column_id = c1.column_id AND tp.object_id = c1.object_id
JOIN sys.columns AS c2 ON fkc.referenced_column_id = c2.column_id AND ref.object_id = c2.object_id
WHERE tp.name = 'Product';
