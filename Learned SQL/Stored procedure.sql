

create table dept(
dept_id int identity(1,1) primary key,
dept_name varchar(max) not null);


exec  sp_rename 'dept','department';

create table employee(
emp_id int identity(1,1) primary key,
emp_Name varchar(max) not null,
dept_id int,
salary int not null 
	constraint fk_dept_id 
	foreign key (dept_id)
	references dept(dept_id)
);

select * from department;
select * from employee;

--update employee
--set is_delete = 1
--where emp_id = 1


insert into dept(dept_name) values('Full Stack Developer'),('frontend'),('Backend'),('data analyst'),('react developer');

truncate table department;



insert into employee(emp_Name,dept_id,salary) values('sethu',1,15000),('Alagar',4,120000),('jayveerapandiyan',3,20000);

--Write a query to display Employee Name, Department Name and Salary using the appropriate JOIN.

select e.emp_Name,d.dept_name
from employee e
left join department d
on e.dept_id=d.dept_id;

--Create a view to display all active employees with their department names.
create view temporary_table 
as select e.emp_id,e.emp_name,d.dept_name
from employee e
inner join department d
on e.dept_id=d.dept_id
where is_delete <>1;

drop view temporary_table;

select * from temporary_table;

--Create sp_Employee_CRUD supporting Insert, Update, Select and Delete operations

create procedure insertEmployee
@name varchar(max),@deptid int,@salary int
as 
begin 
insert into employee(emp_Name,dept_id,salary) values(@name,@deptid,@salary);
end

exec insertEmployee 'Murugn',2,130000;


create procedure updateEmployee
@empid int,@name varchar(max)=null,@deptid int=null,@salary int=null
as 
begin 
	declare @oldname varchar(max)
	declare @olddeptid int

	select @oldname=emp_Name,@olddeptid=dept_id 
	from employee
	where emp_id=@empid;

	update employee
	set emp_name=coalesce(@name,@oldname)
	,dept_id=coalesce(@deptid,@olddeptid)
	where emp_id=@empid;
end
exec updateEmployee @empid=9,@name='murugan';

--exec selectEmployee 9
create procedure selectEmployee
@empid int
as 
begin 
	select *
	from employee
	where emp_id=@empid;
end
----exec DeleteEmployee 9
create procedure DeleteEmployee
@empid int
as 
begin 
	delete employee
	where emp_id=@empid;
end


exec DeleteEmployee 4;

exec selectEmployee 1;

drop procedure updateEmployee;

exec updateEmployee @empid=1,@deptid=1;
exec updateEmployee @empid=1,@name='Assalt Sethu';

select * from employee;

exec insertEmployee 'sundarapandiyan',1,13000;

--Modify the delete operation to implement Soft Delete.

alter table employee
add is_delete tinyint default 0;

update employee
set is_delete=0;


create procedure softDelete
@id int
as
begin
	update employee
	set is_delete=1
	where emp_id=@id;
end

exec softDelete 1;

--Create a separate procedure for Hard Delete.


create procedure hardDeleteEmployee
@empid int
as 
begin 
	delete employee
	where emp_id=@empid;
end

exec hardDeleteEmployee 8;


--Create an Upsert procedure that INSERTs when EmployeeId doesn't exist and UPDATEs when it exists.

create procedure upsertEmployee
@empid int=null,@name varchar(max)=null,@deptid int=null,@salary int=0
as 
begin 
	declare @oldName varchar(max)
	declare @oldDeptid int
	declare @oldSalary int

	if @empid is not null and exists (select 1 from employee where emp_id=@empid)
	begin
	select @oldName=emp_Name,@oldDeptid=dept_id,@oldSalary=Salary
		from employee
		where emp_id=@empid;

		update employee
		set emp_name=coalesce(@name,@oldName),
		dept_id=coalesce(@deptid,@oldDeptid),
		salary=coalesce(@salary,@oldSalary)
		where emp_id=@empid;
	end

	else
	begin
		insert into employee(emp_Name,dept_id,salary) values(@name,@deptid,@salary);
	end
end

drop procedure upsertEmployee

exec upsertEmployee @empid=1,@name='Assalt Sethu',@salary=23000;


select * from employee;


--Given an unnormalized table, identify the normalization problem and split it into normalized tables.

create table student_unnormalized(
std_id int identity(1,1) primary key,
fullname varchar(max) not null,
course_id tinyint not null,
course varchar(max) not null,
mentor varchar(max) not null
)
select * from student_unnormalized;

--drop table student;

insert into student_unnormalized(fullname,course_id,course,mentor) values('sethu',1,'MERN Stack Developer','nagabishek'),('kowshick',2,'node js','harisha'),('jayveerapandiyan',3,'Java Full Stack Developer','parveen'),('Anto jenish',4,'MERNStack Developer','nagabishek'),('sujith',3,'Java Full Stack Developer','parveen');

create table mentors(
mentor_id int identity(1,1) primary key,
mentor_name varchar(max) not null);

select * from mentors;

insert into mentors(mentor_name) values ('naga abishek'),('anusha'),('parvin'),('srinivas'),('harisha');
insert into mentors(mentor_name) values('rohit')

create table courses(
course_id tinyint identity(1,1) primary key ,
course_name varchar(max) not null
)

create course_mentor(
course_id tinyint ,mentor_id 
)
select * from courses;

insert into courses(course_name) values('java'),('javaScript'),('SQL'),('Node JS'),('MongoDB'),('React JS'),('SQL'),('Communication');



create table student(
std_id int identity(1,1) primary key,
fullname varchar(max) not null
);


create table student_enrollment(
std_id int,course_id tinyint 

	primary key(std_id,course_id)
    foreign key (std_id) references student(std_id),
    foreign key (course_id) references courses(course_id)
)
--drop table student_enrollment;
insert into student_enrollment(std_id,course_id) 
values(1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,3),(2,8),(3,2),(3,4),(3,5),(3,6);


select * from student
--insert into student(fullname, course_id, course) 
--values('sethu',1, 'qwerty'),('jayveerapandiyan',1, 'sdfghj'),('kowshick',1, 'sdfgh'),('sujith',1, 'dfghj');

drop table student;



create table course_mentor (
    course_id tinyint,
    mentor_id int,
    primary key (course_id, mentor_id),
    foreign key (course_id) references courses(course_id),
    foreign key (mentor_id) references mentors(mentor_id)
);

delete courses
where course_id=7;

insert into course_mentor(course_id,mentor_id) values(1,1),(2,6),(3,3),(3,2),(4,4),(5,4),(6,6),(8,5);

select * from student;
select * from courses;
select * from mentors;
select * from student_enrollment;
select * from course_mentor;


--drop table courses;

--drop table mentors;

--drop table student_enrollment;