-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 08_date_time_functions.sql
-- Description: Demonstrates MySQL temporal functions:
--              CURDATE(), NOW(), YEAR(), MONTH(), DAY(), DATEDIFF(),
--              DATE_FORMAT(), DATE_ADD(), and DATE_SUB().
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. Display Current Date and Timestamp
-- Description: Inspect system clock using CURDATE() and NOW().
-- ----------------------------------------------------------------------------
SELECT 
    CURDATE() AS current_system_date,
    NOW() AS current_system_timestamp,
    UTC_TIMESTAMP() AS current_utc_timestamp;

-- ----------------------------------------------------------------------------
-- 2. Extract YEAR, MONTH, DAY, and HOUR from Order Timestamps
-- Description: Breaks down temporal components for audit analysis.
-- ----------------------------------------------------------------------------
SELECT 
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month_num,
    MONTHNAME(order_date) AS order_month_name,
    DAY(order_date) AS order_day,
    DAYNAME(order_date) AS order_weekday,
    HOUR(order_date) AS order_hour
FROM Orders
ORDER BY order_date DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 3. Filter Orders Placed in a Specific Year (2023 vs 2024)
-- Description: Annual cohort analysis using YEAR() function.
-- ----------------------------------------------------------------------------
SELECT 
    YEAR(order_date) AS sales_year,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_annual_revenue
FROM Orders
GROUP BY YEAR(order_date)
ORDER BY sales_year ASC;

-- ----------------------------------------------------------------------------
-- 4. Monthly Sales and Order Volume Breakdown
-- Description: Evaluates seasonal trends by grouping by Year and Month.
-- ----------------------------------------------------------------------------
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS order_count,
    SUM(total_amount) AS monthly_sales
FROM Orders
WHERE order_status != 'Cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month ASC;

-- ----------------------------------------------------------------------------
-- 5. Calculate Fulfillment Duration Using DATEDIFF()
-- Description: Measures transit days taken between shipping and delivery.
-- ----------------------------------------------------------------------------
SELECT 
    shipping_id,
    order_id,
    shipping_city,
    shipping_date,
    delivery_date,
    DATEDIFF(delivery_date, shipping_date) AS days_taken_for_delivery
FROM Shipping
WHERE delivery_date IS NOT NULL
ORDER BY days_taken_for_delivery DESC;

-- ----------------------------------------------------------------------------
-- 6. Average Delivery Days Across Cities
-- Description: Evaluates logistics SLA performance by city using DATEDIFF() & AVG().
-- ----------------------------------------------------------------------------
SELECT 
    shipping_city,
    COUNT(shipping_id) AS delivered_shipments,
    ROUND(AVG(DATEDIFF(delivery_date, shipping_date)), 1) AS avg_delivery_days
FROM Shipping
WHERE delivery_date IS NOT NULL
GROUP BY shipping_city
ORDER BY avg_delivery_days ASC;

-- ----------------------------------------------------------------------------
-- 7. Formatting Dates for Invoices & Reports Using DATE_FORMAT()
-- Description: Formats raw MySQL timestamps into polite readable formats.
-- ----------------------------------------------------------------------------
SELECT 
    order_id,
    customer_id,
    DATE_FORMAT(order_date, '%W, %d %M %Y at %h:%i %p') AS formatted_order_time,
    DATE_FORMAT(order_date, '%d-%b-%Y') AS short_date,
    total_amount
FROM Orders
ORDER BY order_id ASC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 8. Customer Tenure / Account Age in Days
-- Description: Calculates how many days each customer has been registered.
-- ----------------------------------------------------------------------------
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    registration_date,
    DATEDIFF('2024-04-10 00:00:00', registration_date) AS account_age_days
FROM Customers
ORDER BY account_age_days DESC;

-- ----------------------------------------------------------------------------
-- 9. Using DATE_ADD and DATE_SUB for SLA Projections
-- Description: Estimate promised delivery deadline (e.g. 5 days after order placement).
-- ----------------------------------------------------------------------------
SELECT 
    order_id,
    order_date,
    DATE_ADD(order_date, INTERVAL 5 DAY) AS estimated_delivery_deadline,
    order_status
FROM Orders
LIMIT 5;
