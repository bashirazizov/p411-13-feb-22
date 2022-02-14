--create database P411Company

--use P411Company

--create table Workers(
--	Id int identity primary key,
--	Name nvarchar(100),
--	Surname nvarchar(100),
--	Email nvarchar(100) unique,
--	Salary int
--)

--create table Positions(
--	Id int identity primary key,
--	Name nvarchar(100)
--)

--alter table Workers add PositionId int references Positions(Id)

--select Salary from Workers

--SELECT AVG(Salary) FROM Workers
--SELECT MIN(Salary) FROM Workers
--SELECT MAX(Salary) FROM Workers

--select * from Workers
--where Salary>(SELECT AVG(Salary) FROM Workers)

--Select Workers.Name,Workers.Surname,Positions.Name  from Workers
--left join Positions
--on Workers.PositionId = Positions.Id

--create table OldWorkers(
--	Id int identity primary key,
--	Name nvarchar(100),
--	Surname nvarchar(100),
--	Email nvarchar(100) unique,
--	Salary int
--)


--Select * from Workers 
--join OldWorkers
--on Workers.Name = OldWorkers.Name

--Select * from Workers order by Name desc

--Select distinct Name from Workers

--Select distinct Name, Surname from Workers

--Select Name, Count(Name) 'count' from Workers
--Group by Name
--having Count(Name)<2



--Select Name, Surname from Workers
--union
--Select Name, Surname from OldWorkers



--Select Name, Surname from Workers
--union all
--Select Name, Surname from OldWorkers



--Select Name, Surname from Workers
--except
--Select Name, Surname from OldWorkers



--Select Name, Surname from OldWorkers
--except
--Select Name, Surname from Workers



--Select Name, Surname from Workers
--intersect
--Select Name, Surname from OldWorkers

--create view WorkerSalary as
--Select Workers.Name,Workers.Surname,Positions.Name 'Position',Workers.Salary  from Workers
--left join Positions
--on Workers.PositionId = Positions.Id


--create procedure GetWorkersByMinSalary @MinSalary int as
--select * from WorkerSalary where Salary > @MinSalary

--exec GetWorkersByMinSalary 200

--select Id from Positions where Name = 'Developer'

--select * from Workers where Salary>200 and PositionId = (select Id from Positions where Name = 'Developer')

--create procedure GetWorkersByMinSalaryAndPosition (@MinSalary int, @Position nvarchar(100)='Developer') as
--select * from Workers 
--where Salary>@MinSalary and 
--PositionId = (select Id from Positions where Name = @Position)

--exec GetWorkersByMinSalaryAndPosition 2000, 'Designer'

--create table Countries(
--	Id int identity primary key,
--	Name nvarchar(100)
--)

--create table Cities(
--	Id int identity primary key,
--	Name nvarchar(100),
--	CountryId int references Countries(Id)
--)

--Proc. receives country name and 
--selects cities of sent country with 
--country name included


--create procedure GetCitiesByCountry @CountryName nvarchar(100)='Usa' as
--select Cities.Name 'City name', Countries.Name 'Country name' from Cities 
--join Countries on Cities.CountryId = Countries.Id
--where Cities.CountryId = (select Id from Countries where Name = @CountryName)

--exec GetCitiesByCountry 'Russia'

--select Count(*) from WorkerSalary where Salary >5000

--create function GetWorkerCountByMinSalary (@MinSalary int) 
--returns int
--as
--begin
--	declare @Count int
--	select @Count = Count(*) from WorkerSalary where Salary > @MinSalary
--	return @Count
--end

--select dbo.GetWorkerCountByMinSalary(1000)


create table Departments(
	Id int identity primary key,
	Name nvarchar(100),
	WorkerCount int
)

alter table Workers add DepartmentId int references Departments(Id)

insert into Workers values('Bulent','Ersoy','bulent@cpde',10000,2,2)

update Departments set WorkerCount =  WorkerCount + 1 where Id = 1


create trigger WorkerAdded
on Workers
after insert
as
begin
	update Departments set WorkerCount =  WorkerCount + 1 where Id = (select DepartmentId from inserted Workers)
end

update Workers set Salary = (select AVG(Salary) from Workers)


create table WorkerHistory(
	Id int,
	Name nvarchar(100),
	Surname nvarchar(100),
	Email nvarchar(100),
	Salary int
)

alter table WorkerHistory add PositionId int, DepartmentId int

alter table WorkerHistory add UpdateTime datetime


create trigger WorkerUpdated
on Workers
after update, delete
as
begin 
	insert into WorkerHistory values(
		(select id from deleted),
		(select name from deleted),
		(select surname from deleted),
		(select email from deleted),
		(select salary from deleted),
		(select PositionId from deleted),
		(select DepartmentId from deleted),
		(select getdate())
	)
end

select * from Workers where id = 1

select getdate()

select * from WorkerHistory where name = 'Rashad' and surname='Quliyev' 

update Workers set Name = 'Mamed' where id = 10

update Workers set Salary = (select AVG(Salary) from Workers) where id = 10

