USE TechShop;


-- Step 2: Create Tables

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

-- Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inventory Table
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Step 3: Insert Sample Data

-- Insert into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@email.com', '1234567890', '123 Main St'),
('Jane', 'Smith', 'jane.smith@email.com', '9876543210', '456 Elm St'),
('Alice', 'Johnson', 'alice.j@email.com', '5555555555', '789 Oak St'),
('Bob', 'Brown', 'bob.b@email.com', '7777777777', '101 Pine St'),
('Charlie', 'Davis', 'charlie.d@email.com', '9999999999', '202 Maple St'),
('David', 'Clark', 'david.c@email.com', '3333333333', '303 Birch St'),
('Emma', 'Evans', 'emma.e@email.com', '6666666666', '404 Cedar St'),
('Frank', 'White', 'frank.w@email.com', '1111111111', '505 Willow St'),
('Grace', 'Lewis', 'grace.l@email.com', '4444444444', '606 Ash St'),
('Hannah', 'Hall', 'hannah.h@email.com', '2222222222', '707 Cherry St');

-- Insert into Products
INSERT INTO Products (ProductName, Description, Price) VALUES
('Laptop', 'High-performance laptop', 1200.00),
('Smartphone', 'Latest model smartphone', 800.00),
('Tablet', '10-inch display tablet', 500.00),
('Smartwatch', 'Water-resistant smartwatch', 250.00),
('Headphones', 'Noise-canceling headphones', 150.00),
('Keyboard', 'Mechanical keyboard', 100.00),
('Mouse', 'Wireless mouse', 50.00),
('Monitor', '24-inch LED monitor', 200.00),
('Speaker', 'Bluetooth speaker', 120.00),
('Camera', 'DSLR camera', 1500.00);

-- Insert into Orders
INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 1200.00),
(2, 800.00),
(3, 500.00),
(4, 250.00),
(5, 150.00),
(6, 100.00),
(7, 50.00),
(8, 200.00),
(9, 120.00),
(10, 1500.00);

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 3),
(6, 6, 1),
(7, 7, 2),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1);

-- Insert into Inventory
INSERT INTO Inventory (ProductID, QuantityInStock) VALUES
(1, 10),
(2, 20),
(3, 15),
(4, 30),
(5, 25),
(6, 50),
(7, 40),
(8, 10),
(9, 5),
(10, 8);

-- Step 4: Verify Data
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Inventory;
