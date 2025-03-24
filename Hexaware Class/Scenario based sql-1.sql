-- Use the newly created database
USE CompanyDB;
GO

-- Task 2: Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees VALUES 
(1, 'Alice', 'HR', 60000), 
(2, 'Bob', 'IT', 45000), 
(3, 'Charlie', 'HR', 55000), 
(4, 'David', 'Finance', 70000);
GO

-- Task 3: Extracting Data with Conditions
SELECT Name FROM Employees WHERE Department = 'HR' AND Salary > 50000;
GO

-- Task 4: Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderAmount DECIMAL(10,2)
);
INSERT INTO Orders VALUES 
(1, 101, '2024-03-10', 500), 
(2, 102, '2024-03-12', 150), 
(3, 101, '2024-03-15', 300), 
(4, 103, '2024-03-18', 200);
GO

-- Task 5: Finding Duplicate CustomerIDs
SELECT CustomerID, COUNT(*) AS Count 
FROM Orders 
GROUP BY CustomerID 
HAVING COUNT(*) > 1;
GO

-- Task 6: Create Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE
);
INSERT INTO Sales VALUES 
(1, 201, 5, '2024-03-10'), 
(2, 202, 10, '2024-03-12'), 
(3, 201, 8, '2024-03-15');
GO

-- Task 7: Total Quantity Sold Per Product
SELECT ProductID, SUM(Quantity) AS TotalQuantity 
FROM Sales 
GROUP BY ProductID;
GO

-- Task 8: Create Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2)
);
INSERT INTO Transactions VALUES 
(1, 301, DATEADD(DAY, -10, GETDATE()), 1000), 
(2, 302, DATEADD(DAY, -35, GETDATE()), 500), 
(3, 303, DATEADD(DAY, -20, GETDATE()), 1500);
GO

-- Task 9: Transactions in Last 30 Days
SELECT * FROM Transactions 
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE());
GO

-- Task 10: Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    StockQuantity INT
);
INSERT INTO Products VALUES 
(1, 'Laptop', 1000, 50), 
(2, 'Mouse', 20, 200), 
(3, 'Keyboard', 30, 80);
GO

-- Task 11: Increase Price by 10% for Products with Stock < 100
UPDATE Products 
SET Price = Price * 1.10 
WHERE StockQuantity < 100;
GO

-- Task 12: Create Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100),
    Status VARCHAR(20)
);
INSERT INTO Users VALUES 
(1, 'JohnDoe', 'john@example.com', 'inactive'), 
(2, 'JaneSmith', 'jane@example.com', 'active');
GO

-- Task 13: Delete Inactive Users
DELETE FROM Users 
WHERE Status = 'inactive';
GO

-- Task 14: Handling NULL Values
ALTER TABLE Products ADD Discount VARCHAR(50) NULL;
UPDATE Products SET Discount = NULL WHERE ProductID = 1;
UPDATE Products SET Discount = '10%' WHERE ProductID = 2;
GO

SELECT ProductName, COALESCE(Discount, 'No Discount') AS Discount 
FROM Products;
GO

-- Task 15: Ranking Sales Amount per Product
ALTER TABLE Sales ADD SaleAmount DECIMAL(10,2);
UPDATE Sales SET SaleAmount = Quantity * 10; -- Assume price per unit is 10
GO

SELECT SaleID, ProductID, SaleAmount, SaleDate, 
       RANK() OVER (PARTITION BY ProductID ORDER BY SaleAmount DESC) AS Rank 
FROM Sales;
GO

-- Task 16: Create test_a and test_b Tables
CREATE TABLE test_a (id NUMERIC);
CREATE TABLE test_b (id NUMERIC);
INSERT INTO test_a (id) VALUES (10), (20), (30), (40), (50);
INSERT INTO test_b (id) VALUES (10), (30), (50);
GO

-- Task 17: Fetch values in test_a but not in test_b (Without NOT keyword)
SELECT a.id 
FROM test_a a 
LEFT JOIN test_b b ON a.id = b.id 
WHERE b.id IS NULL;
GO

-- Task 18: Finding the 10th Highest Salary
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Salary DECIMAL(10,2)
);
INSERT INTO Employee VALUES 
(1, 10000), (2, 20000), (3, 30000), (4, 40000), (5, 50000), 
(6, 60000), (7, 70000), (8, 80000), (9, 90000), (10, 100000), 
(11, 110000);
GO

SELECT DISTINCT Salary 
FROM Employee 
ORDER BY Salary DESC 
OFFSET 9 ROWS FETCH NEXT 1 ROWS ONLY;
GO

-- Task 19: Updating Col2 to Be the Opposite of Col1
CREATE TABLE BinaryTable (
    Col1 INT, 
    Col2 INT
);
INSERT INTO BinaryTable VALUES 
(1, 0), (0, 1), (0, 1), (0, 1), (1, 0), (0, 1);
GO

UPDATE BinaryTable 
SET Col2 = CASE WHEN Col1 = 1 THEN 0 ELSE 1 END;
GO
