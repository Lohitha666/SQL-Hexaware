SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName 
FROM Orders O 
JOIN Customers C ON O.CustomerID = C.CustomerID;
GO

SELECT P.ProductName, SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalRevenue DESC;
GO

SELECT DISTINCT C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;
GO

SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantityOrdered DESC;
GO

SELECT ProductName, Description FROM Products;
GO

SELECT C.CustomerID, C.FirstName, C.LastName, AVG(O.TotalAmount) AS AverageOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;
GO

SELECT TOP 1 O.OrderID, C.FirstName, C.LastName, O.TotalAmount 
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.TotalAmount DESC;
GO

SELECT P.ProductName, COUNT(OD.OrderDetailID) AS TimesOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TimesOrdered DESC;
GO

DECLARE @ProductName VARCHAR(100) = 'Laptop';
SELECT DISTINCT C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.ProductName = @ProductName;
GO

DECLARE @StartDate DATE = '2024-03-01';
DECLARE @EndDate DATE = '2024-03-31';
SELECT SUM(O.TotalAmount) AS TotalRevenue
FROM Orders O
WHERE O.OrderDate BETWEEN @StartDate AND @EndDate;
GO
