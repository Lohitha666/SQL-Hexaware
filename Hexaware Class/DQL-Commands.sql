-- Step 1: Create and Use Database
CREATE DATABASE DQL;
GO
USE DQL;
GO

-- Step 2: Create EMPLOYEES Table
CREATE TABLE EMPLOYEES (
    ENAME VARCHAR(10), 
    EMPNO INT NOT NULL,
    JOB VARCHAR(9),
    MGR INT,
    HIREDATE DATE,
    SAL INT,
    COMM INT,
    DEPTNO INT NOT NULL
); 

-- Step 3: Insert Data into EMPLOYEES Table
INSERT INTO EMPLOYEES (ENAME, EMPNO, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
VALUES ('lohitha', 303, 'ENGINEER', 413, '2004-02-26', 100000, 1, 1); 

-- Step 4: Verify Data in EMPLOYEES Table
SELECT * FROM EMPLOYEES;

-- Step 5: Create DEPARTMENT Table
CREATE TABLE DEPARTMENT (
    DEPTNO INT NOT NULL,
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
); 

-- Step 6: Insert Data into DEPARTMENT Table
INSERT INTO DEPARTMENT (DEPTNO, DNAME, LOC) VALUES 
(10, 'MANAGER', 'CHENNAI'),
(20, 'ANALYST', 'MUMBAI'),
(1, 'PRESIDENT', 'CANADA'),
(5, 'HR', 'BOSTON'),
(40, 'CLERK', 'MADURAI'),
(50, 'SALESMAN', 'CHENNAI'); 

-- Query 1: Select Employee Name, Job, and Salary
SELECT ENAME, JOB, SAL AS SAL FROM EMPLOYEES;

-- Query 2: Select All Departments
SELECT * FROM DEPARTMENT;

-- Query 3: Calculate Annual Salary
SELECT EMPNO, ENAME, SAL * 12 AS "ANNUAL SALARY" FROM EMPLOYEES;

-- Query 4: Display DEPARTMENT Table
SELECT * FROM DEPARTMENT;

-- Query 5: Get Table Information for EMPLOYEES
EXEC sp_help 'EMPLOYEES';

-- Query 6: Rename Columns for EMPLOYEES Table
SELECT ENAME AS EMPLOYEENAME,
       EMPNO,
       JOB,
       MGR,
       HIREDATE AS STARTDATE,
       SAL,
       COMM,
       DEPTNO
FROM EMPLOYEES;

-- Query 7: Get Unique Job Titles
SELECT DISTINCT JOB FROM EMPLOYEES;

-- Query 8: Rename Columns for EMPLOYEES Table
SELECT ENAME AS EMPLOYEES,
       EMPNO AS EMP#,
       JOB AS JOBTITLE,
       MGR,
       HIREDATE,
       SAL,
       COMM,
       DEPTNO
FROM EMPLOYEES;
