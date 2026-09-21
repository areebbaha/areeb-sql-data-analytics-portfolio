/*
MySQL Practice Task — Food Delivery Analysis
SELECT • WHERE • Comparison • Arithmetic • Logical Operators
You are working as a Data Analyst for a food delivery company.
The company has given you an orders table containing information about customers, restaurants, orders, and deliveries.
Your task is to use SQL to answer real-world business questions.
*/

CREATE DATABASE IF NOT EXISTS foods_delivery_db;
USE foods_delivery_db;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    restaurant VARCHAR(100) NOT NULL,
    food_category VARCHAR(50) NOT NULL,
    order_value DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(10,2) NOT NULL,
    distance_km DECIMAL(5,2) NOT NULL,
    customer_age INT NOT NULL,
    delivery_time_min INT NOT NULL,
    restaurant_rating DECIMAL(2,1) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    order_status VARCHAR(30) NOT NULL
);

-- part A  — SELECT Basics

-- Q1 - Display all records from the orders table.
select * from orders;

-- Q2 - Display only the customer name, city, and restaurant.
select customer_name,city,restaurant from orders;

-- Q3 - Display the restaurant, food category, and order value.
select restaurant,food_category,order_value from orders;

-- Q4  - Display customer name, order value, and delivery fee.
select customer_name,order_value,delivery_fee from orders;

-- part B — WHERE & Comparison Operators

-- Q5 - Find all orders placed from Hyderabad.
select * from orders where city='hyderabad';

-- Q6 - Find all orders where the order value is greater than ₹500.
select * from orders where order_value>500;

-- Q7 - Find all orders where the delivery distance is less than 5 km.
select * from orders where distance_km <3;

-- Q8 - Find all orders where the customer age is greater than or equal to 25.
select * from orders where customer_age >=25;

-- Q9 - Find all orders where the restaurant rating is less than 4.0.
select * from orders where restaurant_rating<4;

-- Q10 - Find all orders where the order status is 'Delivered'.
select * from orders where order_status='delivered';

-- Q11 - Find all orders where the order value is exactly ₹300.
select * from orders where order_value=300;

-- Q12 - Find all orders where the order value is not ₹300.
select * from orders where order_value!=300;

-- part C — Arithmetic Operators

-- Q13 - Display the customer name and the total amount paid. Total Amount = order_value + delivery_fee
select customer_name,(order_value+delivery_fee) as total_amount ,order_value ,delivery_fee from orders; 

-- Q14 - Display the restaurant and the order value after applying a 10% discount.
select restaurant,order_value,(order_value*0.9) as after_discount from orders;

-- Q15 - Display the customer name and the order value after adding a ₹50 service charge.
select customer_name,(order_value+50) as total_amount ,order_value from orders; 

-- Q16 - Display the customer name and the delivery cost per kilometre. Delivery Fee ÷ Distance
 
select customer_name,(delivery_fee/distance_km) as delivery_cost_per_kilometre,distance_km ,delivery_fee from orders; 

-- Q17 - Display the customer name and order value after a ₹100 discount.

select customer_name,(order_value-100) as amount_after_discount ,order_value from orders; 

-- Part D — Logical Operators
-- Now combine multiple conditions using AND, OR and NOT.

-- Q18 - Find orders where the order value is greater than ₹500 AND the delivery distance is less than 5 km.
select * from orders where order_value>500 and distance_km<5 ;

-- Q19 - Find orders where the customer is older than 25 AND the order value is greater than ₹400 AND the restaurant rating is greater than 4.0.
 select * from orders where customer_age>25 and order_value>400 and restaurant_rating>4;
 
-- Q20 - Find orders where the order value is greater than ₹800 OR the delivery fee is greater than ₹50.
select * from orders where order_value>800 or delivery_fee>50;
 
-- Q21 - Find orders from Hyderabad OR Bengaluru OR Chennai.
select * from orders where city='hyderabad' OR city = 'banglore' OR city = 'chennai';

-- Q22 - Find orders where the delivery time is greater than 40 minutes AND the restaurant rating is less than 4.0.
select * from orders where delivery_time_min>40 and restaurant_rating<4;

-- Q23 - Find orders where the order value is less than ₹300 OR the delivery distance is greater than 8 km OR the delivery fee is greater than ₹60.
select * from orders where order_value<300 or distance_km>8 or delivery_fee >60;

-- Q24 - Find orders where the customer is younger than 25 AND the order status is 'Delivered' AND the order value is greater than ₹500.
select * from orders where customer_age<25 and order_status='delivered' and order_value>500 ; 

-- Q25 - Find orders where the food category is 'Biryani' OR 'Pizza', and the order value is greater than ₹400.
select * from orders where food_category='biryani' or food_category ='pizza' and order_value>400;

-- Q26 - Find orders that are NOT from Hyderabad and have a restaurant rating greater than 4.0.
select * from orders where not city='hyderabad'  and restaurant_rating>4; 

-- Q27 - Find orders where the customer age is greater than 25 AND either the order value is greater than ₹700 OR the restaurant rating is greater than 4.5.
select * from orders where customer_age>25  and order_value>700 and restaurant_rating>4.5; 

 /*
Q28 - Find orders where: City is Hyderabad
AND order value is greater than ₹500
AND delivery time is less than 40 minutes
AND restaurant rating is greater than 4.0
*/
select * from orders where city='hyderabad' and order_value>500 and delivery_time_min<40 and restaurant_rating>4; 

-- Q29 - Challenge
/*Find orders where:
Order value is greater than ₹500
AND delivery distance is less than 6 km
AND either:
restaurant rating is greater than 4.5
OR delivery time is less than 30 minutes
*/
select * from orders where order_value>500 and distance_km<6 and (restaurant_rating>4.5 or delivery_time_min<30);

-- Q30 - Final Challenge
/*Find orders where:
Customer age is greater than 25
AND city is Hyderabad OR Bengaluru
AND order value is greater than ₹500
AND delivery time is less than 45 minutes
*/
select * from orders where customer_age>25 and (city='hyderabad' or city='bengaluru') and order_value>500 and delivery_time_min<45;
