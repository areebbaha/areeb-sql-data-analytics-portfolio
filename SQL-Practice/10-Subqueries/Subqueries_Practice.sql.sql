-- Today’s task is based on a new EventHub scenario 🎟️ and covers everything we’ve learned up to Subqueries.

CREATE DATABASE IF NOT EXISTS eventhub_db;
USE eventhub_db;

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS venues;
DROP TABLE IF EXISTS organizers;
DROP TABLE IF EXISTS attendees;
DROP TABLE IF EXISTS online_ticket_sales;
DROP TABLE IF EXISTS offline_ticket_sales;

CREATE TABLE attendees (
 attendee_id INT PRIMARY KEY, attendee_name VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL, city VARCHAR(50), age INT CHECK(age>=18)
);
CREATE TABLE organizers (
 organizer_id INT PRIMARY KEY, organizer_name VARCHAR(100) NOT NULL, organizer_type VARCHAR(50)
);
CREATE TABLE venues (
 venue_id INT PRIMARY KEY, venue_name VARCHAR(100) NOT NULL, city VARCHAR(50), capacity INT NOT NULL
);
CREATE TABLE events (
 event_id INT PRIMARY KEY, event_name VARCHAR(120) NOT NULL, organizer_id INT NOT NULL,
 venue_id INT NOT NULL, category VARCHAR(50) NOT NULL, event_date DATE NOT NULL,
 ticket_price DECIMAL(10,2) NOT NULL, event_status VARCHAR(20) NOT NULL,
 FOREIGN KEY(organizer_id) REFERENCES organizers(organizer_id),
 FOREIGN KEY(venue_id) REFERENCES venues(venue_id)
);
CREATE TABLE bookings (
 booking_id INT PRIMARY KEY, attendee_id INT NOT NULL, event_id INT NOT NULL,
 booking_date DATE NOT NULL, ticket_count INT NOT NULL, payment_method VARCHAR(30) NOT NULL,
 booking_status VARCHAR(20) NOT NULL,
 FOREIGN KEY(attendee_id) REFERENCES attendees(attendee_id),
 FOREIGN KEY(event_id) REFERENCES events(event_id)
);
CREATE TABLE online_ticket_sales (
 sale_id INT PRIMARY KEY, attendee_name VARCHAR(100), city VARCHAR(50), event_name VARCHAR(120),
 category VARCHAR(50), ticket_count INT, amount DECIMAL(12,2), sale_date VARCHAR(20),
 discount DECIMAL(5,2), status VARCHAR(20)
);
CREATE TABLE offline_ticket_sales (
 sale_id INT PRIMARY KEY, attendee_name VARCHAR(100), city VARCHAR(50), event_name VARCHAR(120),
 category VARCHAR(50), ticket_count INT, amount DECIMAL(12,2), sale_date VARCHAR(20),
 discount DECIMAL(5,2), status VARCHAR(20)
);


INSERT INTO attendees (attendee_id, attendee_name, email, city, age) VALUES
(1, 'Aarav Mehta', 'aarav@gmail.com', 'Hyderabad', 24),
(2, 'Diya Reddy', 'diya@gmail.com', 'Bengaluru', 27),
(3, 'Rohan Sharma', 'rohan@gmail.com', 'Mumbai', 31),
(4, 'Ananya Rao', 'ananya@gmail.com', 'Hyderabad', 22),
(5, 'Vikram Singh', 'vikram@gmail.com', 'Delhi', 29),
(6, 'Meera Nair', 'meera@gmail.com', 'Kochi', 26),
(7, 'Arjun Kumar', 'arjun@gmail.com', 'Chennai', 34),
(8, 'Sneha Iyer', 'sneha@gmail.com', 'Pune', 23),
(9, 'Karan Verma', 'karan@gmail.com', 'Hyderabad', 36),
(10, 'Pooja Shah', 'pooja@gmail.com', 'Mumbai', 28),
(11, 'Nikhil Das', 'nikhil@gmail.com', 'Delhi', 25),
(12, 'Ishita Kapoor', 'ishita@gmail.com', 'Bengaluru', 30),
(13, 'Rahul Joshi', 'rahul@gmail.com', 'Pune', 21),
(14, 'Kavya Menon', 'kavya@gmail.com', 'Kochi', 32),
(15, 'Aditya Rao', 'aditya@gmail.com', 'Hyderabad', 27),
(16, 'Tanya Bose', 'tanya@gmail.com', 'Kolkata', 29),
(17, 'Sahil Gupta', 'sahil@gmail.com', 'Delhi', 33),
(18, 'Neha Reddy', 'neha@gmail.com', 'Hyderabad', 24),
(19, 'Manish Patel', 'manish@gmail.com', 'Ahmedabad', 38),
(20, 'Sara Khan', 'sara@gmail.com', 'Mumbai', 26);

