CREATE DATABASE IF NOT EXISTS shopsphere_db;

USE shopsphere_db;

-- 1. ONLINE SALES

DROP TABLE IF EXISTS online_sales;

CREATE TABLE online_sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    product VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    amount DECIMAL(10,2),
    order_date VARCHAR(20),
    discount DECIMAL(5,2),
    status VARCHAR(20)
);


INSERT INTO online_sales
(sale_id, customer_name, email, city, product, category,
 quantity, amount, order_date, discount, status)
VALUES

(101, 'Rahul Sharma', 'rahul@gmail.com', 'Hyderabad',
 'Laptop', 'Electronics', 1, 65000, '15-08-2026', 10, 'Delivered'),

(102, 'Priya Reddy', 'priya@gmail.com', 'Bengaluru',
 'Headphones', 'Electronics', 2, 5000, '18-08-2026', 5, 'Delivered'),

(103, 'Arjun Kumar', 'arjun@gmail.com', 'Chennai',
 'Office Chair', 'Furniture', 1, 8500, '20-08-2026', 0, 'Pending'),

(104, 'Sneha Rao', 'sneha@gmail.com', 'Hyderabad',
 'Keyboard', 'Electronics', 3, 4500, '22-08-2026', 8, 'Delivered'),

(105, 'Vikram Singh', 'vikram@gmail.com', 'Mumbai',
 'Monitor', 'Electronics', 2, 30000, '25-08-2026', 12, 'Cancelled'),

(106, 'Ananya Das', 'ananya@gmail.com', 'Delhi',
 'Desk', 'Furniture', 1, 12000, '27-08-2026', 5, 'Delivered'),

(107, 'Kiran Reddy', 'kiran@gmail.com', 'Hyderabad',
 'Mouse', 'Electronics', 4, 3200, '29-08-2026', 0, 'Delivered'),

(108, 'Meera Nair', 'meera@gmail.com', 'Kochi',
 'Backpack', 'Accessories', 2, 4000, '30-08-2026', 15, 'Pending');



-- 2. STORE SALES


DROP TABLE IF EXISTS store_sales;

CREATE TABLE store_sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    product VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    amount DECIMAL(10,2),
    order_date VARCHAR(20),
    discount DECIMAL(5,2),
    status VARCHAR(20)
);


INSERT INTO store_sales
(sale_id, customer_name, email, city, product, category,
 quantity, amount, order_date, discount, status)
VALUES

(201, 'Rahul Sharma', 'rahul@gmail.com', 'Hyderabad',
 'Laptop Bag', 'Accessories', 1, 2500, '16-08-2026', 5, 'Delivered'),

(202, 'Pooja Mehta', 'pooja@gmail.com', 'Pune',
 'Keyboard', 'Electronics', 2, 3000, '19-08-2026', 10, 'Delivered'),

(203, 'Arjun Kumar', 'arjun@gmail.com', 'Chennai',
 'Desk', 'Furniture', 1, 11000, '21-08-2026', 5, 'Delivered'),

(204, 'Rohan Verma', 'rohan@gmail.com', 'Mumbai',
 'Monitor', 'Electronics', 1, 16000, '23-08-2026', 8, 'Pending'),

(205, 'Sneha Rao', 'sneha@gmail.com', 'Hyderabad',
 'Mouse', 'Electronics', 2, 1800, '24-08-2026', 0, 'Delivered'),

(206, 'Neha Kapoor', 'neha@gmail.com', 'Delhi',
 'Office Chair', 'Furniture', 2, 17000, '26-08-2026', 10, 'Delivered'),

(207, 'Kiran Reddy', 'kiran@gmail.com', 'Hyderabad',
 'Headphones', 'Electronics', 1, 2800, '28-08-2026', 5, 'Cancelled'),

