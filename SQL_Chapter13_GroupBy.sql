use SalesOrdersExample;

select CustFirstName, CustLastName, OrderDate, sum(QuotedPrice * QuantityOrdered) as TotalCost from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join Order_Details on Orders.OrderNumber = Order_Details.OrderNumber
group by CustFirstName, CustLastName, OrderDate;

select Vendors.VendName, avg(Product_Vendors.DaysToDeliver) from Vendors inner join Product_Vendors
on Vendors.VendorID = Product_Vendors.VendorID
group by Vendors.VendName;

select products.ProductNumber, ProductName,sum(QuotedPrice * QuantityOrdered)  from Products inner join Order_Details
on Products.ProductNumber = Order_Details.ProductNumber
group by Products.ProductNumber, ProductName;

select Vendors.VendName, COUNT(*) from Vendors inner join Product_Vendors
on Vendors.VendorID = Product_Vendors.VendorID
group by Vendors.VendName;

select Vendors.VendName,(select count(*) from Product_Vendors as PVID where PVID.VendorID = Vendors.VendorID)
as ProductCount
from Vendors order by VendName  ;

use EntertainmentAgencyExample;

select Entertainers.EntertainerID, EntStageName, Members.MbrFirstName, Members.MbrLastName,
(SUM(ContractPrice)/(select count(*) from 
Entertainer_Members where Entertainers.EntertainerID = Entertainer_Members.EntertainerID
and Entertainer_Members.Status <> 3)) as MemberPay
from Entertainers inner join Entertainer_Members
on Entertainers.EntertainerID = Entertainer_Members.EntertainerID
inner join Members on Entertainer_Members.MemberID = Members.MemberID
left outer join  Engagements on Engagements.EntertainerID = Entertainers.EntertainerID
where Entertainer_Members.Status <> 3
group by Entertainers.EntertainerID, EntStageName, Members.MbrFirstName, Members.MbrLastName 
order by MemberPay;

select Agents.AgtFirstName, Agents.AgtLastName,SUM(ContractPrice), 
(SUM(ContractPrice)* agents.CommissionRate) as Commision
 from Agents
inner join Engagements on Agents.AgentID = Engagements.AgentID
group by Agents.AgtFirstName, Agents.AgtLastName, agents.CommissionRate;

use SchoolSchedulingExample;

select Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName, AVG(Grade) as AverageGrade 
from ((((Student_Schedules inner join Students
on Student_Schedules.StudentID = Students.StudentID)
inner join Student_Class_Status on Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus)
inner join Classes on Classes.ClassID = Student_Schedules.ClassID)
inner join Subjects on Subjects.SubjectID = Classes.SubjectID)
inner join Categories on Categories.CategoryID = Subjects.CategoryID
where ClassStatusDescription = 'Completed'
group by Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName;

select Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName, AVG(Grade) as AverageGrade 
from ((((Categories inner join Subjects on Categories.CategoryID = Subjects.CategoryID) 
inner join Classes on Subjects.SubjectID = Classes.SubjectID)
inner join Student_Schedules on Classes.ClassID = Student_Schedules.ClassID)
inner join Student_Class_Status on Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus
inner join Students on Student_Schedules.StudentID = Students.StudentID)
where ClassStatusDescription = 'Completed'
group by Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName;

select CategoryDescription, COUNT(Classes.ClassID) from Categories inner join Subjects on Categories.CategoryID = Subjects.CategoryID
inner join Classes on Subjects.SubjectID = Classes.SubjectID
group by CategoryDescription;

select StfFirstName, StfLastname, count(ClassID) as NoClasses from staff inner join Faculty_Classes
on Staff.StaffID = Faculty_Classes.StaffID
group by StfFirstName, StfLastname
order by StfFirstName;

select StfFirstName, StfLastname, ( select count(*) from Faculty_Classes
where Faculty_Classes.StaffID = staff.StaffID) as NoOfClasses from staff 
order by StfFirstName;

select StfFirstName, StfLastname, count(ClassID) as NoClasses from staff left outer join Faculty_Classes
on Staff.StaffID = Faculty_Classes.StaffID
group by StfFirstName, StfLastname
order by StfFirstName;

use BowlingLeagueExample;

select Bowlers.BowlerFirstName, Bowlers.BowlerLastName, MAX(RawScore) from Bowlers inner join Bowler_Scores
on Bowlers.BowlerID = Bowler_Scores.BowlerID
group by Bowlers.BowlerFirstName, Bowlers.BowlerLastName;

select Bowlers.BowlerFirstName, Bowlers.BowlerLastName,
(select MAX(RawScore) from Bowler_Scores where Bowler_Scores.BowlerID = Bowlers.BowlerID)
from  Bowlers ;

select Bowlers.BowlerFirstName, Bowlers.BowlerLastName, avg(RawScore) from Bowlers inner join Bowler_Scores
on Bowlers.BowlerID = Bowler_Scores.BowlerID
group by Bowlers.BowlerFirstName, Bowlers.BowlerLastName;

use RecipesExample;

select IngredientClassDescription, COUNT(distinct RecipeID) from Recipe_Ingredients inner join
Ingredients on Recipe_Ingredients.IngredientID = Ingredients.IngredientID
right outer join Ingredient_Classes on Ingredient_Classes.IngredientClassID = Ingredients.IngredientClassID
group by IngredientClassDescription;

select IngredientName, MeasurementDescription, SUM(Amount) from Recipe_Ingredients
inner join Ingredients on Ingredients.IngredientID = Recipe_Ingredients.IngredientID
inner join Measurements on Measurements.MeasureAmountID = Recipe_Ingredients.MeasureAmountID
group by IngredientName, MeasurementDescription;

select Ingredients.IngredientName, count(RecipeID) as NoOfReceipes from Ingredients inner join Ingredient_Classes
on Ingredients.IngredientClassID = Ingredient_Classes.IngredientClassID
inner join Recipe_Ingredients on Ingredients.IngredientID = Recipe_Ingredients.IngredientID
where IngredientClassDescription = 'Meat'
group by Ingredients.IngredientName ;

select Ingredients.IngredientName,
(select count(RecipeID) as NoOfReceipes from Recipe_Ingredients as RI where RI.IngredientID = Ingredients.IngredientID)
from Ingredients inner join Ingredient_Classes
on Ingredients.IngredientClassID = Ingredient_Classes.IngredientClassID
where IngredientClassDescription = 'Meat';

select Ingredients.IngredientName, count(RecipeID) as NoOfReceipes from Ingredients 
inner join Ingredient_Classes on Ingredients.IngredientClassID = Ingredient_Classes.IngredientClassID
left outer join Recipe_Ingredients on Ingredients.IngredientID = Recipe_Ingredients.IngredientID
where IngredientClassDescription = 'Meat'
group by Ingredients.IngredientName ;