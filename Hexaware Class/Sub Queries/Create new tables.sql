IF OBJECT_ID('item_mast', 'U') IS NOT NULL DROP TABLE item_mast;
IF OBJECT_ID('company_mast', 'U') IS NOT NULL DROP TABLE company_mast;
IF OBJECT_ID('emp_details', 'U') IS NOT NULL DROP TABLE emp_details;
IF OBJECT_ID('emp_department', 'U') IS NOT NULL DROP TABLE emp_department;
GO

-- Step 4: Create Tables

-- Table: company_mast
CREATE TABLE company_mast (
    COM_ID INT PRIMARY KEY,
    COM_NAME VARCHAR(50)
);
GO

-- Table: item_mast
CREATE TABLE item_mast (
    PRO_ID INT PRIMARY KEY,
    PRO_NAME VARCHAR(50),
    PRO_PRICE DECIMAL(10,2),
    PRO_COM INT FOREIGN KEY REFERENCES company_mast(COM_ID)
);
GO

-- Table: emp_details
CREATE TABLE emp_details (
    EMP_IDNO INT PRIMARY KEY,
    EMP_FNAME VARCHAR(50),
    EMP_LNAME VARCHAR(50),
    EMP_DEPT INT
);
GO

-- Table: emp_department
CREATE TABLE emp_department (
    DPT_CODE INT PRIMARY KEY,
    DPT_NAME VARCHAR(50),
    DPT_ALLOTMENT DECIMAL(10,2)
);
GO

-- Step 5: Insert Sample Data

-- Insert into company_mast
INSERT INTO company_mast (COM_ID, COM_NAME) VALUES
(11, 'Samsung'), (12, 'iBall'), (13, 'Epsion'), (14, 'Zebronics'), (15, 'Asus'), (16, 'Frontech');
GO

-- Insert into item_mast
INSERT INTO item_mast (PRO_ID, PRO_NAME, PRO_PRICE, PRO_COM) VALUES
(101, 'Mother Board', 3200.00, 15), (102, 'Key Board', 450.00, 16),
(103, 'ZIP drive', 250.00, 14), (104, 'Speaker', 550.00, 16),
(105, 'Monitor', 5000.00, 11), (106, 'DVD drive', 900.00, 12),
(107, 'CD drive', 800.00, 12), (108, 'Printer', 2600.00, 13),
(109, 'Refill cartridge', 350.00, 13), (110, 'Mouse', 250.00, 12);
GO

-- Insert into emp_details
INSERT INTO emp_details (EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT) VALUES
(127323, 'Michale', 'Robbin', 57), (526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57), (328717, 'Jhon', 'Snares', 63),
(748681, 'Henrey', 'Gabriel', 47), (733843, 'Mario', 'Saule', 63);
GO

-- Insert into emp_department
INSERT INTO emp_department (DPT_CODE, DPT_NAME, DPT_ALLOTMENT) VALUES
(57, 'IT', 65000), (63, 'Finance', 15000), (47, 'HR', 240000),
(27, 'RD', 55000), (89, 'QC', 75000);
GO
