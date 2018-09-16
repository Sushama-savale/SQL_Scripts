use SalesOrdersModify;

delete from Product_Vendors 
where ProductNumber IN 
( select Products.ProductNumber from products left outer join Order_Details
on Products.ProductNumber = Order_Details.ProductNumber
where Order_Details.ProductNumber is null);

delete from Products 
where ProductNumber IN 
( select Products.ProductNumber from products left outer join Order_Details
on Products.ProductNumber = Order_Details.ProductNumber
where Order_Details.ProductNumber is null)

delete from Employees
where EmployeeID IN
(select  Employees.EmployeeID from Employees left outer join Orders
on Employees.EmployeeID = Orders.EmployeeID
where Orders.EmployeeID is null)

delete from Categories
where CategoryID IN
(select Categories.CategoryID from Categories left outer join Products
on Categories.CategoryID = Products.CategoryID
where Products.CategoryID is null)

use EntertainmentAgencyModify

delete from Customers
where CustomerID IN
(select Customers.CustomerID from Customers left outer join Engagements
on Customers.CustomerID = Engagements.CustomerID
where Engagements.CustomerID is null)

delete from Musical_Styles
where StyleID not IN
(select StyleID from Entertainer_Styles ) and 
StyleID not IN
(select StyleID from Musical_Preferences) 

delete from Members
where MemberID not in
(select MemberID from Entertainer_Members)

use SchoolSchedulingModify

delete from Students
where StudentID not IN
(select Student_Schedules.StudentID from Student_Schedules )

/* not working because second subquery returns 0 rows.
delete from Subjects
where SubjectID not in
(select SubjectID from Classes)
and SubjectID not in
(select SubjectPreReq from Subjects inner join Classes
on Subjects.SubjectID = Classes.SubjectID) */

