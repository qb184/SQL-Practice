--Day1
--Using AdventureWorks Database
--1
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product;
--2
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice = 0
--3
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is null
--4
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is not null
--5
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is not null and ListPrice > 0
--6
SELECT Name + ' ' + Color
FROM Production.Product
WHERE Color is not null
--7
SELECT 'NAME: ' + Name + ' -- COLOR: ' + Color as "Name And Color"
FROM Production.Product
WHERE Color is not null
--8
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500
--9
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color = 'black' or Color='blue'

--10
SELECT * FROM Production.Product
WHERE Name LIKE 'S%'

--11
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%'
order by Name

--12
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%' or Name LIKE 'A%'
order by Name

--13
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'
order by Name

--14
SELECT DISTINCT Color
FROM Production.Product
order by Color

--15
SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID is not null and Color is not null

--16
--WHERE ProductSubcategoryID IS NOT NULL AND Color IN ('Red', 'Black')
--AND (ListPrice BETWEEN 1000 AND 2000
--OR ProductSubcategoryID = 1)

--17
SELECT ProductSubcategoryID,  LEFT([NAME], 35) AS [NAME], Color, ListPrice
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND Color IN ('Red', 'Black')
AND (ListPrice BETWEEN 1000 AND 2000
OR ProductSubcategoryID = 1)
ORDER BY ProductID