--create database MyDataBase;

--use MyDataBase
--go

--SELECT name
--FROM sys.tables;

--create table student(
--std_id int primary key identity(1,1),
--std_name varchar(200) not null,
--std_phone_no bigint unique not null)

--alter table student
--add std_email varchar(200);

--alter table student
--alter column std_email varchar(200) not null;

--alter table student
--add constraint uk_email
--unique(std_email);

--alter table student
--add constraint uk_name
--unique(std_name);

--alter table student 
--drop constraint uk_name;

--alter table student
--add constraint ck_phone_no
--check(len(std_phone_no)=10)

--alter table student
--add std_age tinyint;

--alter table student
--alter column std_age tinyint not null;


--create procedure upsertStudent
--@id int=null,@name varchar(200)=null,@phoneNo bigint=null,@email varchar(200)=null,@age tinyint=null
--as
--begin

--	if @id is not null and exists(select 1 from student where std_id=@id)
--	begin

--		update student
--		set std_name = COALESCE(@name, std_name),
--            std_phone_no = COALESCE(@phoneNo, std_phone_no),
--            std_email = COALESCE(@email, std_email),
--			std_age=COALESCE(@age,std_age)
--		where std_id=@id;
--	end

--	else
--	begin
--		insert into student (std_name,std_phone_no,std_email,std_age) values(@name,@phoneNo,@email,@age);
--	end
--end

--exec upsertStudent null,'sethu',9876543210,'sethu16@gmail.com',25;
--exec upsertStudent null,'Alagar',8765432112,'alagar16@gmail.com',31;
--exec upsertStudent null,'kiran',9999999999,'kirukukiran@gmail.com',25;

--exec upsertStudent @id=1,@name='Assalt Sethu';

--select * from student;

--truncate table student;

--SELECT
--    std_name,
--    std_age,
--    CASE
--        WHEN std_age < 18 THEN 'Child'
--        WHEN std_age=18 THEN 'Teenager'
--        WHEN std_age>=18 THEN 'Adult'
--        ELSE 'Unknown'
--    END AS Category
--FROM student;


create database task1;