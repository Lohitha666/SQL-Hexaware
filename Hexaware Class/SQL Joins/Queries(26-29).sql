

-- Step 26: Create `emp_department` Table (if not exists)
IF OBJECT_ID('emp_department', 'U') IS NULL
CREATE TABLE emp_department (
    dpt_code INT PRIMARY KEY,
    dpt_name VARCHAR(50),
    dpt_allotment DECIMAL(10,2)
);

-- Step 26: Create `emp_details` Table (if not exists)
IF OBJECT_ID('emp_details', 'U') IS NULL
CREATE TABLE emp_details (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(50),
    emp_lname VARCHAR(50),
    emp_dept INT,
    FOREIGN KEY (emp_dept) REFERENCES emp_department(dpt_code)
);

-- Step 26: Insert Data into `emp_department` Table (only if it doesn't exist)
INSERT INTO emp_department (dpt_code, dpt_name, dpt_allotment)
SELECT * FROM (VALUES
    (57, 'IT', 65000),
    (63, 'Finance', 15000),
    (47, 'HR', 240000),
    (27, 'RD', 55000),
    (89, 'QC', 75000)
) AS temp(dpt_code, dpt_name, dpt_allotment)
WHERE NOT EXISTS (SELECT 1 FROM emp_department WHERE emp_department.dpt_code = temp.dpt_code);

-- Step 26: Insert Data into `emp_details` Table (only if it doesn't exist)
INSERT INTO emp_details (emp_idno, emp_fname, emp_lname, emp_dept)
SELECT * FROM (VALUES
    (127323, 'Michale', 'Robbin', 57),
    (526689, 'Carlos', 'Snares', 63),
    (843795, 'Enric', 'Dosio', 57),
    (328717, 'Jhon', 'Snares', 63),
    (444527, 'Joseph', 'Dosni', 47),
    (659831, 'Zanifer', 'Emily', 47),
    (847674, 'Kuleswar', 'Sitaraman', 57),
    (748681, 'Henrey', 'Gabriel', 47),
    (555935, 'Alex', 'Manuel', 57)
) AS temp(emp_idno, emp_fname, emp_lname, emp_dept)
WHERE NOT EXISTS (SELECT 1 FROM emp_details WHERE emp_details.emp_idno = temp.emp_idno);

-- Step 26: Display All Employees with Their Department
SELECT e.emp_idno, e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment
FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code;

-- Step 27: Display Employee Names, Department Name, and Sanction Amount
SELECT e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment AS Sanction_Amount
FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code;

-- Step 28: Find Departments with Budgets More Than 50,000 and Display Employees
SELECT e.emp_fname, e.emp_lname, d.dpt_name, d.dpt_allotment
FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code
WHERE d.dpt_allotment > 50000;

-- Step 29: Find Names of Departments Where More Than Two Employees Are Employed
SELECT d.dpt_name
FROM emp_department d
JOIN emp_details e ON d.dpt_code = e.emp_dept
GROUP BY d.dpt_name
HAVING COUNT(e.emp_idno) > 2;
