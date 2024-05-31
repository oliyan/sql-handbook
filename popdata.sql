CREATE OR REPLACE PROCEDURE popdata()
P1: BEGIN
    DECLARE v_url CLOB(10M);
    DECLARE v_response CLOB(10M);
    DECLARE v_dept_no CHAR(3);
    DECLARE v_dept_name VARCHAR(36);
    DECLARE v_mgr_no CHAR(6);
    DECLARE v_admr_dept CHAR(3);
    DECLARE v_location CHAR(16);
    DECLARE v_emp_no CHAR(6);
    DECLARE v_first_name VARCHAR(12);
    DECLARE v_mid_init CHAR(1);
    DECLARE v_last_name VARCHAR(15);
    DECLARE v_work_dept CHAR(3);
    DECLARE v_phone_no CHAR(4);
    DECLARE v_hire_date DATE;
    DECLARE v_job CHAR(8);
    DECLARE v_ed_level SMALLINT;
    DECLARE v_sex CHAR(1);
    DECLARE v_birth_date DATE;
    DECLARE v_salary DECIMAL(9,2);
    DECLARE v_bonus DECIMAL(9,2);
    DECLARE v_comm DECIMAL(9,2);
    DECLARE i INT;
    DECLARE dept_cursor CURSOR FOR SELECT DEPTNO FROM DEPARTMENT;


    
    -- Populate EMPLOYEE table
    SET i = 1;
    WHILE i <= 500 DO
        SET v_url = 'https://randomuser.me/api/';
        SET v_response = SYSTOOLS.HTTPGETCLOB(v_url, NULL);
        SET v_emp_no = SUBSTR(HEX(RAND()), 1, 6);
        SET v_first_name = JSON_VALUE(v_response, '$.results[0].name.first');
        SET v_mid_init = SUBSTR(JSON_VALUE(v_response, '$.results[0].name.first'), 1, 1);
        SET v_last_name = JSON_VALUE(v_response, '$.results[0].name.last');
        
        -- Assign a random department from DEPARTMENT table
        OPEN dept_cursor;
        FETCH FROM dept_cursor INTO v_work_dept;
        CLOSE dept_cursor;
        
        SET v_phone_no = SUBSTR(HEX(RAND()), 1, 4);
        SET v_hire_date = DATE('2023-01-01') + INT(RAND() * 365 * 10) DAYS;
        SET v_job = 'JOB' || SUBSTR(HEX(RAND()), 1, 4);
        SET v_ed_level = 12 + INT(RAND() * 8);
        SET v_sex = 'M';
        SET v_birth_date = DATE('1960-01-01') + INT(RAND() * 365 * 50) DAYS;
        SET v_salary = DECIMAL(30000 + RAND() * 70000, 9, 2);
        SET v_bonus = DECIMAL(RAND() * 10000, 9, 2);
        SET v_comm = DECIMAL(RAND() * 5000, 9, 2);
        
        INSERT INTO EMPLOYEE 
        (EMPNO, FIRSTNME, MIDINIT, LASTNAME, WORKDEPT, PHONENO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
        VALUES (v_emp_no, v_first_name, v_mid_init, v_last_name, v_work_dept, v_phone_no, v_hire_date, v_job, v_ed_level, 
        v_sex, v_birth_date, v_salary, v_bonus, v_comm);
        
        SET i = i + 1;
    END WHILE;
END P1;
