-- Step 21: Insert Data into `company_mast` Table
INSERT INTO company_mast (com_id, com_name) 
SELECT * FROM (VALUES 
    (11, 'Samsung'),
    (12, 'iBall'),
    (13, 'Epsion'),
    (14, 'Zebronics'),
    (15, 'Asus'),
    (16, 'Frontech')
) AS temp(com_id, com_name)
WHERE NOT EXISTS (SELECT 1 FROM company_mast WHERE company_mast.com_id = temp.com_id);

-- Step 21: Insert Data into `item_mast` Table
INSERT INTO item_mast (pro_id, pro_name, pro_price, pro_com) 
SELECT * FROM (VALUES 
    (101, 'Mother Board', 3200.00, 15),
    (102, 'Key Board', 450.00, 16),
    (103, 'ZIP drive', 250.00, 14),
    (104, 'Speaker', 550.00, 16),
    (105, 'Monitor', 5000.00, 11),
    (106, 'DVD drive', 900.00, 12),
    (107, 'CD drive', 800.00, 12),
    (108, 'Printer', 2600.00, 13),
    (109, 'Refill cartridge', 350.00, 13),
    (110, 'Mouse', 250.00, 12)
) AS temp(pro_id, pro_name, pro_price, pro_com)
WHERE NOT EXISTS (SELECT 1 FROM item_mast WHERE item_mast.pro_id = temp.pro_id);

-- Step 22: Display Item Name, Price, and Company Name of All Products
SELECT i.pro_name AS Item_Name, i.pro_price AS Price, c.com_name AS Company
FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id;

-- Step 23: Calculate Average Price of Items per Company
SELECT c.com_name AS Company, AVG(i.pro_price) AS Avg_Price
FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id
GROUP BY c.com_name;

-- Step 24: Calculate Average Price of Items per Company Where Average >= 350
SELECT c.com_name AS Company, AVG(i.pro_price) AS Avg_Price
FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id
GROUP BY c.com_name
HAVING AVG(i.pro_price) >= 350;

-- Step 25: Find the Most Expensive Product of Each Company
SELECT i.pro_name AS Item_Name, i.pro_price AS Price, c.com_name AS Company
FROM item_mast i
JOIN company_mast c ON i.pro_com = c.com_id
WHERE i.pro_price = (SELECT MAX(pro_price) FROM item_mast WHERE pro_com = i.pro_com);