(208, 'Amit Joshi', 'amit@gmail.com', 'Pune',
 'Backpack', 'Accessories', 3, 6000, '31-08-2026', 12, 'Delivered');
 
 
 show tables;
 select * from online_sales;
 select * from store_sales;
 
 -- Part A — UNION / UNION ALL

 -- Q1 -Display the customer names from both online_sales and store_sales without duplicate names.
 select customer_name from online_sales
 union
 select customer_name from store_sales;
 
 -- Q2 - Display all customer names from both tables, including duplicate names.
 select customer_name from online_sales
 union all
 select customer_name from store_sales;
 
 -- Q3 - Create a combined list of all products sold through both channels without duplicates.
 select product from online_sales
 union
 select product from store_sales;
 
 -- Q4 - Display the customer_name and city from both tables as one combined result, keeping duplicates.
 select customer_name,city from online_sales
 union all
 select customer_name,city from store_sales;
 
 -- Q5 - Display all customers who purchased from either the online store or physical store, but show each customer only once.
 select distinct customer_name from online_sales
 union
 select  distinct customer_name from store_sales;
 
 -- Part B — String Functions

 -- Q6 - Display every customer's name in uppercase.
 select upper(customer_name) from online_sales
 union
 select upper(customer_name) from store_sales;
 
 -- Q7 - Display every customer's email in lowercase.
 select customer_name,lower(email) from online_sales
 union 
 select customer_name,lower(email) from store_sales;
 
 -- Q8 - Display the length of each customer's name.
 select customer_name,length(customer_name) from online_sales
 union
 select customer_name,length(customer_name) from store_sales;
 
 -- Q9 - Display the customer name along with their city in the following format: Rahul Sharma - Hyderabad
 select concat_ws('-',customer_name,city)from online_sales
 union
 select concat_ws('-',customer_name,city) from store_sales;
 
 -- Q10 - Display customer name, city and category as one column separated by |. Example: Rahul Sharma | Hyderabad | Electronics
 select concat_ws('|',customer_name,city,category)from online_sales
 union
 select concat_ws('|',customer_name,city,category) from store_sales;
 
 -- Q11 - Display the first 3 characters of every customer's name.
 select substring(customer_name,1,3) from online_sales
 union
 select substring(customer_name,1,3) from store_sales;
 
 -- Q12 - Display the last 4 characters of every customer's email.
 select customer_name,right(email,4) from online_sales
 union
 select customer_name,right(email,4) from store_sales;
 
 -- Q13 - Display the first 5 characters of each product name.
 select product,left(product,5) from online_sales
 union
 select product,left(product,5) from online_sales;

 -- Q14 - Replace @gmail.com in customer emails with @shopsphere.com.
 select customer_name,replace(email,'@gmail.com','@shopshere.com') from online_sales
 union
 select customer_name,replace(email,'@gmail.com','@shopshere.com') from store_sales;
 
 -- Q15 - Display the customer's name after removing unnecessary spaces from the beginning and end.
 select trim(customer_name) from online_sales
 union
 select trim(customer_name) from store_sales;
 
--  Part C — Date & Time Functions

 -- Q16 - Convert the order_date column from text into an actual MySQL date.
 select str_to_date(order_date,'%d-%m-%Y')from online_sales
 union
 select str_to_date(order_date,'%d-%m-%Y') from store_sales;
 
 -- Q17 - Display each sale along with the year in which it occurred.
 select sale_id,product,year(str_to_date(order_date,'%d-%m-%Y')) from online_sales
 union
 select sale_id,product,year(str_to_date(order_date,'%d-%m-%Y')) from store_sales;
 
 -- Q18 - Display the month number for every sale.
 select sale_id,product,month(str_to_date(order_date,'%d-%m-%Y')) from online_sales
 union
 select sale_id,product,month(str_to_date(order_date,'%d-%m-%Y')) from store_sales;
 
 -- Q19 - Display the month name for every sale.
 select sale_id,product,monthname(str_to_date(order_date,'%d-%m-%Y')) from online_sales
 union
 select sale_id,product,monthname(str_to_date(order_date,'%d-%m-%Y')) from store_sales;
 