INSERT INTO organizers (organizer_id, organizer_name, organizer_type) VALUES
(1, 'Pulse Events', 'Entertainment'),
(2, 'CodeCraft Labs', 'Technology'),
(3, 'EduSphere', 'Education'),
(4, 'FitNation', 'Sports'),
(5, 'ArtVista', 'Arts'),
(6, 'BizConnect', 'Business');

INSERT INTO venues (venue_id, venue_name, city, capacity) VALUES
(1, 'Hitex Exhibition Center', 'Hyderabad', 5000),
(2, 'Novotel Convention Hall', 'Hyderabad', 2500),
(3, 'Bangalore Palace Grounds', 'Bengaluru', 6000),
(4, 'Phoenix Arena', 'Mumbai', 4000),
(5, 'Pragati Auditorium', 'Delhi', 3000),
(6, 'Marine Convention Hall', 'Mumbai', 2200),
(7, 'Chennai Trade Centre', 'Chennai', 4500),
(8, 'Kochi Grand Hall', 'Kochi', 1800),
(9, 'Pune City Arena', 'Pune', 2000),
(10, 'Kolkata Cultural Center', 'Kolkata', 1500);

INSERT INTO events (event_id, event_name, organizer_id, venue_id, category,ticket_price,event_date,event_status) VALUES
(1, 'Sunset Music Festival', 1, 1, 'Music', 1500, '2026-09-10', 'Completed'),
(2, 'Hyderabad Tech Summit', 2, 2, 'Technology', 4500, '2026-09-12', 'Completed'),
(3, 'Data Analytics Bootcamp', 3, 1, 'Workshop', 2500, '2026-09-15', 'Upcoming'),
(4, 'City Marathon Expo', 4, 1, 'Sports', 800, '2026-09-18', 'Upcoming'),
(5, 'Indie Art Showcase', 5, 2, 'Arts', 1200, '2026-09-20', 'Upcoming'),
(6, 'Startup Connect 2026', 6, 2, 'Business', 3500, '2026-09-22', 'Upcoming'),
(7, 'Bengaluru Music Night', 1, 3, 'Music', 2000, '2026-09-25', 'Upcoming'),
(8, 'AI & Cloud Conference', 2, 3, 'Technology', 6000, '2026-09-27', 'Upcoming'),
(9, 'Python for Analysts', 3, 7, 'Workshop', 3000, '2026-09-29', 'Upcoming'),
(10, 'Delhi Fitness Carnival', 4, 5, 'Sports', 1000, '2026-10-02', 'Upcoming'),
(11, 'Modern Art Weekend', 5, 6, 'Arts', 1800, '2026-10-04', 'Upcoming'),
(12, 'Leadership Forum', 6, 5, 'Business', 5000, '2026-10-06', 'Upcoming'),
(13, 'Rock Arena Live', 1, 4, 'Music', 3200, '2026-10-09', 'Upcoming'),
(14, 'Machine Learning Masterclass', 2, 7, 'Technology', 7000, '2026-10-12', 'Upcoming'),
(15, 'SQL Weekend Workshop', 3, 9, 'Workshop', 2200, '2026-10-15', 'Upcoming'),
(16, 'Football Fan Fest', 4, 3, 'Sports', 1300, '2026-10-18', 'Upcoming'),
(17, 'Digital Art Lab', 5, 10, 'Arts', 900, '2026-10-20', 'Upcoming'),
(18, 'Investor Meetup', 6, 4, 'Business', 2800, '2026-10-22', 'Upcoming'),
(19, 'Classical Fusion Night', 1, 6, 'Music', 1700, '2026-10-25', 'Upcoming'),
(20, 'Cloud Security Summit', 2, 3, 'Technology', 5500, '2026-10-28', 'Upcoming'),
(21, 'Advanced SQL Workshop', 3, 9, 'Workshop', 4000, '2026-10-30', 'Upcoming'),
(22, 'Corporate Wellness Day', 4, 5, 'Sports', 1100, '2026-11-02', 'Upcoming'),
(23, 'Photography Masters', 5, 10, 'Arts', 2400, '2026-11-05', 'Upcoming'),
(24, 'Business Growth Summit', 6, 1, 'Business', 6500, '2026-11-08', 'Upcoming'),
(25, 'Electronic Beats Night', 1, 4, 'Music', 2600, '2026-11-10', 'Upcoming'),
(26, 'Generative AI Forum', 2, 2, 'Technology', 8000, '2026-11-12', 'Upcoming'),
(27, 'Excel Analytics Workshop', 3, 7, 'Workshop', 1800, '2026-11-15', 'Upcoming'),
(28, 'Cricket Community Cup', 4, 3, 'Sports', 750, '2026-11-18', 'Upcoming'),
(29, 'Sculpture & Design Fair', 5, 10, 'Arts', 3200, '2026-11-20', 'Upcoming'),
(30, 'CEO Networking Dinner', 6, 6, 'Business', 9000, '2026-11-22', 'Upcoming');

