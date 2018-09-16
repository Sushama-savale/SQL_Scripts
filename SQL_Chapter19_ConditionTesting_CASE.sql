use SalesOrdersExample;

select distinct Products.ProductNumber, ProductName, 
(case when  Products.ProductNumber IN
	(select Order_Details.ProductNumber from Order_Details inner join Orders 
			on Orders.OrderNumber = Order_Details.OrderNumber
            where (Orders.OrderDate between CAST('2012-12-01' as date) and CAST('2012-12-31' as date)))
			then 'Ordered'
            else 'Not ordered'
			end) as ProductStatus from products

select Products.ProductNumber, ProductName ,
( case when sum(QuantityOrdered) <= 200
        then 'Poor'
		when sum(QuantityOrdered) > 200 and sum(QuantityOrdered) <= 500
		then 'Average'
		when sum(QuantityOrdered) > 500 and sum(QuantityOrdered) <= 1000
		then 'Good'
		when sum(QuantityOrdered) > 1000
		then 'Excellent'
		end  ) as SaleRating
from Products left join Order_Details
on Products.ProductNumber = Order_Details.ProductNumber
group by Products.ProductNumber, ProductName

select Customers.CustomerID, (Customers.CustFirstName + ' ' + Customers.CustLastName) as CustomerName,
(case when customers.CustomerID IN 
            ( select CustomerID from Orders where OrderDate between 
			cast('2012-12-01' as date) and cast('2012-12-07' as date) )
		then 'Ordered'
		else ' Not ordered'
		end
) as DecFirstWkOrder
 from Customers;

 select Customers.CustomerID, (Customers.CustFirstName + ' ' + Customers.CustLastName) as CustomerName,
 (case CustState when 'OR' then 'Oregon'
				 when 'TX' then 'Texas'
				 when 'CA' then 'California'
				 when 'WA' then 'Washigton'
				 end
  ) as State  from Customers

  select EmployeeID, (EmpFirstName + ' '+ EmpLastName) as Employee,
  DATEDIFF(yy, EmpBirthDate, CAST('2014-02-15' AS Date)) - 
         (CASE WHEN Month(EmpBirthDate) < 2 
		       THEN 0 
			   WHEN Month(EmpBirthDate) > 2 
			   THEN 1 
			   WHEN Day(EmpBirthDate) > 15 
			   THEN 1 
			   ELSE 0 END) AS EmpAge
  from Employees;

  use EntertainmentAgencyExample;

  select Customers.CustomerID, (Customers.CustFirstName + ' ' + Customers.CustLastName) as Customer,
  (case Musical_Styles.StyleName when '50''s Music'
                                  then 'Oldies'
								  when'60''s Music'
								  then 'Oldies'
								  when '70''s Music'
                                  then 'Oldies'
								  when '80''s Music'
                                  then 'Oldies'
								  else Musical_Styles.StyleName 
								  end) as Style
   from Customers inner join Musical_Preferences
  on Customers.CustomerID = Musical_Preferences.CustomerID
  inner join Musical_Styles on Musical_Preferences.StyleID = Musical_Styles.StyleID;

  select EntertainerID, EntStageName from Entertainers where EntertainerID IN
  (select EntertainerID from Entertainer_Styles inner join Musical_Styles
  on Entertainer_Styles.StyleID = Musical_Styles.StyleID
  where StyleName = 'Jazz')
  and EntertainerID not in 
  (select EntertainerID from Entertainer_Styles inner join Musical_Styles
  on Entertainer_Styles.StyleID = Musical_Styles.StyleID
  where StyleName = 'Contemporary')

  use SchoolSchedulingExample;

  select (StudFirstName + ' ' +StudLastName) as Student,
  (case StudMaritalStatus when 'S' then 'Single'
                          when 'M' then 'Married'
						  when 'D' then 'Divorced'
						  when 'W' then 'Widowed' end  ) as MaritalStatus
	from Students

	select (StudFirstName + ' ' +StudLastName) as Student,
	DATEDIFF(year, StudBirthDate, cast('2012-11-15' as date ))-
	(case when MONTH(StudBirthDate) <= 11 then 0 
	      when MONTH(StudBirthDate) > 11 then 1
		  when DAY(StudBirthDate) > 11 then 1
		  else 0 end              ) as StudAge
	from Students

	use BowlingLeagueExample

	select bowlers.BowlerID, (BowlerFirstName + ' ' + BowlerLastName) As BowlerName,
	(case when count(GameNumber) = 0 then 0
	        else (sum(RawScore)/ count(GameNumber)) end) as AverageScore
	 from Bowlers left outer join Bowler_Scores 
	 on Bowlers.BowlerID = Bowler_Scores.BowlerID
	 group by bowlers.BowlerID, (BowlerFirstName + ' ' + BowlerLastName);

   