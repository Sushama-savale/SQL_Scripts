use SalesOrdersExample;

select VendName, 
(select count(ProductNumber) from Product_Vendors as PV where PV.VendorID = Vendors.VendorID) 
from Vendors ;

select distinct  Products.ProductNumber, ProductName, 
(select MAX(OrderDate) from Orders where Orders.OrderNumber IN
(select distinct OrderNumber from Order_Details inner join Products 
on Products.ProductNumber = Order_Details.ProductNumber))  As LatestOrderDate
from Products;

select distinct OrderNumber from Order_Details inner join Products 
on Products.ProductNumber = Order_Details.ProductNumber
where Order_Details.ProductNumber = 2

select MAX(OrderDate) from Orders where Orders.OrderNumber IN (6,105);

select distinct  Products.ProductNumber, ProductName, 
(select MAX(OrderDate) from Orders inner join Order_Details 
on Orders.OrderNumber = Order_Details.OrderNumber
where Order_Details.ProductNumber = Products.ProductNumber)  As LatestOrderDate
from Products;

select distinct CustFirstName, CustLastName from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join Order_Details 
on Orders.OrderNumber = Order_Details.OrderNumber
inner join Products on Products.ProductNumber = Order_Details.ProductNumber
inner join Categories on Products.CategoryID = Categories.CategoryID
where CategoryDescription = 'Bikes';

select CustFirstName, CustLastName from Customers where CustomerID IN
(select CustomerID from Orders
where OrderNumber IN
	(select OrderNumber from Order_Details
	  where ProductNumber IN
		(select ProductNumber from Products
		 where CategoryID IN
			(select CategoryID from Categories
			where CategoryDescription = 'Bikes'))));

select ProductName from Products left outer join Order_Details
on Products.ProductNumber = Order_Details.ProductNumber
where Order_Details.OrderNumber is null;

select productName from Products where ProductNumber not in
(select ProductNumber from Order_Details);

use EntertainmentAgencyExample;

select CustFirstName, CustLastName, MAX(startDate) as LastBooking from Customers inner join Engagements
on Customers.CustomerID = Engagements.CustomerID
group by CustFirstName, CustLastName;

select CustFirstName, CustLastName, 
( select MAX(startDate) from Engagements where Engagements.CustomerID = Customers.CustomerID) as LastBooking 
from Customers ;

select EntStageName, count(EngagementNumber) from Entertainers left outer join Engagements
on Entertainers.EntertainerID = Engagements.EntertainerID
group by EntStageName;

select  EntStageName,
(select count(EngagementNumber) from Engagements where Engagements.EntertainerID = Entertainers.EntertainerID) as NoOfEngagements
 from Entertainers;

 select CustFirstName, CustLastName from Customers where CustomerID IN
	(select CustomerID from Engagements where EntertainerID IN
		(select EntertainerID from Entertainer_Styles where StyleID IN
			(select StyleID from Musical_Styles where StyleName= 'Country'
												or StyleName = 'Country Rock')));

select distinct  CustFirstName, CustLastName from Customers inner join Engagements
on Customers.CustomerID = Engagements.CustomerID
inner join Entertainer_Styles on Entertainer_Styles.EntertainerID = Engagements.EntertainerID
inner join Musical_Styles on Musical_Styles.StyleID = Entertainer_Styles.StyleID
where Musical_Styles.StyleName = 'Country' Or Musical_Styles.StyleName = 'Country Rock';

select distinct Entertainers.EntertainerID, EntStageName from Entertainers inner join Engagements
on Entertainers.EntertainerID = Engagements.EntertainerID 
inner join Customers on Engagements.CustomerID = Customers.CustomerID
where CustFirstName = 'Berg' or CustFirstName = 'Hallmark'
   or CustLastName = 'Berg' or CustLastName = 'Hallmark';

select EntertainerID, EntStageName from Entertainers where EntertainerID = SOME
	(select EntertainerID  from  Engagements where CustomerID IN
		(select CustomerID from Customers where 
		CustFirstName = 'Berg' or CustFirstName = 'Hallmark'
   or CustLastName = 'Berg' or CustLastName = 'Hallmark')) 

   select AgtFirstName, AgtLastName from Agents left outer join Engagements
   on Agents.AgentID = Engagements.AgentID
   where Engagements.AgentID is null;
   
   select AgtFirstName, AgtLastName from Agents where AgentID not in
   (select AgentID from Engagements);

   use BowlingLeagueExample;

   select BowlerFirstName, BowlerLastName, 
   (select max(RawScore) from Bowler_Scores as BS where BS.BowlerID = Bowlers.BowlerID) as HighScore
   from Bowlers ;

     select BowlerFirstName, BowlerLastName, 
   (select count(*) from Bowler_Scores as BS where BS.BowlerID = Bowlers.BowlerID) as GamesPlayed
   from Bowlers ;
   
   select BowlerFirstName, BowlerLastName from Bowlers inner join Bowler_Scores
   on Bowlers.BowlerID = Bowler_Scores.BowlerID
   where Bowler_Scores.RawScore < ALL
   ( select BS.RawScore from 
   Bowler_Scores as BS inner join Bowlers as B2
   on BS.BowlerID = B2.BowlerID
   where b2.BowlerID <> Bowlers.BowlerID and B2.TeamID = Bowlers.TeamID)

   use RecipesExample;

   select RecipeClassDescription, count(RecipeID) as NoOfReceips from Recipe_Classes left outer join Recipes
   on Recipe_Classes.RecipeClassID = Recipes.RecipeClassID
   group by RecipeClassDescription;
   
   select RecipeClassDescription, 
   (select count(RecipeID) from Recipes where Recipes.RecipeClassID = Recipe_Classes.RecipeClassID)
    from Recipe_Classes;

	select IngredientName from Ingredients where MeasureAmountID <> some
	(select MeasureAmountID from Recipe_Ingredients as RI where RI.IngredientID = Ingredients.IngredientID)
   
   select Recipes.RecipeTitle, IngredientName from Ingredients inner join Recipe_Ingredients
   on Ingredients.IngredientID = Recipe_Ingredients.IngredientID 
   inner join Recipes on Recipes.RecipeID = Recipe_Ingredients.RecipeID
   where Recipe_Ingredients.RecipeID IN
   (select RecipeID from Recipe_Ingredients inner join Ingredients 
   on Recipe_Ingredients.IngredientID = Ingredients.IngredientID
   where Ingredients.IngredientName = 'Carrot')