INSERT INTO bookings (booking_id, attendee_id, event_id, booking_date, ticket_count, payment_method, booking_status) VALUES
(1001, 1, 21, '2026-08-30', 2, 'Credit Card', 'Confirmed'),
(1002, 1, 4, '2026-09-18', 1, 'Net Banking', 'Confirmed'),
(1003, 1, 1, '2026-08-20', 2, 'Credit Card', 'Confirmed'),
(1004, 1, 24, '2026-08-16', 5, 'Credit Card', 'Confirmed'),
(1005, 1, 9, '2026-09-18', 4, 'Credit Card', 'Confirmed'),
(1006, 2, 9, '2026-08-25', 4, 'Debit Card', 'Confirmed'),
(1007, 2, 26, '2026-08-28', 3, 'UPI', 'Confirmed'),
(1008, 2, 28, '2026-08-21', 3, 'Debit Card', 'Confirmed'),
(1009, 2, 1, '2026-08-17', 4, 'UPI', 'Pending'),
(1010, 3, 13, '2026-09-02', 5, 'Debit Card', 'Confirmed'),
(1011, 3, 3, '2026-08-19', 1, 'Credit Card', 'Confirmed'),
(1012, 3, 18, '2026-08-20', 2, 'UPI', 'Confirmed'),
(1013, 4, 15, '2026-09-06', 2, 'Debit Card', 'Confirmed'),
(1014, 4, 21, '2026-08-19', 5, 'Credit Card', 'Confirmed'),
(1015, 4, 27, '2026-08-30', 2, 'Net Banking', 'Confirmed'),
(1016, 4, 12, '2026-09-19', 2, 'Debit Card', 'Cancelled'),
(1017, 4, 6, '2026-08-18', 2, 'UPI', 'Cancelled'),
(1018, 4, 28, '2026-09-09', 3, 'UPI', 'Confirmed'),
(1019, 5, 19, '2026-09-04', 2, 'Net Banking', 'Confirmed'),
(1020, 5, 29, '2026-09-13', 2, 'Debit Card', 'Confirmed'),
(1021, 6, 24, '2026-09-11', 5, 'Net Banking', 'Confirmed'),
(1022, 6, 18, '2026-08-23', 5, 'Net Banking', 'Confirmed'),
(1023, 6, 9, '2026-08-18', 1, 'Credit Card', 'Confirmed'),
(1024, 6, 19, '2026-09-11', 5, 'UPI', 'Confirmed'),
(1025, 7, 20, '2026-08-31', 5, 'UPI', 'Confirmed'),
(1026, 7, 15, '2026-08-22', 5, 'Debit Card', 'Confirmed'),
(1027, 7, 17, '2026-09-05', 1, 'Debit Card', 'Confirmed'),
(1028, 9, 15, '2026-09-16', 2, 'UPI', 'Cancelled'),
(1029, 9, 1, '2026-09-03', 5, 'Credit Card', 'Confirmed'),
(1030, 9, 24, '2026-08-25', 5, 'UPI', 'Confirmed'),
(1031, 9, 29, '2026-09-15', 1, 'UPI', 'Pending'),
(1032, 9, 9, '2026-09-03', 2, 'UPI', 'Confirmed'),
(1033, 10, 19, '2026-08-20', 4, 'UPI', 'Pending'),
(1034, 10, 3, '2026-09-18', 2, 'Credit Card', 'Confirmed'),
(1035, 11, 18, '2026-09-11', 2, 'Credit Card', 'Confirmed'),
(1036, 11, 6, '2026-09-09', 3, 'Net Banking', 'Cancelled'),
(1037, 11, 9, '2026-09-12', 1, 'Credit Card', 'Confirmed'),
(1038, 11, 17, '2026-09-05', 1, 'Credit Card', 'Confirmed'),
(1039, 12, 1, '2026-08-18', 2, 'UPI', 'Pending'),
(1040, 12, 3, '2026-09-05', 1, 'Credit Card', 'Confirmed'),
(1041, 12, 23, '2026-09-15', 2, 'Credit Card', 'Confirmed'),
(1042, 14, 29, '2026-09-14', 2, 'Net Banking', 'Cancelled'),
(1043, 14, 19, '2026-08-27', 1, 'UPI', 'Confirmed'),
(1044, 15, 12, '2026-08-18', 1, 'UPI', 'Confirmed'),
(1045, 15, 14, '2026-09-05', 1, 'Credit Card', 'Confirmed'),
(1046, 15, 15, '2026-09-18', 4, 'Credit Card', 'Confirmed'),
(1047, 15, 28, '2026-09-01', 4, 'Credit Card', 'Cancelled'),
(1048, 15, 24, '2026-08-19', 4, 'UPI', 'Confirmed'),
(1049, 16, 18, '2026-08-15', 1, 'Credit Card', 'Confirmed'),
(1050, 18, 16, '2026-08-18', 2, 'Net Banking', 'Confirmed'),
(1051, 18, 7, '2026-09-08', 3, 'Net Banking', 'Confirmed'),
(1052, 18, 28, '2026-09-19', 4, 'Credit Card', 'Confirmed'),
(1053, 18, 13, '2026-08-28', 1, 'UPI', 'Confirmed'),
(1054, 19, 2, '2026-09-14', 5, 'Credit Card', 'Confirmed'),
(1055, 19, 19, '2026-09-16', 1, 'Credit Card', 'Confirmed'),
(1056, 20, 3, '2026-08-30', 4, 'UPI', 'Pending'),
(1057, 20, 22, '2026-08-30', 5, 'UPI', 'Confirmed'),
(1058, 20, 28, '2026-09-10', 5, 'Debit Card', 'Pending');