-- Q20 - Display the day name on which each order was placed.
 select sale_id,product,dayname(str_to_date(order_date,'%d-%m-%Y')) from online_sales
 union
 select sale_id,product,dayname(str_to_date(order_date,'%d-%m-%Y')) from store_sales;
 
 -- Q21 - Display the order date in this format: August 15, 2026
 select sale_id,product,order_date,date_format(str_to_date(order_date,'%d-%m-%Y'),'%M  %d,%Y') from online_sales
 union
 select sale_id,product,order_date,date_format(str_to_date(order_date,'%d-%m-%Y'),'%M  %d,%Y')from store_sales;	
 
 -- Q22 - Display the customer name and the month in which they placed the order.
 select customer_name,monthname(str_to_date(order_date,'%d-%m-%Y')) from online_sales
 union
 select customer_name,monthname(str_to_date(order_date,'%d-%m-%Y')) from store_sales;
 
 -- Q23 - Find the number of sales made in each month.
 select sale_id,product,quantity,monthname(str_to_date(order_date,'%d-%m-%Y')) from online_sales
 union
 select sale_id,product,quantity,monthname(str_to_date(order_date,'%d-%m-%Y')) from store_sales;
 
 -- Q24 - Display sales that happened during August 2026.
 select sale_id,product,date_format(str_to_date(order_date,'%d-%m-%Y'),'%M   %Y') from online_sales
 union
 select sale_id,product,date_format(str_to_date(order_date,'%d-%m-%Y'),'%M   %Y') from store_sales;
 
-- Part D — Conditional Functions

 -- Q25 - Classify each sale as: High Value if amount ≥ 15000 Regular otherwise
 select amount,sale_id,product,if(amount >= 15000,'high value','regular') from online_sales
 union
 select amount,sale_id,product,if (amount>= 15000,'high value','regular')from store_sales;
 
 -- Q26 - Display: Bulk if quantity >= 3 Normal otherwise
 select quantity,sale_id,product,if(quantity >= 3,'bulk','Normal') from online_sales
 union
 select quantity,sale_id,product,if (quantity >= 3,'bulk','Normal')from store_sales;
 
 -- Q27 - Calculate the final amount after applying the discount.
-- amount - discount amount Here discount represents a percentage.
 select product,amount,discount,amount-(amount*discount/100) as final_amount from online_sales
 union
 select  product,amount,discount,amount-(amount*discount/100) as final_amount from store_sales;
 
 -- Q28 - Display each sale with: Product Amount Discount Final amount
 select product,amount,discount,amount-(amount*discount/100) as final_amount from online_sales
 union
 select  product,amount,discount,amount-(amount*discount/100) as final_amount from store_sales;
 
--  Part E — Mathematical Functions

-- Q29 - Display the average amount per item for every sale.
 select quantity,product,amount,discount,amount/quantity as avg_amount from online_sales
 union
 select quantity,product,amount,discount,amount/quantity as avg_amount from store_sales;
 
 -- Q30 - Round the average amount per item to 2 decimal places.
 select quantity,product,amount,discount,round(amount/quantity,2) as avg_amount from online_sales
 union
 select quantity,product,amount,discount,round(amount/quantity,2)as avg_amount from store_sales;
 
 -- Q31 - Display whether the quantity of each sale is Even or Odd.
 select quantity,product,amount,discount,if (quantity%2=0,'even','odd') from online_sales
 union
 select quantity,product,amount,discount,if (quantity%2=0,'even','odd')from store_sales;
 
 -- Q32 - Display the square of the quantity purchased.
 select quantity,product,amount,discount, power(quantity,2) from online_sales
 union
 select quantity,product,amount,discount,power(quantity,2) from store_sales;
 
 -- Q33 - Find the absolute difference between the sale amount and ₹10,000.
 select quantity,product,amount, abs(amount-10000) from online_sales
 union
 select quantity,product,amount,abs(amount-10000) from store_sales;
 
 -- Q34 - Round each customer's final payable amount to the nearest whole number.
 select product,amount,discount,amount-(amount*discount/100) as final_amount,round(amount-(amount*discount/100)) from online_sales
 union
 select  product,amount,discount,amount-(amount*discount/100) as final_amount,round(amount-(amount*discount/100)) from store_sales;
 
