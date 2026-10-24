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

-- 26\. Find customers whose total sales exceed ₹5,000.

select c.first_name,c.last_name,sum(s.sales) as Total_Sales
from customers c
left join sales s
on c.cust_id = s.cust_id
group by c.first_name, c.last_name
having Total_sales > 5000;

select concat(coalesce(c.first_name,""),' ',coalesce(c.last_name,"")) as Full_Name,
sum(s.sales) as Total_Sales
from customers c
left join sales s
on c.cust_id = s.cust_id
group by Full_Name
having Total_sales > 5000;

-- 27\. Identify locations where total revenue exceeds ₹10,000.

select o.shipping_address, sum(s.sales*s.quantity) as Total_Revenue
from orders as o
join sales as s
on o.order_id = s.order_id
group by o.shipping_address
having Total_Revenue > 10000;

--  Display each customer's full name and annual income.

select concat(coalesce(first_name,""),' ',coalesce(last_name," ")) as Full_Name,
annual_income
from customers;

-- 29\. Find customers who have placed more than one order.

select cust_id, count(*) as Total_Orders
from Orders
group by cust_id
having total_orders > 1;

-- 30\. Identify customers who have never placed an order.

select * from customers
where cust_id not in (select distinct cust_id from orders);


-- 31\. Find customers who have made purchases worth more than ₹10,000 in total.

select cust_id , sum(sales) as Total_sales
from sales
group by cust_id
having total_sales > 10000;

-- 32\. Identify the customer who generated the highest total revenue.

select cust_id, sum(sales*quantity) as Total_Revenue
from sales
group by cust_id
order by Total_Revenue desc limit 1;

select * from customers
where cust_id = (select cust_id
from sales
group by cust_id
order by sum(sales*quantity) desc limit 1);

-- 33\. Find the number of orders placed by each customer.

select cust_id, count(*) as Total_Orders
from Orders
group by Cust_ID;

-- 34\. Calculate the average order value for each customer.

select cust_id, avg(sales) as Average_Order_Value
from Sales
group by cust_id;

-- 35\. Identify customers who have cancelled orders.

select Cust_id, order_status
from orders
where order_status = "Cancelled";

-- 36\. Find customers who have both delivered and cancelled orders.

select Cust_id, order_status
from orders
where order_status = "Cancelled" or order_status = "Delivered";

-- 37\. Identify customers who have not made any successful payments.
select Cust_id, payment_status
from payments
join orders
on payments.order_id = orders.order_id
where payment_status = "Pending";

-- Compare each product price with its average sales value per unit.

select prod_name,unit_price,category,avg(sales*quantity) as Average_sales_value_per_unit
from products as p
join sales as s
on p.prod_id = s.prod_id
group by prod_name;

-- Find products that have sales but generated zero or negative profit 

select prod_name,sales,profit
from products as p
join sales as s
on p.prod_id = s.prod_id
where profit <= 0;

-- Find the Total number of orders placed in September 2026

select 'September 2026 orders',count(order_id) as Total_orders
from sales 
where order_date between '2026-09-01' and '2026-09-30';

-- calculate the number of orders that have been delivered

select order_status, count(*) as Total_orders
from orders
where order_status = 'Delivered'
group by order_status;

-- calculate the number of orders that have been cancelled

select order_status, count(*) as Total_orders
from orders
where order_status = 'Cancelled'
group by order_status;

-- Find the average delivery time in days for delivered sales

select order_status, avg(delivery_date - order_date) as DID
from orders as o
join sales as s
on o.order_id = s.order_id
where order_status = 'Delivered'
group by order_status;

-- Identify sales recored with delivery time exceeding 3 days

select *, delivery_date - order_date as Delivery_in_days
from sales
having Delivery_in_days > 3;

-- Find the orders that have not yet been delivered

select * from orders
where order_status not in ('Delivered','Cancelled');

-- calculate the percentage of orders delivered successfully

select order_status, round((count(*)/20)*100,2) as Total_orders
from orders
where order_status = 'Delivered'
group by order_status;

-- Identify customers who have placed orders with different delivery locations

select c.cust_id, c.first_name,c.last_name,count(distinct shipping_address) as Total_locations
from customers as c
join orders as o
on c.cust_id = o.cust_id
group by c.cust_id
having Total_locations > 1;

-- Find the daily revenue generated by business

