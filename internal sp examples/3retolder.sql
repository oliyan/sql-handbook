create or replace procedure cmpsys.RetrieveSeniorEmployee(
  in  deptId        char(3), 
  out employeeName  varchar(30),
  out DOB           date
)
language sql
reads sql data
specific retolder
not deterministic
begin
    select  firstnme||' '||lastname, birthdate 
    into    employeeName, DOB
    from    cmpsys.employee
    where   workdept = deptID
    order by birthdate 
    fetch first row only;
end;

-- create variable cmpsys.mychar30 char(30);
-- create variable cmpsys.mydate date;
-- call cmpsys.RetrieveSeniorEmployee('939',cmpsys.mychar30, cmpsys.mydate);
-- values(cmpsys.mychar30, cmpsys.mydate);