INSERT INTO online_ticket_sales (sale_id, attendee_name, city, event_name, category, ticket_count, amount, sale_date, discount, status) VALUES
(501, 'Arjun Kumar', 'Chennai', 'Modern Art Weekend', 'Arts', 2, 3600, '09-10-2026', 8, 'Delivered'),
(502, 'Nikhil Das', 'Delhi', 'SQL Weekend Workshop', 'Workshop', 3, 6600, '21-08-2026', 0, 'Delivered'),
(503, 'Ananya Rao', 'Hyderabad', 'Data Analytics Bootcamp', 'Workshop', 2, 5000, '22-09-2026', 12, 'Delivered'),
(504, 'Kavya Menon', 'Kochi', 'Data Analytics Bootcamp', 'Workshop', 2, 5000, '25-09-2026', 8, 'Delivered'),
(505, 'Nikhil Das', 'Delhi', 'Cloud Security Summit', 'Technology', 1, 5500, '29-10-2026', 15, 'Delivered'),
(506, 'Ananya Rao', 'Hyderabad', 'Indie Art Showcase', 'Arts', 3, 3600, '02-09-2026', 0, 'Delivered'),
(507, 'Vikram Singh', 'Delhi', 'Python for Analysts', 'Workshop', 3, 9000, '15-09-2026', 12, 'Delivered'),
(508, 'Arjun Kumar', 'Chennai', 'Python for Analysts', 'Workshop', 4, 12000, '26-08-2026', 8, 'Delivered'),
(509, 'Tanya Bose', 'Kolkata', 'Python for Analysts', 'Workshop', 1, 3000, '01-10-2026', 0, 'Pending'),
(510, 'Pooja Shah', 'Mumbai', 'Startup Connect 2026', 'Business', 4, 14000, '18-11-2026', 12, 'Delivered'),
(511, 'Aarav Mehta', 'Hyderabad', 'City Marathon Expo', 'Sports', 1, 800, '08-09-2026', 15, 'Delivered'),
(512, 'Kavya Menon', 'Kochi', 'Classical Fusion Night', 'Music', 2, 3400, '05-09-2026', 10, 'Delivered'),
(513, 'Kavya Menon', 'Kochi', 'Hyderabad Tech Summit', 'Technology', 3, 13500, '15-11-2026', 5, 'Delivered'),
(514, 'Ananya Rao', 'Hyderabad', 'Leadership Forum', 'Business', 4, 20000, '08-09-2026', 12, 'Cancelled'),
(515, 'Karan Verma', 'Hyderabad', 'Startup Connect 2026', 'Business', 2, 7000, '23-08-2026', 10, 'Delivered'),
(516, 'Ishita Kapoor', 'Bengaluru', 'Machine Learning Masterclass', 'Technology', 2, 14000, '09-09-2026', 8, 'Pending'),
(517, 'Ananya Rao', 'Hyderabad', 'Rock Arena Live', 'Music', 1, 3200, '17-09-2026', 10, 'Delivered'),
(518, 'Neha Reddy', 'Hyderabad', 'Leadership Forum', 'Business', 3, 15000, '17-09-2026', 5, 'Delivered'),
(519, 'Arjun Kumar', 'Chennai', 'Rock Arena Live', 'Music', 3, 9600, '28-08-2026', 8, 'Cancelled'),
(520, 'Pooja Shah', 'Mumbai', 'Leadership Forum', 'Business', 4, 20000, '27-10-2026', 15, 'Delivered'),
(521, 'Aarav Mehta', 'Hyderabad', 'City Marathon Expo', 'Sports', 3, 2400, '02-11-2026', 5, 'Cancelled'),
(522, 'Pooja Shah', 'Mumbai', 'Hyderabad Tech Summit', 'Technology', 1, 4500, '14-10-2026', 12, 'Delivered'),
(523, 'Ishita Kapoor', 'Bengaluru', 'Machine Learning Masterclass', 'Technology', 1, 7000, '01-11-2026', 10, 'Delivered'),
(524, 'Diya Reddy', 'Bengaluru', 'Machine Learning Masterclass', 'Technology', 1, 7000, '27-10-2026', 12, 'Delivered'),
(525, 'Arjun Kumar', 'Chennai', 'Leadership Forum', 'Business', 4, 20000, '13-11-2026', 0, 'Cancelled');

