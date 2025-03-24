-- Step 4: Execute All Queries

-- 1. Salespeople and customers who reside in the same city
SELECT s.name AS Salesman, c.cust_name, s.city
FROM salesman s
JOIN customer c ON s.city = c.city;

-- 2. Orders where order amount is between 500 and 2000
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;

-- 3. Salesperson and customers they represent
SELECT c.cust_name, c.city, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id;

-- 4. Salespeople with commission greater than 12%
SELECT c.cust_name, c.city AS customer_city, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

-- 5. Salespeople who do not live in the same city as their customers but have a commission > 12%
SELECT c.cust_name, c.city AS customer_city, s.name AS Salesman, s.city AS salesman_city, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.city <> s.city AND s.commission > 0.12;

-- 6. Order details
SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.name AS Salesman, s.commission
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

-- 7. Join salesman, customer, and orders
SELECT s.salesman_id, s.name AS Salesman, s.city AS Salesman_City, s.commission, 
       c.customer_id, c.cust_name, c.city AS Customer_City, c.grade,
       o.ord_no, o.ord_date, o.purch_amt
FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id
JOIN orders o ON c.customer_id = o.customer_id;

-- 8. Display customer name, city, grade, salesman, and salesman city sorted by customer_id
SELECT c.customer_id, c.cust_name, c.city AS Customer_City, c.grade, 
       s.name AS Salesman, s.city AS Salesman_City
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id;

-- 9. Customers with a grade less than 300, sorted by customer_id
SELECT c.cust_name, c.city AS Customer_City, c.grade, s.name AS Salesman, s.city AS Salesman_City
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id;

-- 10. Find customers who placed an order and their details
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.ord_date;

-- 11. Salespeople and orders placed by customers
SELECT s.name AS Salesman, c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 12. Salespersons who work with customers or have no customers
SELECT s.name AS Salesman
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
ORDER BY s.salesman_id;

-- 13. Salespersons, customers, and orders where applicable
SELECT s.name AS Salesman, c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Step 14: Salesmen Who Work for Customers or Have No Customers
SELECT DISTINCT s.salesman_id, s.name AS Salesman, s.city, s.commission
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE (o.purch_amt >= 2000 AND c.grade IS NOT NULL)
   OR (o.customer_id IS NULL);

-- Step 15: Report of Customers Who Placed Orders or Orders from Non-Listed Customers
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT 'Unknown Customer', 'Unknown City', o.ord_no, o.ord_date, o.purch_amt
FROM orders o
LEFT JOIN customer c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Step 16: Report of Customers with a Grade Who Placed Orders or Orders from Customers Not in List
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.grade IS NOT NULL
UNION
SELECT 'Unknown Customer', 'Unknown City', o.ord_no, o.ord_date, o.purch_amt
FROM orders o
LEFT JOIN customer c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Step 17: Cross Join of Salesman and Customer (Cartesian Product)
SELECT s.name AS Salesman, c.cust_name, s.city AS Salesman_City, c.city AS Customer_City
FROM salesman s
CROSS JOIN customer c;

-- Step 18: Cartesian Product for Salesman and Customers in Same City
SELECT s.name AS Salesman, c.cust_name, s.city AS Salesman_City, c.city AS Customer_City
FROM salesman s
CROSS JOIN customer c
WHERE s.city = c.city;

-- Step 19: Cartesian Product for Salesmen with City and Customers with Grade
SELECT s.name AS Salesman, c.cust_name, s.city AS Salesman_City, c.city AS Customer_City, c.grade
FROM salesman s
CROSS JOIN customer c
WHERE s.city IS NOT NULL AND c.grade IS NOT NULL;

-- Step 20: Cartesian Product for Salesmen and Customers in Different Cities with Grade
SELECT s.name AS Salesman, c.cust_name, s.city AS Salesman_City, c.city AS Customer_City, c.grade
FROM salesman s
CROSS JOIN customer c
WHERE s.city <> c.city AND c.grade IS NOT NULL;

