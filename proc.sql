CREATE OR REPLACE PROCEDURE ravi.insert_dummy_data()
LANGUAGE SQL
P1:BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE v_emp_name VARCHAR(50);
    DECLARE v_emp_salary DECIMAL(10, 2);
    DECLARE v_emp_dept VARCHAR(20);

    WHILE i <= 100 DO
        select max(emp_id)+1 into j from ravi.Employee ;

        SET v_emp_name = 'Employee' || CHAR(j);
        SET v_emp_salary = DECIMAL(RAND() * 10000, 10, 2);
        SET v_emp_dept = 'Department' || CHAR(mod(j,10) + 1);

        INSERT INTO ravi.Employee(emp_id, emp_name, emp_salary, emp_dept)
        VALUES (j, v_emp_name, v_emp_salary, v_emp_dept);

        SET i = i + 1;
        set j = j+1;
    END WHILE;
END P1;


CREATE OR REPLACE PROCEDURE InsertDummyData()
LANGUAGE SQL
P2: BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE @empno CHAR(6);
    DECLARE @firstnme VARCHAR(12);
    DECLARE @midinit CHAR(1);
    DECLARE @lastname VARCHAR(15);
    DECLARE @workdept CHAR(3);
    DECLARE @phoneno CHAR(4);
    DECLARE @hiredate DATE;
    DECLARE @job CHAR(8);
    DECLARE @edlevel SMALLINT;
    DECLARE @sex CHAR(1);
    DECLARE @birthdate DATE;
    DECLARE @salary DECIMAL(9,2);
    DECLARE @bonus DECIMAL(9,2);
    DECLARE @comm DECIMAL(9,2);

    WHILE i < 100 DO
        SET i = i + 1;
        SET @empno = CHAR(i);
        SET @firstnme = 'FirstName' || CHAR(i);
        SET @midinit = 'M';
        SET @lastname = 'LastName' || CHAR(i);
        SET @workdept = 'DPT';
        SET @phoneno = '1234';
        SET @hiredate = CURRENT DATE;
        SET @job = 'JOB';
        SET @edlevel = 10;
        SET @sex = 'M';
        SET @birthdate = DATE('2000-01-01');
        SET @salary = 50000;
        SET @bonus = 5000;
        SET @comm = 2000;

        INSERT INTO EMPLOYEE (EMPNO, FIRSTNME, MIDINIT, LASTNAME, WORKDEPT, PHONENO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
        VALUES (@empno, @firstnme, @midinit, @lastname, @workdept, @phoneno, @hiredate, @job, @edlevel, @sex, @birthdate, @salary, @bonus, @comm);
    END WHILE;
END P2;
