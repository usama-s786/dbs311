Name: Khizar Mehmood

--1)
SELECT 
    TO_CHAR(sysdate + 1, 'MONTH DD"th" "of year" YYYY') AS Tomorrow
FROM dual;


--2)
SELECT 
    p.product_ID, 
    p.product_Name, 
    p.list_Price, 
    TRUNC((p.list_Price/100) * 2 + p.list_Price) AS new_Price,
    TRUNC((p.list_Price/100) * 2 + p.list_Price) - p.list_Price AS difference
FROM products p 
WHERE p.category_ID in (2,3,5);




--3)
SELECT 
    first_name || ',' || ' ' || last_name || ' ' || 'is'|| ' ' || job_Title || '.'
FROM employees
WHERE manager_id = 2;




--4)
SELECT 
    last_name,
    TO_CHAR(hire_date, 'DD-MON-YYYY') AS hiredate,
    ROUND((TO_DATE(sysdate) - TO_DATE(hire_date, 'YY-MM-DD'))/365,4) AS years_worked,
    ROUND((TO_DATE(sysdate) - TO_DATE(hire_date, 'YY-MM-DD'))/365) AS years_worked_rounded
FROM employees
WHERE EXTRACT(YEAR FROM TO_DATE (hire_date, 'YY-MM-DD')) <= 2016 AND EXTRACT(MONTH FROM TO_DATE (hire_date, 'YY-MM-DD')) < 10
ORDER BY (TO_DATE(sysdate) - TO_DATE(hire_date, 'YY-MM-DD'))/365 DESC;



 
--5)
SELECT
    last_name,
    TO_CHAR(hire_date, 'DD-MON-YYYY') AS hire_date,
    (NEXT_DAY(TO_DATE(hire_date+365), 'TUESDAY')) as reviewdate,
    TO_CHAR(NEXT_DAY(TO_DATE(hire_date+365), 'TUESDAY'), 'DAY"," MONTH "the" DDSP "of year" YYYY') AS reviewday
FROM employees
WHERE EXTRACT(YEAR FROM TO_DATE (hire_date, 'YY-MM-DD')) >= 2016    /* I've put >= intentionally here for employees after 2016 as there are no employees after year 2016, if the question was correct it would be > instead of >=*/
ORDER BY reviewdate;




--6)
SELECT 
    w.warehouse_id,
    w.warehouse_name,
    l.city,
    case when l.state is null then 'unknown' else l.state end
FROM warehouses w JOIN 
locations l ON w.location_id = l.location_id;
    
