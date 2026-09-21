/*
MySQL Case Study — CineWorld Movie Booking
Build a Relational Database from a Real-World Scenario
🎥 Scenario
CineWorld wants to build a database for its online movie ticket booking system.
The system needs to manage:
🎭 Theatres
🎬 Movies
🎟️ Shows
👤 Customers
🎫 Bookings
Your task is to design and build the database using the concepts you have learned so far.
*/

-- Task 1 - Create the Database

create database cineworld_db;
use cineworld_db;
create table theatres (
theatre_id int primary key,
theatre_name varchar(100) not null unique,
city varchar(100) not null,
number_of_screens int check(number_of_screens >0)
);
/*
-- Task 2 - Create the Tables
Based on the requirements:
Decide the columns for each table.
Choose appropriate MySQL data types.
Create all 5 tables.

-- Task 3- Add Primary Keys 🔑
Every table must have a suitable Primary Key.
Think:
“Which column uniquely identifies each record?”

-- Task 4- Connect the Tables 🔗
Use Foreign Keys to establish the relationships.
Think about these requirements:
A movie can have many shows.
A theatre can have many shows.
A customer can make many bookings.
A show can have many bookings.
Decide:
Which table should contain the Foreign Key?

-- Task 5- Apply the Rules 🔐
Use the appropriate constraints based on the business requirements.
You have learned:
PRIMARY KEY
NOT NULL
UNIQUE
DEFAULT
CHECK
FOREIGN KEY
Your job is to decide which constraint is required for each rule.

-- Task 6- Insert Data
Insert at least 3–5 realistic records into every table.
⚠️ Follow the relationships carefully.
For example:
Don't create a show for a movie that doesn't exist.
Don't create a booking for a customer that doesn't exist.
Don't create a booking for a show that doesn't exist.

*/

create table movies (
movie_id int primary key ,
movie_title varchar(100) not null ,
genre varchar(100) not null,
duration int check (duration >0),
language varchar(100) not null
);

create table shows(
show_id int primary key,
movie_id int ,
show_date date not null ,
show_time time not null,
ticket_price decimal(10,2) not null check (ticket_price >0),
foreign key (movie_id) references movies (movie_id)
);

create table customers (
Customer_ID int primary key, 
Customer_name varchar(100) not null,
Email varchar(100) not null unique,
Phone_number varchar(20) not null unique
);
create table bookings (
Booking_ID int primary key,
Customer_ID int ,
show_id int ,
Number_of_seats int not null check (Number_of_seats>0),
Booking_date date default (curdate()), 
Total_amount decimal(10,2) not null check(Total_amount>0),
foreign key(customer_id) references customers (customer_id),
 foreign key (show_id) references shows (show_id)
);
select * from customers;

INSERT INTO theatres
(theatre_id, theatre_name, city, number_of_screens)
VALUES
(1, 'PVR Cinemas', 'Hyderabad', 8),
(2, 'INOX', 'Mumbai', 6),
(3, 'Cinepolis', 'Bengaluru', 7),
(4, 'Miraj Cinemas', 'Delhi', 5),
(5, 'Asian Cinemas', 'Chennai', 6);

INSERT INTO movies
(movie_id, movie_title, genre, duration, language)
VALUES
(101, 'Interstellar', 'Sci-Fi', 169, 'English'),
(102, 'Dangal', 'Sports Drama', 161, 'Hindi'),
(103, 'RRR', 'Action Drama', 187, 'Telugu'),
(104, '3 Idiots', 'Comedy Drama', 170, 'Hindi'),
(105, 'Avengers Endgame', 'Action', 181, 'English');

INSERT INTO shows
(show_id, movie_id, show_date, show_time, ticket_price)
VALUES
(201, 101, '2026-09-15', '18:00:00', 350.00),
(202, 102, '2026-09-16', '15:30:00', 250.00),
(203, 103, '2026-09-17', '19:30:00', 300.00),
(204, 104, '2026-09-18', '14:00:00', 220.00),
(205, 105, '2026-09-19', '20:00:00', 400.00);

INSERT INTO customers
(Customer_ID, Customer_name, Email, Phone_number)
VALUES
(1, 'Rahul Sharma', 'rahul.sharma@gmail.com', '9876543210'),
(2, 'Priya Reddy', 'priya.reddy@gmail.com', '9876543211'),
(3, 'Arjun Kumar', 'arjun.kumar@gmail.com', '9876543212'),
(4, 'Sneha Rao', 'sneha.rao@gmail.com', '9876543213'),
(5, 'Vikram Singh', 'vikram.singh@gmail.com', '9876543214');

INSERT INTO bookings
(Booking_ID, Customer_ID, show_id, Number_of_seats, Booking_date, Total_amount)
VALUES
(1001, 1, 201, 2, '2026-09-12', 700.00),
(1002, 2, 202, 3, '2026-09-12', 750.00),
(1003, 3, 203, 2, '2026-09-13', 600.00),
(1004, 4, 204, 4, '2026-09-13', 880.00),
(1005, 5, 205, 2, '2026-09-14', 800.00);

-- Task 7- Test Your Foreign Keys 🔗
-- Try creating a record with a Foreign Key value that doesn't exist in the referenced table. Observe what happens.
-- Then answer: Why did MySQL reject the record?

insert into bookings values (1006,6,206,5,'2026-09-14','1000');
-- ans : it gives an error saying cannot add or update a child row : a foreign key constraint fails ,bcoz when have a foreign key constraint it means that u cannot insert 
-- values in child table when u dont have that value in ur parent table.


/*
Creating the ER Diagram
After creating your database in MySQL Workbench:
Database → Reverse Engineer
Generate the ER diagram and check whether:
All 5 tables are present.
Primary Keys are shown.
Foreign Keys are connected correctly.
The relationships make sense.
*/

-- Q1 - Why do we need separate tables instead of storing everything in one table?
-- ans : we need separate table to easily identify relationships and can easily search and analyze data and maintain data consistency and integrity. 

-- Q2 - Why do we need the Bookings table?
-- ans : we need bookings table to know which customers booked the ticket and to identify which show has the customer booked for
-- and also what is ur seat no and at what date did we book the ticket .

-- Q3 - What happens when you try to use a Foreign Key value that doesn't exist?
-- ans : it gives an error saying cannot add or update a child row : a foreign key constraint fails ,bcoz when have a foreign key constraint it means that u cannot insert 
-- values in child table when u dont have that value in ur parent table.

-- Q4 - Why should the parent table be created before the table containing the Foreign Key?
-- ans : Because the foreign key needs to reference an existing parent table and its primary key.

-- Q5 - What kind of relationship exists between Customers and Bookings?
-- ans : customers is the parent table and bookings is the child table ,one to many relationship one customer can have many bookings.

-- Q6 - What kind of relationship exists between Movies and Shows?
-- ans : movies is the parent table and shows is the child table ,one to many relationship one movie can have many shows.

-- Q7 - What problems could occur if we removed all the Foreign Key constraints?
-- ans : Without foreign keys, the database could contain invalid or orphan records.