INSERT INTO offline_ticket_sales (sale_id, attendee_name, city, event_name, category, ticket_count, amount, sale_date, discount, status) VALUES
(601, 'Ishita Kapoor', 'Bengaluru', 'City Marathon Expo', 'Sports', 3, 2400, '28-09-2026', 12, 'Delivered'),
(602, 'Ishita Kapoor', 'Bengaluru', 'Rock Arena Live', 'Music', 3, 9600, '05-09-2026', 12, 'Delivered'),
(603, 'Aditya Rao', 'Hyderabad', 'Startup Connect 2026', 'Business', 3, 10500, '29-10-2026', 10, 'Pending'),
(604, 'Nikhil Das', 'Delhi', 'Delhi Fitness Carnival', 'Sports', 2, 2000, '02-11-2026', 10, 'Delivered'),
(605, 'Ishita Kapoor', 'Bengaluru', 'SQL Weekend Workshop', 'Workshop', 4, 8800, '14-11-2026', 10, 'Delivered'),
(606, 'Manish Patel', 'Ahmedabad', 'Startup Connect 2026', 'Business', 1, 3500, '24-10-2026', 8, 'Delivered'),
(607, 'Ishita Kapoor', 'Bengaluru', 'Data Analytics Bootcamp', 'Workshop', 2, 5000, '28-09-2026', 15, 'Delivered'),
(608, 'Arjun Kumar', 'Chennai', 'Indie Art Showcase', 'Arts', 1, 1200, '20-09-2026', 0, 'Cancelled'),
(609, 'Rohan Sharma', 'Mumbai', 'SQL Weekend Workshop', 'Workshop', 4, 8800, '01-11-2026', 15, 'Delivered'),
(610, 'Aditya Rao', 'Hyderabad', 'Football Fan Fest', 'Sports', 4, 5200, '07-09-2026', 5, 'Delivered'),
(611, 'Aarav Mehta', 'Hyderabad', 'City Marathon Expo', 'Sports', 4, 3200, '11-09-2026', 5, 'Pending'),
(612, 'Sara Khan', 'Mumbai', 'SQL Weekend Workshop', 'Workshop', 1, 2200, '20-09-2026', 12, 'Cancelled'),
(613, 'Ananya Rao', 'Hyderabad', 'SQL Weekend Workshop', 'Workshop', 2, 4400, '13-11-2026', 10, 'Delivered'),
(614, 'Ishita Kapoor', 'Bengaluru', 'SQL Weekend Workshop', 'Workshop', 4, 8800, '16-10-2026', 12, 'Pending'),
(615, 'Manish Patel', 'Ahmedabad', 'SQL Weekend Workshop', 'Workshop', 3, 6600, '09-11-2026', 5, 'Delivered'),
(616, 'Sara Khan', 'Mumbai', 'Football Fan Fest', 'Sports', 2, 2600, '15-10-2026', 8, 'Delivered'),
(617, 'Nikhil Das', 'Delhi', 'AI & Cloud Conference', 'Technology', 3, 18000, '29-09-2026', 8, 'Pending'),
(618, 'Rohan Sharma', 'Mumbai', 'Indie Art Showcase', 'Arts', 2, 2400, '08-10-2026', 5, 'Delivered'),
(619, 'Arjun Kumar', 'Chennai', 'Data Analytics Bootcamp', 'Workshop', 4, 10000, '01-10-2026', 10, 'Delivered'),
(620, 'Tanya Bose', 'Kolkata', 'Hyderabad Tech Summit', 'Technology', 2, 9000, '08-10-2026', 10, 'Cancelled'),
(621, 'Aarav Mehta', 'Hyderabad', 'Classical Fusion Night', 'Music', 4, 6800, '20-08-2026', 10, 'Cancelled'),
(622, 'Nikhil Das', 'Delhi', 'Rock Arena Live', 'Music', 4, 12800, '28-10-2026', 12, 'Pending'),
(623, 'Karan Verma', 'Hyderabad', 'Football Fan Fest', 'Sports', 2, 2600, '14-10-2026', 8, 'Delivered'),
(624, 'Aditya Rao', 'Hyderabad', 'Modern Art Weekend', 'Arts', 4, 7200, '10-09-2026', 15, 'Pending'),
(625, 'Vikram Singh', 'Delhi', 'Cloud Security Summit', 'Technology', 1, 5500, '03-11-2026', 10, 'Delivered');

