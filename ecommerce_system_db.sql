CREATE DATABASE ECOM; -- creating database
USE ECOM;	-- using the database

-- creating tables
-- customers

CREATE TABLE CUSTOMERS(
CUST_ID VARCHAR(255),
FIRST_NAME VARCHAR(250),
LAST_NAME VARCHAR(255),
EMAIL VARCHAR(250),
GENDER ENUM("Male","Female","Others"),
PHONE VARCHAR(10),
ANNUAL_INCOME DECIMAL(10,2));

SELECT * 
FROM CUSTOMERS;

DESCRIBE CUSTOMERS;

-- PRODUCT TABLE

CREATE TABLE PRODUCTS(
PROD_ID INT PRIMARY KEY,
PROD_NAME VARCHAR(255) UNIQUE,
UNIT_PRICE DECIMAL(10,2),
CATEGORY VARCHAR(200));

ALTER TABLE CUSTOMERS
MODIFY COLUMN  CUST_ID VARCHAR(255) PRIMARY KEY;

DESCRIBE CUSTOMERS;

-- SALES TABLE

CREATE TABLE SALES(
QUANTITY INT,
SALES DECIMAL(9,2),
CUST_ID VARCHAR(200),
PROD_ID INT,
DISCOUNT DECIMAL(3,2),
LOCATION CHAR(50),
ORDER_DATE DATE,
DELIVERY_DATE DATE,
PROFIT DECIMAL(9,2));

ALTER TABLE SALES
ADD CONSTRAINT FOREIGN KEY (CUST_ID) REFERENCES CUSTOMERS(CUST_ID),
ADD CONSTRAINT FOREIGN KEY (PROD_ID) REFERENCES PRODUCTS(PROD_ID);

DESCRIBE SALES;

-- INSERTING DATA ON CUSTOMERS

INSERT INTO CUSTOMERS(CUST_ID,FIRST_NAME,LAST_NAME,EMAIL,GENDER,PHONE,ANNUAL_INCOME)
VALUES
("CUST-101","Veena","Kutty","veena.kutty@gmail.com","Female","1234567890",55000);

INSERT INTO CUSTOMERS VALUES
("CUST-102","Alex",NULL,"alex@gmail.com","Male","0987654321",50000),
("CUST-103","Alice","George",NULL,"Female","9088989765",75000),
("CUST-104","Ram","Patel","ram.patel@gmail.com","Male",NULL,60000),
("CUST-105","Hitesh","Hirwani","hitesh.hirwani@gmail.com","Male","656563473",65000);

SELECT *
FROM CUSTOMERS;

SELECT FIRST_NAME,GENDER
FROM CUSTOMERS;

-- Modify Tables

ALTER TABLE SALES
ADD COLUMN SALE_ID INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE CUSTOMERS
MODIFY COLUMN FIRST_NAME VARCHAR(255) NOT NULL;

ALTER TABLE PRODUCTS
MODIFY COLUMN PROD_NAME VARCHAR(255) NOT NULL,
MODIFY COLUMN UNIT_PRICE DECIMAL(10,2) NOT NULL;

ALTER TABLE PRODUCTS
ADD CONSTRAINT CHECK (UNIT_PRICE > 0);

ALTER TABLE SALES
ADD CONSTRAINT CHECK (QUANTITY > 0);

ALTER TABLE SALES
ADD CONSTRAINT CHECK (DISCOUNT BETWEEN 0 AND 1);

CREATE TABLE PAYMENTS(
PAYMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
ORDER_ID INT NOT NULL,
PAYMENT_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
PAYMENT_METHOD ENUM ('UPI','Card','Net Banking','COD'),
PAYMENT_AMOUNT DECIMAL(10,2) NOT NULL,
PAYMENT_STATUS ENUM ('Pending','Completed','Failed','Refunded') DEFAULT 'Pending');

CREATE TABLE ORDERS(
ORDER_ID INT AUTO_INCREMENT PRIMARY KEY,
CUST_ID VARCHAR(255),
ORDER_STATUS ENUM ('Pending','Shipped','Delivered','Cancelled','Confirmed','On The Way') DEFAULT 'Pending',
SHIPPING_ADDRESS VARCHAR(255),
FOREIGN KEY (CUST_ID) REFERENCES CUSTOMERS(CUST_ID));

ALTER TABLE PAYMENTS
ADD CONSTRAINT
FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID);

-- Insert data

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO PRODUCTS VALUES
(1001,"Men's T-Shirt",400,"Clothing"),
(1002,"Shoes",1500,"Foot-Wear"),
(1003,"Apple Watch",68000,"Electronics"),
(1004,"Table",15000,"Furniture"),
(1005,"Heels",400,"Foot-Wear"),
(1006,"Samsung S26 Ultra",135000,"Electronics");