select order_date, sum(sales*quantity) as Total_Revenue
from sales
group by order_date;

-- identify the day with the highest sales

select order_date, sum(sales*quantity) as Total_Revenue
from sales
group by order_date
order by Total_Revenue desc limit 1;

-- Calculate the total payment amount received from completed payments

select payment_status,sum(payment_amount) as Total_Amount
from payments
where payment_status = 'Completed'
group by payment_status;

-- Find the total value of pending payments

select payment_status,sum(payment_amount) as Total_Amount
from payments
where payment_status = 'Pending'
group by payment_status;

-- calculate the total amount refunded

select payment_status,sum(payment_amount) as Total_Amount
from payments
where payment_status = 'Refunded'
group by payment_status;

-- find the number of payments made using each payment methods

select payment_method, count(*) as Total_Payments
from payments
group by payment_method;

-- identify the payment method generating the highest completed payment value

select payment_method, sum(payment_amount) as Total_Amount
from payments
where payment_Status = 'Completed'
group by payment_method
order by Total_Amount desc limit 1;

-- Find orders that donot have any payment records

select o.order_id,p.payment_id
from orders o
left join payments p
on o.order_id = p.order_id
where p.payment_id is null;

-- Identify orders that has payment status as failed

select o.order_id,p.payment_status
from orders o
left join payments p
on o.order_id = p.order_id
where payment_status = 'Failed';

-- compare total sales revenue with total completed payments

select (select sum(sales*quantity) from sales) as Total_Revenue, 
(select sum(payment_amount) as Total_Amount from Payments where
 payment_status = 'Completed') as Total_Completed_Payments;

-- calculate the success rate of payments
select count(*) as Total_Transactions,
sum(Case 
when payment_status = 'Completed' Then 1 Else 0 End) as Successful_Transctions,
round(100*sum(Case 
when payment_status = 'Completed' Then 1 Else 0 End)/nullif(count(*),0),2) as payment_success_Rate
from payments;

-- identify orders where the payment amount differs from the corresponding sales amount

Create View sales_by_orders as 
select order_id,sum(sales) as Total_sales
from sales
group by order_id;

create view payment_by_orders as
select order_id,sum(payment_amount) as Total_Amount
from payments
group by order_id;

select s.order_id,s.total_sales,p.total_amount
from sales_by_orders as s
join payment_by_orders as p
on s.order_id = p.order_id
where s.total_sales<>p.total_amount;

with sales_total as (select
order_id,sum(sales) as Total_Sales
from Sales
group by order_id),
payment_total as (select order_id,sum(payment_amount) as Total_amount
from payments
group by order_id)
select s.order_id,s.total_sales,p.total_amount from sales_total as s
join payment_total as p
on s.order_id = p.order_id
where s.total_sales <> p.total_amount;

-- rank customers based on total_revenue using Rank()

select c.cust_id,first_name,last_name,sum(sales*quantity) as total_revenue,
rank() over(order by sum(sales*quantity) desc) as Revenue_rank
from customers as c
join sales as s
on c.cust_id = s.cust_id
group by c.cust_id;

-- rank customers based on total sales using dense_rank()

select c.cust_id,first_name,last_name,sum(sales) as total_sales,
dense_rank() over(order by sum(sales) desc) as Sales_rank
from customers as c
join sales as s
on c.cust_id = s.cust_id
group by c.cust_id;

-- calculate cumulative daily revenue

select order_date , 
sum(sales*quantity)over(order by order_date) as cumulative_revenue
from sales;

-- calculate month to date sales revenue

select sum(sales) as MTD_Revenue
from sales
where order_date >= date_format(curdate(),'%Y-%m-01')
and order_date < curdate() + interval 1 day;

-- Find each product's percentage contribution to total revenue

create view Prod_revenue as 
select prod_name, sum(sales*quantity) as Total_Revenue
from sales as s
join products as p
on p.prod_id =s.prod_id
group by prod_name;

select prod_name,total_revenue,
round(total_revenue * 100/sum(total_revenue) over(),2) as Revenue_Percentage
from prod_revenue;

-- identify customers whose spending is above average

select * from customers
where cust_id in 
(select cust_id from sales where sales > 
(select avg(sales) from sales));

-- find the second highest revenue product
-- calculate the difference between daily revenue and the previous days revenue
-- identify the top performing product in each category
-- calculate the running total of profit ordered by sale date