-- Q1 -  Find all events happening in Hyderabad.
select * from events where venue_id in (select venue_id from venues where city='hyderabad');

-- Q2 -  Display events whose ticket price is between ₹1,000 and ₹5,000, sorted highest to lowest.
select event_name,ticket_price from events where ticket_price between 1000 and 5000 order by ticket_price desc;

-- Q3 - Find the number of events organized by each organizer.
select o.organizer_name,o.organizer_id,count(e.event_id) as number_of_events from events e right join organizers o on e.organizer_id=o.organizer_id
 group by  o.organizer_name,o.organizer_id;
 
-- Q4 - Display each event with its organizer name, venue name and venue city.
select e.event_name, o.organizer_name,o.organizer_id,v.venue_name,v.city from events e inner join organizers o on e.organizer_id=o.organizer_id
 inner join venues v on v.venue_id=e.venue_id;
 
 -- Q5 - Find venues that have never hosted an event.
 select v.venue_name,e.event_name from venues v left join events e on v.venue_id=e.venue_id where e.event_id is null;
 select venue_name from venues where venue_id not in (select venue_id from events );
 
-- Q6 - Find the total number of tickets booked for each event.
select event_name,sum(ticket_count) as total_tickets from 
(select event_name,ticket_count from offline_ticket_sales
union all 
select event_name,ticket_count from online_ticket_sales) as total_number_tickets
 group by event_name;
 
-- Q7 - Find the event with the highest confirmed booking revenue. Revenue = ticket_count × ticket_price.
select e.event_name,sum(b.ticket_count*e.ticket_price) as total_revenue from events e inner join bookings b on e.event_id=e.event_id 
where b.booking_status='confirmed' group by e.event_name order by total_revenue desc limit 1;

-- Q8 -  Add a price category: Below ₹2,000 = Budget; ₹2,000–₹5,000 = Standard; above ₹5,000 = Premium.
select ticket_price,case when ticket_price<2000 then 'budget'
when ticket_price between 2000 and 5000 then 'standard'
else 'premium'
end as price_category from events;

