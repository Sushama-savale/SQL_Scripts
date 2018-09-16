use SalesOrdersModify;

insert into Orders (OrderDate, ShipDate,CustomerID, EmployeeID, OrderTotal)
select cast('2013-06-12' as date) as OrderDate, cast('2013-06-15' as date)  as ShipDate, 
CustomerID, EmployeeID, OrderTotal from Orders 
where OrderDate = '2012-12-11' 
and CustomerID = (select CustomerID from  Customers 
		where CustFirstName = 'Liz' and CustLastName = 'Keyser')

insert into Order_Details (OrderNumber, ProductNumber, QuotedPrice, QuantityOrdered)
select 945 as OrderNumber,  ProductNumber, QuotedPrice, QuantityOrdered
from Order_Details
where OrderNumber = 
(select OrderNumber from Orders 
where OrderDate = '2012-12-11' 
and CustomerID = (select CustomerID from  Customers 
		where CustFirstName = 'Liz' and CustLastName = 'Keyser'))

insert into Customers( CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState,
CustZipCode, CustAreaCode, CustPhoneNumber)
values('Mary','Baker', '7834 W 32ndct', 'Bothell', 'WA', '98011','425', '555-9876');

insert into Orders ( OrderDate, ShipDate,CustomerID, EmployeeID, OrderTotal)
select  cast('2013-06-15' as date) as OrderDate, cast('2013-06-18' as date)  as ShipDate, 
CustomerID, EmployeeID, OrderTotal from Orders 
where (OrderDate between '2012-11-01' and '2012-11-30')
and CustomerID = (select CustomerID from  Customers 
		where CustFirstName = 'Angel' and CustLastName = 'Kennedy')

		/* not working
insert into Order_Details (OrderNumber, ProductNumber, QuotedPrice, QuantityOrdered)
select orders.OrderNumber, ProductNumber, QuotedPrice, QuantityOrdered
from Order_Details, Orders
where Order_Details.OrderNumber IN
(select OrderNumber from Orders as O1
where O1.OrderDate = '2012-12-11' 
and CustomerID = (select CustomerID from  Customers 
		where CustFirstName = 'Liz' and CustLastName = 'Keyser'))
		and 
		(Orders.OrderDate = '2013-06-15' and 
		Orders.CustomerID = (select CustomerID from  Customers 
		where CustFirstName = 'Liz' and CustLastName = 'Keyser')) */

use EntertainmentAgencyModify;

insert into Customers ( CustFirstName, CustLastName, CustStreetAddress,
CustCity, CustState, CustZipCode, CustPhoneNumber)
select AgtFirstName, AgtLastName, AgtStreetAddress, AgtCity, AgtState, AgtZipCode, AgtPhoneNumber
 from Agents where AgtFirstName = 'Marianne' and AgtLastName = 'Wier'

 insert into Musical_Styles (StyleName)
 values ('New Age')

 insert into Engagements 
 (StartDate,EndDate,StartTime,StopTime,ContractPrice, CustomerID,AgentID,EntertainerID)
 select '8/1/2013' AS StartDate, '8/4/2013' AS EndDate, 
 Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, 
 Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID from 
 Customers INNER JOIN Engagements ON 
 Customers.CustomerID = Engagements.CustomerID
WHERE     (Customers.CustFirstName = 'Doris') AND (Customers.CustLastName = 'Hartwig') 
AND (Engagements.StartDate = '12/1/2012');

use SchoolSchedulingModify;

insert into students 
([StudFirstName]
      ,[StudLastName]
      ,[StudStreetAddress]
      ,[StudCity]
      ,[StudState]
      ,[StudZipCode]
      ,[StudAreaCode]
      ,[StudPhoneNumber]
      ,[StudGPA]
      ,[StudMajor])
	  select 'Angel'
      ,[StudLastName]
      ,[StudStreetAddress]
      ,[StudCity]
      ,[StudState]
      ,[StudZipCode]
      ,[StudAreaCode]
      ,[StudPhoneNumber]
      ,[StudGPA]
      ,[StudMajor] from Students where StudFirstName = 'John' and StudLastName = 'Kennedy'

insert into Students ([StudFirstName],[StudLastName],[StudStreetAddress]
      ,[StudCity],[StudState] ,[StudZipCode],[StudAreaCode],[StudPhoneNumber]
      ,[StudGPA],[StudMajor])
	  select StfFirstName,StfLastname,StfStreetAddress, StfCity,
	  StfState, StfZipCode, StfAreaCode, StfPhoneNumber,0,null 
	  from Staff where StfFirstName= 'Tim' and StfLastname='Smith'

use BowlingLeagueModify

insert into Tournaments_Archive (TourneyID,TourneyDate,TourneyLocation)
select TourneyID,TourneyDate,TourneyLocation 
from Tournaments where TourneyDate between '2012-01-01' and '2012-12-31'

insert into Tourney_Matches_Archive (MatchID,TourneyID,Lanes,OddLaneTeamID,EvenLaneTeamID)
select MatchID,TourneyID,Lanes,OddLaneTeamID,EvenLaneTeamID from Tourney_Matches
where TourneyID in 
(select TourneyID
from Tournaments where TourneyDate between '2012-01-01' and '2012-12-31')

insert into Match_Games_Archive(MatchID, GameNumber, WinningTeamID)
select Match_Games.MatchID, GameNumber, WinningTeamID 
from Match_Games inner join Tourney_Matches 
on Match_Games.MatchID = Tourney_Matches.MatchID
inner join Tournaments 
on Tournaments.TourneyID = Tourney_Matches.TourneyID
where TourneyDate between '2012-01-01' and '2012-12-31'

insert into Bowler_Scores_Archive (MatchID,GameNumber,BowlerID,HandiCapScore,WonGame)
select Bowler_Scores.MatchID,GameNumber,BowlerID,HandiCapScore,WonGame 
from Bowler_Scores inner join Tourney_Matches 
on Bowler_Scores.MatchID = Tourney_Matches.MatchID
inner join Tournaments 
on Tournaments.TourneyID = Tourney_Matches.TourneyID
where TourneyDate between '2012-01-01' and '2012-12-31'

insert into Tournaments_Archive (TourneyID,TourneyDate,TourneyLocation)
select TourneyID + 25 ,DateAdd(d, 728, TourneyDate),TourneyLocation 
from Tournaments where TourneyDate between '2012-01-01' and '2012-12-31'

 /* not working 
 
 insert into Tourney_Matches_Archive (TourneyID,Lanes,OddLaneTeamID,EvenLaneTeamID)
select TourneyID + 25,Lanes,OddLaneTeamID,EvenLaneTeamID from Tourney_Matches
where TourneyID in 
(select TourneyID
from Tournaments where TourneyDate between '2012-01-01' and '2012-12-31') */
