/*
===========================================================
 Script:    EC_IT143_W3.4_WD.sql
 Author:    Wilfrid N'DAMBI MBOUILOU
 Course:    IT 143
 Deliverable: 3.4 Adventure Works—Create Answers
 Date:      9/24/2025
===========================================================
 Description:
 This script contains eight AdventureWorks questions and 
 their corresponding SQL answers. Each question is 
 commented out with attribution to the original author. 

 Runtime Estimate: < 5 minutes in total.
===========================================================
*/

/*===========================================================
 Q1 (Marginal Complexity)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: What is the list price of the cheapest product 
 in the Product table?
===========================================================*/

-- SQL Answer:
SELECT TOP 1 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice ASC;


/*===========================================================
 Q2 (Marginal Complexity)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: Which five customers placed the most orders by 
 total count?
===========================================================*/

-- SQL Answer:
SELECT TOP 5 c.CustomerID, p.FirstName, p.LastName, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY OrderCount DESC;


/*===========================================================
 Q3 (Moderate Complexity)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: Looking back at 2013, which three customers 
 brought us the most revenue, and how many orders did 
 each place?
===========================================================*/

-- SQL Answer:
SELECT TOP 3 c.CustomerID, p.FirstName, p.LastName,
       COUNT(soh.SalesOrderID) AS OrderCount,
       SUM(soh.TotalDue) AS TotalRevenue
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2013
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY TotalRevenue DESC;


/*===========================================================
 Q4 (Moderate Complexity)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: Which salespeople sold to Canadian customers in 
 2014, and what are their names and email addresses?
===========================================================*/

-- SQL Answer:
SELECT DISTINCT sp.BusinessEntityID, p.FirstName, p.LastName, ea.EmailAddress
FROM Sales.SalesPerson sp
JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
JOIN Person.StateProvince spv ON a.StateProvinceID = spv.StateProvinceID
JOIN Person.CountryRegion cr ON spv.CountryRegionCode = cr.CountryRegionCode
WHERE cr.Name = 'Canada' AND YEAR(soh.OrderDate) = 2014;


/*===========================================================
 Q5 (Increased Complexity)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: For the year 2013, which product subcategories 
 contributed the most to revenue (by month)?
===========================================================*/

-- SQL Answer:
SELECT YEAR(soh.OrderDate) AS OrderYear, MONTH(soh.OrderDate) AS OrderMonth,
       ps.Name AS Subcategory, SUM(sod.LineTotal) AS Revenue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE YEAR(soh.OrderDate) = 2013
GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate), ps.Name
ORDER BY OrderYear, OrderMonth, Revenue DESC;


/*===========================================================
 Q6 (Increased Complexity)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: Customer demographics for internet orders in 
 2012, by country/state.
===========================================================*/

-- SQL Answer:
SELECT a.CountryRegionCode, a.StateProvinceID,
       COUNT(DISTINCT soh.CustomerID) AS UniqueCustomers,
       SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Address a ON soh.BillToAddressID = a.AddressID
WHERE YEAR(soh.OrderDate) = 2012
  AND soh.OnlineOrderFlag = 1
GROUP BY a.CountryRegionCode, a.StateProvinceID
ORDER BY TotalSales DESC;


/*===========================================================
 Q7 (Metadata Question)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: List all tables in AdventureWorks that contain 
 a column named "BusinessEntityID".
===========================================================*/

-- SQL Answer:
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'BusinessEntityID';


/*===========================================================
 Q8 (Metadata Question)
 Author: Wilfrid N'DAMBI MBOUILOU
 Question: Which views include product inventory 
 information, and what schema do they belong to?
===========================================================*/

-- SQL Answer:
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME LIKE '%Inventory%';
