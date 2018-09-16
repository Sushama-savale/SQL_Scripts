use BowlingLeagueModify

update Teams
set TeamName = 'Manta Rays '
where TeamName = 'Huckleberrys';

update Bowlers
set BowlerCity = ( select City from WAZips where ZIP = Bowlers.BowlerZip)  
where BowlerCity <> ( select City from WAZips where ZIP = Bowlers.BowlerZip)
Update Bowlers 
set BowlerState = ( select State from WAZips where ZIP = Bowlers.BowlerZip)
where BowlerState <> ( select State from WAZips where ZIP = Bowlers.BowlerZip)
		

update Bowlers
set BowlerCity = ( select City from WAZips where ZIP = Bowlers.BowlerZip)  
,BowlerState =  ( select State from WAZips where ZIP = Bowlers.BowlerZip)

use SchoolSchedulingModify

update staff
set Salary = (1.05 * Salary)
where staffid IN  ( Select StaffID from Faculty where Status = 'Full Time' and Tenured = 1);

update Staff
set StfAreaCode =  360 
where StfZipCode in (98270, 98271);

use EntertainmentAgencyModify;

update 


		
		