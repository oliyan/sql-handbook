create or replace procedure cmpsys.changedept(
  in dept_name char(3)
)
language sql
set option dbgview=*source
begin
    declare emp_no char(6);
    declare emp_last_name varchar(15);
    declare emp_first_name varchar(12);
    declare row_not_found condition for '02000';
    declare end_of_emp int default 0;

    changedep: Begin
      -- declare a cursor for the result set from deptemployees
      declare c_emp cursor for
          select empno, lastname, firstnme
          from table(cmpsys.getspecemp());

      declare continue handler for row_not_found set end_of_emp = 1;

      -- open the cursor
      open c_emp;

      -- fetch and process each row
      fetch from c_emp into emp_no, emp_last_name, emp_first_name;
      while end_of_emp = 0 do
        update  cmpsys.employee
        set     workdept = dept_name
        where   current of c_emp;
          -- process the employee data (e.g., display or use it)
          -- replace this with your actual processing logic
          -- for example: insert into anothertable ...

          -- fetch the next row
          fetch from c_emp into emp_no, emp_last_name, emp_first_name;
      end while;

      -- close the cursor
      close c_emp;
    end changedep;
end;
