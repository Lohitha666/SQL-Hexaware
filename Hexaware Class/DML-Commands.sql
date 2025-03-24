-- Step 1: Create Database
CREATE DATABASE DML;
GO
USE DML;
GO

-- Step 2: Create MY_EMPLOYEE Table
CREATE TABLE MY_EMPLOYEE (
    ID         INT PRIMARY KEY,
    LAST_NAME  VARCHAR(25),
    FIRST_NAME VARCHAR(25),
    USERID     VARCHAR(8),
    SALARY     INT
);

-- Step 3: Insert Data into MY_EMPLOYEE Table
INSERT INTO MY_EMPLOYEE (ID, LAST_NAME, FIRST_NAME, USERID, SALARY)
VALUES (1, 'Suggala', 'Lohitha', 'lohitha', 50000);

-- Step 4: Insert Multiple Rows into MY_EMPLOYEE Table
INSERT INTO MY_EMPLOYEE (ID, LAST_NAME, FIRST_NAME, USERID, SALARY)
VALUES 
(2, 'Chava', 'Yogitha', 'yogitha', 60000), 
(3, 'Marri', 'Saritha', 'saritha', 70000), 
(4, 'Hruthi', 'Hruthika', 'hruthika', 80000);

-- Step 5: Display All Employees
SELECT * FROM MY_EMPLOYEE;

-- Step 6: Declare and Set Variables
DECLARE @ID INT, @LAST_NAME VARCHAR(25), @FIRST_NAME VARCHAR(25), @SALARY DECIMAL(9,2), @USERID VARCHAR(8);
SET @ID = 4;
SET @LAST_NAME = 'Verma';
SET @FIRST_NAME = 'Hruthika';
SET @SALARY = 90000;
SET @USERID = UPPER(LEFT(@FIRST_NAME, 1) + LEFT(@LAST_NAME, 7));

-- Step 7: Update Employee Last Name (Changing Yogitha's Last Name)
UPDATE MY_EMPLOYEE
SET LAST_NAME = 'Kumar'
WHERE ID = 2;

-- Step 8: Update Salary for Employees with Salary Less Than 70000
UPDATE MY_EMPLOYEE
SET SALARY = 75000
WHERE SALARY < 70000;

-- Step 9: Display Updated Employees
SELECT * FROM MY_EMPLOYEE;

-- Step 10: Delete an Employee Based on First Name and Last Name
DELETE FROM MY_EMPLOYEE
WHERE FIRST_NAME = 'Lohitha' AND LAST_NAME = 'Suggala';

-- Step 11: Truncate the Table (Removes All Data but Keeps Structure)
TRUNCATE TABLE MY_EMPLOYEE;