--  Part F — MIX EVERYTHING

 -- Q35 - Combine online and store sales into one result and display: Customer_name,Product,City,Amount
 select customer_name,product,city,amount from online_sales
 union all
 select customer_name,product,city,amount from store_sales;
 
 -- Q36 - Combine both tables and display only unique customers from Hyderabad.
 select customer_name from online_sales where city='hyderabad'
 union
 select customer_name from store_sales where city='hyderabad';
 
 -- Q37 - Display all sales with: Customer name in uppercase,Product in lowercase,Month name,Final amount after discount
 select sale_id,upper(customer_name),lower(product),date_format(str_to_date(order_date,'%d-%m-%Y'),'%M') as month_name,amount,discount,
 round(amount-(amount*discount/100),2)
 as final_amount from online_sales
 union
 select  sale_id,upper(customer_name),lower(product),date_format(str_to_date(order_date,'%d-%m-%Y'),'%M')as month_name,amount,discount,
 round(amount-(amount*discount/100),2) 
 as final_amount from store_sales;
 
-- Q38 - Find the total final revenue for each month, considering both online and store sales.
SELECT month_name, ROUND(SUM(final_amount), 2) AS total_final_revenue
FROM (SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%M') AS month_name,
ROUND(amount - (amount * discount / 100), 2) AS final_amount
FROM online_sales
UNION ALL
SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%M') AS month_name,
ROUND(amount - (amount * discount / 100), 2) AS final_amount
FROM store_sales
) AS combined_sales
GROUP BY month_name
ORDER BY MONTH(STR_TO_DATE(month_name, '%M'));
 
 -- Q39 - Find the total revenue generated by each city, combining both sales channels.
SELECT city,ROUND(SUM(final_amount), 2) AS total_final_revenue
FROM (SELECT city, ROUND(amount - (amount * discount / 100), 2) AS final_amount
FROM online_sales
UNION ALL
SELECT city,ROUND(amount - (amount * discount / 100), 2) AS final_amount
FROM store_sales
) AS combined_sales
GROUP BY city
ORDER BY total_final_revenue DESC;

-- Q40 - Find the top 3 products by final revenue, considering sales from both tables.
SELECT product,ROUND(SUM(final_amount), 2) AS total_final_revenue
FROM (SELECT product,ROUND(amount - (amount * discount / 100), 2) AS final_amount
FROM online_sales
UNION ALL
SELECT product,ROUND(amount - (amount * discount / 100), 2) AS final_amount
FROM store_sales) AS combined_sales
GROUP BY product
ORDER BY total_final_revenue DESC
LIMIT 3;

 /* Final Challenge
Q41 - Combine both tables and create a sales report containing: Customer name in uppercase,City
Product,Category,Month name,Quantity,Original amount,Discount,Final amount,Sale classification
Where:Final Amount = Amount - (Amount × Discount / 100)
Classify sales as:
 High Value → Final Amount >= 15000
Regular    → Otherwise
Sort the result by Final Amount descending.
*/

 select upper(customer_name)as customer_name,city,product,category,monthname(str_to_date(order_date,'%d-%m-%Y')),quantity,amount as original_amount,
 discount,round(amount-(amount*discount/100),2)
 as final_amount, if(amount-(amount*discount/100)>=15000, 'high value','regular') as sale_classification from online_sales
 union all
 select upper(customer_name) as customer_name,city,product,category,monthname(str_to_date(order_date,'%d-%m-%Y'))as month_name,quantity,amount as original_amount,
 discount,round(amount-(amount*discount/100),2) 
 as final_amount,if(amount-(amount*discount/100)>=15000, 'high value','regular') as sale_classification from store_sales order by final_amount desc;
 