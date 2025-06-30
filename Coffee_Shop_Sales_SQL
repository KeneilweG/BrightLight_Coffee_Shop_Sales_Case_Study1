--Selecting the whole table to examine it--
SELECT * FROM coffeeshop_db.transactions.bright_coffee_shop;

--Checking the number of rows--
SELECT COUNT(*) 
FROM coffeeshop_db.transactions.bright_coffee_shop;

SELECT 
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    SUM(transaction_qty) AS number_of_items_sold,
    SUM(transaction_qty*unit_price) AS total_revenue,

    TO_DATE(transaction_date) AS purchase_date,
    TO_CHAR(TO_DATE(transaction_date), 'YYYY-MM') AS month_id,
    DAYNAME(TO_DATE(transaction_date)) AS day_name,
    MONTHNAME(TO_DATE(transaction_date)) AS month_name,
    
    
    CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN transaction_time BETWEEN '16:00:00' AND '20:00:00' THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,

    CASE 
        WHEN SUM(transaction_qty*unit_price) <=1 THEN 'Low'
        WHEN SUM(transaction_qty*unit_price) BETWEEN 2 AND 10 THEN 'Medium'
        ELSE 'High'
    END AS spender_bucket,

    store_location,
    product_category,
    product_type,
    product_detail
 
FROM coffeeshop_db.transactions.bright_coffee_shop
GROUP BY 
    store_location,
    product_category,
    product_type,
    product_detail,
    time_bucket,
    purchase_date,
    month_id,
    day_name,
    month_name
HAVING SUM(transaction_qty*unit_price)>0;
