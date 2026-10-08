-- ============================================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- File: 04_insert_data.sql
-- Description: Inserts realistic, production-like Indian e-commerce data.
--              Includes 18 Customers, 10 Categories, 35 Products, 30 Orders,
--              60 Order Items, 30 Payments, 25 Shipping entries, and 20 Reviews.
-- Target RDBMS: MySQL 8.0+
-- ============================================================================

USE ecommerce_db;

-- ----------------------------------------------------------------------------
-- 1. Insert Categories (10 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Consumer electronics, accessories, audio devices, and smart wearables'),
(2, 'Mobiles', 'Latest smartphones, 5G devices, mobile accessories, and chargers'),
(3, 'Laptops', 'Ultrabooks, gaming laptops, business computers, and PC peripherals'),
(4, 'Fashion', 'Men, women, and kids apparel, ethnic wear, footwear, and apparel accessories'),
(5, 'Home Appliances', 'Kitchen appliances, smart home gadgets, air conditioners, and refrigerators'),
(6, 'Books', 'Academic textbooks, competitive examination guides, fiction, and non-fiction'),
(7, 'Beauty', 'Skincare, haircare, personal grooming essentials, and cosmetic products'),
(8, 'Sports', 'Fitness equipment, athletic gear, sporting goods, and outdoor accessories'),
(9, 'Furniture', 'Ergonomic study chairs, wooden desks, sofas, and modern bedroom furniture'),
(10, 'Grocery', 'Packaged staples, organic dry fruits, gourmet tea, coffee, and daily essentials');

-- ----------------------------------------------------------------------------
-- 2. Insert Customers (18 Records across major Indian cities)
-- ----------------------------------------------------------------------------
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, city, state, pincode, registration_date) VALUES
(1, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '9876543210', 'Flat 402, Green Meadows, Madhapur', 'Hyderabad', 'Telangana', '500081', '2023-01-15 10:30:00'),
(2, 'Sai', 'Kiran', 'sai.kiran@example.com', '9876543211', 'Plot 12, Ring Road, Benz Circle', 'Vijayawada', 'Andhra Pradesh', '520010', '2023-02-10 11:15:00'),
(3, 'Priya', 'Reddy', 'priya.reddy@example.com', '9876543212', 'House 5-9/1, Beach Road', 'Visakhapatnam', 'Andhra Pradesh', '530002', '2023-03-05 14:20:00'),
(4, 'Karthik', 'Raman', 'karthik.raman@example.com', '9876543213', '24 Anna Salai, T Nagar', 'Chennai', 'Tamil Nadu', '600017', '2023-03-22 09:45:00'),
(5, 'Ananya', 'Iyer', 'ananya.iyer@example.com', '9876543214', '78 Koramangala 4th Block', 'Bangalore', 'Karnataka', '560034', '2023-04-12 16:10:00'),
(6, 'Rohan', 'Mehta', 'rohan.mehta@example.com', '9876543215', '502 Sea View Apt, Bandra West', 'Mumbai', 'Maharashtra', '400050', '2023-05-18 18:30:00'),
(7, 'Neha', 'Kapoor', 'neha.kapoor@example.com', '9876543216', 'B-14 Hauz Khas Enclave', 'Delhi', 'Delhi', '110016', '2023-06-01 12:00:00'),
(8, 'Debabrata', 'Mukherjee', 'debabrata.m@example.com', '9876543217', '18 Park Street, 2nd Floor', 'Kolkata', 'West Bengal', '700016', '2023-06-25 15:40:00'),
(9, 'Sneha', 'Patil', 'sneha.patil@example.com', '9876543218', '203 Shivaji Nagar, FC Road', 'Pune', 'Maharashtra', '411005', '2023-07-09 10:05:00'),
(10, 'Vikram', 'Varma', 'vikram.varma@example.com', '9876543219', '14 Jubilee Hills, Road No 36', 'Hyderabad', 'Telangana', '500033', '2023-08-14 13:50:00'),
(11, 'Meera', 'Nair', 'meera.nair@example.com', '9876543220', '32 MG Road, Panampilly Nagar', 'Kochi', 'Kerala', '682036', '2023-09-02 17:25:00'),
(12, 'Aditya', 'Chauhan', 'aditya.c@example.com', '9876543221', '88 C-Scheme, Ashok Nagar', 'Jaipur', 'Rajasthan', '302001', '2023-09-20 11:35:00'),
(13, 'Pooja', 'Verma', 'pooja.verma@example.com', '9876543222', '45 Gomti Nagar, Vibhuti Khand', 'Lucknow', 'Uttar Pradesh', '226010', '2023-10-05 14:15:00'),
(14, 'Manoj', 'Kumar', 'manoj.kumar@example.com', '9876543223', '10 Gandhinagar, Eluru Road', 'Vijayawada', 'Andhra Pradesh', '520003', '2023-11-11 08:50:00'),
(15, 'Divya', 'Bhat', 'divya.bhat@example.com', '9876543224', '15 Indiranagar 100ft Road', 'Bangalore', 'Karnataka', '560038', '2023-12-01 19:00:00'),
(16, 'Rajesh', 'Guptha', 'rajesh.guptha@example.com', '9876543225', '67 Siripuram Junction', 'Visakhapatnam', 'Andhra Pradesh', '530003', '2024-01-08 10:20:00'),
(17, 'Harish', 'Rao', 'harish.rao@example.com', '9876543226', '29 Somajiguda Main Road', 'Hyderabad', 'Telangana', '500082', '2024-02-14 16:45:00'),
(18, 'Kavya', 'Menon', 'kavya.menon@example.com', '9876543227', '9 Palayam, University Road', 'Thiruvananthapuram', 'Kerala', '695034', '2024-03-01 12:10:00');

