-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 06_update_delete.sql
-- Description: Demonstrates data manipulation (DML) for modifying existing
--              records and safely deleting rows with foreign-key awareness.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ============================================================================
-- PART 1: REALISTIC UPDATE OPERATIONS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Update Product Price (Discount/Price Revision)
-- Description: Apply a 5% discount on all Apple products in the catalog.
-- ----------------------------------------------------------------------------
UPDATE Products
SET price = ROUND(price * 0.95, 2)
WHERE brand = 'Apple';

-- Verify the update:
SELECT product_id, product_name, brand, price
FROM Products
WHERE brand = 'Apple';

-- ----------------------------------------------------------------------------
-- 2. Update Product Inventory Stock
-- Description: Replenish inventory stock for product_id 35 by 15 units.
-- ----------------------------------------------------------------------------
UPDATE Products
SET stock_quantity = stock_quantity + 15
WHERE product_id = 35;

-- Verify the update:
SELECT product_id, product_name, stock_quantity
FROM Products
WHERE product_id = 35;

-- ----------------------------------------------------------------------------
-- 3. Update Customer Address & Contact Info
-- Description: Update address and phone number for customer_id 1 upon relocation.
-- ----------------------------------------------------------------------------
UPDATE Customers
SET address = 'Flat 901, Skyview Towers, Financial District',
    pincode = '500032',
    phone = '9876543999'
WHERE customer_id = 1;

-- Verify the update:
SELECT customer_id, first_name, last_name, address, pincode, phone
FROM Customers
WHERE customer_id = 1;

-- ----------------------------------------------------------------------------
-- 4. Update Order Status
-- Description: Transition Order 29 from 'Pending' to 'Processing' upon verification.
-- ----------------------------------------------------------------------------
UPDATE Orders
SET order_status = 'Processing'
WHERE order_id = 29 AND order_status = 'Pending';

-- Verify the update:
SELECT order_id, order_status, total_amount
FROM Orders
WHERE order_id = 29;

-- ----------------------------------------------------------------------------
-- 5. Update Payment Status & Method
-- Description: Confirm cash-on-delivery collection for Order 29.
-- ----------------------------------------------------------------------------
UPDATE Payments
SET payment_status = 'Completed'
WHERE order_id = 29;

-- Verify the update:
SELECT payment_id, order_id, payment_status, amount
FROM Payments
WHERE order_id = 29;

-- ----------------------------------------------------------------------------
-- 6. Update Shipping Status & Delivery Timestamp
-- Description: Mark in-transit delivery as 'Delivered' and record current timestamp.
-- ----------------------------------------------------------------------------
UPDATE Shipping
SET shipping_status = 'Delivered',
    delivery_date = '2024-03-29 11:30:00'
WHERE shipping_id = 25;

-- Verify the update:
SELECT shipping_id, order_id, shipping_status, delivery_date
FROM Shipping
WHERE shipping_id = 25;


-- ============================================================================
-- PART 2: SAFE DELETE OPERATIONS WITH FOREIGN KEY AWARENESS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 7. Safe Delete: Child Table Record (Reviews)
-- Description: Delete an outdated or inappropriate customer review (review_id 20).
-- Referential Integrity Note:
-- Reviews is a leaf/child table referenced by nothing else, so deleting
-- a review does not violate any foreign key constraints.
-- ----------------------------------------------------------------------------
DELETE FROM Reviews
WHERE review_id = 20;

-- Verify deletion:
SELECT * FROM Reviews WHERE review_id = 20;

-- ----------------------------------------------------------------------------
-- 8. Safe Cascade Delete: Order with Dependent Child Records
-- Description: Remove cancelled order (order_id 30).
-- Referential Integrity Note:
-- Because Order_Items, Payments, and Shipping tables have FOREIGN KEY 
-- constraints defined with ON DELETE CASCADE pointing to Orders(order_id),
-- removing order_id 30 cleanly and automatically removes all of its associated
-- order items and payment audit records without orphan data.
-- ----------------------------------------------------------------------------
DELETE FROM Orders
WHERE order_id = 30 AND order_status = 'Cancelled';

-- Verify cascade:
SELECT * FROM Orders WHERE order_id = 30;
SELECT * FROM Order_Items WHERE order_id = 30;
SELECT * FROM Payments WHERE order_id = 30;

-- ----------------------------------------------------------------------------
-- 9. Deleting Unreferenced Parent Record Safely
-- Description: Customer 18 (Kavya Menon) registered but has not placed any orders.
-- Referential Integrity Note:
-- Attempting to DELETE Customer 1 (who has active orders) would fail with error
-- `Cannot delete or update a parent row: a foreign key constraint fails (ON DELETE RESTRICT)`.
-- However, deleting an inactive customer who has 0 orders is completely safe.
-- ----------------------------------------------------------------------------
DELETE FROM Customers
WHERE customer_id = 18
  AND customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);

-- Verify deletion:
SELECT customer_id, first_name, last_name FROM Customers WHERE customer_id = 18;
