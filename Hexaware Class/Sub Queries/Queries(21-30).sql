-- 21. Find Salespeople with Names Alphabetically Before Customers
SELECT DISTINCT S.salesman_id, S.name, S.city, S.commission
FROM Salesman S
JOIN Customer C ON S.salesman_id = C.salesman_id
WHERE S.name < C.cust_name;
GO

-- 22. Find Customers with Higher Grade Than Those Below New York
SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade > ALL (SELECT grade FROM Customer WHERE city > 'New York');
GO

-- 23. Find Orders Exceeding Any Order from September 10, 2012
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt > ANY (SELECT purch_amt FROM Orders WHERE ord_date = '2012-09-10');
GO

-- 24. Find Orders with Amount Less Than Any Order from London
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt < ANY (SELECT purch_amt FROM Orders O
WHERE customer_id IN (SELECT customer_id FROM Customer WHERE city = 'London'));
GO

-- 25. Find Orders with Amount Less Than the Max Order from London
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt < (SELECT MAX(purch_amt) FROM Orders O
WHERE customer_id IN (SELECT customer_id FROM Customer WHERE city = 'London'));
GO

-- 26. Find Customers with Higher Grades Than Those in New York
SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade > ALL (SELECT grade FROM Customer WHERE city = 'New York');
GO

-- 27. Calculate Total Order Amount by Salespeople in Customer Cities
SELECT S.name, S.city, SUM(O.purch_amt) AS total_order_amount
FROM Salesman S
JOIN Orders O ON S.salesman_id = O.salesman_id
WHERE S.city IN (SELECT DISTINCT city FROM Customer)
GROUP BY S.name, S.city;
GO

-- 28. Find Customers with Grades Different from Those in London
SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade NOT IN (SELECT DISTINCT grade FROM Customer WHERE city = 'London');
GO

-- 29. Find Customers with Grades Different from Those in Paris
SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade NOT IN (SELECT DISTINCT grade FROM Customer WHERE city = 'Paris');
GO

-- 30. Find Customers with Grades Different from Any in Dallas
SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
