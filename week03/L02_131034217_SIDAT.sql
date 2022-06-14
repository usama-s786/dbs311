/*
NAME: USAMA SIDAT
ID: 131034217
TITLE: LAB 02
*/


--1
--For each job title display the number of employees. 
SELECT 
job_title,
COUNT(employee_id) AS COUNT
FROM employees
GROUP BY job_title;


--2
--Display the Highest, Lowest and Average customer credit limits. Name these results High, Low and Avg. Add a column that shows the difference between the highest and lowest credit limits.
SELECT
MAX(credit_limit) AS HIGH,
MIN(credit_limit) AS LOW,
(MAX(credit_limit) - MIN(credit_limit)) AS DIFFERENCE,
ROUND(AVG(credit_limit),2) AS AVERAGE
FROM customers;


--3
--Display the order id and the total order amount for orders with the total amount over $1000,000. 
SELECT 
    order_id, SUM(quantity*unit_price)AS TOTAL_PRICE
FROM order_items
GROUP BY order_id
HAVING SUM(quantity*unit_price) > 1000000
ORDER BY order_id;


--4
--Display the warehouse id, warehouse name, and the total number of products for each warehouse. 
SELECT 
    warehouse_id,
    warehouse_name,
    (   SELECT count(product_id) AS COUNT
        FROM inventories i
        WHERE warehouse_id = w.warehouse_id
        GROUP BY warehouse_id   ) AS PRODUCT_COUNT
FROM warehouses w
ORDER BY warehouse_id;


--5
--For each customer display the number of orders issued by the customer. If the customer does not have any orders, the result show display 0.
SELECT 
    customer_id,
    name,
    (SELECT count(order_id) AS COUNT
        FROM orders o
        WHERE customer_id = c.customer_id ) AS ORDER_COUNT
FROM customers c
ORDER BY customer_id;


--6
--Write a SQL query to show the total and the average sale amount for each category.
SELECT 
    pc.category_id,
    category_name,
    CASE 
        WHEN SUM(quantity*unit_price) IS NOT NULL
            THEN SUM(quantity*unit_price)
        ELSE 0
    END AS TOTAL_SALE,
    CASE 
        WHEN ROUND(AVG(quantity*unit_price),2) IS NOT NULL
            THEN ROUND(AVG(quantity*unit_price),2)
        ELSE 0
    END AS AVERAGE_SALE
from products p
FULL JOIN product_categories pc ON  p.category_id = pc.category_id
FULL JOIN order_items USING (product_id)
GROUP BY pc.category_id, pc.category_name
ORDER BY category_id;

