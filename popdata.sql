CREATE OR REPLACE PROCEDURE POPULATE_TABLES()
BEGIN
    DECLARE v_url CLOB(2G);
    DECLARE v_response CLOB(2G);
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
    
    -- Populate DEPARTMENT table
    FOR i IN 1..10 DO
        SET v_url = 'https://api.mockaroo.com/api/0b43d0e0?count=1&key=your_api_key';
        SET v_response = SYSTOOLS.HTTPGETCLOB(v_url);
        SET v_dept_no = JSON_VALUE(v_response, '$[0].DEPTNO');
        SET v_dept_name = JSON_VALUE(v_response, '$[0].DEPTNAME');
        SET v_mgr_no = JSON_VALUE(v_response, '$[0].MGRNO');
        SET v_admr_dept = JSON_VALUE(v_response, '$[0].ADMRDEPT');
        SET v_location = JSON_VALUE(v_response, '$[0].LOCATION');
        
        INSERT INTO DEPARTMENT (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT, LOCATION)
        VALUES (v_dept_no, v_dept_name, v_mgr_no, v_admr_dept, v_location);
    END FOR;
    
    -- Populate EMPLOYEE table
    FOR i IN 1..500 DO
        SET v_url = 'https://randomuser.me/api/';
        SET v_response = SYSTOOLS.HTTPGETCLOB(v_url);
        SET v_emp_no = SUBSTR(HEX(RANDOM()), 1, 6);
        SET v_first_name = JSON_VALUE(v_response, '$.results[0].name.first');
        SET v_mid_init = SUBSTR(JSON_VALUE(v_response, '$.results[0].name.first'), 1, 1);
        SET v_last_name = JSON_VALUE(v_response, '$.results[0].name.last');
        SET v_work_dept = (SELECT DEPTNO FROM DEPARTMENT ORDER BY RAND() FETCH FIRST 1 ROW ONLY);
        SET v_phone_no = SUBSTR(HEX(RANDOM()), 1, 4);
        SET v_hire_date = DATE('2023-01-01') + INT(RAND() * 365 * 10) DAYS;
        SET v_job = 'JOB' || SUBSTR(HEX(RANDOM()), 1, 4);
        SET v_ed_level = 12 + INT(RAND() * 8);
        SET v_sex = JSON_VALUE(v_response, '$.results[0].gender')[1];
        SET v_birth_date = DATE('1960-01-01') + INT(RAND() * 365 * 50) DAYS;
        SET v_salary = DECIMAL(30000 + RAND() * 70000, 9, 2);
        SET v_bonus = DECIMAL(RAND() * 10000, 9, 2);
        SET v_comm = DECIMAL(RAND() * 5000, 9, 2);
        
        INSERT INTO EMPLOYEE (EMPNO, FIRSTNME, MIDINIT, LASTNAME, WORKDEPT, PHONENO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
        VALUES (v_emp_no, v_first_name, v_mid_init, v_last_name, v_work_dept, v_phone_no, v_hire_date, v_job, v_ed_level, v_sex, v_birth_date, v_salary, v_bonus, v_comm);
    END FOR;
END;
