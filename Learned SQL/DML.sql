create database task2

use task2 
go

create table studentDetails(
stdId  int identity(1,1) primary key,
sName varchar(max) not null,
sAge tinyint ,
sPhoneNum bigint unique,
deptId int,
isDelete bit default 0,
isActive bit default 1,
	constraint fk_stuDept_id
		foreign key (deptId)
		references DeptDetails(deptId)
);

create table DeptDetails(
deptId int identity(1,1) primary key ,
dName varchar(max) not null,
isDelete bit default 0,
isActive bit default 1);

select name from sys.tables;

drop table DeptDetails;



INSERT INTO DeptDetails (dName)
VALUES
('Computer Science'),
('Information Technology'),
('Electronics'),
('Mechanical'),
('Civil');


INSERT INTO studentDetails (sName, sAge, sPhoneNum, deptId)
VALUES
('Arun Kumar', 20, 9876543210, 1),
('Priya Sharma', 21, 9876543211, 2),
('Rahul Raj', 19, 9876543212, 3),
('Divya Devi', 20, 9876543213, 1),
('Karthik S', 22, 9876543214, 4),
('Sneha Reddy', 21, 9876543215, 5),
('Vijay Kumar', 20, 9876543216, 2),
('Anjali Singh', 19, 9876543217, 3),
('Suresh Babu', 22, 9876543218, 4),
('Meena Lakshmi', 21, 9876543219, 5);

select * from DeptDetails;
select * from studentDetails;


