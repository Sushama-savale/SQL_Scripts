use salesordersexample;

select CustFirstName, CustLastName, OrderDate, sum(QuotedPrice * QuantityOrdered) as TotalSale 
from (customers inner join orders
on customers.CustomerID = orders.CustomerID)
inner join order_details on orders.OrderNumber = order_details.OrderNumber
group by CustFirstName, CustLastName, OrderDate
having sum(QuotedPrice * QuantityOrdered) > 1000;

select VendName, avg(DaysToDeliver) as AvgDaysToDeliver from vendors inner join product_vendors
on vendors.VendorID = product_vendors.VendorID
group by VendName
having avg(DaysToDeliver) > ( select avg(DaysToDeliver) from product_vendors);

select products.ProductNumber, ProductName, sum(QuotedPrice * QuantityOrdered) as TotalSale from 
(products inner join order_details
on products.ProductNumber = order_details.ProductNumber)
group by products.ProductNumber, ProductName
having sum(QuotedPrice * QuantityOrdered) > 
(select (sum(QuotedPrice * QuantityOrdered)/(count(OD.ProductNumber))) from order_details as OD inner join products as P1
on OD.ProductNumber = P1.ProductNumber
/*group by P1.ProductName*/
where P1.CategoryID = products.CategoryID);

select 