-- ----------------------------------------------------------------------------
-- 3. Insert Products (35 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Products (product_id, product_name, category_id, price, stock_quantity, brand, description, created_at) VALUES
(1, 'Sony WH-1000XM5 Wireless Headphones', 1, 29990.00, 25, 'Sony', 'Premium active noise cancelling wireless over-ear headphones', '2023-01-01 10:00:00'),
(2, 'Apple AirPods Pro (2nd Gen)', 1, 24900.00, 40, 'Apple', 'True wireless earbuds with active noise cancellation and USB-C case', '2023-01-02 10:00:00'),
(3, 'Boat Rockerz 450 Bluetooth Headphone', 1, 1499.00, 120, 'boAt', 'Lightweight wireless on-ear headset with 15hr playback', '2023-01-03 10:00:00'),
(4, 'Logitech MX Master 3S Mouse', 1, 9495.00, 30, 'Logitech', 'Ergonomic performance wireless mouse with quiet clicks and 8K DPI', '2023-01-04 10:00:00'),
(5, 'Apple iPhone 15 Pro 128GB', 2, 134900.00, 15, 'Apple', 'A17 Pro chip, aerospace titanium design, 48MP main camera', '2023-01-05 10:00:00'),
(6, 'Samsung Galaxy S24 Ultra 256GB', 2, 129999.00, 18, 'Samsung', 'Snapdragon 8 Gen 3 with Galaxy AI, S-Pen and 200MP camera', '2023-01-06 10:00:00'),
(7, 'OnePlus 12 5G 256GB', 2, 64999.00, 28, 'OnePlus', 'Flagship Hasselblad camera, Snapdragon 8 Gen 3, 100W SuperVOOC', '2023-01-07 10:00:00'),
(8, 'Redmi Note 13 Pro+ 5G', 2, 31999.00, 50, 'Xiaomi', 'Curved AMOLED display with 200MP camera and IP68 protection', '2023-01-08 10:00:00'),
(9, 'Apple MacBook Air M2 256GB', 3, 99900.00, 20, 'Apple', '13.6-inch Liquid Retina display, 8-core CPU, 8GB unified memory', '2023-01-09 10:00:00'),
(10, 'Dell XPS 13 Plus Core i7', 3, 159990.00, 8, 'Dell', 'OLED infinity edge touch screen, 16GB LPDDR5 RAM, 1TB NVMe SSD', '2023-01-10 10:00:00'),
(11, 'Lenovo Legion 5 Pro Gaming Laptop', 3, 124990.00, 12, 'Lenovo', 'AMD Ryzen 7 7745HX, RTX 4060 8GB GPU, 16GB RAM, 1TB SSD', '2023-01-11 10:00:00'),
(12, 'ASUS TUF Gaming F15', 3, 62990.00, 22, 'ASUS', 'Intel Core i5-11400H, RTX 2050 GPU, 16GB RAM, 512GB SSD', '2023-01-12 10:00:00'),
(13, 'HP 15s Ryzen 5 Thin Laptop', 3, 44990.00, 35, 'HP', 'AMD Ryzen 5 5500U, 15.6-inch FHD display, 16GB DDR4, 512GB SSD', '2023-01-13 10:00:00'),
(14, 'Men Slim Fit Denim Jacket', 4, 2499.00, 60, 'Levi\'s', 'Classic blue washed denim jacket with metal button closures', '2023-01-14 10:00:00'),
(15, 'Women Pure Cotton Anarkali Kurta', 4, 1899.00, 75, 'Biba', 'Handcrafted ethnic printed anarkali kurti with floral patterns', '2023-01-15 10:00:00'),
(16, 'Nike Air Jordan 1 Low Retro', 4, 8995.00, 14, 'Nike', 'Premium genuine leather low-top basketball sneakers', '2023-01-16 10:00:00'),
(17, 'Puma Men Running Shoes', 4, 3499.00, 45, 'Puma', 'Lightweight mesh athletic jogging and gym running trainers', '2023-01-17 10:00:00'),
(18, 'Philips Digital Air Fryer 4.1L', 5, 8999.00, 20, 'Philips', 'Rapid Air technology for healthy cooking with up to 90% less fat', '2023-01-18 10:00:00'),
(19, 'LG 8 Kg Front Load Washing Machine', 5, 38990.00, 10, 'LG', 'AI Direct Drive with steam allergy care and 6 Motion technology', '2023-01-19 10:00:00'),
(20, 'Samsung 253L Inverter Refrigerator', 5, 24490.00, 15, 'Samsung', 'Frost-free double door refrigerator with digital inverter motor', '2023-01-20 10:00:00'),
(21, 'Dyson V8 Cordless Vacuum Cleaner', 5, 29900.00, 9, 'Dyson', 'Powerful cordless stick vacuum with detangling motorbar brush', '2023-01-21 10:00:00'),
(22, 'Database System Concepts (Silberschatz)', 6, 899.00, 110, 'McGraw Hill', 'Comprehensive guide to database design, relational models, and SQL', '2023-01-22 10:00:00'),
(23, 'Atomic Habits by James Clear', 6, 550.00, 150, 'Penguin Random House', 'Proven practical framework for building good habits and breaking bad ones', '2023-01-23 10:00:00'),
(24, 'Designing Data-Intensive Applications', 6, 1750.00, 40, 'O\'Reilly', 'Architecture guide for distributed systems, reliability, and scaling', '2023-01-24 10:00:00'),
(25, 'Minimalist 10% Niacinamide Serum', 7, 599.00, 85, 'Minimalist', 'Facial serum for acne marks, blemishes, and oil control', '2023-01-25 10:00:00'),
(26, 'The Ordinary Hyaluronic Acid 2% + B5', 7, 750.00, 90, 'The Ordinary', 'Hydrating water-based serum with pure hyaluronic acid molecules', '2023-01-26 10:00:00'),
(27, 'Forest Essentials Ayurvedic Face Cleanser', 7, 1425.00, 30, 'Forest Essentials', 'Gentle facial wash enriched with saffron and neem oils', '2023-01-27 10:00:00'),
(28, 'Yonex Astrox 77 Badminton Racket', 8, 8490.00, 18, 'Yonex', 'High-modulus graphite racket for powerful steep smashes', '2023-01-28 10:00:00'),
(29, 'Decathlon 20kg Adjustable Dumbbell Set', 8, 4999.00, 25, 'Domyos', 'Cast iron weight plates with spinlock threaded chrome bars', '2023-01-29 10:00:00'),
(30, 'Cosco Championship Football Size 5', 8, 999.00, 60, 'Cosco', 'FIFA quality hand-stitched synthetic leather match football', '2023-01-30 10:00:00'),
(31, 'Wakefit Ergonomic High Back Office Chair', 9, 8799.00, 15, 'Wakefit', 'Breathable mesh chair with adjustable lumbar support and 2D armrests', '2023-01-31 10:00:00'),
(32, 'Green Soul Solid Wood Study Desk', 9, 6499.00, 12, 'Green Soul', 'Engineered teak finish modern writing desk with 2 drawers', '2023-02-01 10:00:00'),
(33, 'Organic Kashmiri Almonds 500g', 10, 850.00, 100, 'NuttyGritties', '100% natural, vacuum-packed jumbo California almonds', '2023-02-02 10:00:00'),
(34, 'Blue Tokai Attikan Estate Dark Roast Coffee', 10, 520.00, 80, 'Blue Tokai', 'Artisan 100% arabica specialty coffee grounds 250g', '2023-02-03 10:00:00'),
(35, 'Logitech C920 HD Pro Webcam', 1, 7495.00, 0, 'Logitech', 'Full HD 1080p video calling and recording with stereo audio', '2023-02-04 10:00:00');

-- ----------------------------------------------------------------------------
-- 4. Insert Orders (30 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Orders (order_id, customer_id, order_date, order_status, total_amount) VALUES
(1, 1, '2023-03-10 11:20:00', 'Delivered', 29990.00),
(2, 2, '2023-03-15 15:45:00', 'Delivered', 24900.00),
(3, 3, '2023-04-02 09:10:00', 'Delivered', 134900.00),
(4, 4, '2023-04-18 14:30:00', 'Delivered', 4398.00),
(5, 5, '2023-05-05 16:50:00', 'Delivered', 99900.00),
(6, 6, '2023-05-20 12:15:00', 'Delivered', 159990.00),
(7, 7, '2023-06-11 18:00:00', 'Delivered', 1449.00),
(8, 8, '2023-06-29 10:40:00', 'Delivered', 2649.00),
(9, 1, '2023-07-14 13:25:00', 'Delivered', 9495.00),
(10, 9, '2023-08-01 17:10:00', 'Delivered', 8999.00),
(11, 10, '2023-08-19 11:05:00', 'Delivered', 129999.00),
(12, 2, '2023-09-05 14:55:00', 'Delivered', 1899.00),
(13, 11, '2023-09-22 19:30:00', 'Delivered', 38990.00),
(14, 12, '2023-10-10 10:15:00', 'Delivered', 8995.00),
(15, 3, '2023-11-04 16:40:00', 'Delivered', 1349.00),
(16, 13, '2023-11-20 12:50:00', 'Delivered', 24490.00),
(17, 14, '2023-12-08 15:20:00', 'Delivered', 8490.00),
(18, 5, '2023-12-25 18:05:00', 'Delivered', 1370.00),
(19, 1, '2024-01-12 11:45:00', 'Delivered', 64999.00),
(20, 6, '2024-01-28 14:10:00', 'Delivered', 8799.00),
(21, 15, '2024-02-10 09:30:00', 'Delivered', 4999.00),
(22, 7, '2024-02-22 16:15:00', 'Delivered', 1425.00),
(23, 16, '2024-03-05 13:40:00', 'Delivered', 6499.00),
(24, 4, '2024-03-18 10:50:00', 'Delivered', 1499.00),
(25, 2, '2024-03-25 17:00:00', 'Shipped', 31999.00),
(26, 10, '2024-03-28 12:30:00', 'Shipped', 124990.00),
(27, 8, '2024-03-30 15:10:00', 'Processing', 899.00),
(28, 9, '2024-04-01 11:20:00', 'Processing', 29900.00),
(29, 11, '2024-04-02 14:00:00', 'Pending', 62990.00),
(30, 13, '2024-04-03 16:45:00', 'Cancelled', 44990.00);

-- Note: Customer 17 (Harish Rao) and Customer 18 (Kavya Menon) have placed 0 orders
-- so we can validate LEFT JOIN and NULL handling queries accurately!

-- ----------------------------------------------------------------------------
-- 5. Insert Order_Items (60 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 29990.00),
(2, 2, 2, 1, 24900.00),
(3, 3, 5, 1, 134900.00),
(4, 4, 14, 1, 2499.00),
(5, 4, 15, 1, 1899.00),
(6, 5, 9, 1, 99900.00),
(7, 6, 10, 1, 159990.00),
(8, 7, 22, 1, 899.00),
(9, 7, 23, 1, 550.00),
(10, 8, 22, 1, 899.00),
(11, 8, 24, 1, 1750.00),
(12, 9, 4, 1, 9495.00),
(13, 10, 18, 1, 8999.00),
(14, 11, 6, 1, 129999.00),
(15, 12, 15, 1, 1899.00),
(16, 13, 19, 1, 38990.00),
(17, 14, 16, 1, 8995.00),
(18, 15, 25, 1, 599.00),
(19, 15, 26, 1, 750.00),
(20, 16, 20, 1, 24490.00),
(21, 17, 28, 1, 8490.00),
(22, 18, 33, 1, 850.00),
(23, 18, 34, 1, 520.00),
(24, 19, 7, 1, 64999.00),
(25, 20, 31, 1, 8799.00),
(26, 21, 29, 1, 4999.00),
(27, 22, 27, 1, 1425.00),
(28, 23, 32, 1, 6499.00),
(29, 24, 3, 1, 1499.00),
(30, 25, 8, 1, 31999.00),
(31, 26, 11, 1, 124990.00),
(32, 27, 22, 1, 899.00),
(33, 28, 21, 1, 29900.00),
(34, 29, 12, 1, 62990.00),
(35, 30, 13, 1, 44990.00),
-- Additional multi-item lines for rich order basket diversity:
(36, 1, 3, 1, 1499.00),
(37, 2, 4, 1, 9495.00),
(38, 5, 23, 2, 550.00),
(39, 9, 34, 2, 520.00),
(40, 11, 1, 1, 29990.00),
(41, 14, 17, 1, 3499.00),
(42, 19, 2, 1, 24900.00),
(43, 20, 4, 1, 9495.00),
(44, 21, 30, 2, 999.00),
(45, 25, 3, 2, 1499.00),
(46, 26, 4, 1, 9495.00),
(47, 4, 17, 1, 3499.00),
(48, 7, 33, 1, 850.00),
(49, 10, 25, 2, 599.00),
(50, 12, 26, 2, 750.00),
(51, 13, 18, 1, 8999.00),
(52, 15, 27, 1, 1425.00),
(53, 16, 21, 1, 29900.00),
(54, 17, 30, 3, 999.00),
(55, 18, 23, 1, 550.00),
(56, 22, 25, 2, 599.00),
(57, 23, 31, 1, 8799.00),
(58, 24, 14, 1, 2499.00),
(59, 27, 24, 1, 1750.00),
(60, 28, 18, 1, 8999.00);

-- Note: Product 35 (Logitech C920 HD Pro Webcam) has 0 orders (to demonstrate unpurchased products query).

-- Recalculate and synchronize exact total_amount in Orders matching Order_Items sums:
UPDATE Orders o
JOIN (
    SELECT order_id, SUM(quantity * unit_price) AS calculated_sum
    FROM Order_Items
    GROUP BY order_id
) sub ON o.order_id = sub.order_id
SET o.total_amount = sub.calculated_sum;

-- ----------------------------------------------------------------------------
-- 6. Insert Payments (30 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status, amount) VALUES
(1, 1, '2023-03-10 11:22:00', 'Credit Card', 'Completed', 31489.00),
(2, 2, '2023-03-15 15:47:00', 'UPI', 'Completed', 34395.00),
(3, 3, '2023-04-02 09:12:00', 'Net Banking', 'Completed', 134900.00),
(4, 4, '2023-04-18 14:32:00', 'UPI', 'Completed', 7897.00),
(5, 5, '2023-05-05 16:53:00', 'Credit Card', 'Completed', 101000.00),
(6, 6, '2023-05-20 12:18:00', 'Net Banking', 'Completed', 159990.00),
(7, 7, '2023-06-11 18:02:00', 'Debit Card', 'Completed', 2299.00),
(8, 8, '2023-06-29 10:42:00', 'UPI', 'Completed', 2649.00),
(9, 9, '2023-07-14 13:28:00', 'Credit Card', 'Completed', 10535.00),
(10, 10, '2023-08-01 17:12:00', 'UPI', 'Completed', 10197.00),
(11, 11, '2023-08-19 11:08:00', 'Credit Card', 'Completed', 159989.00),
(12, 12, '2023-09-05 14:58:00', 'Debit Card', 'Completed', 3399.00),
(13, 13, '2023-09-22 19:33:00', 'Net Banking', 'Completed', 47989.00),
(14, 14, '2023-10-10 10:18:00', 'UPI', 'Completed', 12494.00),
(15, 15, '2023-11-04 16:42:00', 'UPI', 'Completed', 2774.00),
(16, 16, '2023-11-20 12:54:00', 'Credit Card', 'Completed', 54390.00),
(17, 17, '2023-12-08 15:23:00', 'UPI', 'Completed', 11487.00),
(18, 18, '2023-12-25 18:08:00', 'Cash on Delivery', 'Completed', 1920.00),
(19, 19, '2024-01-12 11:48:00', 'Net Banking', 'Completed', 89899.00),
(20, 20, '2024-01-28 14:14:00', 'Credit Card', 'Completed', 18294.00),
(21, 21, '2024-02-10 09:33:00', 'UPI', 'Completed', 6997.00),
(22, 22, '2024-02-22 16:18:00', 'Debit Card', 'Completed', 2623.00),
(23, 23, '2024-03-05 13:43:00', 'Net Banking', 'Completed', 15298.00),
(24, 24, '2024-03-18 10:53:00', 'UPI', 'Completed', 3998.00),
(25, 25, '2024-03-25 17:03:00', 'Credit Card', 'Completed', 34997.00),
(26, 26, '2024-03-28 12:35:00', 'Net Banking', 'Completed', 134485.00),
(27, 27, '2024-03-30 15:13:00', 'UPI', 'Completed', 2649.00),
(28, 28, '2024-04-01 11:22:00', 'Credit Card', 'Completed', 38899.00),
(29, 29, '2024-04-02 14:05:00', 'Cash on Delivery', 'Pending', 62990.00),
(30, 30, '2024-04-03 16:50:00', 'UPI', 'Refunded', 44990.00);

-- Sync Payments amounts with exact Orders totals:
UPDATE Payments p
JOIN Orders o ON p.order_id = o.order_id
SET p.amount = o.total_amount;

-- ----------------------------------------------------------------------------
-- 7. Insert Shipping (25 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Shipping (shipping_id, order_id, shipping_address, shipping_city, shipping_state, shipping_pincode, shipping_date, delivery_date, shipping_status) VALUES
(1, 1, 'Flat 402, Green Meadows, Madhapur', 'Hyderabad', 'Telangana', '500081', '2023-03-11 09:00:00', '2023-03-13 14:30:00', 'Delivered'),
(2, 2, 'Plot 12, Ring Road, Benz Circle', 'Vijayawada', 'Andhra Pradesh', '520010', '2023-03-16 10:00:00', '2023-03-18 16:00:00', 'Delivered'),
(3, 3, 'House 5-9/1, Beach Road', 'Visakhapatnam', 'Andhra Pradesh', '530002', '2023-04-03 11:00:00', '2023-04-06 12:15:00', 'Delivered'),
(4, 4, '24 Anna Salai, T Nagar', 'Chennai', 'Tamil Nadu', '600017', '2023-04-19 09:30:00', '2023-04-21 17:00:00', 'Delivered'),
(5, 5, '78 Koramangala 4th Block', 'Bangalore', 'Karnataka', '560034', '2023-05-06 14:00:00', '2023-05-08 11:45:00', 'Delivered'),
(6, 6, '502 Sea View Apt, Bandra West', 'Mumbai', 'Maharashtra', '400050', '2023-05-21 10:30:00', '2023-05-24 15:30:00', 'Delivered'),
(7, 7, 'B-14 Hauz Khas Enclave', 'Delhi', 'Delhi', '110016', '2023-06-12 12:00:00', '2023-06-15 13:00:00', 'Delivered'),
(8, 8, '18 Park Street, 2nd Floor', 'Kolkata', 'West Bengal', '700016', '2023-06-30 08:30:00', '2023-07-03 16:45:00', 'Delivered'),
(9, 9, 'Flat 402, Green Meadows, Madhapur', 'Hyderabad', 'Telangana', '500081', '2023-07-15 10:00:00', '2023-07-17 14:00:00', 'Delivered'),
(10, 10, '203 Shivaji Nagar, FC Road', 'Pune', 'Maharashtra', '411005', '2023-08-02 11:30:00', '2023-08-05 18:00:00', 'Delivered'),
(11, 11, '14 Jubilee Hills, Road No 36', 'Hyderabad', 'Telangana', '500033', '2023-08-20 09:00:00', '2023-08-22 13:30:00', 'Delivered'),
(12, 12, 'Plot 12, Ring Road, Benz Circle', 'Vijayawada', 'Andhra Pradesh', '520010', '2023-09-06 13:00:00', '2023-09-08 17:15:00', 'Delivered'),
(13, 13, '32 MG Road, Panampilly Nagar', 'Kochi', 'Kerala', '682036', '2023-09-23 10:15:00', '2023-09-26 15:00:00', 'Delivered'),
(14, 14, '88 C-Scheme, Ashok Nagar', 'Jaipur', 'Rajasthan', '302001', '2023-10-11 11:45:00', '2023-10-14 16:30:00', 'Delivered'),
(15, 15, 'House 5-9/1, Beach Road', 'Visakhapatnam', 'Andhra Pradesh', '530002', '2023-11-05 10:00:00', '2023-11-07 14:00:00', 'Delivered'),
(16, 16, '45 Gomti Nagar, Vibhuti Khand', 'Lucknow', 'Uttar Pradesh', '226010', '2023-11-21 09:30:00', '2023-11-24 16:00:00', 'Delivered'),
(17, 17, '10 Gandhinagar, Eluru Road', 'Vijayawada', 'Andhra Pradesh', '520003', '2023-12-09 14:00:00', '2023-12-11 12:30:00', 'Delivered'),
(18, 18, '78 Koramangala 4th Block', 'Bangalore', 'Karnataka', '560034', '2023-12-26 10:00:00', '2023-12-28 17:00:00', 'Delivered'),
(19, 19, 'Flat 402, Green Meadows, Madhapur', 'Hyderabad', 'Telangana', '500081', '2024-01-13 11:00:00', '2024-01-15 15:30:00', 'Delivered'),
(20, 20, '502 Sea View Apt, Bandra West', 'Mumbai', 'Maharashtra', '400050', '2024-01-29 09:45:00', '2024-02-01 14:20:00', 'Delivered'),
(21, 21, '15 Indiranagar 100ft Road', 'Bangalore', 'Karnataka', '560038', '2024-02-11 13:00:00', '2024-02-13 18:00:00', 'Delivered'),
(22, 22, 'B-14 Hauz Khas Enclave', 'Delhi', 'Delhi', '110016', '2024-02-23 10:30:00', '2024-02-25 16:45:00', 'Delivered'),
(23, 23, '67 Siripuram Junction', 'Visakhapatnam', 'Andhra Pradesh', '530003', '2024-03-06 12:00:00', '2024-03-09 13:15:00', 'Delivered'),
(24, 24, '24 Anna Salai, T Nagar', 'Chennai', 'Tamil Nadu', '600017', '2024-03-19 14:30:00', '2024-03-21 16:00:00', 'Delivered'),
(25, 25, 'Plot 12, Ring Road, Benz Circle', 'Vijayawada', 'Andhra Pradesh', '520010', '2024-03-26 10:00:00', NULL, 'In Transit');

-- ----------------------------------------------------------------------------
-- 8. Insert Reviews (20 Records)
-- ----------------------------------------------------------------------------
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_text, review_date) VALUES
(1, 1, 1, 5, 'Superb sound quality and top-notch noise cancellation. Worth every rupee!', '2023-03-15 14:00:00'),
(2, 2, 2, 5, 'Great battery backup, seamless pairing, and crisp audio output.', '2023-03-20 18:30:00'),
(3, 5, 3, 5, 'Premium titanium finish and unmatched camera zoom performance.', '2023-04-10 11:20:00'),
(4, 14, 4, 4, 'Comfortable fit and durable denim material. Fits true to size.', '2023-04-25 16:10:00'),
(5, 9, 5, 5, 'Incredible battery life and smooth display. Perfect lightweight workstation.', '2023-05-12 10:00:00'),
(6, 10, 6, 4, 'Stunning 4K screen, though fans can get a bit loud during heavy workloads.', '2023-05-28 17:45:00'),
(7, 22, 7, 5, 'Must-read book for anyone preparing for DBMS and backend engineering.', '2023-06-18 12:15:00'),
(8, 23, 7, 5, 'Life-changing book with simple, highly actionable habits.', '2023-06-20 15:30:00'),
(9, 4, 1, 5, 'The best ergonomic mouse for productivity. Dual scroll wheel is amazing.', '2023-07-20 14:40:00'),
(10, 18, 9, 4, 'Healthy frying with minimal oil. Great for quick evening snacks.', '2023-08-08 19:10:00'),
(11, 6, 10, 5, 'Outstanding display clarity and AI camera features. S-Pen is very handy.', '2023-08-25 13:00:00'),
(12, 19, 11, 5, 'Very silent operation and effective wash cycles. Clean wash every time.', '2023-10-01 16:20:00'),
(13, 16, 12, 4, 'Iconic sneaker design. Looks fantastic with casual jeans.', '2023-10-18 11:35:00'),
(14, 25, 3, 5, 'Visibly reduced acne marks and dark spots within three weeks.', '2023-11-12 09:50:00'),
(15, 20, 13, 4, 'Even cooling across all shelves and very energy efficient.', '2023-11-28 14:15:00'),
(16, 28, 14, 5, 'Lightweight frame with tremendous smash power. Great balance.', '2023-12-15 17:00:00'),
(17, 33, 5, 5, 'Fresh, crunchy almonds with great taste. Nicely sealed packaging.', '2024-01-02 12:40:00'),
(18, 7, 1, 5, 'Blazing fast 100W charging and crisp 120Hz LTPO display.', '2024-01-18 15:20:00'),
(19, 31, 6, 4, 'Provides solid back support for long remote work hours.', '2024-02-05 18:30:00'),
(20, 29, 15, 5, 'Heavy-duty steel plates and sturdy spin collars. Perfect home gym set.', '2024-02-18 10:15:00');
