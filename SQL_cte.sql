/* 1. Find the 3rd highest paid player.*/
/* Assumption: Salary Table: There could be different SalaryID for same PlayerID 
to implement multiple salaries offered to him*/
use Ancestry;
with cteSalaryPerPlayer (PlayerID, TotSal) as
(
select PlayerID, sum(Amount) as TotSal from Salaries group by PlayerID
)
select (FirstName + ' ' + LastName) as thirdHighestPaidPlayer , TotSal as Amount from 
Players as P inner join cteSalaryPerPlayer as cte
on cte.PlayerID = P.PlayerID
order by Amount desc
OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;


/* 2. Find the 3rd lowest paid player.*/

with cteSalaryPerPlayer (PlayerID, TotSal) as
(
select PlayerID, sum(Amount) as TotSal from Salaries group by PlayerID
)
select (FirstName + ' ' + LastName) as thirdLowestPaidPlayer , TotSal as Amount from 
Players as P inner join cteSalaryPerPlayer as cte
on cte.PlayerID = P.PlayerID
order by Amount asc
OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;

/* 3. Which position scored the most goals?*/
select PositionName, sum(Totalcount) as NoOfGoals from Positions as PS
inner join  Players as P on P.PositionID = PS.PositionID inner join
 (select PlayerID , count(GoalId) as Totalcount
from ScoredGoals 
group by PlayerID) as TotalGoals
on P.PlayerID =  TotalGoals.PlayerID
group by PositionName
order by NoOfGoals desc
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;
----------------------------------------------------------
with cteTotalGoal (PlayerID,Totalcount)
as
(select PlayerID , count(GoalId) from ScoredGoals 
group by PlayerID
)
select PositionName, sum(Totalcount) as NoOfGoals  from Positions as PS inner join 
 Players as P on PS.PositionID = P.PositionID
 inner join  cteTotalGoal on P.PlayerID = cteTotalGoal.PlayerID
where Totalcount IN (select MAX(Totalcount)from cteTotalGoal)
group by PositionName

/* 4. Which players never scored?*/

select (FirstName + ' '+ LastName) as PlayerNeverScored
from Players as P  left outer join ScoredGoals as SG
on P.PlayerID = SG.PlayerID
where SG.PlayerID is null

/* 5. Which player scored the most goals?*/

with cteTotalGoal (PlayerID,Totalcount)
as
(select PlayerID , count(GoalId) from ScoredGoals 
group by PlayerID
)
select (FirstName + ' ' + LastName) as Player, Totalcount as NoOfGoals 
from Players as P inner join  cteTotalGoal 
on P.PlayerID = cteTotalGoal.PlayerID
where Totalcount = (select MAX(Totalcount)from cteTotalGoal)

/* 6. Which player scored the most goals in a single game*/

with cteTotalGoalsPerGamePerPlayer(GameID, PlayerID, TotalGoal) as
(
select GameID, PlayerID , count(GoalId) as TotalGoal from ScoredGoals 
group by PlayerID, GameID
),
cteMaxGoalsPerGame (GameID, MaxGoal ) as
(
select GameID, MAX(TotalGoal)from cteTotalGoalsPerGamePerPlayer group by GameID
)
select a1.GameID, (FirstName + ' '+ LastName) as Player, MaxGoal 
from cteTotalGoalsPerGamePerPlayer as a1 inner join cteMaxGoalsPerGame as a2
on a1.GameID = a2.GameID inner join Players as P
on P.PlayerID = a1.PlayerID
where a1.TotalGoal = MaxGoal ;

/* 7.  What is the salary paid per goal per position?*/

with cteTotalSalaryPerPos (PositionName , TotalSal) as
(
select PositionName, SUM(Amount1) from Players as P 
inner join (select PlayerID, sum(Amount) as Amount1 from Salaries group by PlayerID) as salPerPlayer
on salPerPlayer.PlayerID = P.PlayerID
inner join Positions as PS
on PS.PositionID = P.PositionID
group by PositionName),
cteTotalGoalPerPos (PositionName, TotalGoal) as
(
select PositionName, sum(TotalGoal) from Players as P
inner join Positions as PS on PS.PositionID = P.PositionID
inner join (select PlayerID, count(GoalId) as TotalGoal from ScoredGoals group by PlayerID) as goalPerPlayer
on goalPerPlayer.PlayerID = P.PlayerID 
group by PositionName
)
select a1.PositionName, TotalSal, TotalGoal,TotalSal/TotalGoal as SalaryPerPositionPerGoal from cteTotalGoalPerPos as a1 inner join cteTotalSalaryPerPos as a2
on a1.PositionName = a2.PositionName;

/*8.       What is the average minute of scoredgoals for each game?*/

select GameID, avg(Minute_time) as Average_Minute from ScoredGoals group by GameID

/* 9. What should the Salaries table look like if we needed to track historical data? */
/* Salaries (SalaryID, PlayerID, Amount, DATEofSalary )*/









	