use salesordersexample;

select count(*) as CaliforniaCustomers from customers
where CustState = 'CA';

select distinct products.ProductNumber, ProductName from products 
inner join order_details on products.ProductNumber = order_details.ProductNumber
where QuotedPrice >= ( select avg(RetailPrice) from products);

select avg(RetailPrice) as AveragePriceofMountainBike from products
where ProductName like '% mountain Bike%';

select max(OrderDate) as RecentOrder from orders;

select SUM(QuotedPrice * QuantityOrdered) as TotalAmountOrder8 from order_details
where OrderNumber = 8;

use entertainmentagencyexample;

select EngagementNumber, ContractPrice from engagements
where StartDate = ( select min(StartDate) from engagements);

select sum(ContractPrice) from entertainmentagencyexample.engagements
where StartDate  between  '2012/10/1' and  '2012/10/31';

select avg(salary) from agents;

select EngagementNumber from engagements
where ContractPrice >= ( select avg(ContractPrice) from engagements);

select count(*) from entertainmentagencyexample.entertainers
where EntCity = 'Bellevue';

SELECT * FROM schoolschedulingexample.staff;

select max(salary) from staff;

select sum(salary) from staff
where StfState = 'CA';

select avg(Duration) from classes;

select StfFirstName, StfLastname from staff
where DateHired = (select min(DateHired) from staff);

select count(*) from classes
where ClassRoomID = 3346;

use bowlingleagueexample;

select  count(*) from tournaments where TourneyLocation = 'Red Rooster Lanes';

select  bowlers.BowlerFirstName, bowlers.BowlerLastName from bowlers 
where (select avg(RawScore) from bowler_scores as BS where BS.BowlerID = bowlers.BowlerID) >=
(select avg(RawScore) from bowler_scores);

select max(HandiCapScore) from bowler_scores;

select TourneyLocation from tournaments where TourneyDate = (select min(TourneyDate) from tournaments);

select max(TourneyDate) from tournaments;

use recipesexample;

select count(*) from recipe_ingredients
where IngredientID = (select IngredientID from ingredients as Test where Test.IngredientID = recipe_ingredients.IngredientID
and IngredientName like '%Beef%');

select count(*) from ingredients inner join measurements
on ingredients.MeasureAmountID = measurements.MeasureAmountID
and MeasurementDescription = 'Cup';
 
select RecipeTitle from (recipes inner join recipe_ingredients 
on recipes.RecipeID = recipe_ingredients.RecipeID)
inner join ingredients on ingredients.IngredientID = recipe_ingredients.IngredientID
where (IngredientName = 'Garlic'
and amount = (select max(Amount) from recipe_ingredients inner join 
ingredients on ingredients.IngredientID = recipe_ingredients.IngredientID
where IngredientName = 'Garlic'));

select count(*) from recipes inner join recipe_classes
on recipe_classes.RecipeClassID = recipes.RecipeClassID
where RecipeClassDescription = 'Main course';

select sum(Amount) from (recipes inner join recipe_ingredients 
on recipes.RecipeID = recipe_ingredients.RecipeID)
inner join ingredients on ingredients.IngredientID = recipe_ingredients.IngredientID
where IngredientName = 'Salt';