-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 10_joins.sql
-- Description: Comprehensive demonstration of relational joins in MySQL 8.0+:
--              1. INNER JOIN
--              2. LEFT JOIN
--              3. RIGHT JOIN
--              4. FULL OUTER JOIN (Simulated via LEFT JOIN UNION RIGHT JOIN)
--              5. SELF JOIN
--              6. CROSS JOIN
--              7. EQUI JOIN
--              8. NATURAL JOIN
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. INNER JOIN
-- Explanation:
-- An INNER JOIN returns only records that have matching values in both tables.
-- Unmatched customers or unassigned orders are excluded.
-- Business Use Case:
-- Retrieves active orders together with corresponding customer profile data.
-- ----------------------------------------------------------------------------
SELECT 
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    c.phone
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id ASC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- 2. LEFT JOIN (LEFT OUTER JOIN)
-- Explanation:
-- Returns ALL records from the left table (Customers), and matched records
-- from the right table (Orders). If no match exists, NULL values are returned.
-- Business Use Case:
-- Lists every registered customer, identifying both purchasing customers and
-- dormant users who have never placed an order (order_id IS NULL).
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    c.email,
    o.order_id,
    o.order_date,
    o.total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id ASC, o.order_id ASC;

-- ----------------------------------------------------------------------------
-- 3. RIGHT JOIN (RIGHT OUTER JOIN)
-- Explanation:
-- Returns ALL records from the right table (Products), and matched records
-- from the left table (Order_Items). Products with no purchase show NULL.
-- Business Use Case:
-- Validates product catalog sales coverage, surfacing products that have never
-- been ordered.
-- ----------------------------------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    p.brand,
    p.price,
    oi.order_item_id,
    oi.order_id,
    oi.quantity
FROM Order_Items oi
RIGHT JOIN Products p ON oi.product_id = p.product_id
ORDER BY p.product_id ASC;

-- ----------------------------------------------------------------------------
-- 4. FULL OUTER JOIN EQUIVALENT IN MYSQL
-- Explanation:
-- MySQL 8.0 does NOT have a native `FULL OUTER JOIN` keyword syntax.
-- In standard MySQL, FULL OUTER JOIN is achieved by combining a LEFT JOIN 
-- and a RIGHT JOIN using the `UNION` operator to eliminate duplicate records.
-- Business Use Case:
-- Comprehensive reconciliation between Customers and Orders, displaying all
-- customers (even without orders) AND all orders (even if customer foreign key
-- was orphaned or set to NULL in an outer system).
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    o.order_id,
    o.total_amount,
    o.order_status
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    o.order_id,
    o.total_amount,
    o.order_status
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

-- ----------------------------------------------------------------------------
-- 5. SELF JOIN
-- Explanation:
-- A regular join where a table is joined with itself by aliasing it twice (c1, c2).
-- Business Use Case:
-- Pairs customers who reside in the exact same city and state to identify
-- local geographic clusters for grouped delivery hubs or local community marketing.
-- ----------------------------------------------------------------------------
SELECT 
    c1.city,
    c1.state,
    CONCAT(c1.first_name, ' ', c1.last_name) AS customer_1,
    c1.customer_id AS id_1,
    CONCAT(c2.first_name, ' ', c2.last_name) AS customer_2,
    c2.customer_id AS id_2
FROM Customers c1
JOIN Customers c2 
    ON c1.city = c2.city 
    AND c1.customer_id < c2.customer_id
ORDER BY c1.city ASC;

-- ----------------------------------------------------------------------------
-- 6. CROSS JOIN
-- Explanation:
-- Produces the Cartesian product of two tables (m × n rows), pairing every row 
-- of table 1 with every row of table 2.
-- Business Use Case:
-- Evaluates theoretical pricing matrix combinations of top categories and
-- standard payment methods for promotional discount campaign modeling.
-- ----------------------------------------------------------------------------
SELECT 
    c.category_name,
    pm.payment_method
FROM (
    SELECT DISTINCT category_name 
    FROM Categories 
    LIMIT 3
) c
CROSS JOIN (
    SELECT DISTINCT payment_method 
    FROM Payments 
    LIMIT 3
) pm
ORDER BY c.category_name, pm.payment_method;

-- ----------------------------------------------------------------------------
-- 7. EQUI JOIN
-- Explanation:
-- A join condition that exclusively uses the equality operator (`=`) to match
-- column values between two or more tables.
-- Business Use Case:
-- Combines Order_Items, Products, and Categories on identical primary/foreign keys.
-- ----------------------------------------------------------------------------
SELECT 
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    c.category_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total
FROM Order_Items oi, Products p, Categories c
WHERE oi.product_id = p.product_id 
  AND p.category_id = c.category_id
ORDER BY oi.order_item_id ASC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- 8. NATURAL JOIN
-- Explanation:
-- Automatically matches columns across two tables that share the EXACT same name
-- (e.g., category_id in Categories and Products).
-- Note: While concise, best production practice prefers explicit ON clauses.
-- Business Use Case:
-- Joins Products directly to Categories without typing an explicit ON condition.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    category_id,
    category_name,
    price,
    brand
FROM Products
NATURAL JOIN Categories
ORDER BY product_id ASC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- 9. MULTI-TABLE 5-WAY JOIN (Production Workflow Demonstration)
-- Explanation:
-- Connects Customers -> Orders -> Order_Items -> Products -> Shipping -> Payments.
-- Business Use Case:
-- Generates an end-to-end commercial dispatch & audit report for every line item.
-- ----------------------------------------------------------------------------
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    o.total_amount AS order_grand_total,
    pay.payment_method,
    pay.payment_status,
    s.shipping_city,
    s.shipping_status
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
LEFT JOIN Payments pay ON o.order_id = pay.order_id
LEFT JOIN Shipping s ON o.order_id = s.order_id
WHERE o.order_id = 1;
