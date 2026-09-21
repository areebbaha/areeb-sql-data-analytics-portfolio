/* MySQL Case Study — Constraints
PRIMARY KEY, NOT NULL, UNIQUE, DEFAULT & CHECK
Scenario
SwiftPay is a digital wallet startup that onboards thousands of new customers every day through its mobile app.
In its early weeks, the backend team stored customer information without proper database rules. This caused several problems:
Two customers had the same email address.
Some records had no customer name.
An underage customer was registered.
A test account had a negative wallet balance.
The team has decided that these rules should not depend only on application code. The database itself should prevent invalid data.
Your task is to create a reliable customers table that enforces all the business rules below.
*/

-- part A - Create the Database
CREATE DATABASE swiftpay_db;
USE swiftpay_db;

-- part B - Create the customers Table
create table customers (
customer_id int primary key ,
full_name varchar(50) not null,
email varchar(50) not null unique,
age int check (age>=18) ,
mobile varchar (15) not null unique,
account_status varchar(20) default 'active',
wallet_balance decimal (10,2) default 0.00 check (wallet_balance>=0)
 );
 
 
-- TRY : A valid customer is inserted without specifying: Account_Status,Wallet_Balance
-- What values will MySQL store?
-- Why does MySQL automatically use those values?

-- ans: it gives active and 0.0 as they are the default values for account_status and wallet_balance


-- part C - Think Like a Database Designer

-- Q1 - Why should Customer_ID be unique?
-- ans: customer_id should be unique so that we identify individual customers based on that id to distinguish between different customers.

-- Q2 - Why should Email and Mobile be different for every customer?
--  ans: email and mobile should be different bcoz every customer have different contact no and email so that they can receive updates individually .

-- Q3 - Why should the database prevent an age below 18?
--  ans: bcoz of ur check condition we have kept a constraint saying check if the age is 18 or more if it satisfies the condition then only insert.

-- Q4 - Why should Wallet_Balance never be negative?
--  ans: bcoz balance can never be neagtive it can be either little money or no money but not negative.

-- Q5 - Why is it useful for Account_Status and Wallet_Balance to have automatic values?
--  ans: bcoz we usually dont know the values so it is useful to keep default values when not inserted default values are inserted automatically. 
