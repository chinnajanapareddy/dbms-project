-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 11_subqueries.sql
-- Description: Demonstrates nested subqueries in MySQL 8.0+:
--              1. Single-row subqueries
--              2. Multi-row subqueries (IN, ANY, ALL)
--              3. Correlated subqueries (EXISTS, NOT EXISTS)
--              4. Subqueries in SELECT and FROM clauses
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ============================================================================
-- PART 1: SINGLE-ROW SUBQUERIES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Products Priced Above the Catalog Average
-- Subquery Concept:
-- The inner query returns a single scalar float representing the average price.
-- The outer query filters products that exceed this single value.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    brand,
    price
FROM Products
WHERE price > (
    SELECT AVG(price) 
    FROM Products
)
ORDER BY price DESC;

-- ----------------------------------------------------------------------------
-- 2. Retrieve the Absolute Most Expensive Product
-- Subquery Concept:
-- The subquery calculates MAX(price), and the outer query returns the record.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    brand,
    price
FROM Products
WHERE price = (
    SELECT MAX(price) 
    FROM Products
);

-- ----------------------------------------------------------------------------
-- 3. Customers Whose Total Spending is Above Average Customer Spending
-- Subquery Concept:
-- Inner scalar subquery averages the total spend across all customers.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS customer_total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(order_sum)
    FROM (
        SELECT SUM(total_amount) AS order_sum
        FROM Orders
        WHERE order_status != 'Cancelled'
        GROUP BY customer_id
    ) AS customer_averages
)
ORDER BY customer_total_spent DESC;


-- ============================================================================
-- PART 2: MULTI-ROW SUBQUERIES (IN, NOT IN, ANY, ALL)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 4. Multi-Row Subquery with IN: Customers Who Have Placed Orders
-- Subquery Concept:
-- The inner query returns a result set list of distinct customer_ids.
-- ----------------------------------------------------------------------------
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS active_buyer,
    city,
    email
FROM Customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id 
    FROM Orders
);

-- ----------------------------------------------------------------------------
-- 5. Multi-Row Subquery with NOT IN: Products That Have Never Been Ordered
-- Subquery Concept:
-- Finds inventory items that have never appeared in any order line item.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    brand,
    price,
    stock_quantity
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM Order_Items
);

-- ----------------------------------------------------------------------------
-- 6. Multi-Row Subquery with > ALL: Products Priced Higher Than ALL Book Category Products
-- Subquery Concept:
-- Finds items whose price exceeds the price of every item in category_id = 6 (Books).
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    price
FROM Products
WHERE price > ALL (
    SELECT price 
    FROM Products 
    WHERE category_id = 6
)
ORDER BY price ASC
LIMIT 10;


-- ============================================================================
-- PART 3: CORRELATED SUBQUERIES (EXISTS, NOT EXISTS, ROW-BY-ROW EVALUATION)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 7. Correlated Subquery: Products Priced Higher Than Their Own Category Average
-- Subquery Concept:
-- For each product evaluated in the outer query, the inner query calculates
-- the average price strictly within that product's specific category_id.
-- ----------------------------------------------------------------------------
SELECT 
    p1.product_id,
    p1.product_name,
    p1.category_id,
    p1.price,
    ROUND((
        SELECT AVG(p2.price) 
        FROM Products p2 
        WHERE p2.category_id = p1.category_id
    ), 2) AS category_avg_price
FROM Products p1
WHERE p1.price > (
    SELECT AVG(p2.price)
    FROM Products p2
    WHERE p2.category_id = p1.category_id
)
ORDER BY p1.category_id ASC, p1.price DESC;

-- ----------------------------------------------------------------------------
-- 8. Correlated Subquery with EXISTS: Customers Who Have at Least One Delivered Order
-- Subquery Concept:
-- Tests for the existence of rows in Orders matching the outer customer_id.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city
FROM Customers c
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.customer_id = c.customer_id 
      AND o.order_status = 'Delivered'
);

-- ----------------------------------------------------------------------------
-- 9. Correlated Subquery with NOT EXISTS: Customers Who Never Placed Any Orders
-- Subquery Concept:
-- Returns records from Customers where no matching order exists in Orders.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS dormant_customer,
    c.email,
    c.registration_date
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.customer_id = c.customer_id
);


-- ============================================================================
-- PART 4: SUBQUERY IN SELECT & FROM (DERIVED TABLES)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 10. Subquery in SELECT Clause: Customer Order Count Alongside Details
-- Subquery Concept:
-- Computes an inline count for each customer row directly in the SELECT list.
-- ----------------------------------------------------------------------------
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    (
        SELECT COUNT(*) 
        FROM Orders o 
        WHERE o.customer_id = c.customer_id
    ) AS total_orders_placed
FROM Customers c
ORDER BY total_orders_placed DESC;

-- ----------------------------------------------------------------------------
-- 11. Subquery in FROM Clause (Derived Table): Rank Top Spending Customers
-- Subquery Concept:
-- Treats the aggregated result set as a virtual table in the FROM clause.
-- ----------------------------------------------------------------------------
SELECT 
    customer_summary.customer_id,
    customer_summary.total_spend,
    CASE 
        WHEN customer_summary.total_spend >= 100000 THEN 'Platinum VIP'
        WHEN customer_summary.total_spend >= 25000  THEN 'Gold'
        ELSE 'Silver'
    END AS customer_loyalty_tier
FROM (
    SELECT customer_id, SUM(total_amount) AS total_spend
    FROM Orders
    WHERE order_status != 'Cancelled'
    GROUP BY customer_id
) AS customer_summary
ORDER BY total_spend DESC;
