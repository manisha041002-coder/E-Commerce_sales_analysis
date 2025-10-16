-- 1️⃣ Create Database
CREATE DATABASE ecommerce_project;
USE ecommerce_project;

-- 2️⃣ Create Tables

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    prime_member BOOLEAN
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    payment_mode VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3️⃣ Insert Sample Data

-- Customers
INSERT INTO customers VALUES
(1, 'Ravi', 'Chennai', TRUE),
(2, 'Priya', 'Bangalore', FALSE),
(3, 'Ankit', 'Hyderabad', TRUE);

-- Products
INSERT INTO products VALUES
(101, 'Mobile', 15000, 100),
(102, 'Laptop', 55000, 50),
(103, 'Headphones', 2000, 200),
(104, 'Smartwatch', 5000, 150);

-- Orders
INSERT INTO orders VALUES
(1001, 1, '2025-09-01', 'UPI'),
(1002, 2, '2025-09-05', 'COD'),
(1003, 1, '2025-09-10', 'Credit Card'),
(1004, 3, '2025-09-12', 'UPI');

-- Order Items
INSERT INTO order_items VALUES
(1, 1001, 101, 1, 15000),
(2, 1001, 103, 2, 4000),
(3, 1002, 102, 1, 55000),
(4, 1003, 103, 1, 2000),
(5, 1004, 104, 1, 5000),
(6, 1004, 103, 1, 2000);

-- 4️⃣ Example Queries (Analytics)

-- Top-selling products
SELECT p.category, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sold DESC;

-- Monthly sales trend
SELECT MONTH(o.order_date) AS month, SUM(oi.price) AS total_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY MONTH(o.order_date);

-- Prime vs Non-Prime sales
SELECT c.prime_member, SUM(oi.price) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.prime_member;

-- Customers with highest spending
SELECT c.name, SUM(oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Products low in stock (less than 50)
SELECT * FROM products
WHERE stock < 50;