INSERT INTO ORDERS VALUE
(1101,'CUST-103','Pending','Mumbai');

INSERT INTO ORDERS(CUST_ID,ORDER_STATUS,SHIPPING_ADDRESS) VALUES
('CUST-104','Delivered','Pune'),
('CUST-101','On The Way','Delhi'),
('CUST-102','Confirmed','Nagpur'),
('CUST-101','Cancelled','Nashik'),
('CUST-105','Shipped','Gurgaon'),
('CUST-101','Delivered','Haryana'),
('CUST-104','Cancelled','Pune'),
('CUST-102','On The Way','Nagpur'),
('CUST-102','Shipped','Mumbai');

-- Connect SALES with ORDERS
ALTER TABLE SALES
ADD COLUMN ORDER_ID INT;

ALTER TABLE SALES
ADD CONSTRAINT
FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID);

-- Inserting more data

INSERT INTO CUSTOMERS
(CUST_ID, FIRST_NAME, LAST_NAME, EMAIL, GENDER, PHONE, ANNUAL_INCOME)
VALUES
('CUST-106', 'Priya', 'Sharma', 'priya.sharma@gmail.com', 'Female', '9876543210', 85000),
('CUST-107', 'Rahul', 'Verma', 'rahul.verma@gmail.com', 'Male', '9876501234', 72000),
('CUST-108', 'Sneha', 'Patil', 'sneha.patil@gmail.com', 'Female', '9876512345', 92000),
('CUST-109', 'Amit', 'Joshi', 'amit.joshi@gmail.com', 'Male', '9876523456', 48000),
('CUST-110', 'Neha', 'Shah', 'neha.shah@gmail.com', 'Female', '9876534567', 110000),
('CUST-111', 'Karan', 'Mehta', 'karan.mehta@gmail.com', 'Male', '9876545678', 68000),
('CUST-112', 'Pooja', 'Desai', 'pooja.desai@gmail.com', 'Female', '9876556789', 78000),
('CUST-113', 'Arjun', 'Nair', 'arjun.nair@gmail.com', 'Male', '9876567890', 95000),
('CUST-114', 'Riya', 'Kapoor', 'riya.kapoor@gmail.com', 'Female', '9876578901', 58000),
('CUST-115', 'Mohit', 'Singh', 'mohit.singh@gmail.com', 'Male', '9876589012', 88000);

INSERT INTO PRODUCTS
(PROD_ID, PROD_NAME, UNIT_PRICE, CATEGORY)
VALUES
(1007, 'Laptop', 75000, 'Electronics'),
(1008, 'Keyboard', 1200, 'Electronics'),
(1009, 'Mouse', 650, 'Electronics'),
(1010, 'Office Chair', 8500, 'Furniture'),
(1011, 'Jeans', 1800, 'Clothing'),
(1012, 'Jacket', 3200, 'Clothing'),
(1013, 'Running Shoes', 2800, 'Foot-Wear'),
(1014, 'Dining Table', 22000, 'Furniture'),
(1015, 'Headphones', 2500, 'Electronics'),
(1016, 'Backpack', 1600, 'Accessories');

INSERT INTO ORDERS
(CUST_ID, ORDER_STATUS, SHIPPING_ADDRESS)
VALUES
('CUST-106', 'Delivered', 'Mumbai'),
('CUST-107', 'Shipped', 'Pune'),
('CUST-108', 'Confirmed', 'Thane'),
('CUST-109', 'Pending', 'Nashik'),
('CUST-110', 'Delivered', 'Delhi'),
('CUST-111', 'Cancelled', 'Nagpur'),
('CUST-112', 'On The Way', 'Mumbai'),
('CUST-113', 'Shipped', 'Bengaluru'),
('CUST-114', 'Delivered', 'Pune'),
('CUST-115', 'Confirmed', 'Hyderabad');

set foreign_key_checks = 0;