-- Q9 - Find cities having more than 3 events.
select v.city,count(distinct e.event_id) as total_events from venues v join events e on e.venue_id=v.venue_id group by v.city having total_events>3;

-- 10 - Display the 5 earliest upcoming events.
select * from events where event_status='upcoming' order by event_date asc limit 5;

-- Q11 - Find attendees who have made at least one booking.
select a.attendee_id,a.attendee_name,count(distinct b.booking_id)from attendees a inner join bookings b on a.attendee_id=b.attendee_id 
group by a.attendee_id,a.attendee_name;

-- Q12 - Find attendees who have never made a booking.
select a.attendee_id,a.attendee_name,count(distinct b.booking_id) total_bookings from attendees a left join bookings b on a.attendee_id=b.attendee_id 
 group by a.attendee_id,a.attendee_name having total_bookings=0;
SELECT a.attendee_id,a.attendee_name,b.booking_id
FROM attendees a LEFT JOIN bookings b ON a.attendee_id = b.attendee_id WHERE b.booking_id IS NULL;

-- Q13 - Find total spending by each attendee on confirmed bookings.
select a.attendee_name,a.attendee_id,sum(b.ticket_count*e.ticket_price) as total_spending from events e inner join bookings b on e.event_id=e.event_id 
inner join attendees a on a.attendee_id=b.attendee_id
where b.booking_status='confirmed' group by a.attendee_name,a.attendee_id;

-- Q14 - Find attendees whose confirmed booking spending is greater than ₹20,000.
select a.attendee_name,a.attendee_id,sum(b.ticket_count*e.ticket_price) as total_spending from events e inner join bookings b on e.event_id=e.event_id 
inner join attendees a on a.attendee_id=b.attendee_id
where b.booking_status='confirmed' group by a.attendee_name,a.attendee_id having total_spending>20000;

-- Q15 - Find organizers whose confirmed booking revenue is greater than ₹100,000.
select o.organizer_name,o.organizer_id,sum(b.ticket_count*e.ticket_price) as total_revenue from events e inner join bookings b on e.event_id=b.event_id 
inner join organizers o on o.organizer_id=e.organizer_id
where b.booking_status='confirmed' group by o.organizer_name,o.organizer_id having total_revenue>100000;

-- Q16 - Find the most expensive event in each category.
select e.event_name,e.category,e.ticket_price from events e where e.ticket_price=(select max(e2.ticket_price) as most_expensive from events e2
 where e2.category = e.category);
 
-- Q17 - Find events whose ticket price is greater than the average ticket price of all events.
select event_name,ticket_price from events where ticket_price>(select avg(ticket_price) from events );

-- Q18 - Find events whose ticket price is greater than the average ticket price of all events.
select a.attendee_name,a.attendee_id,count(b.booking_id) as booking_count from attendees a left join bookings b on a.attendee_id=b.attendee_id
 group by a.attendee_name,a.attendee_id having booking_count > (select avg(x.booking_count) from (
 SELECT attendee_id, COUNT(*) AS booking_count FROM bookings GROUP BY attendee_id) AS x);
 
-- Q19 - Find events whose ticket price is greater than ANY event in the Music category.
select event_name,ticket_price from events where ticket_price > any(select ticket_price from events where category='music');

-- Q20 - Find events whose ticket price is greater than ALL events in the Workshop category.
select event_name,ticket_price from events where ticket_price >all (select ticket_price from events where category='workshop');

-- Q21 - Find events whose ticket price is lower than ALL events in the Technology category.
select event_name,ticket_price from events where ticket_price <all (select ticket_price from events where category='technology');

-- Q22 - Find events whose ticket price is greater than the average ticket price of their own category.
select e.category,e.event_name,e.ticket_price from events e where e.ticket_price > (select avg(e2.ticket_price) from events e2 where e2.category=e.category);

-- Q23 -  Find organizers whose event count is greater than the average number of events organized per organizer.
select o.organizer_name,o.organizer_id,count(e.event_id) as event_count from organizers o left join events e on o.organizer_id=e.organizer_id 
group by  o.organizer_name,o.organizer_id having event_count > (select avg(x.event_count) from (
select organizer_id,count(*) as event_count from events group by organizer_id) as x);

-- Q24 - Find venues whose capacity is greater than every venue in Hyderabad.
select venue_name from venues where capacity>all(select capacity from venues where city='hyderabad');

