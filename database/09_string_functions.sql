-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 09_string_functions.sql
-- Description: Demonstrates MySQL string manipulation functions:
--              CONCAT(), CONCAT_WS(), UPPER(), LOWER(), LENGTH(), CHAR_LENGTH(),
--              SUBSTRING(), TRIM(), REPLACE(), and LPAD() on store records.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. CONCAT() and CONCAT_WS()
-- Description: Merges customer first name and last name into full legal name.
-- ----------------------------------------------------------------------------
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name_concat,
    CONCAT_WS(' - ', CONCAT(first_name, ' ', last_name), city, phone) AS customer_contact_card
FROM Customers
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 2. UPPER() and LOWER()
-- Description: Standardizes text cases for reporting and email normalization.
-- ----------------------------------------------------------------------------
SELECT 
    brand,
    UPPER(brand) AS brand_uppercase,
    email,
    LOWER(email) AS email_normalized
FROM Products p
JOIN Customers c ON p.product_id = c.customer_id
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 3. LENGTH() and CHAR_LENGTH()
-- Description: Calculates character count of product names and descriptions.
-- ----------------------------------------------------------------------------
SELECT 
    product_name,
    CHAR_LENGTH(product_name) AS product_name_char_count,
    LENGTH(description) AS description_byte_length
FROM Products
ORDER BY CHAR_LENGTH(product_name) DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 4. SUBSTRING() / SUBSTR()
-- Description: Truncates descriptions for product summary card previews.
-- ----------------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    SUBSTRING(description, 1, 35) AS short_preview_description,
    CONCAT(SUBSTRING(description, 1, 35), '...') AS ellipsis_card_preview
FROM Products
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 5. TRIM(), LTRIM(), and RTRIM()
-- Description: Demonstrates stripping accidental leading/trailing spaces from user inputs.
-- ----------------------------------------------------------------------------
SELECT 
    TRIM('   Flat 402, Green Meadows   ') AS cleaned_address_both,
    LTRIM('   Left padded text') AS cleaned_left,
    RTRIM('Right padded text   ') AS cleaned_right;

-- ----------------------------------------------------------------------------
-- 6. REPLACE() Function
-- Description: Masks sensitive phone number digits or formats address text.
-- ----------------------------------------------------------------------------
SELECT 
    customer_id,
    phone,
    CONCAT('XXXXXX', SUBSTRING(phone, 7, 4)) AS masked_phone,
    REPLACE(email, '@example.com', '@ecommerce-store.in') AS internal_domain_email
FROM Customers
LIMIT 5;

-- ----------------------------------------------------------------------------
-- 7. LPAD() and RPAD() Formatting
-- Description: Generates padded formal invoice order IDs (e.g., ORD-00001).
-- ----------------------------------------------------------------------------
SELECT 
    order_id,
    CONCAT('ORD-', LPAD(order_id, 5, '0')) AS formatted_order_reference,
    customer_id,
    total_amount
FROM Orders
ORDER BY order_id ASC
LIMIT 5;