INSERT INTO PAYMENTS
(ORDER_ID, PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_AMOUNT, PAYMENT_STATUS)
VALUES
(1101, '2026-09-01 10:30:00', 'UPI', 1500.00, 'Pending'),
(1102, '2026-09-02 11:15:00', 'Card', 8500.00, 'Completed'),
(1103, '2026-09-03 12:00:00', 'UPI', 3200.00, 'Completed'),
(1104, '2026-09-04 14:20:00', 'Net Banking', 75000.00, 'Completed'),
(1105, '2026-09-05 15:10:00', 'Card', 400.00, 'Refunded'),
(1106, '2026-09-06 09:45:00', 'COD', 2800.00, 'Pending'),
(1107, '2026-09-07 16:00:00', 'UPI', 2500.00, 'Completed'),
(1108, '2026-09-08 17:30:00', 'Card', 22000.00, 'Completed'),
(1109, '2026-09-09 13:10:00', 'UPI', 1600.00, 'Failed'),
(1110, '2026-09-10 18:15:00', 'Net Banking', 135000.00, 'Completed'),
(1111, '2026-09-11 10:00:00', 'UPI', 4000.00, 'Completed'),
(1112, '2026-09-12 11:30:00', 'Card', 75000.00, 'Completed'),
(1113, '2026-09-13 12:45:00', 'COD', 3200.00, 'Pending'),
(1114, '2026-09-14 14:00:00', 'UPI', 1800.00, 'Completed'),
(1115, '2026-09-15 15:20:00', 'Card', 2500.00, 'Refunded'),
(1116, '2026-09-16 16:30:00', 'Net Banking', 8500.00, 'Completed'),
(1117, '2026-09-17 09:20:00', 'UPI', 1200.00, 'Failed'),
(1118, '2026-09-18 10:40:00', 'Card', 2800.00, 'Completed'),
(1119, '2026-09-19 13:50:00', 'COD', 1600.00, 'Pending'),
(1120, '2026-09-20 17:00:00', 'UPI', 2500.00, 'Completed');

INSERT INTO SALES
(QUANTITY, SALES, CUST_ID, PROD_ID, DISCOUNT,
 LOCATION, ORDER_DATE, DELIVERY_DATE, PROFIT, ORDER_ID)
VALUES
(2, 800.00, 'CUST-103', 1001, 0.00, 'Mumbai', '2026-09-01', '2026-09-04', 160.00, 1101),
(1, 1500.00, 'CUST-104', 1002, 0.00, 'Pune', '2026-09-02', '2026-09-05', 300.00, 1102),
(1, 3200.00, 'CUST-101', 1012, 0.00, 'Delhi', '2026-09-03', '2026-09-06', 640.00, 1103),
(1, 75000.00, 'CUST-102', 1007, 0.00, 'Nagpur', '2026-09-04', '2026-09-08', 7500.00, 1104),
(1, 400.00, 'CUST-101', 1005, 0.00, 'Nashik', '2026-09-05', NULL, 80.00, 1105),
(1, 2800.00, 'CUST-105', 1013, 0.00, 'Gurgaon', '2026-09-06', NULL, 560.00, 1106),
(1, 2500.00, 'CUST-101', 1015, 0.00, 'Haryana', '2026-09-07', '2026-09-10', 500.00, 1107),
(1, 22000.00, 'CUST-104', 1014, 0.00, 'Pune', '2026-09-08', NULL, 4400.00, 1108),
(1, 1600.00, 'CUST-102', 1016, 0.00, 'Nagpur', '2026-09-09', NULL, 320.00, 1109),
(1, 135000.00, 'CUST-102', 1006, 0.00, 'Mumbai', '2026-09-10', '2026-09-13', 13500.00, 1110),
(2, 800.00, 'CUST-106', 1001, 0.00, 'Mumbai', '2026-09-11', '2026-09-14', 160.00, 1111),
(1, 75000.00, 'CUST-107', 1007, 0.00, 'Pune', '2026-09-12', NULL, 7500.00, 1112),
(1, 3200.00, 'CUST-108', 1012, 0.00, 'Thane', '2026-09-13', NULL, 640.00, 1113),
(1, 1800.00, 'CUST-109', 1011, 0.00, 'Nashik', '2026-09-14', NULL, 360.00, 1114),
(1, 2500.00, 'CUST-110', 1015, 0.00, 'Delhi', '2026-09-15', '2026-09-18', 500.00, 1115),
(1, 8500.00, 'CUST-111', 1010, 0.00, 'Nagpur', '2026-09-16', NULL, 1700.00, 1116),
(1, 1200.00, 'CUST-112', 1008, 0.00, 'Mumbai', '2026-09-17', NULL, 240.00, 1117),
(1, 2800.00, 'CUST-113', 1013, 0.00, 'Bengaluru', '2026-09-18', NULL, 560.00, 1118),
(1, 1600.00, 'CUST-114', 1016, 0.00, 'Pune', '2026-09-19', '2026-09-22', 320.00, 1119),
(1, 2500.00, 'CUST-115', 1015, 0.00, 'Hyderabad', '2026-09-20', NULL, 500.00, 1120);

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM PAYMENTS;
SELECT * FROM PRODUCTS;
SELECT * FROM SALES;

-- Gender-Wise Analysis

