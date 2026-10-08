-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 05_basic_queries.sql
-- Description: Demonstrates core Data Query Language (DQL) clauses:
--              SELECT, WHERE, ORDER BY, DISTINCT, LIMIT, BETWEEN, IN,
--              LIKE, and IS NULL / IS NOT NULL with realistic scenarios.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. Simple SELECT *
-- Description: Retrieve all columns and rows from the Customers table.
-- ----------------------------------------------------------------------------
SELECT * 
FROM Customers;

-- ----------------------------------------------------------------------------
-- 2. Column Projection (SELECT specific columns)
-- Description: Fetch only name, price, and stock for all products.
-- ----------------------------------------------------------------------------
SELECT product_id, product_name, brand, price, stock_quantity
FROM Products;

-- ----------------------------------------------------------------------------
-- 3. WHERE Clause (Exact Match Filter)
-- Description: Retrieve all customers residing in 'Hyderabad'.
-- ----------------------------------------------------------------------------
SELECT customer_id, first_name, last_name, city, phone
FROM Customers
WHERE city = 'Hyderabad';

-- ----------------------------------------------------------------------------
-- 4. WHERE with Comparison Operators (> and <=)
-- Description: Find all premium products with price greater than 50,000 INR.
-- ----------------------------------------------------------------------------
SELECT product_id, product_name, brand, price
FROM Products
WHERE price > 50000.00
ORDER BY price DESC;

-- ----------------------------------------------------------------------------
-- 5. ORDER BY (Ascending & Descending)
-- Description: List all products sorted alphabetically by brand ASC, then price DESC.
-- ----------------------------------------------------------------------------
SELECT product_id, brand, product_name, price
FROM Products
ORDER BY brand ASC, price DESC;

-- ----------------------------------------------------------------------------
-- 6. DISTINCT Clause
-- Description: Retrieve unique cities where registered customers live.
-- ----------------------------------------------------------------------------
SELECT DISTINCT city, state
FROM Customers
ORDER BY state ASC, city ASC;

-- ----------------------------------------------------------------------------
-- 7. LIMIT Clause (Pagination & Top Records)
-- Description: View the top 5 most expensive products available in the catalog.
-- ----------------------------------------------------------------------------
SELECT product_id, product_name, brand, price
FROM Products
ORDER BY price DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 8. LIMIT with OFFSET (Pagination)
-- Description: Retrieve page 2 of products (items 6 through 10, offset 5, limit 5).
-- ----------------------------------------------------------------------------
SELECT product_id, product_name, price
FROM Products
ORDER BY product_id ASC
LIMIT 5 OFFSET 5;

-- ----------------------------------------------------------------------------
-- 9. BETWEEN Operator (Range Filtering)
-- Description: Find products priced between 1,000 and 10,000 INR.
-- ----------------------------------------------------------------------------
SELECT product_id, product_name, brand, price
FROM Products
WHERE price BETWEEN 1000.00 AND 10000.00
ORDER BY price ASC;

-- ----------------------------------------------------------------------------
-- 10. IN Operator (List Membership)
-- Description: Retrieve orders with status 'Delivered' or 'Shipped'.
-- ----------------------------------------------------------------------------
SELECT order_id, customer_id, order_date, order_status, total_amount
FROM Orders
WHERE order_status IN ('Delivered', 'Shipped')
ORDER BY order_date DESC;

-- ----------------------------------------------------------------------------
-- 11. NOT IN Operator
-- Description: List customers who do not belong to metro hubs (Delhi, Mumbai, Bangalore).
-- ----------------------------------------------------------------------------
SELECT customer_id, first_name, last_name, city, state
FROM Customers
WHERE city NOT IN ('Delhi', 'Mumbai', 'Bangalore')
ORDER BY city ASC;

-- ----------------------------------------------------------------------------
-- 12. LIKE Operator (Wildcard Matching)
-- Description: Find all products containing the keyword 'Wireless' anywhere in their name.
-- ----------------------------------------------------------------------------
SELECT product_id, product_name, brand, price
FROM Products
WHERE product_name LIKE '%Wireless%';

-- ----------------------------------------------------------------------------
-- 13. LIKE Operator (Prefix and Suffix pattern matching)
-- Description: Find customers whose first name starts with 'A' and ends with 'a' or 'v'.
-- ----------------------------------------------------------------------------
SELECT customer_id, first_name, last_name, email
FROM Customers
WHERE first_name LIKE 'A%v' OR first_name LIKE 'A%a';

-- ----------------------------------------------------------------------------
-- 14. IS NULL Operator
-- Description: Identify shipments that have not yet been delivered (delivery_date IS NULL).
-- ----------------------------------------------------------------------------
SELECT shipping_id, order_id, shipping_city, shipping_status, shipping_date, delivery_date
FROM Shipping
WHERE delivery_date IS NULL;

-- ----------------------------------------------------------------------------
-- 15. IS NOT NULL Operator
-- Description: Find product reviews where users wrote an explicit textual feedback.
-- ----------------------------------------------------------------------------
SELECT review_id, product_id, customer_id, rating, review_text
FROM Reviews
WHERE review_text IS NOT NULL;
