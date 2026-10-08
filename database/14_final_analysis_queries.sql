-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 14_final_analysis_queries.sql
-- Description: 20 Advanced Analytical SQL Queries addressing real-world
--              e-commerce business, operational, and financial intelligence questions.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. Top 10 Best-Selling Products (by Units Sold)
-- Business Value: Identifies customer demand volume to guide inventory restocking.
-- ----------------------------------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    p.brand,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY p.product_id, p.product_name, p.brand
ORDER BY total_units_sold DESC, total_revenue DESC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- 2. Top Customers by Total Spending (High-Value Customers / VIPs)
-- Business Value: Helps marketing identify top spenders for VIP loyalty programs.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
ORDER BY total_spending DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 3. Total Store Gross Merchandise Value (GMV / Revenue)
-- Business Value: Executive financial KPI summarizing total gross sales revenue.
-- ----------------------------------------------------------------------------
SELECT 
    COUNT(order_id) AS successful_orders_count,
    SUM(total_amount) AS total_store_revenue,
    ROUND(AVG(total_amount), 2) AS overall_average_order_value
FROM Orders
WHERE order_status != 'Cancelled';

-- ----------------------------------------------------------------------------
-- 4. Revenue by Product Category
-- Business Value: Guides capital allocation toward the highest-earning product lines.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_id,
    c.category_name,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY category_revenue DESC;

-- ----------------------------------------------------------------------------
-- 5. Monthly Revenue and Order Growth Trend
-- Business Value: Tracks month-over-month sales velocity and seasonality.
-- ----------------------------------------------------------------------------
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(order_id) AS monthly_order_count,
    SUM(total_amount) AS monthly_gross_revenue,
    ROUND(AVG(total_amount), 2) AS monthly_aov
FROM Orders
WHERE order_status != 'Cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month ASC;

-- ----------------------------------------------------------------------------
-- 6. Average Order Value (AOV)
-- Business Value: Measures customer basket size to evaluate upselling effectiveness.
-- ----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_value,
    MIN(total_amount) AS min_order_value,
    MAX(total_amount) AS max_order_value
FROM Orders
WHERE order_status != 'Cancelled';

-- ----------------------------------------------------------------------------
-- 7. Customers Who Have Never Placed an Order (Dormant Signups)
-- Business Value: Pinpoints registered leads needing re-engagement discount coupons.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    c.registration_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- ----------------------------------------------------------------------------
-- 8. Products That Have Never Been Ordered (Dead Inventory)
-- Business Value: Detects stagnant catalog items requiring price drop or promotion.
-- ----------------------------------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    p.brand,
    p.price,
    p.stock_quantity
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- ----------------------------------------------------------------------------
-- 9. Low-Stock Products Requiring Immediate Restocking (Stock <= 15)
-- Business Value: Alerts supply chain managers of imminent stockouts.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    brand,
    stock_quantity,
    price
FROM Products
WHERE stock_quantity <= 15
ORDER BY stock_quantity ASC;

-- ----------------------------------------------------------------------------
-- 10. Most Popular Category (by Total Sales Volume)
-- Business Value: Highlights product domain driving maximum consumer adoption.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_name,
    SUM(oi.quantity) AS total_units_sold
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY total_units_sold DESC
LIMIT 1;

-- ----------------------------------------------------------------------------
-- 11. Highest-Value Single Order Placed
-- Business Value: Discovers maximum basket invoice and buyer identity.
-- ----------------------------------------------------------------------------
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.total_amount DESC
LIMIT 1;

-- ----------------------------------------------------------------------------
-- 12. Orders with Payment Pending
-- Business Value: Finance audit identifying orders awaiting payment verification.
-- ----------------------------------------------------------------------------
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    p.payment_method,
    p.payment_status,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE p.payment_status = 'Pending';

-- ----------------------------------------------------------------------------
-- 13. Orders Not Yet Delivered (Active Operational Pipeline)
-- Business Value: Operations dispatch tracking for pending fulfillment.
-- ----------------------------------------------------------------------------
SELECT 
    o.order_id,
    o.order_date,
    o.order_status,
    s.shipping_city,
    s.shipping_status,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
LEFT JOIN Shipping s ON o.order_id = s.order_id
WHERE o.order_status IN ('Pending', 'Processing', 'Shipped');

-- ----------------------------------------------------------------------------
-- 14. Average Delivery Duration (in Days) Across Fulfilled Orders
-- Business Value: Key Logistics KPI measuring average shipment turnaround time.
-- ----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(DATEDIFF(delivery_date, shipping_date)), 2) AS average_delivery_days,
    MIN(DATEDIFF(delivery_date, shipping_date)) AS fastest_delivery_days,
    MAX(DATEDIFF(delivery_date, shipping_date)) AS slowest_delivery_days
FROM Shipping
WHERE delivery_date IS NOT NULL AND shipping_date IS NOT NULL;

-- ----------------------------------------------------------------------------
-- 15. Customer Purchase Frequency (Order Count Distribution)
-- Business Value: Segments customer base into one-time vs repeat buyers.
-- ----------------------------------------------------------------------------
SELECT 
    order_frequency,
    COUNT(*) AS total_customers_in_cohort
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_frequency
    FROM Orders
    WHERE order_status != 'Cancelled'
    GROUP BY customer_id
) AS frequency_table
GROUP BY order_frequency
ORDER BY order_frequency ASC;

-- ----------------------------------------------------------------------------
-- 16. Products Priced Above the Global Catalog Average
-- Business Value: Isolates premium tier inventory for targeted luxury marketing.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    brand,
    price,
    ROUND((SELECT AVG(price) FROM Products), 2) AS catalog_average_price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products)
ORDER BY price DESC;

-- ----------------------------------------------------------------------------
-- 17. Category-Wise Product Count & Inventory Valuation
-- Business Value: Measures inventory capital locked in warehouse stock by category.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_name,
    COUNT(p.product_id) AS total_products,
    SUM(p.stock_quantity) AS total_warehouse_units,
    SUM(p.stock_quantity * p.price) AS total_inventory_valuation
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_inventory_valuation DESC;

-- ----------------------------------------------------------------------------
-- 18. Revenue Contribution Percentage by Product
-- Business Value: Evaluates Pareto Principle (80/20 rule) in individual item sales.
-- ----------------------------------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS product_revenue,
    ROUND((SUM(oi.quantity * oi.unit_price) / (
        SELECT SUM(quantity * unit_price) 
        FROM Order_Items oi2
        JOIN Orders o2 ON oi2.order_id = o2.order_id
        WHERE o2.order_status != 'Cancelled'
    )) * 100, 2) AS revenue_percentage_share
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- 19. Customers With Total Spending Above Average Customer Spending
-- Business Value: Extracts upper tier of purchasing cohort for account management.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS customer_lifetime_spend
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_spend_per_cust)
    FROM (
        SELECT SUM(total_amount) AS total_spend_per_cust
        FROM Orders
        WHERE order_status != 'Cancelled'
        GROUP BY customer_id
    ) AS cohort_spending
)
ORDER BY customer_lifetime_spend DESC;

-- ----------------------------------------------------------------------------
-- 20. Repeat Customers (Customers with Multiple Successful Purchases)
-- Business Value: Measures customer retention rate and repeats count.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    COUNT(o.order_id) AS successful_orders_count,
    SUM(o.total_amount) AS cumulative_expenditure
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
HAVING COUNT(o.order_id) > 1
ORDER BY successful_orders_count DESC, cumulative_expenditure DESC;
