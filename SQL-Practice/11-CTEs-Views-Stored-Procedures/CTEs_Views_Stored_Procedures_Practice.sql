CREATE DATABASE advanced_sql_db;
USE advanced_sql_db;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    job_role VARCHAR(50),
    salary INT,
    joining_date DATE,
    city VARCHAR(30),
    performance_score DECIMAL(3,1)
);


INSERT INTO employees
(employee_id, employee_name, department, job_role, salary, joining_date, city, performance_score)
VALUES
(1, 'Rahul Sharma', 'IT', 'Data Analyst', 72000, '2022-04-15', 'Hyderabad', 8.7),
(2, 'Priya Reddy', 'HR', 'HR Executive', 55000, '2021-07-20', 'Bengaluru', 8.2),
(3, 'Arjun Kumar', 'IT', 'Software Engineer', 90000, '2020-02-10', 'Chennai', 9.1),
(4, 'Sneha Rao', 'Sales', 'Sales Executive', 65000, '2023-01-12', 'Hyderabad', 7.9),
(5, 'Karan Singh', 'IT', 'Data Engineer', 82000, '2021-11-05', 'Pune', 8.9),
(6, 'Ananya Das', 'Finance', 'Financial Analyst', 68000, '2022-08-18', 'Delhi', 8.4),
(7, 'Vikram Patel', 'Sales', 'Sales Manager', 95000, '2019-06-25', 'Mumbai', 9.0),
(8, 'Meera Nair', 'HR', 'Recruiter', 60000, '2023-03-14', 'Kochi', 8.0),
(9, 'Rohan Verma', 'IT', 'Software Engineer', 90000, '2022-01-28', 'Hyderabad', 8.8),
(10, 'Pooja Shah', 'Finance', 'Accountant', 58000, '2021-09-09', 'Mumbai', 7.8),
(11, 'Aditya Rao', 'IT', 'DevOps Engineer', 85000, '2020-12-11', 'Bengaluru', 9.2),
(12, 'Neha Kapoor', 'Sales', 'Sales Executive', 65000, '2024-02-19', 'Delhi', 8.1),
(13, 'Kiran Reddy', 'Finance', 'Finance Manager', 88000, '2019-10-21', 'Hyderabad', 9.0),
(14, 'Ishita Menon', 'HR', 'HR Manager', 78000, '2020-05-16', 'Chennai', 8.9),
(15, 'Sahil Gupta', 'IT', 'QA Engineer', 70000, '2023-06-07', 'Pune', 8.3),
(16, 'Kavya Iyer', 'Marketing', 'Marketing Executive', 62000, '2022-10-03', 'Bengaluru', 8.5),
(17, 'Manish Joshi', 'Marketing', 'Marketing Manager', 84000, '2020-08-27', 'Mumbai', 9.1),
(18, 'Tanya Bose', 'Marketing', 'Content Strategist', 62000, '2024-01-15', 'Kolkata', 8.0),
(19, 'Nikhil Das', 'IT', 'Data Analyst', 72000, '2024-04-22', 'Delhi', 8.6),
(20, 'Sara Khan', 'Finance', 'Financial Analyst', 68000, '2023-09-12', 'Pune', 8.7);

-- Q1 - Display every employee along with the average salary of the entire company.
with avg_Sal as (
select avg(salary) as average_salary from employees)
select e.employee_name,e.salary,c.average_salary from employees e cross join avg_sal c;

-- Q2 - Display every employee along with their department average salary and the difference between their salary and the department average.
with avg_dept_salary as (
select department,avg(salary) as dept_average_salary from employees group by department)
select e.employee_name,e.department,e.salary,c.dept_average_salary ,(e.salary-c.dept_average_salary )as difference from employees e
 inner join avg_dept_salary c on e.department=c.department;
 
 -- Q3 -Rank all employees based on salary from highest to lowest.
 select employee_name,salary,rank() over( order by salary desc) as salary_rank from employees;
 
-- Q4 - Display employees with their department-wise salary rank.
select employee_name,department,salary,rank() over(partition by department order by salary desc) from employees;

-- Q5 - Display each employee's salary along with the previous employee's salary based on joining date.
select employee_name,salary,joining_date,lag (salary,1) over(order by joining_date asc) as previous_employee_salary from employees;

-- Q6 - Display employee name, department, salary, department average salary and department rank in a single result.
select employee_name,department,salary,avg(salary) over(partition by department ),
rank() over(partition by department order by salary desc) from employees;

-- Q7 - Find employees whose salary is higher than the average salary of their department.
with avg_dept_sal as (
select department,avg(salary) as average_salary from employees group by department)
select e.employee_name,e.salary,e.department,d.average_salary from employees e inner join avg_dept_sal d on e.department=d.department where e.salary>d.average_salary ;

-- Q8 - Create a result containing each department's employee count, average salary and maximum salary, then display departments having more than 3 employees.
with result as (
select department,count(distinct employee_id) as employee_count,
avg(salary) as average_salary,
max(salary) as maximum_salary 
from employees group by department)
select * from result where employee_count>3;

-- Q9 - Find the top 3 highest-paid employees in each department.
with ranked_employees as (
select employee_name,department,salary,rank() over (partition by department order by salary desc) as salary_rank from employees)
select * from ranked_employees where salary_rank<=3;

