select * from test1

create table tblemployeeiot(ID int,NAME nvarchar(20),GENDER nvarchar(20),DEPARTMENTID int)
create table tbledeptiot(DEPTID int,DEPTNAME nvarchar(20))

select * from tblEmployee
select * from  tblDepartment



alter view vWEmployeeDetails
as 
select ID, NAME, GENDER, DepartmentName 
from tblEmployee
join tblDepartment
on tblDepartment.DeptID=tblEmployee.DepartmentID 

select * from vWEmployeeDetails

insert into vWEmployeeDetails values (11,'alarie','Female','IT')


create trigger tr_vWEmployeeDetails_InsteadofInsert on vWEmployeeDetails
Instead of Insert
as 
begin
      select * from inserted
	  select * from deleted
end

alter trigger tr_vWEmployeeDetails_InsteadofInsert on vWEmployeeDetails
Instead of Insert
as 
begin
      Declare @DeptID int
	  select @DeptID=DeptID from tblDepartment
	  join inserted
	  on inserted.DepartmentName=tblDepartment.DepartmentName

	  if (@DeptID is null)
	  Begin
	      Raiserror('Invalid Department Name.Statement Terminated',16,1)
		  return
		  end
	 insert into tblEmployee(ID,Name,Gender,DepartmentID)
	 select ID,Name,Gender,@DeptID from inserted
     
end