-- Q25 - Find attendees who booked at least one event whose ticket price is greater than the overall average ticket price.
select a.attendee_name,e.ticket_price from attendees a inner join bookings b on a.attendee_id=b.attendee_id inner join events e on e.event_id=b.event_id
 where e.ticket_price>any(select avg(ticket_price) from events);
 
-- Q26 -  Combine online and offline ticket sales into one result containing attendee_name, city, event_name, category, ticket_count and amount.
select attendee_name,city,event_name,category,ticket_count,amount from offline_ticket_sales
union all
select attendee_name,city,event_name,category,ticket_count,amount from online_ticket_sales;

-- Q27 - Combine both sales channels and calculate final amount after discount: amount - (amount × discount / 100).
select attendee_name,city,event_name,category,ticket_count,amount,discount,amount - (amount * discount / 100)as final_amount from offline_ticket_sales
union all
select attendee_name,city,event_name,category,ticket_count,amount,discount,amount - (amount * discount / 100)as final_amount from online_ticket_sales;

-- Q28 - Using both sales channels, find total final revenue by city, highest to lowest.
select s.city,sum(s.amount-(s.amount*s.discount/100)) as total_revenue from (
 select attendee_name,city,event_name,category,amount,discount from offline_ticket_sales
union all
select attendee_name,city,event_name,category,amount,discount from online_ticket_sales) as s
group by s.city order by total_revenue desc;

-- Q29 - Using both sales channels, find the top 3 events by final revenue.
select s.event_name,sum(s.amount-(s.amount*s.discount/100)) as total_revenue from (
 select event_name,city,category,amount,discount from offline_ticket_sales
union all
select event_name,city,category,amount,discount from online_ticket_sales) as s
group by s.event_name order by total_revenue desc limit 3;

-- Q30 - Display attendee names in uppercase and email addresses in lowercase.
select Upper(attendee_name),lower(email) from attendees;

-- Q31 - Display each event name with its length, first 4 characters and last 4 characters. 
select length(event_name),left(event_name,4),right(event_name,4) from events;

-- Q32 - Convert sale_date from text to a proper date and display it as DD-Month-YYYY.
select event_name,date_format(event_date,'%d-%m-%Y') from events;

-- Q33 - Using both sales channels, find total tickets sold and total final revenue for each category.
select s.category,sum(s.ticket_count) as total_tickets,sum(s.amount-(s.amount*s.discount/100)) as total_revenue from
(select event_name,category,ticket_count,amount,discount from offline_ticket_sales
union all
select event_name,category,ticket_count,amount,discount from online_ticket_sales) as s
group by s.category;

-- Q34 -  Find categories whose total final revenue is greater than the average category revenue.
select category,sum(amount-(amount*discount/100)) as total_revenue from
(select category,amount,discount from offline_ticket_sales
union all
select category,amount,discount from online_ticket_sales) as s
group by category having total_revenue > (select avg(x.total_revenue) from (
select category,sum(amount - (amount * discount / 100)) as total_revenue from 
(select category,amount,discount from offline_ticket_sales
union all
select category,amount,discount from online_ticket_sales) as s2 group by category )as x);

/* Q35 - FINAL BOSS: Find organizers satisfying ALL: event count greater than average organizer event count; 
confirmed booking revenue > ₹100,000; 
at least one event has ticket price above the overall average; 
at least one event is Completed.
 Display organizer_name, event_count and total_booking_revenue, sorted by revenue descending.
 */

SELECT o.organizer_name,COUNT(DISTINCT e.event_id) AS event_count,SUM(b.ticket_count * e.ticket_price) AS total_booking_revenue FROM organizers o
JOIN events e ON o.organizer_id = e.organizer_id
JOIN bookings b ON e.event_id = b.event_id
WHERE b.booking_status = 'confirmed'
GROUP BY o.organizer_id, o.organizer_name
HAVING event_count >(SELECT AVG(x.event_count)FROM
        (SELECT organizer_id, COUNT(*) AS event_count FROM events GROUP BY organizer_id) AS x)
AND SUM(b.ticket_count * e.ticket_price) > 100000
AND o.organizer_id IN
(SELECT organizer_id FROM events WHERE ticket_price >(SELECT AVG(ticket_price)FROM events) )
AND o.organizer_id IN
(SELECT organizer_id FROM events WHERE event_status = 'completed') ORDER BY total_booking_revenue DESC;	


