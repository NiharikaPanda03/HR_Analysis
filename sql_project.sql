select * from hr1;
select * from hr2;
select * from kpi_1;
select * from kpi_2;
select * from kpi_3;
select * from kpi_4;
select * from kpi_5;
select * from kpi_6;

#Q1 Avg Attrition rate of all department
create view kpi_1
as
select a.department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_y from hr1 ) as a
group by a.department;


#Q2 Average Hourly rate of male research scientist
create view kpi_2
as
select avg(hourly_rate), gender, job_role from hr1
where job_role='Research Scientist' and gender="male";


#Q3 attrition rate vs monthly income stats
create view kpi_3
as
select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_attrition,format(avg(b.monthly_income),2) as Average_Monthly_Income
from ( select department,attrition, employee_number as employee_id,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr1) as a
inner join hr2 as b on b.employee_id = a.employee_id
group by a.department;


#Q4 Average working years for each department
create view kpi_4
as
select a.department, format(avg(b.total_working_years),1) as Average_Working_Year
from hr1 as a
inner join hr2 as b on b.employee_id=a.employee_number
group by a.department;


#Q5 Job role Vs Work life balance
create view kpi_5
as
select a.job_role,
sum(case when performance_rating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performance_rating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performance_rating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performance_rating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(b.performance_rating) as Total_Employee, format(avg(b.work_life_balance),2) as Average_WorkLifeBalance_Rating
from hr1 as a
inner join hr2 as b on b.employee_id = a.employee_number
group by a.job_role;


#Q6 Attrition rate vs last years since promotion
create view kpi_6
as
select a.job_role, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(b.years_since_last_promotion),2) as Average_YearsSinceLastPromotion
from ( select job_role, attrition, employee_number as employee_id,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr1) as a
inner join hr2 as b on b.employee_id = a.employee_id
group by a.job_role;