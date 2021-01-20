# create new database to store three tables acct.scv - account info, cust.csv - customer demographics info,  tran.csv - transactions info
create database segmentation;
use segmentation;

#import tables acct.scv cust.csv tran.csv using Table Data Import Wizard
#top 10 lines of each table to see the columns 
select * from acct
limit 10;
select * from cust
limit 10;
select * from tran
limit 10;

#Investigate NULL Category Tags
Select distinct description, categoryTags from tran
where categoryTags="";

#There is one distinct description, which has NULL value in categoryTags. Need to update the empty categoryTags to "Payday Loan"
UPDATE tran
SET categoryTags = 'Payday Loan'
where categoryTags="";

Select distinct categoryTags from tran

ALTER TABLE acct
MODIFY openDate date;



#joining all three tables together
select * from cust as c
left join acct as a
on c.id = a.cust_id
left join tran as t
on c.id = t.customerId;


#selecting only certain columns from the three tables and re-naming columns to better headings
select 
c.id as "Customer ID",
c.gender as "Gender",
c.birthDate as "Birth Date",
c.workActivity as "Work Activity",
c.totalIncome as "Income",
c.relationshipStatus as "Marital Status",
c.habitationStatus as "Habitation",
t.description as "Trans Description",
t.currencyAmount as "Trans Amount",
t.originationDateTime as "Trans Date",
t.categoryTags as "Trans Category",
a.branchNumber as "Bank Branch",
a.type as "Account Type",
a.openDate as "Open Date",
a.balance as "Account Balance",
a.currency as "Currency" 
from cust as c
left join acct as a
on c.id = a.cust_id
left join tran as t
on c.id = t.customerId;

#Create View and extract as CSV
create view Segmentation_table as
select 
c.id as "Customer ID",
c.gender as "Gender",
c.birthDate as "Birth Date",
c.workActivity as "Work Activity",
c.totalIncome as "Income",
c.relationshipStatus as "Marital Status",
c.habitationStatus as "Habitation",
t.description as "Trans Description",
t.currencyAmount as "Trans Amount",
t.originationDateTime as "Trans Date",
t.categoryTags as "Trans Category",
a.branchNumber as "Bank Branch",
a.type as "Account Type",
a.openDate as "Open Date",
a.balance as "Account Balance",
a.currency as "Currency" 
from cust as c
left join acct as a
on c.id = a.cust_id
left join tran as t
on c.id = t.customerId;