SELECT GENDER,COUNT(*) AS TOTAL_CUSTOMERS
FROM CUSTOMERS
GROUP BY GENDER;

-- Total Profit

SELECT SUM(PROFIT) AS TOTAL_PROFIT
FROM SALES;

-- Sorting Customers 

SELECT * 
FROM CUSTOMERS
ORDER BY ANNUAL_INCOME DESC;

-- Average Annual Income

SELECT ROUND(AVG(ANNUAL_INCOME),2) AS AVG_INCOME
FROM CUSTOMERS;

-- CUSTOMERS WITH ABOVE AVERAGE ANNUAL INCOME

SELECT *
FROM CUSTOMERS
WHERE ANNUAL_INCOME > 73266.67;

-- Customers Who doesnt have emails

SELECT *
FROM CUSTOMERS
WHERE EMAIL IS NULL;

-- -- Customers Who have emails

SELECT *
FROM CUSTOMERS
WHERE EMAIL IS NOT NULL;

-- TOTAL CUSTOMERS BY REGION

SELECT SHIPPING_ADDRESS, COUNT(CUST_ID) AS TOTAL_CUSTOMERS
FROM ORDERS
GROUP BY SHIPPING_ADDRESS;

SELECT * FROM ORDERS;

SELECT * 
FROM ORDERS
WHERE ORDER_STATUS = 'Pending' OR ORDER_STATUS = 'On The Way';

SELECT * 
FROM ORDERS
WHERE ORDER_STATUS IN('Pending','On The Way');

-- business analysis

-- 1. Display all customer details.

select * from customers;

-- 2. Find the total number of customers registered in the database.

select count(*) as Total_customers from customers;

-- 3. Find customers whose annual income is greater than ₹75,000.

select * from customers where annual_income > 75000;

-- 4. Display customers whose first name starts with the letter 'A'.

select * from customers where first_name like 'A%';

-- 5. Find customers whose email address is missing.

select * from customers where email is null;

-- 6. Display all distinct product categories.

select distinct category from products;

-- 7. Find products with a unit price greater than ₹5,000.

select * from products where unit_price >5000;

-- 8. Display the five most expensive products.

select * from products order by unit_price desc limit 5;

-- 9. Find all orders with the status 'Delivered'.

select * from orders where order_status = "Delivered";

-- 10. Display all payments with the status 'Failed'.

select * from payments where payment_status = 'Failed';

-- 11. Find sales records where the delivery date is `NULL`.

select * from sales where delivery_date is null;

-- 12. Display all orders placed for customers from Mumbai.

select * from orders where shipping_address = 'Mumbai';

-- 13\. Calculate the total revenue generated by the business.

select sum(quantity*sales) as Total_Revenue from sales;

-- 14\. Calculate the total profit generated by the business.

select sum(profit) as Total_Profit from sales;

-- 15\. Find the average sales amount per sales transaction.

select round(avg(sales),2) as Average_sales from sales;

-- 16\. Calculate the total quantity of products sold.

select sum(quantity) as Total_quantity from sales;

-- 17\. Find the highest and lowest sales amounts.

select max(sales) as Highest_Sales_Amount,
min(sales) as Lowest_Sales_Amount
from sales;

-- 18\. Calculate total revenue generated by each product.

select prod_id, sum(quantity*sales) as Total_Revenue from sales
group by prod_id;

-- 19\. Find total sales generated by each product category.

select p.category,sum(s.sales) as Total_Sales
from Products as p
Join Sales as s
on p.prod_id = s.prod_id
group by p.category;

-- 20\. Identify the product category generating the highest revenue.

select p.category,sum(s.quantity*s.sales) as Total_Revenue
from Products as p
join Sales as s
on p.prod_id = s.prod_id
group by p.category
order by Total_Revenue desc limit 1;

-- 21\. Find total revenue generated by each location.

select o.shipping_address, sum(s.quantity*s.sales) as Total_Revenue
from Orders as o
join Sales as s
on o.order_id = s.order_id
group by o.shipping_address;

-- 22\. Calculate total profit generated by each location.

select o.shipping_address, sum(s.profit) as Total_Profit
from Orders as o
join Sales as s
on o.order_id = s.order_id
group by o.shipping_address;

-- 23\. Find the number of orders in each order status.

select Order_Status, count(*) as Total_Orders
from Orders
group by order_status;

-- 24\. Find the average annual income of customers.

select round(avg(annual_income),2) as Average_Income
from customers;

-- 25\. Identify products that have generated total sales greater than ₹10,000.

select p.prod_name,sum(s.sales) as Total_Sales
from Products p
join Sales s
on p.prod_id = s.prod_id
group by p.prod_name
having Total_Sales > 10000;