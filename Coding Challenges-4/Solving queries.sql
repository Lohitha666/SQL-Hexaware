-- Step 5: Execute Queries

-- 1. Update the daily rate for Mercedes to 68 (Check if it exists first)
UPDATE Vehicle SET dailyRate = 68.00 WHERE make = 'Mercedes';

-- 2. Delete a customer and all associated leases/payments (Check customer exists first)
SELECT * FROM Customer WHERE customerID = 1; 
DELETE FROM Customer WHERE customerID = 1;

-- 3. Find a customer by email
SELECT * FROM Customer WHERE email = 'janesmith@example.com';

-- 4. Get active leases for a specific customer
SELECT * FROM Lease WHERE customerID = 2;

-- 5. Find all payments made by a customer with a specific phone number
SELECT p.* FROM Payment p
JOIN Lease l ON p.leaseID = l.leaseID
JOIN Customer c ON l.customerID = c.customerID
WHERE c.phoneNumber = '555-123-4567';

-- 6. Calculate the average daily rate of all available cars
SELECT AVG(dailyRate) AS avgDailyRate FROM Vehicle WHERE status = 'available';

-- 7. Find the car with the highest daily rate
SELECT TOP 1 * FROM Vehicle ORDER BY dailyRate DESC;

-- 8. Retrieve all cars leased by a specific customer
SELECT v.* FROM Vehicle v
JOIN Lease l ON v.vehicleID = l.vehicleID
WHERE l.customerID = 2;

-- 9. Find the details of the most recent lease
SELECT TOP 1 * FROM Lease ORDER BY endDate DESC;

-- 10. List all payments made in 2023
SELECT * FROM Payment WHERE YEAR(transactionDate) = 2023;

-- 11. Retrieve customers who have not made any payments
SELECT c.* FROM Customer c
LEFT JOIN Lease l ON c.customerID = l.customerID
LEFT JOIN Payment p ON l.leaseID = p.leaseID
WHERE p.paymentID IS NULL;

-- 12. Retrieve Car Details and Their Total Payments
SELECT v.make, v.model, SUM(p.amount) AS totalPayments
FROM Vehicle v
JOIN Lease l ON v.vehicleID = l.vehicleID
JOIN Payment p ON l.leaseID = p.leaseID
GROUP BY v.make, v.model;

-- 13. Calculate Total Payments for Each Customer
SELECT c.firstName, c.lastName, SUM(p.amount) AS totalPayments
FROM Customer c
JOIN Lease l ON c.customerID = l.customerID
JOIN Payment p ON l.leaseID = p.leaseID
GROUP BY c.firstName, c.lastName;

-- 14. List Car Details for Each Lease
SELECT l.leaseID, v.make, v.model, l.startDate, l.endDate, l.leaseType
FROM Lease l
JOIN Vehicle v ON l.vehicleID = v.vehicleID;

-- 15. Retrieve Details of Active Leases with Customer and Car Information
SELECT l.leaseID, c.firstName, c.lastName, v.make, v.model, l.startDate, l.endDate
FROM Lease l
JOIN Customer c ON l.customerID = c.customerID
JOIN Vehicle v ON l.vehicleID = v.vehicleID
WHERE l.endDate >= GETDATE();

-- 16. Find the Customer Who Has Spent the Most on Leases
SELECT TOP 1 c.firstName, c.lastName, SUM(p.amount) AS totalSpent
FROM Customer c
JOIN Lease l ON c.customerID = l.customerID
JOIN Payment p ON l.leaseID = p.leaseID
GROUP BY c.firstName, c.lastName
ORDER BY totalSpent DESC;

-- 17. List All Cars with Their Current Lease Information
SELECT v.make, v.model, l.startDate, l.endDate, c.firstName, c.lastName
FROM Vehicle v
LEFT JOIN Lease l ON v.vehicleID = l.vehicleID
LEFT JOIN Customer c ON l.customerID = c.customerID