--Day2
--1: 504 products
SELECT  COUNT(ProductID)
FROM Production.Product
--2
SELECT  COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID is not null
--3
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS "CountedProducts"
FROM Production.Product 
WHERE ProductSubcategoryID is not null
GROUP BY ProductSubcategoryID

--4: 209
SELECT  COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID is null

--5
SELECT ProductID, SUM(Quantity) as "Quantity"
FROM Production.ProductInventory
GROUP BY ProductID

--6
SELECT ProductID, SUM(Quantity) as "Quantity"
FROM Production.ProductInventory
where LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) <100

--7
SELECT ProductID, Shelf
FROM Production.ProductInventory
where LocationID = 40
GROUP BY ProductID, Shelf
HAVING SUM(Quantity) <100

--8
SELECT ProductID, AVG(Quantity) as "Average Quantity"
FROM Production.ProductInventory
where LocationID = 10
GROUP BY ProductID

--9
SELECT ProductID, Shelf, AVG(Quantity) as "TheAvg"
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

--10
SELECT ProductID, Shelf, AVG(Quantity) as "TheAvg"
FROM Production.ProductInventory
where Shelf is not null
GROUP BY ProductID, Shelf

--11
SELECT Color, Class, count(Color) AS "TheCount", AVG(ListPrice) as "AvgPrice"
FROM Production.Product
WHERE Color is not null or Class is not null
GROUP BY Color, Class

--12
SELECT c.Name as "Country", s.Name as "Province"
FROM Person.CountryRegion c inner join Person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode

--13
SELECT c.Name as "Country", s.Name as "Province"
FROM Person.CountryRegion c inner join Person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name = 'Canada' or c.Name =  'Germany'

--14
SELECT p.ProductID, p.ProductName
FROM dbo.Products as p inner join dbo.[Order Details] as od
on p.ProductID = od.ProductID
inner join dbo.Orders as o on od.OrderID = o.OrderID
where o.OrderDate > 1996
GROUP BY p.ProductID, p.ProductName

--15
SELECT top 5 o.ShipPostalCode
FROM  dbo.[Order Details] as od
inner join dbo.Orders as o
on od.OrderID = o.OrderID
Group by od.ProductID, o.ShipPostalCode
order by sum(od.Quantity) desc

--16
SELECT top 5 o.ShipPostalCode
FROM dbo.Products as p inner join dbo.[Order Details] as od
on p.ProductID = od.ProductID
inner join dbo.Orders as o on od.OrderID = o.OrderID
where o.OrderDate > 2001
Group by od.ProductID, o.ShipPostalCode
order by sum(od.Quantity) desc

--17
SELECT ShipCity as "City name", count(CustomerID) as "Number of Customers"
from Orders
group by ShipCity

--18
SELECT ShipCity as "City name", count(CustomerID) as "Number of Customers"
from Orders
group by ShipCity
having count(CustomerID) > 10

--19
SELECT c.CompanyName
FROM  dbo.Customers as c
inner join dbo.Orders as o
on c.CustomerID = o.CustomerID
WHERE OrderDate > 1998/1/1
GROUP BY c.CompanyName

--20
SELECT * FROM dbo.Customers

--21
SELECT c.CompanyName, SUM(od.Quantity)
FROM  dbo.Customers as c
inner join dbo.Orders as o
on c.CustomerID = o.CustomerID
inner join dbo.[Order Details] od on o.OrderID = od.OrderID
GROUP BY c.CompanyName

--22
SELECT c.CompanyName
FROM  dbo.Customers as c
inner join dbo.Orders as o
on c.CustomerID = o.CustomerID
inner join dbo.[Order Details] od on o.OrderID = od.OrderID
GROUP BY c.CompanyName
HAVING SUM(od.Quantity) > 100

--23
--24
SELECT o.OrderDate, p.ProductName
FROM dbo.Orders as o
inner join dbo.[Order Details] od on o.OrderID = od.OrderID
inner join dbo.Products as p on p.ProductID = od.ProductID
GROUP BY o.OrderDate, p.ProductName

--25
SELECT FirstName, LastName
FROM dbo.Employees
WHERE Title IN (SELECT TITLE FROM dbo.Employees  group by title having count(Title) >1)

--26
SELECT e2.FirstName, e2.LastName
FROM dbo.Employees as e1 inner join dbo.Employees as e2
on e1.ReportsTo = e2.EmployeeID
group by e1.ReportsTo, e2.FirstName, e2.LastName
having count(e1.ReportsTo) > 2

--27
--28
--select F1.T1, F2.T2
--From T1 inner join T2 on F1.T1 = F2.T2
--result: table 
-------
--2 3
--2 3
-------

--29
--select F1.T1, F2.T2
--From T1 left join T2 on F1.T1 = F2.T2
--result: table:
-----------
--1  null
--2  2
--3  3

