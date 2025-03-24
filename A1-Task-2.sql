SELECT FirstName, LastName, Email FROM Customers;
GO

SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName 
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID;
GO

IF NOT EXISTS (SELECT 1 FROM Customers WHERE Email = 'pam@email.com')
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) 
    VALUES ('Pam', 'Beesly', 'pam@email.com', '9567890123', 'Scranton, PA');
END
GO

UPDATE Products 
SET Price = Price * 1.10;
GO

DECLARE @OrderID INT = 2;
IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
BEGIN
    DELETE FROM OrderDetails WHERE OrderID = @OrderID;
    DELETE FROM Orders WHERE OrderID = @OrderID;
END
GO

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) 
VALUES (3, GETDATE(), 0.00);
GO

DECLARE @CustomerID INT = 3;
DECLARE @NewEmail VARCHAR(100) = 'new.email@email.com';
DECLARE @NewAddress VARCHAR(255) = '456 New Avenue';

UPDATE Customers
SET Email = @NewEmail, Address = @NewAddress
WHERE CustomerID = @CustomerID;
GO

UPDATE Orders
SET TotalAmount = ISNULL((
    SELECT SUM(OD.Quantity * P.Price)
    FROM OrderDetails OD
    JOIN Products P ON OD.ProductID = P.ProductID
    WHERE OD.OrderID = Orders.OrderID
), 0);
GO

DECLARE @CustomerIDToDelete INT = 4;
IF EXISTS (SELECT 1 FROM Orders WHERE CustomerID = @CustomerIDToDelete)
BEGIN
    DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerIDToDelete);
    DELETE FROM Orders WHERE CustomerID = @CustomerIDToDelete;
END
GO

INSERT INTO Products (ProductName, Description, Price) 
VALUES ('Gaming Console', 'Latest 4K gaming console', 500.00);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Orders' AND COLUMN_NAME = 'Status')
BEGIN
    ALTER TABLE Orders ADD Status VARCHAR(50) DEFAULT 'Pending';
END
GO

DECLARE @OrderToUpdate INT = 3;
DECLARE @NewStatus VARCHAR(50) = 'Shipped';

UPDATE Orders
SET Status = @NewStatus
WHERE OrderID = @OrderToUpdate;
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Customers' AND COLUMN_NAME = 'OrderCount')
BEGIN
    ALTER TABLE Customers ADD OrderCount INT DEFAULT 0;
END
GO

UPDATE Customers
SET OrderCount = (
    SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID
);
GO
