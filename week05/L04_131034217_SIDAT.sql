/*
NAME: Usama Sidat
ID: 131034217
TITLE: DBS311 LAB 4 - SET OPERATORS
*/

--1
--The HR department needs a list of Department IDs for departments that do not contain the job ID of ST_CLERK> Use a set operator to create this report.
SELECT
    department_id
FROM
    employees
MINUS
SELECT
    department_id
FROM
    employees
WHERE
    LOWER(job_id) = 'st_clerk';
--THIS COMMAND WILL NOT RETURN ANY RESULTS AND DISPLAY AN ERROR BECAUSE THERE ID NO DEPARTMENT ID IN ANY OF THE TABLE
--BUT I HAVE STILL ANSWERED THE QUESTION ACCORDING TO THE GIVEN STATEMENT


--2
--Display cities that no warehouse is located in them. (use set operators to answer this question)
SELECT
    city
FROM
    locations
MINUS
SELECT
    nvl(substr(warehouse_name, 0, instr(warehouse_name, ',') - 1), warehouse_name)
FROM
    warehouses;
    

--3
--Display the category ID, category name, and the number of products in category 1, 2, and 5. In your result, display first the number of products in category 5, then category 1 and then 2.
SELECT
    category_name,
    pr.category_id,
    COUNT(*) AS COUNT
FROM
    products pr
    JOIN product_categories prc ON pr.category_id = prc.category_id
WHERE
    pr.category_id = 5
GROUP BY
    pr.category_id,
    category_name
UNION ALL
SELECT
    category_name,
    pr.category_id,
    COUNT(*) AS COUNT
FROM
    products pr
    JOIN product_categories prc ON pr.category_id = prc.category_id
WHERE
    pr.category_id = 1
GROUP BY
    pr.category_id,
    category_name
UNION ALL
SELECT
    category_name,
    pr.category_id,
    COUNT(*) AS COUNT
FROM
    products pr
    JOIN product_categories prc ON pr.category_id = prc.category_id
WHERE
    pr.category_id = 2
GROUP BY
    pr.category_id,
    category_name;
    

--4
--Display product ID for ordered products whose quantity in the inventory is greater than 5. (You are not allowed to use JOIN for this question.)
SELECT
    product_id
FROM
    inventories
WHERE
    quantity > 5
INTERSECT
SELECT
    product_id
FROM
    order_items;
    
    
--5
--We need a single report to display all warehouses and the state that they are located in and all states regardless of whether they have warehouses in them or not.
SELECT
    warehouse_name,
    state
FROM
         warehouses w
    JOIN locations l ON w.location_id = l.location_id
UNION
SELECT
    to_char(NULL),
    state
FROM
    locations;
