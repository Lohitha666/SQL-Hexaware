-- 11. Display Salespeople with More Than One Customer
SELECT S.salesman_id, S.name
FROM Salesman S
JOIN Customer C ON S.salesman_id = C.salesman_id
GROUP BY S.salesman_id, S.name
HAVING COUNT(C.customer_id) > 1;
GO

-- 12. Display Orders with Amount Above Average Order Value
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt > (SELECT AVG(purch_amt) FROM Orders);
GO

-- 13. Display Orders with Amount ≥ Average Order Value
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt >= (SELECT AVG(purch_amt) FROM Orders);
GO

-- 14. Show Order Sums by Date Exceeding Max Order by 1000
SELECT ord_date, SUM(purch_amt) AS total_purch_amt
FROM Orders
GROUP BY ord_date
HAVING SUM(purch_amt) >= (SELECT MAX(purch_amt) FROM Orders) + 1000;
GO

-- 15. Show All Customers If Any Are Located in London
SELECT * FROM Customer
WHERE EXISTS (SELECT 1 FROM Customer WHERE city = 'London');
GO

-- 16. Find Salespeople Handling Multiple Customers
SELECT S.salesman_id, S.name, S.city, S.commission
FROM Salesman S
WHERE S.salesman_id IN (
    SELECT salesman_id FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) > 1
);
GO

-- 17. Find Salespeople Handling Only One Customer
SELECT S.salesman_id, S.name, S.city, S.commission
FROM Salesman S
WHERE S.salesman_id IN (
    SELECT salesman_id FROM Customer 
    GROUP BY salesman_id 
    HAVING COUNT(customer_id) = 1
);
GO

-- 18. Find Salespeople Handling Customers with Multiple Orders
SELECT DISTINCT S.salesman_id, S.name, S.city, S.commission
FROM Salesman S
JOIN Customer C ON S.salesman_id = C.salesman_id
WHERE C.customer_id IN (
    SELECT customer_id FROM Orders 
    GROUP BY customer_id 
    HAVING COUNT(ord_no) > 1
);
GO

-- 19. Find Salespeople in Cities with at Least One Customer
SELECT DISTINCT S.salesman_id, S.name, S.city, S.commission
FROM Salesman S
WHERE EXISTS (
    SELECT 1 FROM Customer C WHERE C.city = S.city
);
GO

-- 20. Find Salespeople Living in a Customer's City
SELECT DISTINCT S.salesman_id, S.name, S.city, S.commission
FROM Salesman S
JOIN Customer C ON S.city = C.city;
GO
