--Examining the table
SELECT * FROM coffee_db.public.shop_tb;

--number of records we have in the table (149116)
SELECT COUNT(*)
FROM coffee_db.public.shop_tb;

--Checking missing values coffee shop (No missing values)
SELECT *
FROM coffee_db.public.shop_tb
WHERE transaction_id IS NULL OR transaction_date IS NULL OR transaction_time IS NULL OR transaction_qty IS NULL OR store_location IS NULL OR unit_price IS NULL OR product_category IS NULL OR product_type IS NULL;

--Checking duplicates values for user profiles (No duplicates)
SELECT *, Count(*)
FROM Coffee_db.public.shop_tb
GROUP BY ALL
HAVING Count(*)>1;

--Checking the inside store location column
SELECT DISTINCT store_location
FROM coffee_db.public.shop_tb;

--Checking the inside product category column
SELECT DISTINCT product_category
FROM coffee_db.public.shop_tb;

--Checking the inside product type column
SELECT DISTINCT product_type
FROM coffee_db.public.shop_tb;

--Count unique transactions (149 116)
SELECT COUNT (DISTINCT transaction_id) AS sales_count
FROM coffee_db.public.shop_tb;

--Min Date 
SELECT MIN(transaction_date) (2023-01-01)
FROM coffee_db.public.shop_tb;

--Max Date 
SELECT MAX(transaction_date) (2023-06-30)
FROM coffee_db.public.shop_tb;

--Date information--
SELECT 
TO_DATE(transaction_date) AS purchase_date,
TO_CHAR(TO_DATE(transaction_date), 'YYYY-MM') AS month_id,
DAYNAME(TO_DATE(transaction_date)) AS day_name,
MONTHNAME(TO_DATE(transaction_date)) AS month_name
FROM coffee_db.public.shop_tb;

--Min Time
SELECT MIN(transaction_time)
FROM coffee_db.public.shop_tb;

--Max Time
SELECT MAX(transaction_time)
FROM coffee_db.public.shop_tb;

--Create case statement for time
SELECT 
CASE
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning (06:00–11:59)'
    WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN H'Afternoon (12:00-15:59'
    WHEN transaction_time BETWEEN '16:00:00' AND '20:00:00' THEN 'Evening (16:00-20:00)'
    ELSE 'Night (20:01-23:59)'
END AS time_bucket
FROM coffee_db.public.shop_tb;

--Calculating the total items sold
SELECT SUM(transaction_qty) AS items_count
FROM coffee_db.public.shop_tb;

--Calculating the total revenue made
SELECT transaction_id,SUM(transaction_qty*unit_price) AS total_revenue
FROM coffee_db.public.shop_tb
GROUP BY ALL
HAVING SUM(transaction_qty*unit_price)>1
ORDER BY SUM(transaction_qty*unit_price) ;

--Min total revenue
SELECT MIN(transaction_qty*unit_price) AS total_revenue
FROM coffee_db.public.shop_tb
;

--MAX total revenue
SELECT Sum(transaction_qty*unit_price) AS total_revenue
FROM coffee_db.public.shop_tb
;

--Counting theunique , the total revenue and the total items bought
SELECT
    SUM(transaction_qty*unit_price) AS total_revenue,
    COUNT (DISTINCT transaction_id) AS sales_count,
    SUM(transaction_qty) AS items_count
FROM coffee_db.public.shop_tb;

SELECT
    SUM(transaction_qty*unit_price) AS total_revenue,
    COUNT (DISTINCT transaction_id) AS sales_count,
    SUM(transaction_qty) AS items_count,

    TO_DATE(transaction_date) AS purchase_date,
    TO_CHAR(TO_DATE(transaction_date), 'YYYY-MM') AS month_id,
    DAYNAME(TO_DATE(transaction_date)) AS day_name,
    MONTHNAME(TO_DATE(transaction_date)) AS month_name,

    CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning (06:00–11:59)'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon (12:00-15:59)'
        WHEN transaction_time BETWEEN '16:00:00' AND '20:00:00' THEN 'Evening (16:00-20:00)'
        ELSE 'Night (20:01-23:59)'
    END AS time_bucket,
    store_location,
    product_category,
    product_type
    
    FROM coffee_db.public.shop_tb
    GROUP BY ALL
    HAVING SUM(transaction_qty*unit_price)>0;

