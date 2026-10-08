-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 07_aggregate_functions.sql
-- Description: Demonstrates SQL aggregate functions (COUNT, SUM, AVG, MIN, MAX),
--              along with GROUP BY and HAVING clauses for commercial analytics.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ============================================================================
-- PART 1: CORE AGGREGATE FUNCTIONS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Total Number of Registered Customers
-- Description: Measures user acquisition reach using COUNT().
-- ----------------------------------------------------------------------------
SELECT COUNT(*) AS total_customers
FROM Customers;

-- ----------------------------------------------------------------------------
-- 2. Total Products and Total Units in Inventory Stock
-- Description: Computes catalog breadth and total available warehouse items.
-- ----------------------------------------------------------------------------
SELECT 
    COUNT(product_id) AS total_product_catalog_count,
    SUM(stock_quantity) AS total_stock_units_in_warehouse
FROM Products;

-- ----------------------------------------------------------------------------
-- 3. Product Pricing Metrics: Average, Minimum, and Maximum
-- Description: Evaluates product catalog pricing tiers.
-- ----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(price), 2) AS average_product_price,
    MIN(price) AS lowest_product_price,
    MAX(price) AS highest_product_price
FROM Products;

-- ----------------------------------------------------------------------------
-- 4. Total Sales and Overall Order Count
-- Description: Computes total gross merchandise value (GMV) and order volume.
-- ----------------------------------------------------------------------------
SELECT 
    COUNT(order_id) AS total_orders_placed,
    SUM(total_amount) AS total_sales_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM Orders
WHERE order_status != 'Cancelled';

-- ----------------------------------------------------------------------------
-- 5. Total Quantity of Units Sold Across All Orders
-- Description: Sums the total individual items ordered using Order_Items.
-- ----------------------------------------------------------------------------
SELECT SUM(quantity) AS total_units_sold
FROM Order_Items;


-- ============================================================================
-- PART 2: GROUP BY AGGREGATIONS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 6. Products Count and Average Price by Category
-- Description: Groups products by their category to analyze category size and pricing.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.price), 2) AS avg_category_price,
    MIN(p.price) AS min_price,
    MAX(p.price) AS max_price
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC;

-- ----------------------------------------------------------------------------
-- 7. Sales Revenue and Volume by Category
-- Description: Computes total revenue contributed by each product category.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_name,
    COUNT(oi.order_item_id) AS total_items_sold,
    SUM(oi.quantity * oi.unit_price) AS total_category_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY total_category_revenue DESC;

-- ----------------------------------------------------------------------------
-- 8. Orders and Total Spending by Customer
-- Description: Summarizes purchase activity per customer.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spend
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_spend DESC;

-- ----------------------------------------------------------------------------
-- 9. Revenue and Transaction Count by Payment Method
-- Description: Evaluates customer payment channel preferences and volume.
-- ----------------------------------------------------------------------------
SELECT 
    payment_method,
    COUNT(payment_id) AS transaction_count,
    SUM(amount) AS total_processed_amount,
    ROUND(AVG(amount), 2) AS average_transaction_value
FROM Payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY total_processed_amount DESC;

-- ----------------------------------------------------------------------------
-- 10. Order Distribution by Status
-- Description: Groups orders by fulfillment pipeline stage.
-- ----------------------------------------------------------------------------
SELECT 
    order_status,
    COUNT(order_id) AS order_count,
    SUM(total_amount) AS status_total_value
FROM Orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ============================================================================
-- PART 3: HAVING CLAUSE (FILTERING GROUPED AGGREGATIONS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 11. Repeat Customers (Customers with strictly more than 2 Orders)
-- Description: Uses HAVING to filter customers who placed > 2 orders.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 2
ORDER BY order_count DESC;

-- ----------------------------------------------------------------------------
-- 12. High-Performing Categories (Total Sales Exceeding 50,000 INR)
-- Description: Uses HAVING to isolate elite sales categories generating > 50K.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.category_id, c.category_name
HAVING SUM(oi.quantity * oi.unit_price) > 50000.00
ORDER BY category_revenue DESC;

-- ----------------------------------------------------------------------------
-- 13. Cities with High Customer Density (More than 1 Customer)
-- Description: Groups customers by city and filters for cities with > 1 resident.
-- ----------------------------------------------------------------------------
SELECT 
    city,
    state,
    COUNT(customer_id) AS total_registered_customers
FROM Customers
GROUP BY city, state
HAVING COUNT(customer_id) > 1
ORDER BY total_registered_customers DESC;
