
use SalesOrdersExample

select (CustFirstName + ' '+  CustLastName) as customer, cast(OrderDate as date) as OrderDate
 from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID
order by OrderDate asc


select distinct (EmpFirstName + ' ' + EmpLastName) as Employee, (CustFirstName + ' ' + CustLastName) as Customer
 from ((Employees inner join Orders
on Employees.EmployeeID = Orders.EmployeeID )
inner join Customers on Customers.CustomerID = Orders.CustomerID)

select Orders.OrderNumber, Products.ProductName, Order_Details.QuotedPrice
from ((Orders inner join Order_Details
on Orders.OrderNumber = Order_Details.OrderNumber)
inner join Products on Products.ProductNumber = Order_Details.ProductNumber)
order by Orders.OrderNumber


select VendName as Vendor, ProductName as Product, WholesalePrice from Vendors inner join Product_Vendors
on Vendors.VendorID = Product_Vendors.VendorID
inner join Products on Products.ProductNumber = Product_Vendors.ProductNumber
where WholesalePrice < 100

select (CustFirstName + ' ' + CustLastName) as Customer, (EmpFirstName + ' '+  EmpLastName ) as Employee
 from Customers inner join Employees
on Customers.CustLastName = Employees.EmpLastName

select (CustFirstName + ' ' + CustLastName) as Customer, (EmpFirstName + ' '+  EmpLastName )as Employee, CustCity, EmpCity  as Employee
 from Customers inner join Employees 
 on Customers.CustCity = Employees.EmpCity


use EntertainmentAgencyExample	

select (AgtFirstName + ' '+ AgtLastName) as Agent, StartDate, EndDate
 from Engagements inner join Agents
on Engagements.AgentID = Agents.AgentID
order by StartDate asc

select distinct (CustFirstName + ' ' +CustLastName) as Customer , EntStageName as Entertainer   from ((Customers inner join Engagements
on Customers.CustomerID = Engagements.CustomerID) inner join Entertainers
on Entertainers.EntertainerID = Engagements.EntertainerID)

select (AgtFirstName + ' '+ AgtLastName) as Agent, (EntStageName) as Entertainer
 from Agents inner join Entertainers 
on Agents.AgtZipCode= Entertainers.EntZipCode

use BowlingLeagueExample

select Teams.TeamID, TeamName, (BowlerFirstName + ' ' + BowlerLastName) as Bowler
 from Teams inner join Bowlers
on Teams.TeamID = Bowlers.TeamID

select (BowlerFirstName + ' ' + BowlerLastName) as Bowler, MatchID, GameNumber, RawScore, HandiCapScore
 from Bowlers inner join Bowler_Scores
on Bowlers.BowlerID = Bowler_Scores.BowlerID

use RecipesExample

select RecipeTitle, Preparation, RecipeClassDescription  from Recipes inner join Recipe_Classes
on Recipes.RecipeClassID = Recipe_Classes.RecipeClassID
where RecipeClassDescription = 'salad'

select distinct RecipeTitle , IngredientClassDescription
from Recipes inner join Recipe_Ingredients 
on Recipes.RecipeID = Recipe_Ingredients.RecipeID
inner join Ingredients 
on Recipe_Ingredients.IngredientID = Ingredients.IngredientID
inner join Ingredient_Classes
on Ingredient_Classes.IngredientClassID = Ingredients.IngredientClassID
where IngredientClassDescription = 'Dairy'


select FirstIngredientName, FirstIngredient.Amount, SecondIngredientName from 
((select IngredientName as FirstIngredientName, Amount from Ingredients inner join Recipe_Ingredients
on Ingredients.IngredientID = Recipe_Ingredients.IngredientID) FirstIngredient inner join 
(select IngredientName as SecondIngredientName, Amount from Ingredients inner join Recipe_Ingredients
on Ingredients.IngredientID = Recipe_Ingredients.IngredientID) SecondIngredient on 
((FirstIngredient.Amount = SecondIngredient.Amount) and 
(FirstIngredient.FirstIngredientName <> SecondIngredient.SecondIngredientName )))