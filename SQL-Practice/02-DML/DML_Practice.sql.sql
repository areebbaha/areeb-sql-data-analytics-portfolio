/*
 MySQL DML Practice Task
Scenario
You are managing the student records of a Data Science Training Institute.
Create the students table..
Now your job is to add, update, and delete student information using DML commands.
*/
create database ds_training_institute;
use ds_training_institute;
create table students (student_id int,
student_name VARCHAR(100),
age INT,
city VARCHAR(50),
email VARCHAR(100),
course VARCHAR(50),
fees DECIMAL(10,2)
);
-- part 1 - Insert 10 student records into the table.

insert into students values
(101,'Rahul',22,'Hyderabad','rahul@gmail.com','Data Science',45000);
insert into students values
(102,'Priya',24,'Vijayawada','priya@gmail.com','Python',25000),
(103,'Arjun',21,'Visakhapatnam','arjun@gmail.com','Data Analytics',30000),
(104,'Sneha',23,'Hyderabad','sneha@gmail.com','Data Science',45000),
(105,'Kiran',25,'Bengaluru','kiran@gmail.com','Python',25000),
(106,'Ananya',22,'Chennai','ananya@gmail.com','Machine Learning',50000),
(107,'Rohit',26,'Hyderabad','rohit@gmail.com','Data Analytics',30000),
(108,'Divya',23,'Pune','divya@gmail.com','Data Science',45000),
(109,'Varun',24,'Vijayawada','varun@gmail.com','Machine Learning',50000),
(110,'Meghana',21,'Visakhapatnam','meghana@gmail.com','Python',25000);
select* from students;
truncate table students;
-- part 2 - UPDATE — Modify Student Data

-- task 1 - Rahul has moved from Hyderabad to Bengaluru.Update his city.
update students set city='Bengaluru' where student_name='Rahul';

-- task 2 - Priya has provided a new email: priya.ds@gmail.com.Update her email.
update students set email='priya.ds@gmail.com' where student_name='priya';

-- task 3 - The Data Science course fee has increased to 48000.Update the appropriate student records.
update students set fees=48000 where course='Data Science';

-- task 4 - Arjun has changed his course from Data Analytics to Data Science.Update his course.
update students set course='Data Science' where student_name='Arjun';

-- task 5 - Sneha has moved to Chennai and changed her email to: sneha23@gmail.com
update students set city='Chennai',email='sneha23@gmail.com' where student_name='sneha';

-- part 3 - DELETE — Remove Data

-- task 1 - Student 110 has cancelled the course and their record needs to be removed.Delete the student using student_id.
delete from students where student_id=110;

-- task 2 - Student 105 was added by mistake.Delete that record.
delete from students where student_id=105;

-- part 4 - Think and Answer

-- Q1 - What will happen? DELETE FROM students;
delete from students;
-- ans: all the records of students table will be deleted.
-- Q2 - What will happen? UPDATE students SET fees = 50000 WHERE course = 'Python';
UPDATE students
SET fees = 50000 WHERE course = 'Python';
-- ans: here the fees will be updated to 50000 in where course is python.

-- part 5 - Why Do We Need Constraints?
-- Try 1 - A student with a negative age.
update students set age=-25 where student_id=101;
-- ans: we need constraints to enforce rules to main data integrity and consistency and data validation.

-- Try 2 - A student without a name.
insert into students values(101,-30,'hyderabad','rahul@gmail.com','python',-65000); 
-- ans: we get error doing these things.


-- 1.Q - Should two students have the same student_id? Why?
-- ans: No u cant have same student_id of two students bcoz student_id is used to distinguish between students to identify students 
-- so if both have same student_id then a lot of confusion and errors happen.

-- 2.Q - Should a student's age be negative? Why?
-- ans: NO a students age cannot be negative bcoz age doesnt go backwards.

-- 3.Q - Should every student record have a name?

-- ans: yes every student record should have a name.alter

-- 4.Q - Should two students be allowed to register with the same email?
-- ans: no two students cannot have same email bcoz then u cannot distinguish between the two studunts and who is that msg for.

-- 5.Q - If MySQL allows us to enter such incorrect data, how can we tell the database what rules the data must follow?
-- ans: we can use constraints to avoid duplication and data inconsistency,constraints helps to enforce rules which are imp to maintain data validation and data integrity. 