create or replace procedure cmpsys.InsertEmployee(
  In  In_empno      char(6),
  In  In_fname      char(12),
  In  In_midinit    char(1),
  In  In_lname      char(15),
  In  In_edlevel    smallint       
)
language sql
Result Sets 0
Modifies SQL Data
Specific insemp
P1: BEGIN
    declare v_dept_no char(3);
    declare v_dept_name varchar(36);
    declare v_mgr_no char(6);
    declare v_admr_dept char(3);
    declare v_location char(16);
    declare v_work_dept char(3);
    declare v_phone_no char(4);
    declare v_hire_date date;
    declare v_job char(8);
    declare v_sex char(1);
    declare v_birth_date date;
    declare v_salary decimal(9,2);
    declare v_bonus decimal(9,2);
    declare v_comm decimal(9,2);
    declare i int default 1;

    -- Assign a random department from DEPARTMENT table
    select  deptno 
    into    v_work_dept
    from    cmpsys.department
    order by rand()
    fetch first row only;

    -- Populate EMPLOYEE table
    set v_phone_no = substr(HEX(rand()), 1, 4);
    set v_hire_date = date('2023-01-01') + int(rand() * 365 * 10) DAYS;
    set v_job = 'JOB' || substr(HEX(rand()), 1, 4);
    set v_sex = case when rand() < 0.5 then 'M' else 'F' end;
    set v_birth_date = date('1960-01-01') + int(rand() * 365 * 50) DAYS;
    set v_salary = decimal(30000 + rand() * 70000, 9, 2);
    set v_bonus = decimal(rand() * 10000, 9, 2);
    set v_comm = decimal(rand() * 5000, 9, 2);
    
    insert into cmpsys.EMPLOYEE 
    (EMPNO, FIRSTNME, MIDINIT, LASTNAME, WORKDEPT, PHONENO, HIREdate, JOB, EDLEVEL, SEX, BIRTHdate, SALARY, BONUS, COMM)
    VALUES (In_empno, In_fname, In_midinit, In_lname, v_work_dept, v_phone_no, v_hire_date, v_job, In_edlevel, 
    v_sex, v_birth_date, v_salary, v_bonus, v_comm);
        
end P1;
