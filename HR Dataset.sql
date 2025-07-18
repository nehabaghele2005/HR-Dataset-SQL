create database hrdata; 
use hrdata;
select * from employees;
-- total employees
select count(*) as total_employees from employees;
-- total old employees 
select count(*) as total_old_employees from employees
where dateoftermination != '';
select count(*) as total_old_employees from employees
where dateoftermination = '';

-- avg salary
select avg(salary) as avg_salary from employees;

-- avg age
select avg(timestampdiff(year, str_to_date(dob, '%d-%m-%Y'), curdate()))
as avg_age from employees;		

-- average years in company
select avg(timestampdiff(year, str_to_date(dateofhire, '%d-%m-%Y'), curdate()))
as avg_years_in_company from employees;

-- add new column 
alter table employees add employeecurrentstatus int;

-- updating values for new column 
set sql_safe_updates=0;
update employees 
set employeecurrentstatus = case
when dateoftermination = '' then 1 
else 0 
end;	

-- calculate attrition rate based on custom empstatusid values 
select (cast(count(case when employeecurrentstatus = 0 then 1 end) as float) / count(*)) * 100 as attrition_rate from employees;	

-- get column names and data types or show columns from employees 
describe employees;
 
 -- print limit 5
select * from employees limit 5;  

-- print last 5 rows  
select * from employees order by empid desc limit 5;

-- changing data types of salary int to decimal
alter table employees modify column salary decimal(10,2);

-- convert all date columns in proper dates
update employees 
set dob = str_to_date(dob, '%d-%m-%Y');

update employees 
set dateofhire = str_to_date(dateofhire, '%d-%m-%Y');

update employees 
set lastperformancereview_date = str_to_date(lastperformancereview_date, '%d-%m-%Y');

alter table employees 
modify column dob date,
modify column dateofhire date,
modify column lastperformancereview_date date;

alter table employees add employeestatus int;
set sql_safe_updates=0;
update employees 
set employeestatus = case
when dateoftermination = '' then 1 
else 0 
end;



  