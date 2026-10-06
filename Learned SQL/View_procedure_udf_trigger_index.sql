
--create database task1;

--use task1
--go

--Write a query to display Employee Name, Department Name and Manager Name using the appropriate JOIN.

--create table employee(
--empId int primary key identity(1,1),
--empName varchar(200) not null,
--salary int not null,
--deptId int

--	constraint fk_deptId
--	foreign key(deptId) 
--	references department(deptId)
--);


--create table department(
--deptId int primary key identity(1,1),
--deptName varchar(max) not null );

insert into department(deptName) values('Full Stack Developer'),('Frontend Developer'),('Backend Developer'),('Testing'),('Q/A');


insert into employee(empName,salary,deptId) values('sethu',20000,1),('Alagar',100000,5),('kowshik',15000,3),('deepak',13000,2),('sabari',18000,3),('kiran',12000,null);



--alter table employee
--add isDelete int default 0;

--truncate table employee;

select e.empName,d.deptName
from employee e
inner join department d
on e.deptId=d.deptId;

update employee
set isDelete=1
where empId=6;

--Write a query to display Department Name, Total Number of Employees and Average Salary using aggregate functions and GROUP BY.

select  d.deptName,count(empId) as no_of_employees,avg(e.salary) as average_salary
from employee e
inner join department d
on d.deptId=e.deptId
group by d.deptName;






--Create a view to display all active employees with their Department Name and Salary.

create view activeEmployee
as
select e.empName,d.deptName,e.salary
from employee e
inner join department d
on e.deptId=d.deptId
where e.isDelete<>1;

drop view activeEmployee;

select * from activeEmployee;


--Create sp_Department_CRUD supporting Insert, Update, Select and Delete operations for the Department table.

create procedure insertDept
@deptName varchar(200)
as
begin
	insert into department(deptName) values(@deptName);
end

exec insertDept 'devops';

create procedure updateDept
@id int, @name varchar(200)
as
begin
	update department
	set deptName=@name
	where deptId=@id;
end

exec updatedept 6 ,'DevOps'

create procedure selectDept
@id int
as
begin
	select * from department
	where deptId=@id;
end

exec selectDept 1;

create procedure deleteDept
@id int
as
begin
	delete department
	where deptId=@id;
end

exec deleteDept 6;


--Modify the Employee delete operation to implement Soft Delete instead of permanently deleting the employee record.

update employee
set isDelete=1
where empId=5;

 --Create a separate stored procedure to permanently delete an employee record using EmployeeId (Hard Delete).

 create procedure deleteEmployee
 @id int
 as
 begin
	 delete employee
	 where empId=@id
 end

 exec deleteEmployee 5;


 --Create an Upsert procedure for Employee that INSERTs a new employee when EmployeeId does not exist and UPDATEs the employee when EmployeeId already exists.

 create procedure upsertEmployee
 @id int=null,@name varchar(200)=null,@salary int =null,@deptId int=null
 as
 begin
	 if @id is not null and exists (select 1 from employee where empId=@id)
	 begin
		 update employee
		 set empName=COALESCE(@name,empName),
		 salary=COALESCE(@salary,salary),
		 deptId=COALESCE(@deptId,deptId)
		 where empId=@id
	 end

	 else
	 begin
		 insert into employee(empName,salary,deptId)  values(@name,@salary,@deptId)
	 end
 end

 drop procedure upsertEmployee;

exec upsertEmployee @name='sujith',@salary=13000,@deptId=2;
 

--Write a query to display Department Name, Maximum Salary, Minimum Salary and Total Salary for each department using aggregate functions

select * from department;
select * from employee;


select d.deptName,max(e.salary) as Maximum_Salary,min(e.salary) as Minimum_Salary,sum(e.salary) as Total_salary
from employee e
join department d
on e.deptId=d.deptId
group by d.deptName

--Write a query to display all employees, including employees who are not assigned to any department, using the appropriate JOIN.

select * 
from employee e
left join department d
on e.deptId=d.deptId;

--Given an unnormalized Employee-Project table containing Employee, Department, Project and Manager details, identify the normalization problems and split the table into appropriate normalized tables with Primary Keys and Foreign Keys.

create table employeeDetail_denormalization(
emp_id int primary key identity(1,1),
emp_name varchar(max) not null,
dept_id int not null,
dept_name varchar(max) not null ,
project_id int not null,
project_name varchar(max) not null,
manager_id int not null,
manager_name varchar(max) not null
)

select * from employeeDetail_denormalization;


insert into employeeDetail_denormalization(emp_name,dept_id,dept_name,project_id,project_name,manager_id,manager_name) values('sethu',1,'full stack developer',1,'task management',1,'shamugaprian'),('alagar',2,'data analyist',2,'flow chart',2,'vivek')

create table dept(
dept_id int primary key identity(1,1),
dept_name varchar(200) not null
)

create table employeeDetail(
emp_id int primary key identity(1,1),
emp_name varchar(200) not null
)

alter table employeeDetail
add dept_id int not null;

alter table employeeDetail
add constraint fk_d_Id
foreign key (dept_id)
references dept(dept_id)

create table manager(
m_id int primary key identity(1,1),
m_name varchar(200) not null,
)

alter table manager
add project_id int

alter table manager
add constraint fk_p_id
foreign key (project_id)
references project(p_id)



create table project(
p_id int primary key identity(1,1),
p_name varchar(200) not null)

select * from employeeDetail
select * from dept;


create trigger Trg_employee
on employee
instead of delete
as
begin
	print 'summa irukuda dei'
end

drop trigger  Trg_employee;

delete employee
where empId=12;

select * from employee;

create trigger trg_emp
on employee
before insert 
as
begin
	select * from inserted;
end



--drop trigger insertEmptrg;

select * from empLog;

insert into employee(empName,salary,deptId) values('puttu pandi',15000,1);

insert into employee(empName,salary,deptId) values('pk',25000,3),('pandi',30000,2),('vj pandiyan',25000,1);

delete employee
where empId=11;


CREATE TRIGGER trg_DDL
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'A table was created';
END;

drop trigger trg_DDL;

create table adengappa(
id int primary key identity(1,1),
nick_name varchar(200) unique)

drop table adengappa;

create function percentSalary(@salary int)
returns int
as
begin
 return @salary * 0.10
end;
drop table employee;

select EmployeeID,FirstName,dbo.percentsalary(Salary) as TenPercentOfSalary from employee

create function getEmpFromRole(@role varchar(max))
returns table
as
return(select EmployeeID,FirstName,LastName,HireDate from employee where emp_Role=@role);


select * from dbo.getEmpFromRole('developer');

select * from employee;

create index idx_emp_name
on employee(empName);


drop index idx_EmpName on employee;

select * 
from employee
where empName='kiran';

begin TRANSACTION 
insert into employee(empName,empSalary,deptId) values('thala ajith',20000,3);
COMMIT TRANSACTION ;


begin transaction;

insert into employee(empName,empSalary,deptId) values('thala...',300000,1);

save transaction point1;

insert into employee(empName,empSalary,deptId) values('Ultimate star ajith',400000,1);
insert into employee(empName,empSalary,deptId) values('AK',500000,1);

rollback transaction point1;

commit transaction;

create index idx_empId
on employee(empId);

select * from employee
where empId=1;



SELECT *
FROM employee
WHERE empId = 1;


select name 
from sys.indexes;


