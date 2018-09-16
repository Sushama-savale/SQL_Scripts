use [SalesOrdersExample]

select distinct (CustFirstName + ' ' + CustLastName) as Customer 
from Customers left outer join 
			(select Orders.CustomerID  from 
					(( Orders inner join Order_Details
					 on Orders.OrderNumber = Order_Details.OrderNumber)
						inner join Products  on 
						Order_Details.ProductNumber = Products.ProductNumber)
			where ProductName like '%helmet%') as HelmetCustomer
			on Customers.CustomerID = HelmetCustomer.CustomerID
where HelmetCustomer.CustomerID is null

select (CustFirstName + ' ' + CustLastName) as Customer from Customers left outer join
			  Employees on Customers.CustZipCode = Employees.EmpZipCode	
			  where Employees.EmpZipCode is null

select distinct Products.ProductName, Orders.OrderDate from Products left outer join
			  (Order_Details inner join Orders
							on Order_Details.OrderNumber = Orders.OrderNumber)
				on Products.ProductNumber = Order_Details.ProductNumber

use EntertainmentAgencyExample

select (AgtFirstName + ' ' +AgtLastName) as agent from Agents left outer join Engagements
 on Agents.AgentID = Engagements.AgentID
 where Engagements.AgentID is null 

 select (CustFirstName + ' ' +CustLastName) as Customer from Customers left outer join Engagements
 on Customers.CustomerID = Engagements.CustomerID
 where Engagements.CustomerID is null 

 select EntStageName , EngagementNumber, StartDate,StartTime
 from Entertainers left outer join Engagements
 on Entertainers.EntertainerID = Engagements.EntertainerID

 use SchoolSchedulingExample

 select classes.ClassID from Classes left outer join 
 (select ClassID from (Student_Schedules inner join Student_Class_Status 
 on Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus)
 where Student_Class_Status.ClassStatusDescription = 'Enrolled') as EnrolledClasses
 on Classes.ClassID = EnrolledClasses.ClassID
 where EnrolledClasses.ClassID is null

 select SubjectCode, SubjectName from Subjects left outer join Faculty_Subjects
 on Subjects.SubjectID = Faculty_Subjects.SubjectID
 where Faculty_Subjects.StaffID is null

 select (StudFirstName + ' ' + StudLastName) as Student from Students 
 left outer join  ( select StudentID from (Student_Schedules inner join Student_Class_Status
					on Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus)
					where Student_Class_Status.ClassStatusDescription = 'Enrolled') as EnrolledStudents
 on Students.StudentID = EnrolledStudents.StudentID
 where EnrolledStudents.StudentID is null

 select (StfFirstName + ' ' + StfLastname) as Faculty, Classes.ClassID, StartDate, Subjects.SubjectName
  from staff left outer join
				(( Faculty_Classes inner join Classes 
				on Faculty_Classes.ClassID = Classes.ClassID)
				inner join Subjects on Subjects.SubjectID = Classes.SubjectID)
				on Staff.StaffID = Faculty_Classes.StaffID

use BowlingLeagueExample
select Tourney_Matches.MatchID, TourneyID from Tourney_Matches left outer join Match_Games
on Tourney_Matches.MatchID = Match_Games.MatchID
where Match_Games.MatchID is null

select Tournaments.TourneyID, TourneyDate, TourneyLocation, Tourney_Matches.MatchID from Tournaments
left outer join 
Tourney_Matches 
on Tournaments.TourneyID = Tourney_Matches.TourneyID
where Tourney_Matches.MatchID is null

use RecipesExample

select RecipeClassDescription from Recipe_Classes left outer join Recipes
on Recipe_Classes.RecipeClassID = Recipes.RecipeClassID
where Recipes.RecipeClassID is null

select IngredientName, RecipeTitle from Ingredients  left outer join 
(Recipe_Ingredients inner join Recipes
on Recipe_Ingredients.RecipeID = Recipes.RecipeID)
on Ingredients.IngredientID = Recipe_Ingredients.IngredientID

select RecipeClassDescription, RecipeTitle from Recipe_Classes left outer join Recipes
on Recipe_Classes.RecipeClassID = Recipes.RecipeClassID


