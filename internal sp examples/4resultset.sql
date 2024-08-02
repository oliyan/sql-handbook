create or replace procedure cmpsys.getspecemp(
  In In_dept char(3)
)
language sql
result sets 1
set option dbgview=*source
begin
    declare vSQLQuery varchar(1000);
    set vSQLQuery = 'select  empno, firstnme, lastname, workdept, birthdate, salary ' ||
                    ' from    cmpsys.employee' ||
                    ' where   workdept = ' || '''' || In_dept || '''';
    begin
      declare c1 cursor with return for getspec_s1;
      prepare getspec_s1 from vSQLQuery;
      open c1;
    end;
end;

-- call cmpsys.getspecemp('556');