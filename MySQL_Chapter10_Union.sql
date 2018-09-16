use salesordersexample;
SELECT 
    distinct CONCAT(CustFirstName, ' ', CustLastName) AS Name, 'Customer' as Type, ProductName
FROM
    ((customers
    INNER JOIN orders ON customers.CustomerID = orders.CustomerID)
    INNER JOIN order_details ON orders.OrderNumber = order_details.OrderNumber)
        INNER JOIN
    products ON order_details.ProductNumber = products.ProductNumber
WHERE
    ProductName LIKE '%helmet%'
union all
select distinct VendName, 'Vendor' as Type, ProductName from (vendors inner join product_vendors
on vendors.VendorID = product_vendors.VendorID)
inner join products on products.ProductNumber = product_vendors.ProductNumber
where ProductName like '%helmet%'; 

use entertainmentagencyexample;

select concat(CustFirstName, ' ' , CustLastName) as Name , 'Customer' as Type from customers 
union
select entstagename, 'Entertainer' as Type from entertainers;


select concat(CustFirstName,' ' , CustLastName) As Name, 'Customer' as Type from (customers inner join musical_preferences
on customers.CustomerID = musical_preferences.CustomerID)
inner join musical_styles on musical_preferences.StyleID = musical_styles.StyleID
where StyleName = 'Contemporary'
union
select EntStageName, 'Entertainer' as TypeEntertainersEntertainerStylesEntertainersEntertainerStyles from (entertainers inner join entertainer_styles
on entertainers.EntertainerID = entertainer_styles.EntertainerID)
inner join musical_styles on musical_styles.StyleID = entertainer_styles.StyleID
where StyleName = 'Contemporary';

use schoolschedulingexample;
select StudFirstName, StudLastName, StudStreetAddress, StudCity, StudState,StudZipCode from students 
union
select StfFirstName,StfLastname,StfStreetAddress,StfCity,StfState, StfZipCode from staff
order by StudZipCode;


use Bowlingleagueexample;

use bowlingleagueexample;

select TourneyLocation,BowlerLastName,BowlerFirstName, RawScore from ((Bowlers inner join bowler_scores
on Bowlers.BowlerID = bowler_scores.bowlerid)
inner join tourney_matches on tourney_matches.MatchID = bowler_scores.MatchID)
inner join tournaments on tournaments.TourneyID = tourney_matches.TourneyID
 where TourneyLocation = 'Thunderbird Lanes'
 and RawScore >= 165
 union 
 select TourneyLocation,BowlerLastName,BowlerFirstName, RawScore from ((Bowlers inner join bowler_scores
on Bowlers.BowlerID = bowler_scores.bowlerid)
inner join tourney_matches on tourney_matches.MatchID = bowler_scores.MatchID)
inner join tournaments on tournaments.TourneyID = tourney_matches.TourneyID
 where TourneyLocation = 'Bolero Lanes'
 and RawScore >= 150;
 
 use recipesexample;

select IngredientName, MeasurementDescription from ingredients inner join measurements
on ingredients.MeasureAmountID = measurements.MeasureAmountID
union all
select distinct IngredientName, MeasurementDescription from ingredients inner join recipe_ingredients
on ingredients.IngredientID = recipe_ingredients.IngredientID
inner join measurements
on recipe_ingredients.MeasureAmountID = measurements.MeasureAmountID;