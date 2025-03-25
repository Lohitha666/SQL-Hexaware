-- 31. Calculate Average Price of Products by Manufacturer
SELECT C.COM_NAME, AVG(I.PRO_PRICE) AS Average_Price
FROM item_mast I
JOIN company_mast C ON I.PRO_COM = C.COM_ID
GROUP BY C.COM_NAME;
GO

-- 32. Calculate Average Price of Manufacturer's Products (≥ 350)
SELECT C.COM_NAME, AVG(I.PRO_PRICE) AS Average_Price
FROM item_mast I
JOIN company_mast C ON I.PRO_COM = C.COM_ID
WHERE I.PRO_PRICE >= 350
GROUP BY C.COM_NAME;
GO

-- 33. Find Most Expensive Product of Each Company
SELECT I.PRO_NAME, I.PRO_PRICE, C.COM_NAME
FROM item_mast I
JOIN company_mast C ON I.PRO_COM = C.COM_ID
WHERE I.PRO_PRICE = (
    SELECT MAX(PRO_PRICE) FROM item_mast WHERE PRO_COM = I.PRO_COM
);
GO

-- 34. Find Employees with Last Name Gabriel or Dosio
SELECT EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT
FROM emp_details
WHERE EMP_LNAME IN ('Gabriel', 'Dosio');
GO

-- 35. Find Employees in Departments 89 or 63
SELECT EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT
FROM emp_details
WHERE EMP_DEPT IN (89, 63);
GO

-- 36. Find Employees in Departments with Allotment > Rs. 50000
SELECT E.EMP_FNAME, E.EMP_LNAME
FROM emp_details E
JOIN emp_department D ON E.EMP_DEPT = D.DPT_CODE
WHERE D.DPT_ALLOTMENT > 50000;
GO

-- 37. Find Departments with Sanction Amount Above Average
SELECT DPT_CODE, DPT_NAME, DPT_ALLOTMENT
FROM emp_department
WHERE DPT_ALLOTMENT > (SELECT AVG(DPT_ALLOTMENT) FROM emp_department);
GO

-- 38. Find Departments with More Than Two Employees
SELECT D.DPT_NAME
FROM emp_department D
JOIN emp_details E ON D.DPT_CODE = E.EMP_DEPT
GROUP BY D.DPT_NAME
HAVING COUNT(E.EMP_IDNO) > 2;
GO

-- 39. Find Employees in Departments with Second Lowest Allotment
SELECT E.EMP_FNAME, E.EMP_LNAME
FROM emp_details E
JOIN emp_department D ON E.EMP_DEPT = D.DPT_CODE
WHERE D.DPT_ALLOTMENT = (
    SELECT DISTINCT DPT_ALLOTMENT 
    FROM emp_department 
    ORDER BY DPT_ALLOTMENT ASC 
    OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
);
GO