-- Q10 - Display employees who are earning more than the company average salary and show the difference between their salary and the company average.
with company_sal as (
select employee_name,avg(salary) as average_salary from employees group by employee_name)
select e.employee_name,e.salary from employees e inner join company_sal c on e.employee_name=c.employee_name where (e.salary >c.average_salary) and
 (e.salary-c.average_salary);
 
 -- Q11 - Create a view named employee_salary_details containing employee name, department, job role, salary and city.
 create view employee_salary_details as 
 select employee_name,department,job_role,salary,city from employees ;
 select * from employee_salary_details;
 
 -- Q12 - Using the employee_salary_details view, display employees whose salary is above ₹75,000, sorted from highest to lowest salary.
 select employee_name,salary from employee_salary_details where salary>75000 order by salary desc;
 
 -- Q13 - Create a view named department_salary_summary containing:
-- Department,Employee count,Average salary,Minimum salary,Maximum salary
 create view department_salary_summary as 
 select department,count(distinct employee_id) as employee_count,
 avg(salary) as average_salary,
 min(salary) as minimum_salary,
 max(salary) as maximum_salary from employees group by department;
select * from department_salary_summary;

-- Q14 - Using department_salary_summary, display departments whose average salary is above ₹70,000.
select department from department_salary_summary where average_salary>70000 ;

-- Q15 - Create a view that displays each employee along with their department average salary and department rank.
create view employee_dept_details as
select employee_name,department,salary,avg(salary) over(partition by department)as department_average_salary,rank() over (partition by department order by salary desc) 
as department_rank from employees;
select * from employee_dept_details;

 -- Q16 - Using the view created above, display only employees who are ranked 1st in their department.
 select * from employee_dept_details where department_rank=1;
 
-- Q17 - Create a stored procedure named show_all_employees to display all employees.
delimiter //
create procedure show_all_employees () 
begin
select * from employees;
end //
delimiter ;
call show_all_employees;

-- Q18 - Create a stored procedure that accepts a department name as an IN parameter and displays all employees belonging to that department.
delimiter //
create procedure get_employees_by_departments (in dept_name varchar(30)) 
begin
select * from employees where department=dept_name;
end //
delimiter ;
call get_employees_by_departments('IT');

-- Q19 - Create a stored procedure that accepts a city as an IN parameter and displays employees from that city.
delimiter //
create procedure get_employees_by_city (in city_name varchar(30)) 
begin
select * from employees where city=city_name;
end //
delimiter ;
call get_employees_by_city('Hyderabad');

-- Q20 - Create a stored procedure that accepts a department name as an IN parameter and returns the number of employees in that department using an OUT parameter.
delimiter //
create procedure get_employees (in dept_name varchar(30),out number_of_employees int) 
begin
select count(employee_id) into number_of_employees 
from employees where department=dept_name ;
end //
delimiter ;
call get_employees('IT',@number_of_employees);
select @number_of_employees;

-- Q21 - Create a stored procedure that accepts a salary through an INOUT parameter and adds ₹5,000 to it.
delimiter //
create procedure adds_bonus ( inout get_bonus int) 
begin
set get_bonus=get_bonus+5000 ;
end //
delimiter ;
set @get_bonus=50000;
call adds_bonus(@get_bonus);
select @get_bonus;

-- Q22 - Create a stored procedure that accepts an employee's ID as an IN parameter and returns their salary through an OUT parameter.
delimiter //
create procedure get_employees_by_sal (in emp_id int ,out salaries int) 
begin
select salary into salaries from employees where employee_id=emp_id;
end //
delimiter ;
call get_employees_by_sal(1,@salaries);
select @salaries;

-- Q23 - Create a stored procedure that accepts a department name and salary amount as IN parameters,
-- then displays employees from that department whose salary is greater than the supplied amount.
delimiter //
create procedure get_dept_by_salaries (in dept_name varchar(30),in sal int) 
begin
select employee_name,salary,department from employees where department=dept_name and salary>sal;
end //
delimiter ;
call get_dept_by_salaries('IT',60000);

-- Q24 - Create a stored procedure that accepts a department name as an IN parameter and returns the average salary of that department through an OUT parameter.
delimiter //
create procedure gets_dept_by_avg_salary (in dept_name varchar(30),out avg_dept_salary int) 
begin
select avg(salary) into avg_dept_salary from employees where department=dept_name;
end //
delimiter ;
call gets_dept_by_avg_salary('HR',@avg_dept_salary);
select @avg_dept_salary;

/*
-- Q25 - Final Challenge: Create a result containing:
Employee name
Department
Salary
Department average salary
Department rank
Difference from department average
Previous employee salary based on joining date
Then display only employees who:
earn more than their department average,
have a department rank of 1 or 2,
and sort the final result by department and salary descending.
*/

with final_challenges as (
select employee_name,department,salary,avg(salary)over(partition by department )as dept_average_salary,
rank()over(partition by department order by salary desc) as dept_rank,
lag(salary,1) over (order by joining_date asc)as previous_employee_salary from employees) 
select employee_name,department,salary,dept_average_salary,dept_rank,(salary-dept_average_salary )as difference,
previous_employee_salary from final_challenges where salary>dept_average_salary and dept_rank <=2 order by department,salary desc;
