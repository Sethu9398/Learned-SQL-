create database task2

use task2
go

create table department(
deptId int primary key identity(1,1),
deptName varchar(max) not null);

create table employee(
empId int primary key identity(1,1),
empName varchar(max) not null,
deptId int ,
empSalary int not null
	constraint fk_deptId
	foreign key (deptId)
	references department(deptId)
);


INSERT INTO department (deptName)
VALUES
('IT'),
('HR'),
('Finance'),
('Sales'),
('Marketing');


INSERT INTO employee (empName, deptId, empSalary)
VALUES
('Ravi',    1, 60000),
('Kumar',   2, 45000),
('Priya',   1, 75000),
('Arun',    4, 50000),
('Meena',   1, 55000),
('Suresh',  3, 65000),
('Anitha',  2, 52000),
('Rahul',   4, 48000),
('Divya',   5, 70000),
('Vijay',   3, 80000);



BEGIN TRANSACTION;

UPDATE employee
SET empSalary = empSalary + 1000
WHERE empId = 1;

ROLLBACK TRANSACTION;

alter table employee
drop constraint fk_deptId;

alter table employee
add constraint fk_dept_Id
foreign key (deptId)
references department(deptId)
on delete cascade

delete department
where deptId=1

select * from employee;
select * from department;

select empId,empName , sum(empSalary) over(partition by deptId order by deptId) as total_dept_salary
from employee

select * ,min(empSalary) over() as minimum_Salary
from employee

select * ,ROW_NUMBER() over(order by empSalary desc) as ranking
from employee

select * ,rank() over(partition by deptId order by Empsalary desc) ranking
from employee;

select * , DENSE_RANK() over(partition by deptId order by Empsalary desc) dense_Ranking
from employee

select * , PERCENT_RANK() over(order by empSalary) 
from employee

select *,ntile(5) over(order by empSalary) 
from employee 

select *, lag(empSalary) over(order by empID)
from employee

select *, lead(empSalary) over(order by empID)
from employee

select * ,first_value(empSalary) over(order by empSalary)
from employee

select * ,last_value(empSalary) over(order by empSalary rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
from employee

--select * ,NTH_VALUE(empSalary,5) over(order by empSalary)
--from employee