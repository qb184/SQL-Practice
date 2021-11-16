--1, 2, 3
begin TRANSACTION
insert into Region values (5, 'Middle Earth')
insert into Territories values (98777, 'Gondor', 5)
insert into Employees ( LastName, FirstName) values ('King', 'Aragorn')
insert into EmployeeTerritories values (13, 98777)
update Territories set TerritoryDescription = 'Arnor' WHere TerritoryID = 98777
delete EmployeeTerritories where TerritoryID = 98777
delete Territories where RegionID = 5
delete Region where RegionID = 5
commit

--4
create view "view_product_order_bui" AS
select ProductID, Sum(Quantity) as 'Total QUantity'
from [Order Details]
group by ProductID

--5
create PROC "sp_product_oorder_quantity_bui"
@product_id INT,
@total_quantity int out
AS
BEGIN
    SELECT OrderID from [Order Details]
    where ProductID = @product_id
    set @total_quantity = @@ROWCOUNT
END

--6
create PROC "sp_product_order_city_bui"
@product_name varchar(20)
AS
BEGIN
    select dt.ShipCity, dt.Quantity FROM
    (SELECT o.ShipCity, Sum(Quantity) as "Quantity", DENSE_RANK() over(order by Sum(Quantity) desc) "rank"
    from Orders o inner join [Order Details] od
    on o.OrderID = od.OrderID
    INNER join Products p on od.ProductID = p.ProductID
    where p.ProductName = 'Chai'
    GROUP By ShipCity ) dt
    Where dt."rank" <=5
END

--7
begin TRAN
    exec ('create proc "sp_move_employees_bui"
    as
    BEGIN
        DECLARE @employee int
        SELECT @employee = e.EmployeeID
        from EmployeeTerritories e inner join Territories t
        on e.TerritoryID = t.TerritoryID
        where t.TerritoryDescription = \'Tory\'

        If (@@ROWCOUNT > 0)
            insert into Region values (6, 'North')
            insert into Territories values (98778, 'Stevens Point', 6)
            update EmployeeTerritories set TerritoryID = 98778 where EmployeeID in (@employee)
    END
    
    ')
 

