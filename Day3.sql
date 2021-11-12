--1
SELECT c.City FROM dbo.Customers as c 
INTERSECT
SELECT e.City FROM dbo.Employees as e

-- SELECT DISTINCT c.City
-- FROM dbo.Customers as c LEFT JOIN dbo.Employees as e
-- ON c.City = e.City WHERE e.City is NOT null

--2
--a) Use sub-query
SELECT DISTINCT City
FROM dbo.Customers
WHERE City not in (SELECT DISTINCT City FROM dbo.Employees)
--b) Not use sub-query
SELECT DISTINCT c.City
FROM dbo.Customers as c LEFT JOIN dbo.Employees as e
ON c.City = e.City WHERE e.City is null

--3
SELECT p.ProductID, p.ProductName, SUM(od.Quantity)
FROM dbo.Products p, dbo.[Order Details] od
WHERE p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName

--4
SELECT c.City, COUNT(od.Quantity) as "Quantity"
FROM dbo.Customers c LEFT JOIN dbo.Orders o
on c.CustomerID = o.CustomerID
inner join dbo.[Order Details] od on o.OrderID = od.OrderID
GROUP BY c.City

--5
SELECT City
FROM Customers
GROUP BY City
HAVING Count(City) >= 2

--6
SELECT c.City
FROM dbo.Customers c LEFT JOIN dbo.Orders o
on c.CustomerID = o.CustomerID
inner join dbo.[Order Details] od on o.OrderID = od.OrderID
GROUP BY c.City
HAVING Count(ProductID) >=2

--7
SELECT c.CustomerID, c.CompanyName
FROM dbo.Customers c LEFT JOIN dbo.Orders o
on c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity
GROUP BY c.CustomerID, c.CompanyName

--8
SELECT Top 5 dt.ProductID, dt.City, dt.UnitPrice
FROM (SELECT od.ProductID, c.City, od.Quantity, od.UnitPrice, dense_rank() over(order by od.Quantity desc) "rank"
FROM dbo.Orders o INNER JOIN dbo.Customers c on o.CustomerID = c.CustomerID
INNER JOIN dbo.[Order Details] od on o.OrderID = od.OrderID) dt
ORDER BY dt."rank" 

--9
--a
SELECT c.City
FROM dbo.Customers c 
WHERE c.City not in (SELECT ShipCity FROM dbo.Orders) 
    and c.City in (SELECT City From dbo.Employees)

--b
SELECT DISTINCT c.City
FROM dbo.Customers as c 
LEFT JOIN dbo.Orders as o ON c.City = o.ShipCity
LEFT JOIN dbo.Employees e on c.City = e.City
WHERE o.ShipCity is null and e.City is not null

--10
SELECT e.City
FROM
(SELECT o.EmployeeID, COUNT(EmployeeID) as "count", dense_rank() over(order by COUNT(EmployeeID) desc) "rank"
FROM dbo.Orders o
GROUP BY o.EmployeeID) dt 
inner Join dbo.Employees e on dt.EmployeeID = e.EmployeeID
inner join (SELECT o.ShipCity, dense_rank() over(order by COUNT(od.Quantity) desc) "rank2"
            FROM dbo.Orders o INNER JOIN dbo.[Order Details] od on o.OrderID = od.OrderID
            GROUP BY o.ShipCity) dt2 
on e.City = dt2.ShipCity
WHERE dt."rank" = 1 and dt2."rank2" =1

--11
--Can use Group by and Having clause (when count > 1)

--12
SELECT empid
FROM Employee
WHERE empid not in (SELECT mgrid from Employee)

--13
Select d.deptname, COUNT(deptid)
FROM Dept d Inner join 
    (Select deptid, dense_rank() over (order by COUNT(deptid) desc) "rank"
    FROM Employee) dt
on d.deptid = dt.deptid
Where dt."rank"=1
Order by deptname

--14
Select e.empid, dense_rank() over (partition by e.deptid order by e.salary desc) "rank"
from employee e 
inner join department d on e.deptid = d.deptid
where "rank" <=3

--15 top 3 products from everycity which were sold maximum
select dt.ShipCity, dt.ProductID, p.ProductName, DENSE_RANK() over (PARTITION by ShipCity order by dt."total" desc) "Rank"
from
(select o.ShipCity, od.ProductID, SUM(od.Quantity) as "total"
FROM Orders o Inner join [Order Details] od on o.OrderID = od.OrderID
GROUP BY o.ShipCity, od.ProductID) dt
inner join Products p 
on dt.ProductID = p.ProductID
where dt."total" <=3


