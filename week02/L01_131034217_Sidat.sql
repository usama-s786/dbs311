/*
-NAME: Usama Sidat
-ID: 131034217
-EMAIL: uisidat@myseneca.ca
-TITLE: DBS311 LAB 1
*/


/*
1)
Write a query to display the tomorrow?s date in the following format:
     January 10th of year 2019
the result will depend on the day when you RUN/EXECUTE this query.  Label the column ?Tomorrow?.*/
SELECT 
    TO_CHAR(sysdate + 1, 'MONTH DD"th" "of year" YYYY') AS Tomorrow
FROM dual;



/*
2)
For each product in category 2, 3, and 5, show product ID, product name, list price, and the new list price increased by 2%. Display a new list price as a whole number.
In your result, add a calculated column to show the difference of old and new list prices.*/
SELECT 
    p.product_ID, 
    p.product_Name, 
    p.list_Price, 
    round((p.list_Price/100) * 2 + p.list_Price) AS new_Price,
    round((p.list_Price/100) * 2 + p.list_Price) - p.list_Price AS difference
FROM products p 
WHERE p.category_ID in (2,3,5);



/*
3)
For employees whose manager ID is 2, write a query that displays the employee?s Full Name and Job Title in the following format:
SUMMER, PAYNE is Public Accountant.*/
SELECT 
    UPPER(first_name) || ',' || ' ' || UPPER(last_name) || ' ' || 'is'|| ' ' || job_Title || '.'
FROM employees
WHERE manager_id = 2;



/*
4)
: For each employee hired before October 2016, display the employee?s last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
?	Label the column Years worked. 
?	Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.*/
SELECT 
    last_name,
    TO_CHAR(hire_date, 'DD-MON-YYYY') AS hiredate,
    ROUND((TO_DATE(sysdate) - TO_DATE(hire_date, 'YY-MM-DD'))/365,4) AS years_worked,
    ROUND((TO_DATE(sysdate) - TO_DATE(hire_date, 'YY-MM-DD'))/365) AS years_worked_rounded
FROM employees
WHERE EXTRACT(YEAR FROM TO_DATE (hire_date, 'YY-MM-DD')) <= 2016 AND EXTRACT(MONTH FROM TO_DATE (hire_date, 'YY-MM-DD')) < 10
ORDER BY (TO_DATE(sysdate) - TO_DATE(hire_date, 'YY-MM-DD'))/365 DESC;



/* 
5)
: Display each employee?s last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016.  
?	Label the column REVIEW DAY. 
?	Format the dates to appear in the format like:
    TUESDAY, August the Thirty-First of year 2016
?	Sort by review date*/
SELECT
    last_name,
    TO_CHAR(hire_date, 'DD-MON-YYYY') AS hire_date,
    (NEXT_DAY(TO_DATE(hire_date+365), 'TUESDAY')) as reviewdate,
    TO_CHAR(NEXT_DAY(TO_DATE(hire_date+365), 'TUESDAY'), 'DAY"," MONTH "the" DDSP "of year" YYYY') AS reviewday
FROM employees
WHERE EXTRACT(YEAR FROM TO_DATE (hire_date, 'YY-MM-DD')) >= 2016    /* I've put >= intentionally here for employees after 2016 as there are no employees after year 2016, if the question was correct it would be > instead of >=*/
ORDER BY reviewdate;



/*
6)
For all warehouses, display warehouse id, warehouse name, city, and state. For warehouses with the null value for the state column, display ?unknown?.*/
SELECT 
    w.warehouse_id,
    w.warehouse_name,
    l.city,
    case when l.state is null then 'unknown' else l.state end
FROM warehouses w JOIN 
locations l ON w.location_id = l.location_id;
    
