/*
NAME: USAMA SIDAT
ID: 131034217
EMAIL: uisidat@myseneca.ca
TITLE: DBS311 LAB 03 - SUB QUERIES
DATE: 07-06-2022
*/


--1 
--Write a SQL query to display the last name and hire date of all employees who were hired before the employee with ID 107 got hired. Sort the result by the hire date.

SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date < (
        SELECT
            hire_date
        FROM
            employees
        WHERE
            employee_id = 107
    )
ORDER BY
    hire_date;


--2
--Write a SQL query to display customer name and credit limit for customers with lowest credit limit. Sort the result by customer name.

SELECT
    name,
    credit_limit
FROM
    customers
WHERE
    credit_limit = (
        SELECT
            MIN(credit_limit)
        FROM
            customers
    )
ORDER BY
    name;
    
    
--3
--Write a SQL query to display the product ID, product name, and list price of the highest paid product(s) in each category.  Sort by category ID. 

SELECT
    category_id,
    product_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price IN (
        SELECT
            MAX(list_price)
        FROM
            products
        GROUP BY
            category_id
    )
ORDER BY
    category_id;


--4
--Write a SQL query to display the category name of the most expensive (highest list price) product(s).

SELECT
    pc.category_id,
    category_name,
    MAX(list_price)
FROM
         products p
    JOIN product_categories pc ON p.category_id = pc.category_id
GROUP BY
    pc.category_id,
    category_name
ORDER BY
    pc.category_id;
  
    
--5
--Write a SQL query to display product name and list price for products in category 1 which have the list price less than the lowest list price in ANY category.  Sort the output by top list prices first and then by the product name

SELECT
    product_name,
    list_price
FROM
    products
WHERE
        category_id = 1
    AND list_price < ANY (
        SELECT
            MIN(list_price)
        FROM
            products
        GROUP BY
            category_id
    )
ORDER BY
    list_price DESC,
    product_name;

--6
--Display product ID, product name, and category ID for products of the category(s) that the lowest price product belongs to.

SELECT
    product_id,
    product_name,
    list_price,
    category_id
FROM
    products
WHERE
    category_id = (
        SELECT
            category_id
        FROM
            products
        WHERE
            list_price = (
                SELECT
                    MIN(list_price)
                FROM
                    products
            )
    );
            
