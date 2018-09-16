use SalesOrdersExample ;



select distinct HelmetCustomer.CustFirstName, HelmetCustomer.CustLastName from 
(select Customers.CustomerID,CustFirstName, CustLastName from 
((Customers inner join Orders 
on Customers.CustomerID = Orders.CustomerID)
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%helmet%') as HelmetCustomer inner join
( select Customers.CustomerID, CustFirstName, CustLastName from 
 ((Customers inner join Orders 
on Customers.CustomerID = Orders.CustomerID)
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%bike%') as BikeCustomer
on HelmetCustomer.CustomerID = BikeCustomer.CustomerID;

select CustomerID from Customers 
where customers.CustomerID IN
(select Customers.CustomerID from 
((Customers inner join Orders 
on Customers.CustomerID = Orders.CustomerID)
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%helmet%') and
customers.CustomerID IN
(select Customers.CustomerID from 
((Customers inner join Orders 
on Customers.CustomerID = Orders.CustomerID)
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%bike%');

select  CustomerID from Customers 
where exists
(select Orders.CustomerID from 
( Orders inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%helmet%' and Orders.CustomerID = Customers.CustomerID) and
exists
(select Orders.CustomerID from 
(Orders inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%bike%');

select distinct  Tirecust.CustFirstName, TireCust.CustLastName from 
(select Customers.CustomerID, CustFirstName, CustLastName  from
 (((Customers inner join Orders 
on Customers.CustomerID = Orders.CustomerID)
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber)
inner join Categories on Categories.CategoryID = Products.CategoryID
where CategoryDescription <> 'Tires' ) as TireCust 
inner join 
(select Customers.CustomerID, CustFirstName, CustLastName from
 (((Customers inner join Orders 
on Customers.CustomerID = Orders.CustomerID)
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber)
inner join Categories on Categories.CategoryID = Products.CategoryID
where CategoryDescription <> 'Bikes') as BikeCust
on TireCust.CustomerID = BikeCust.CustomerID;

 select   CustFirstName, CustLastName from 
Customers left outer join 
( select CustomerID from ((Orders
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber)
inner join Categories on Categories.CategoryID = Products.CategoryID
where CategoryDescription in ('Tires','Bikes')) as TireBikeCust
on Customers.CustomerID = TireBikeCust.CustomerID
where TireBikeCust.CustomerID is null


select CustomerID, CustFirstName, CustLastName from Customers where CustomerID  not IN
(select CustomerID from ((Orders
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber)
inner join Categories on Categories.CategoryID = Products.CategoryID
where CategoryDescription in ('Tires','Bikes'));

select CustomerID, CustFirstName, CustLastName from Customers where not exists
(select CustomerID from ((Orders
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber)
inner join Categories on Categories.CategoryID = Products.CategoryID
where CategoryDescription in ('Tires','Bikes')
and Orders.CustomerID = Customers.CustomerID);

select distinct Customers.CustFirstName, Customers.CustLastName from
customers where customerid not in  
(select CustomerID from 
(Orders inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%helmet%') 
and customerid in
( select CustomerID from 
 (Orders inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%bike%') ;

select CustomerID, CustFirstName, CustLastName from Customers 
where not exists
(select Orders.CustomerID from 
( Orders inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%helmet%' and Orders.CustomerID = Customers.CustomerID) and
exists
(select Orders.CustomerID from 
(Orders inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%bike%'and Orders.CustomerID = Customers.CustomerID);

select OrderNumber from Orders where OrderNumber IN
(select OrderNumber from Order_Details 
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%Bike%') and 
OrderNumber NOT IN
(select OrderNumber from Order_Details 
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%Helmet%')

select  Orders.OrderNumber from customers inner join Orders 
on customers.CustomerID = Orders.CustomerID
where EXISTS
(select OrderNumber from (Order_Details 
inner join Products on Order_Details.ProductNumber = Products.ProductNumber)
where ProductName like '%bike' and Order_Details.OrderNumber = Orders.OrderNumber) and 
Not exists
(select * from Order_Details 
inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where ProductName like '%helmet' and Order_Details.OrderNumber = Orders.OrderNumber)

SELECT Orders.OrderNumber FROM Customers INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE EXISTS  
(SELECT OrderNumber  FROM (Order_Details
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber)
where ProductName like '%bike%'
AND Order_Details.OrderNumber = Orders.OrderNumber)
AND NOT EXISTS  (SELECT *  FROM Order_Details
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber WHERE Products.ProductName LIKE '%helmet'
AND Order_Details.OrderNumber = Orders.OrderNumber);

select * from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID
where Orders.OrderNumber IN
(select OrderNumber from (Order_Details inner join Products
on Order_Details.ProductNumber = Products.ProductNumber)
inner join Categories on Categories.CategoryID = Products.CategoryID
where CategoryDescription = 'Bikes')
and Orders.OrderNumber IN
(select OrderNumber from (Order_Details inner join Products
on Order_Details.ProductNumber = Products.ProductNumber)
where ProductName like '%Helmet')

SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Orders.OrderNumber, Orders.OrderDate
 from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID
where exists
(select * from ( orders as O1 inner join Order_Details 
on O1.OrderNumber = Order_Details.OrderNumber
inner join Products
on Order_Details.ProductNumber = Products.ProductNumber)
where categoryid = 2
and O1.OrderNumber= Orders.OrderNumber
and Orders.CustomerID = Customers.CustomerID)
and exists
(select O2.OrderNumber from (orders as O2 inner join Order_Details 
on O2.OrderNumber = Order_Details.OrderNumber
 inner join Products
on Order_Details.ProductNumber = Products.ProductNumber)
where ProductName like '%Helmet' and
O2.OrderNumber= Orders.OrderNumber and
Orders.CustomerID = Customers.CustomerID)
order by orders.ordernumber

select * from vendors inner join 