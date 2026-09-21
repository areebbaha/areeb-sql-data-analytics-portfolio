CREATE DATABASE CarePlus_hospital_db;

USE CarePlus_hospital_db;

-- 1. Patients Table
CREATE TABLE patients (
    patient_id VARCHAR(20) PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    patient_type VARCHAR(20) NOT NULL,
    preferred_time_slot VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL
);
-- 2. Doctors Table
CREATE TABLE doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    speciality VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    employment_type VARCHAR(20),
    is_active VARCHAR(3) NOT NULL
);
-- 3. Rooms Table
CREATE TABLE rooms (
    room_id VARCHAR(10) PRIMARY KEY,
    room_type VARCHAR(30) NOT NULL,
    floor INT NOT NULL,
    equipment_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    last_maintenance_date DATE NOT NULL,
    is_available VARCHAR(3) NOT NULL
);
-- 4. Appointments Table
CREATE TABLE appointments (
    appointment_id VARCHAR(20) PRIMARY KEY,
    patient_id VARCHAR(20) NOT NULL,
    appointment_date DATE NOT NULL,
    doctor_id VARCHAR(10) NOT NULL,
    service_type VARCHAR(30) NOT NULL,
    priority VARCHAR(10) NOT NULL,
    estimated_cost DECIMAL(10,2) NOT NULL,
    booking_channel VARCHAR(20) NOT NULL,
    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);
-- 5. Treatments Table
CREATE TABLE treatments (
    treatment_id VARCHAR(20) PRIMARY KEY,
    appointment_id VARCHAR(20) NOT NULL,
    doctor_id VARCHAR(10) NOT NULL,
    room_id VARCHAR(10) NOT NULL,
    actual_treatment_date DATE,
    status VARCHAR(20) NOT NULL,
    treatment_attempt INT NOT NULL,
    treatment_duration_min INT NOT NULL,
    waiting_time_min INT NOT NULL,
    treatment_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (appointment_id)
	    REFERENCES appointments(appointment_id),
    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id),
    FOREIGN KEY (room_id)
        REFERENCES rooms(room_id)
);
select * from treatments;
select * from rooms;
select * from doctors;
select * from appointments;
select * from patients;

-- 1.4  Analytical Thinking from the ER Diagram
-- 1. Management wants to identify patients who have booked multiple appointments. Which table and columns are needed?
-- ans:- table: Appointments 
-- columns: patient_id,appointment_id.
select patient_id,count(*) as appointment_count from appointments group by patient_id having appointment_count> 1;

-- 2. Operations wants to identify appointments that required more than one treatment attempt. Where is this information found?
-- ans:- table: treatments
-- columns : appointment_id,treatment_attempt
select appointment_id,max(treatment_attempt) max_treatment_attempt from treatments group by appointment_id having max_treatment_attempt>1;

-- 3. Patient Services wants to compare General, Corporate, and Insurance patients based on appointment activity. Which tables must be connected?
-- ans:- table: patients,appointments
-- columns: patient_type,appointment_id.
select p.patient_type,count(a.appointment_id) as appointment_count,count(distinct p.patient_id) as patient_count from patients p
 inner join appointments a on p.patient_id=a.patient_id group by p.patient_type;

-- 4. Operations wants to compare service types based on treatment duration and waiting time. Which tables are required?
-- ans:- table: appointments,treatments.
-- columns:service_type,treatment_id,treatment_duration_min,waiting_time_min
select a.service_type,count(treatment_id) as treatment_count,round(avg(t.treatment_duration_min),2) as avg_treatment_duration,
round(avg(t.waiting_time_min),2) as avg_waiting_time from appointments a inner join treatments t on a.appointment_id=t.appointment_id group by a.service_type;

-- 5. The team wants to identify which doctors handled treatments and examine their recorded ratings. What information is needed?
-- ans:- table:treatments,doctors
-- columns: treatment_id,doctor_id,rating
select d.doctor_id,d.doctor_name,d.speciality,d.rating,count(t.treatment_id) as treatment_count from doctors d 
inner join treatments t on t.doctor_id=d.doctor_id group by d.doctor_id,d.doctor_name,d.speciality,d.rating;

-- 6. Operations wants to understand whether different room/equipment types are used for different service types. Which tables and columns are required?
-- ans:- table:rooms,treatments,appointments.
-- columns:room_id,equipment_type,service_type
select r.room_id,r.equipment_type,a.service_type,count(t.treatment_id) as treatment_count from rooms r inner join treatments t on r.room_id=t.room_id 
inner join appointments a on t.appointment_id=a.appointment_id group by r.room_id,r.equipment_type,a.service_type;

-- 7. Management wants to compare treatment performance across cities. What information must be connected?
-- ans:- table:treatments,appointments,patients.
-- columns:treatment_id,status,city
select count(t.treatment_id) as treatment_count,t.status,p.city from treatments t inner join appointments a on t.appointment_id=a.appointment_id 
inner join  patients p on a.patient_id=p.patient_id group by p.city,t.status ;

-- 8. Operations wants to investigate whether higher-priority appointments have longer waiting times or different outcomes. What information is needed?
-- ans:- table:treatments,appointments.
-- columns:priority,treatment_id,waiting_time_min,status.
select a.priority,t.status,count(t.treatment_id) as treatment_count,round(avg(t.waiting_time_min),2) as avg_waiting_time from appointments a 
inner join treatments t on a.appointment_id=t.appointment_id group by a.priority,t.status;

-- 9. Management wants to understand whether treatment outcomes differ across service types. What tables and fields should be combined?
-- ans:- table:treatments,appointments.
-- columns:status,service_type
select t.status,a.service_type,count(t.treatment_id) as treatment_count from appointments a
 inner join treatments t on a.appointment_id=t.appointment_id group by t.status,a.service_type;

-- 10. The Patient Services team wants to connect each patient to their appointments and treatment outcomes. What relationships are required?
-- ans:- table:patients,appointments,treatments.
-- columns:patient_id,p.patient_name,appointment_id,status
select p.patient_id,p.patient_name,t.status from patients p inner join appointments a on p.patient_id=a.patient_id inner join treatments t on a.appointment_id=t.appointment_id ;


-- Sprint 3: Basic Analysis / Data Exploration

-- 1. What is the total number of patients?
select count(*) as total_patients from patients;

-- 2. What is the total number of appointments?
select count(*) as total_appointments from appointments;

-- 3. What is the total number of treatment records?
select count(*) AS total_treatment_records from treatments;

-- 4. What are the different medical service types?
select distinct service_type from appointments;

-- 5. How many doctors are currently active?
select count(is_active) as currently_active from doctors where is_active='yes';

-- 6. What are the different room types?
select distinct room_type from rooms;

-- 7. What is the total estimated appointment value?
select sum(estimated_cost) as estimated_value from appointments;

-- 8. What is the average treatment duration?
select round(avg(treatment_duration_min),2) as average_treatment_duration from treatments;

-- Sprint 4: Objective-Based Analysis
-- 4.1 Understand Patient and Appointment Demand

-- 1)Compare appointment volume across cities.
SELECT p.city,COUNT(a.appointment_id) AS appointment_volume FROM
patients p INNER JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.city ORDER BY appointment_volume DESC;

-- 2)Compare appointments across service types and priorities.
SELECT service_type,priority,
COUNT(appointment_id) AS appointment_count FROM appointments 
GROUP BY service_type,priority ORDER BY appointment_count DESC;

-- 3)Examine appointment volume over time.
select appointment_date,count(appointment_id) as appointment_volume from appointments
 group by appointment_date order by appointment_date asc;

-- 4)Compare estimated appointment value across patient types.
select p.patient_type,sum(a.estimated_cost) as total_estimated_value from patients p inner join appointments a on p.patient_id=a.patient_id 
group by p.patient_type order by total_estimated_value desc;

-- 5)Examine booking channels and their contribution to demand.
SELECT booking_channel,COUNT(appointment_id) AS appointment_count FROM appointments
GROUP BY booking_channel ORDER BY appointment_count DESC;

-- =========================================================
-- STUDENT-DEVELOPED ADVANCED ANALYTICS
-- Objective 4.1: Patient and Appointment Demand
-- =========================================================

-- Advanced Q1:
-- Which cities have appointment demand above the average appointment volume across all cities?
WITH city_appointments AS (
    SELECT p.city,COUNT(a.appointment_id) AS appointment_volume FROM patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id
    GROUP BY p.city)
SELECT city,appointment_volume FROM city_appointments
WHERE appointment_volume >(SELECT AVG(appointment_volume) FROM city_appointments)
ORDER BY appointment_volume DESC;

-- Advanced Q2:
-- Rank cities by appointment demand and calculate their percentage contribution to total appointments.
WITH city_appointments AS (
    SELECT p.city,COUNT(a.appointment_id) AS appointment_volume FROM patients p
    INNER JOIN appointments a ON p.patient_id = a.patient_id GROUP BY p.city
)
SELECT city,appointment_volume,
    RANK() OVER (ORDER BY appointment_volume DESC) AS city_rank,
    ROUND(appointment_volume * 100.0 /SUM(appointment_volume) OVER (),2) AS percentage_of_total
FROM city_appointments ORDER BY city_rank;

-- Advanced Q3:
-- Calculate monthly appointment volume and month-over-month percentage change.
WITH monthly_appointments AS (
SELECT DATE_FORMAT(appointment_date, '%Y-%m') AS appointment_month,
COUNT(appointment_id) AS appointment_volume FROM appointments
GROUP BY DATE_FORMAT(appointment_date, '%Y-%m')),
monthly_comparison AS (
SELECT appointment_month,appointment_volume,LAG(appointment_volume) OVER (ORDER BY appointment_month) 
AS previous_month_volume FROM monthly_appointments)
SELECT appointment_month,appointment_volume,previous_month_volume,
ROUND((appointment_volume - previous_month_volume)* 100.0 / previous_month_volume,2)AS month_over_month_growth_pct
FROM monthly_comparison ORDER BY appointment_month;

-- Advanced Q4:
-- Identify the dominant priority for each service type and calculate its percentage of that service's appointments.
WITH service_priority AS (
    SELECT service_type,priority,COUNT(appointment_id) AS appointment_count
    FROM appointments GROUP BY service_type, priority),
ranked_priorities AS (
SELECT service_type,priority,appointment_count,
RANK() OVER (PARTITION BY service_type ORDER BY appointment_count DESC) AS priority_rank,
SUM(appointment_count) OVER (PARTITION BY service_type) AS total_service_appointments FROM service_priority)
SELECT service_type,priority,appointment_count,
ROUND(appointment_count * 100.0 /total_service_appointments,2) AS percentage_of_service_appointments
FROM ranked_priorities WHERE priority_rank = 1 ORDER BY service_type;

-- Advanced Q5:
-- Calculate booking channel demand, percentage contribution and cumulative percentage of total appointments.
WITH channel_demand AS (
SELECT booking_channel,COUNT(appointment_id) AS appointment_count
FROM appointments GROUP BY booking_channel)
SELECT booking_channel,appointment_count,
ROUND(appointment_count * 100.0 /SUM(appointment_count) OVER (),2) AS percentage_of_total,
ROUND(SUM(appointment_count) OVER (
ORDER BY appointment_count DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) * 100.0 /SUM(appointment_count) OVER (),2) AS cumulative_percentage
FROM channel_demand ORDER BY appointment_count DESC;

/*
============================================================
              BUSINESS FINDINGS & ANALYTICS
              CAREPLUS HOSPITAL
============================================================

============================================================
4.1 PATIENT AND APPOINTMENT DEMAND
============================================================

FINDING 1 - Appointment demand varies across cities
Kochi recorded the highest appointment volume with 440 appointments, followed by Mumbai with 393 and Chennai with 386 appointments.
Pune recorded the lowest volume with 334 appointments.

BUSINESS INSIGHT:
The difference in appointment volume shows that patient demand is not evenly distributed geographically.
Management can use city-level appointment demand to plan doctor availability, staffing and other operational resources.

------------------------------------------------------------

FINDING 2 - Routine Consultation is the dominant service
Routine Consultation recorded the highest service-priority combination with 860 appointments. 
Other high-volume combinations included Routine Diagnostic Tests with 451 appointments and Routine Follow-ups with 399 appointments.

BUSINESS INSIGHT:
Routine consultations represent a major portion of hospital
appointment demand. Sufficient consultation capacity and
appropriate scheduling availability are therefore important
for maintaining smooth patient flow.

------------------------------------------------------------

FINDING 3 - General patients contribute the highest estimated appointment value
General patients generated approximately Rs. 75.66 lakh in total estimated appointment value, compared with approximately Rs. 38.18 lakh from 
Insurance patients and Rs. 29.48 lakh from Corporate patients.

BUSINESS INSIGHT:
General patients represent the largest estimated appointment-value segment in this dataset.
 Management can monitor this segment while also understanding the different appointment behaviour of Insurance and Corporate patients.

------------------------------------------------------------

FINDING 4 - The App is the largest booking channel
The App generated 887 appointments, followed by Website with 612, Phone with 559, Walk-in with 557 and Referral with 385 appointments.

BUSINESS INSIGHT:
The App is the largest appointment booking channel in the dataset. 
This indicates that digital booking is an important source of patient demand and should be considered when planning appointment capacity.

------------------------------------------------------------

FINDING 5 - Appointment demand changes over time
Appointment volume changes across different periods rather than remaining constant. 
July 2025 recorded the highest monthly appointment volume with 276 appointments.

BUSINESS INSIGHT:
Monitoring appointment demand over time helps management identify high-demand periods and prepare appropriate staffing and appointment capacity.
*/

-- 4.2 Understand Patient Appointment Behaviour

-- 1)Compare patients by number of appointments.
SELECT patient_id,COUNT(appointment_id) AS appointment_count FROM 
appointments GROUP BY patient_id ORDER BY appointment_count DESC;

-- 2)Identify patients with higher cumulative estimated appointment value.
SELECT patient_id,SUM(estimated_cost) AS total_estimated_value FROM 
appointments GROUP BY patient_id ORDER BY total_estimated_value DESC;

-- 3)Compare patient activity across cities.
SELECT p.city,COUNT(a.appointment_id) AS appointment_volume
FROM patients p JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.city ORDER BY appointment_volume DESC;

-- 4)Compare General, Corporate, and Insurance patients.
SELECT p.patient_type,COUNT(a.appointment_id) AS appointment_count FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_type ORDER BY appointment_count DESC;

-- 5)Examine patient booking patterns over time.
SELECT appointment_date,COUNT(DISTINCT patient_id) AS active_patients,
COUNT(appointment_id) AS appointment_count FROM appointments
GROUP BY appointment_date ORDER BY appointment_date;

-- =========================================================
-- STUDENT-DEVELOPED ADVANCED ANALYTICS
-- Objective 4.2: Patient Appointment Behaviour
-- =========================================================

-- Advanced Q1:
-- Patients whose appointment count is above the average appointment count per patient
WITH patient_appointments AS (
    SELECT patient_id,COUNT(appointment_id) AS appointment_count FROM appointments
    GROUP BY patient_id)
SELECT patient_id,appointment_count FROM patient_appointments
WHERE appointment_count >(SELECT AVG(appointment_count) FROM patient_appointments)
ORDER BY appointment_count DESC;

-- Advanced Q2:
-- Rank patients by appointment activity within each patient type
WITH patient_activity AS (
SELECT p.patient_id,p.patient_name,p.patient_type,
COUNT(a.appointment_id) AS appointment_count
FROM patients p INNER JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id,p.patient_name,p.patient_type
)
SELECT
patient_id,patient_name,patient_type,appointment_count,
RANK() OVER (PARTITION BY patient_type ORDER BY appointment_count DESC) AS patient_rank
FROM patient_activity
ORDER BY patient_type, patient_rank;

-- Advanced Q3:
-- Rank patients by cumulative estimated appointment value within each patient type
WITH patient_value AS (
SELECT p.patient_id,p.patient_name,p.patient_type,
SUM(a.estimated_cost) AS total_estimated_value
FROM patients p INNER JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id,p.patient_name,p.patient_type),
ranked_patients AS (
SELECT patient_id,patient_name,patient_type,total_estimated_value,
RANK() OVER (PARTITION BY patient_type ORDER BY total_estimated_value DESC) AS value_rank FROM patient_value)
SELECT patient_id,patient_name,patient_type,total_estimated_value,value_rank
FROM ranked_patients WHERE value_rank <= 3 ORDER BY patient_type, value_rank;

-- Advanced Q4:
-- Calculate the number of days between consecutive appointments for each patient
WITH patient_appointments AS (
SELECT patient_id,appointment_id,appointment_date,
LAG(appointment_date) OVER (PARTITION BY patient_id ORDER BY appointment_date) AS previous_appointment_date FROM appointments)
SELECT patient_id,appointment_id,appointment_date,previous_appointment_date,
DATEDIFF(appointment_date,previous_appointment_date) AS days_since_previous_appointment FROM patient_appointments
WHERE previous_appointment_date IS NOT NULL
ORDER BY patient_id, appointment_date;

-- Advanced Q5:
-- Compare active patient volume month over month
WITH monthly_patient_activity AS (
SELECT DATE_FORMAT(appointment_date, '%Y-%m') AS appointment_month,
COUNT(DISTINCT patient_id) AS active_patients FROM appointments
GROUP BY DATE_FORMAT(appointment_date, '%Y-%m')
),
monthly_comparison AS (SELECT appointment_month,active_patients,
LAG(active_patients) OVER (ORDER BY appointment_month) AS previous_month_active_patients
 FROM monthly_patient_activity)
SELECT appointment_month,active_patients,previous_month_active_patients,
(active_patients - previous_month_active_patients) AS change_in_active_patients
FROM monthly_comparison ORDER BY appointment_month;
/*
============================================================
            BUSINESS FINDINGS & ANALYTICS
			CAREPLUS HOSPITAL
============================================================

===========================================================
4.2 PATIENT APPOINTMENT BEHAVIOUR
============================================================

FINDING 1 - Patients have different levels of appointment activity
The dataset contains 400 patients and 3,000 appointments, resulting in an average of 7.5 appointments per patient.
 Some patients have considerably more appointments than the average, with highly active patients reaching up to 15 appointments.

BUSINESS INSIGHT:
The difference in appointment frequency indicates that patient engagement is not uniform.
Identifying highly active patients can help the hospital understand recurring healthcare requirements and manage appointment demand more effectively.

------------------------------------------------------------

FINDING 2 - A small group of patients contributes higher estimated appointment value
Some patients contribute significantly higher cumulative estimated appointment values than others.
 The highest-value patients include P0216 with approximately Rs. 81,348, P0069 with approximately Rs. 76,950, and P0289 with approximately Rs. 74,213.

BUSINESS INSIGHT:
A relatively small group of patients contributes a higher estimated appointment value. 
Understanding the appointment behaviour of these patients can help management monitor recurring services and patient engagement.

------------------------------------------------------------

FINDING 3 - Patient activity varies across cities
Kochi recorded the highest appointment activity with 440 appointments, while Pune recorded 334 appointments among the analyzed cities.

BUSINESS INSIGHT:
Patient activity differs geographically across the hospital's service locations. 
City-level patient activity can help management understand where appointment demand is concentrated and plan resources accordingly.

------------------------------------------------------------

FINDING 4 - General patients represent the largest patient group
General patients generated 1,594 appointments, followed by Insurance patients with 791 appointments and Corporate patients with 615 appointments.

BUSINESS INSIGHT:
General patients account for the largest share of appointment activity in the dataset.
 Management can monitor the requirements of this group while also understanding the different appointment patterns of Insurance and Corporate patients.

------------------------------------------------------------

FINDING 5 - Patient activity changes over time
The number of active patients and appointments varies across different dates and periods. 
This indicates that patient booking activity does not remain constant throughout the observation period.

BUSINESS INSIGHT:
Monitoring patient activity over time can help the hospital identify periods of higher patient engagement and support better appointment scheduling and resource planning.
*/
-- 4.3 Evaluate Treatment Performance

-- 1)Compare treatment outcomes across cities.
SELECT p.city,t.status,COUNT(t.treatment_id) AS treatment_count
FROM patients p INNER JOIN appointments a ON
 p.patient_id = a.patient_id INNER JOIN treatments t ON
 a.appointment_id = t.appointment_id GROUP BY p.city, t.status 
 ORDER BY p.city, treatment_count DESC;

-- 2)Examine treatment duration and waiting time.
SELECT round(AVG(treatment_duration_min),2) AS 
average_treatment_duration,
round(AVG(waiting_time_min),2) AS average_waiting_time
 FROM treatments;

-- 3)Compare Completed, Cancelled, No-Show, Rescheduled, and In Progress outcomes.
SELECT status,COUNT(treatment_id) AS treatment_count FROM treatments
GROUP BY status ORDER BY treatment_count DESC;

-- 4)Identify areas with higher treatment activity or poorer outcomes.
SELECT p.city,COUNT(t.treatment_id) AS total_treatments,
SUM(CASE 
        WHEN t.status IN ('Cancelled', 'No-Show', 'Rescheduled') 
        THEN 1 ELSE 0 
    END) AS unsuccessful_treatments,
ROUND(100 * SUM(
            CASE
                WHEN t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
                THEN 1 ELSE 0
            END) / COUNT(t.treatment_id),2) AS unsuccessful_rate
FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
INNER JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY p.city ORDER BY unsuccessful_rate DESC;

-- 5)Compare treatment performance over time.
SELECT actual_treatment_date,
COUNT(treatment_id) AS treatment_count,
ROUND(AVG(treatment_duration_min), 2) AS avg_duration,
ROUND(AVG(waiting_time_min), 2) AS avg_waiting_time
FROM treatments WHERE actual_treatment_date IS NOT NULL
GROUP BY actual_treatment_date ORDER BY actual_treatment_date;

-- =========================================================
-- STUDENT-DEVELOPED ADVANCED ANALYTICS
-- Objective 4.3:  Evaluate Treatment Performance
-- =========================================================

-- ADVANCED Q1:
-- How does the monthly treatment completion rate change over time, and what is the running average completion rate?

WITH monthly_performance AS (
SELECT DATE_FORMAT(actual_treatment_date, '%Y-%m') AS treatment_month,COUNT(*) AS total_treatments,
SUM(CASE WHEN status = 'Completed' THEN 1
	ELSE 0 END) AS completed_treatments,
ROUND(100 * SUM(CASE WHEN status = 'Completed' THEN 1
	ELSE 0 END) / COUNT(*),2) AS completion_rate
FROM treatments WHERE actual_treatment_date IS NOT NULL
GROUP BY DATE_FORMAT(actual_treatment_date, '%Y-%m'))
SELECT treatment_month,total_treatments,completed_treatments,completion_rate,
ROUND(AVG(completion_rate) OVER (ORDER BY treatment_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) 
AS running_avg_completion_rate FROM monthly_performance ORDER BY treatment_month;

-- ADVANCED Q2:
-- Which cities have the highest and lowest treatment completion rates, and how do they rank against each other?
WITH city_performance AS (
    SELECT p.city,COUNT(t.treatment_id) AS total_treatments,
        SUM(CASE
                WHEN t.status = 'Completed' THEN 1
                ELSE 0
                END) AS completed_treatments,
ROUND(100 * SUM(CASE
				WHEN t.status = 'Completed' THEN 1
				ELSE 0 
				END) / COUNT(t.treatment_id),2) AS completion_rate
FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
INNER JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY p.city)
SELECT city,total_treatments,completed_treatments,completion_rate,
RANK() OVER (ORDER BY completion_rate DESC) AS city_rank
FROM city_performance
ORDER BY city_rank;

-- ADVANCED Q3:
-- Which doctors have an average treatment duration higher than the average duration of doctors in their own specialty?
WITH doctor_performance AS (
    SELECT d.doctor_id,d.doctor_name,d.speciality,
COUNT(t.treatment_id) AS treatment_count,
ROUND(AVG(t.treatment_duration_min),2) AS avg_treatment_duration
FROM doctors d
INNER JOIN treatments t ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,d.doctor_name,d.speciality),

specialty_comparison AS (
    SELECT *,ROUND(AVG(avg_treatment_duration) OVER (PARTITION BY speciality),2) AS specialty_avg_duration
FROM doctor_performance)

SELECT doctor_id,doctor_name,speciality,treatment_count,avg_treatment_duration,specialty_avg_duration,
ROUND(avg_treatment_duration - specialty_avg_duration,2) AS difference_from_specialty_avg
FROM specialty_comparison WHERE avg_treatment_duration > specialty_avg_duration
ORDER BY difference_from_specialty_avg DESC;

-- ADVANCED Q4:
-- For appointments requiring multiple treatment attempts, how many days passed between each treatment attempt?
WITH treatment_history AS (
    SELECT treatment_id,appointment_id,treatment_attempt,actual_treatment_date,status,
LAG(actual_treatment_date) OVER (PARTITION BY appointment_id ORDER BY actual_treatment_date) AS previous_treatment_date
    FROM treatments WHERE actual_treatment_date IS NOT NULL)
SELECT appointment_id,treatment_id,treatment_attempt,actual_treatment_date,previous_treatment_date,
    DATEDIFF(actual_treatment_date,previous_treatment_date) AS days_since_previous_attempt,status
FROM treatment_history WHERE previous_treatment_date IS NOT NULL
ORDER BY appointment_id, actual_treatment_date;

-- ADVANCED Q5:
-- Which treatments had waiting times higher than the overall average and how did their treatment duration compare with the overall average?
WITH treatment_benchmark AS (SELECT AVG(waiting_time_min) AS avg_waiting_time,
AVG(treatment_duration_min) AS avg_treatment_duration FROM treatments)
SELECT t.treatment_id,t.appointment_id,t.waiting_time_min,t.treatment_duration_min,t.status,
ROUND(b.avg_waiting_time, 2) AS overall_avg_waiting_time,
ROUND(b.avg_treatment_duration, 2) AS overall_avg_treatment_duration,
ROUND(t.waiting_time_min - b.avg_waiting_time,2) AS waiting_time_difference
FROM treatments t CROSS JOIN treatment_benchmark b WHERE t.waiting_time_min > b.avg_waiting_time
ORDER BY waiting_time_difference DESC;

/*
============================================================
              BUSINESS FINDINGS & ANALYTICS
              CAREPLUS HOSPITAL
============================================================


============================================================
4.3 TREATMENT PERFORMANCE
============================================================

FINDING 1 - Completed treatments are the dominant outcome
The treatment dataset contains 3,500 treatment records.
The major treatment outcomes were:

Completed    - 2,464
Rescheduled  - 366
Cancelled    - 283
No-Show      - 251
In Progress  - 136
Approximately 70.4% of treatment records were completed.

BUSINESS INSIGHT:
Completed treatments represent the majority of treatment records.
 However, rescheduled, cancelled, no-show and in-progress treatments together represent a significant operational area that should be monitored.

------------------------------------------------------------

FINDING 2 - Treatment completion performance varies across cities

Delhi recorded the highest treatment completion rate at approximately 72.27%, followed by Hyderabad at approximately 71.56% and Vijayawada at approximately 71.53%.
Kochi recorded the lowest completion rate at approximately 68.46%.

BUSINESS INSIGHT:
Treatment completion performance differs between cities.
Locations with relatively lower completion rates can be investigated further to understand possible scheduling,staffing or patient-flow factors.

------------------------------------------------------------

FINDING 3 - Treatment duration and waiting time provide important operational benchmarks
The overall average treatment duration is approximately 38.72 minutes, while the average waiting time is approximately 15.62 minutes.

BUSINESS INSIGHT:
These averages can be used as operational benchmarks.
Management can compare individual doctors, rooms, cities and time periods against these overall values to identify areas requiring further investigation.

------------------------------------------------------------

FINDING 4 - High treatment activity does not necessarily mean better treatment outcomes
Kochi handled approximately 520 treatment records, making it one of the higher-activity cities, but it did not have the highest completion rate.

BUSINESS INSIGHT:
Treatment volume and treatment outcome should be analyzed together.
 A location handling a large number of treatments should not automatically be considered to have better performance.

------------------------------------------------------------

FINDING 5 - Treatment performance can be monitored over time
The monthly treatment analysis tracks total treatments,completed treatments, completion rate and the running average completion rate.

BUSINESS INSIGHT:
Monitoring treatment performance over time allows management to identify periods where treatment outcomes improve or decline
 and investigate the operational reasons behind those changes.
 */

-- 4.4 Understand Doctor and Room Performance

-- 1)Compare the number of treatments handled by doctors.
SELECT d.doctor_id,d.doctor_name,d.speciality,
COUNT(t.treatment_id) AS treatment_count
FROM doctors d INNER JOIN treatments t ON 
d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,d.doctor_name,d.speciality
ORDER BY treatment_count DESC;

-- 2)Compare doctor performance across treatment outcomes.
SELECT doctor_id,status,COUNT(treatment_id) AS treatment_count
FROM treatments GROUP BY doctor_id, status
ORDER BY doctor_id, treatment_count DESC;

-- 3)Examine treatment duration across doctors.
SELECT d.doctor_id,d.doctor_name,d.speciality,
ROUND(AVG(t.treatment_duration_min), 2) AS average_treatment_duration
FROM doctors d INNER JOIN treatments t ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,d.doctor_name,d.speciality
ORDER BY average_treatment_duration DESC;

-- 4)Compare room usage across room types and equipment types.
SELECT r.room_type,r.equipment_type,COUNT(t.treatment_id)
AS treatment_count FROM rooms r JOIN treatments t 
ON r.room_id = t.room_id
GROUP BY r.room_type, r.equipment_type
ORDER BY treatment_count DESC;

-- 5)Evaluate treatment performance across rooms.
SELECT room_id,COUNT(treatment_id) AS treatment_count,
round(AVG(treatment_duration_min),2) AS average_treatment_duration,
round(AVG(waiting_time_min),2) AS average_waiting_time 
FROM treatments
GROUP BY room_id ORDER BY treatment_count DESC;

-- =========================================================
-- STUDENT-DEVELOPED ADVANCED ANALYTICS
-- Objective 4.4:  Doctor and Room Performance
-- =========================================================

-- ADVANCED Q1:
-- How do doctors rank within their respective specialties based on the number of treatments they handle?
SELECT d.doctor_id,d.doctor_name,d.speciality,
COUNT(t.treatment_id) AS treatment_count,
RANK() OVER (PARTITION BY d.speciality ORDER BY COUNT(t.treatment_id) DESC) AS specialty_rank 
FROM doctors d INNER JOIN treatments t ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,d.doctor_name,d.speciality ORDER BY d.speciality,specialty_rank;

-- ADVANCED Q2:    
-- Which doctors have a treatment completion rate higher than the average completion rate of all doctors?
WITH doctor_performance AS (
SELECT d.doctor_id,d.doctor_name,d.speciality,
COUNT(t.treatment_id) AS total_treatments,
SUM(CASE
	WHEN t.status = 'Completed' THEN 1
	ELSE 0
	END) AS completed_treatments,
ROUND(100 * SUM(
CASE
WHEN t.status = 'Completed' THEN 1
ELSE 0
END) / COUNT(t.treatment_id),2) AS completion_rate
FROM doctors d
INNER JOIN treatments t ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,doctor_name,d.speciality
),
with_average AS (
SELECT *,ROUND(AVG(completion_rate) OVER (),2) AS average_doctor_completion_rate
FROM doctor_performance)
SELECT doctor_id,doctor_name,speciality,total_treatments,completed_treatments,completion_rate,average_doctor_completion_rate,
ROUND(completion_rate - average_doctor_completion_rate,2) AS difference_from_average
FROM with_average
WHERE completion_rate > average_doctor_completion_rate
ORDER BY difference_from_average DESC;

-- ADVANCED Q3
-- Which doctors have an average treatment duration higher than the average duration of doctors in their specialty?
WITH doctor_duration AS (
SELECT d.doctor_id,d.doctor_name,d.speciality,
COUNT(t.treatment_id) AS treatment_count,
ROUND(AVG(t.treatment_duration_min),2) AS avg_treatment_duration
FROM doctors d INNER JOIN treatments t ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id,d.doctor_name,d.speciality
),
specialty_comparison AS (
SELECT *,ROUND(AVG(avg_treatment_duration) OVER (PARTITION BY speciality),2) AS specialty_avg_duration
FROM doctor_duration)
SELECT doctor_id,doctor_name,speciality,treatment_count,avg_treatment_duration,specialty_avg_duration,
ROUND(avg_treatment_duration - specialty_avg_duration,2) AS difference_from_specialty_avg
FROM specialty_comparison
WHERE avg_treatment_duration > specialty_avg_duration
ORDER BY difference_from_specialty_avg DESC;

-- ADVANCED Q4:
-- Which rooms have both a high treatment workload and above-average patient waiting time?
WITH room_performance AS (SELECT room_id,COUNT(treatment_id) AS treatment_count,
ROUND(AVG(waiting_time_min),2) AS avg_waiting_time,
ROUND(AVG(treatment_duration_min),2) AS avg_treatment_duration FROM treatments GROUP BY room_id ),
benchmarks AS (SELECT AVG(treatment_count) AS avg_room_treatment_count, AVG(avg_waiting_time) AS avg_room_waiting_time FROM room_performance)
SELECT r.room_id,r.treatment_count,r.avg_waiting_time,r.avg_treatment_duration,
ROUND(b.avg_room_treatment_count, 2) AS overall_avg_room_treatment_count,
ROUND(b.avg_room_waiting_time, 2) AS overall_avg_room_waiting_time FROM room_performance r CROSS JOIN benchmarks b
WHERE r.treatment_count > b.avg_room_treatment_count AND r.avg_waiting_time > b.avg_room_waiting_time ORDER BY r.treatment_count DESC;

-- ADVANCED Q5:
-- How does each doctor's monthly treatment workload change compared with the previous month?
WITH monthly_doctor_workload AS (
SELECT doctor_id,DATE_FORMAT(actual_treatment_date, '%Y-%m') AS treatment_month,
COUNT(treatment_id) AS treatment_count
FROM treatments
WHERE actual_treatment_date IS NOT NULL
GROUP BY doctor_id,
DATE_FORMAT(actual_treatment_date, '%Y-%m')
),
workload_change AS (
SELECT doctor_id,treatment_month,treatment_count,
LAG(treatment_count) OVER (PARTITION BY doctor_id ORDER BY treatment_month) AS previous_month_treatments
FROM monthly_doctor_workload
)
SELECT doctor_id,treatment_month,treatment_count,previous_month_treatments,
(treatment_count - previous_month_treatments) AS change_from_previous_month
FROM workload_change
ORDER BY doctor_id,treatment_month;

/*
============================================================
            BUSINESS FINDINGS & ANALYTICS
			CAREPLUS HOSPITAL
============================================================

============================================================
4.4 DOCTOR AND ROOM PERFORMANCE
============================================================

FINDING 1 - Doctor workload is not evenly distributed
Treatment volumes differ across doctors.
 Doctor D080 handled 66 treatments, while other highly active doctors handled approximately 58 to 59 treatments.

BUSINESS INSIGHT:
Treatment workload is not equally distributed among doctors.
Workload analysis can help management identify workload concentration and evaluate whether scheduling adjustments are required.

------------------------------------------------------------

FINDING 2 - Doctor performance should be evaluated using multiple metrics
Doctor performance can be analyzed using treatment count,completed treatment count and treatment completion rate.

BUSINESS INSIGHT:
Treatment count alone does not provide a complete view of doctor performance.
 Combining workload with treatment outcomes provides a more meaningful operational analysis.

------------------------------------------------------------

FINDING 3 - Treatment duration differs across doctors
The analysis calculates average treatment duration for each doctor
 and compares individual doctor duration against the average duration of doctors within the same specialty.

BUSINESS INSIGHT:
Differences in treatment duration can help identify doctors or specialties that require further operational review.
However, longer treatment duration does not automatically indicate poorer performance because treatment complexity may differ.

------------------------------------------------------------

FINDING 4 - Room utilization is uneven
The average room workload is approximately 70 treatment records. 
Some rooms recorded substantially higher activity, including R006 with 88 treatments, R007 with 86 treatments and R005 with 84 treatments.

BUSINESS INSIGHT:
Some rooms are utilized more heavily than others.
Management can monitor highly utilized rooms to ensure that room capacity, equipment availability and scheduling are sufficient.

------------------------------------------------------------

FINDING 5 - High workload and waiting time can indicate potential room bottlenecks
The advanced room analysis identifies rooms where treatment workload is above the average room workload
 and average waiting time is also above the overall room benchmark.

BUSINESS INSIGHT:
Rooms with both high workload and high waiting time deserve additional operational attention because they may indicate potential capacity or scheduling bottlenecks.
*/

-- 4.5 Identify Treatment and Appointment Problems

-- 1)Identify appointments requiring multiple treatment attempts.
SELECT appointment_id,COUNT(treatment_id) AS treatment_count,
MAX(treatment_attempt) AS maximum_attempts FROM treatments
GROUP BY appointment_id HAVING MAX(treatment_attempt) > 1
ORDER BY maximum_attempts DESC;

-- 2)Find common problem statuses and patterns.
SELECT status,COUNT(treatment_id) AS treatment_count
FROM treatments WHERE status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY status ORDER BY treatment_count DESC;

-- 3)Compare waiting time for appointments with multiple attempts.
SELECT appointment_id,
MAX(treatment_attempt) AS maximum_attempts,
ROUND(AVG(waiting_time_min), 2) AS average_waiting_time
FROM treatments
GROUP BY appointment_id HAVING MAX(treatment_attempt) > 1
ORDER BY average_waiting_time DESC;

-- 4)Identify cities or service types with more cancellations, no-shows, or rescheduling.
SELECT p.city,a.service_type,t.status,
COUNT(t.treatment_id) AS problem_count
FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
INNER JOIN treatments t ON a.appointment_id = t.appointment_id
WHERE t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
GROUP BY p.city,a.service_type,t.status
ORDER BY problem_count DESC;

-- 5)Investigate whether priority level is associated with waiting time or treatment outcomes.
SELECT a.priority,t.status,COUNT(t.treatment_id) AS
treatment_count,ROUND(AVG(t.waiting_time_min), 2)
AS average_waiting_time FROM appointments a
INNER JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY a.priority,t.status 
ORDER BY a.priority,treatment_count DESC;

-- =========================================================
-- STUDENT-DEVELOPED ADVANCED ANALYTICS
-- Objective 4.5:Treatment and Appointment Problems
-- =========================================================

-- Advanced Q1 
-- Are repeated treatment attempts associated with longer waiting times?
WITH appointment_attempts AS (
SELECT appointment_id,
MAX(treatment_attempt) AS maximum_attempts,
AVG(waiting_time_min) AS average_waiting_time
FROM treatments GROUP BY appointment_id
)
SELECT CASE
WHEN maximum_attempts > 1 THEN 'Multiple Attempts'
ELSE 'Single Attempt'
END AS attempt_category,
COUNT(*) AS appointment_count,
ROUND(AVG(average_waiting_time), 2) AS average_waiting_time
FROM appointment_attempts
GROUP BY CASE
WHEN maximum_attempts > 1 THEN 'Multiple Attempts'
ELSE 'Single Attempt' 
END;
    
-- Advanced Q2 
-- Which cities have an above-average problem rate?
WITH city_performance AS (SELECT p.city,COUNT(t.treatment_id) AS total_treatments,
SUM(CASE WHEN t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
THEN 1 ELSE 0 END) AS problem_treatments FROM patients p INNER JOIN appointments a ON 
p.patient_id = a.patient_id INNER JOIN treatments t ON a.appointment_id = t.appointment_id GROUP BY p.city),
city_rates AS (SELECT *,ROUND(100.0 * problem_treatments / total_treatments,2) AS problem_rate FROM city_performance),
overall_average AS (SELECT AVG(problem_rate) AS average_problem_rate FROM city_rates )
SELECT c.city,c.total_treatments,c.problem_treatments,c.problem_rate,
ROUND(o.average_problem_rate, 2) AS overall_average_problem_rate FROM city_rates c
CROSS JOIN overall_average o WHERE c.problem_rate > o.average_problem_rate ORDER BY c.problem_rate DESC;

-- Advanced Q3 
-- Which priority level has the highest problem rate?
WITH priority_analysis AS (
SELECT a.priority,COUNT(t.treatment_id) AS total_treatments,
SUM(CASE
	WHEN t.status IN ('Cancelled', 'No-Show', 'Rescheduled')
	THEN 1 ELSE 0
	END) AS problem_treatments
FROM appointments a INNER JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY a.priority)
SELECT priority,total_treatments,problem_treatments,
ROUND(100.0 * problem_treatments / total_treatments,2) AS problem_rate
FROM priority_analysis ORDER BY problem_rate DESC;

-- Advanced Q4
-- Find patients who have both repeated treatment attempts and high waiting time
WITH patient_problems AS (SELECT p.patient_id,p.patient_name,
COUNT(DISTINCT t.appointment_id) AS appointment_count,MAX(t.treatment_attempt) AS maximum_attempts,
ROUND(AVG(t.waiting_time_min),2) AS average_waiting_time FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id INNER JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY p.patient_id,p.patient_name)
SELECT patient_id,patient_name,appointment_count,maximum_attempts,average_waiting_time FROM patient_problems
WHERE maximum_attempts > 1 AND average_waiting_time >
(SELECT AVG(average_waiting_time) FROM patient_problems) ORDER BY average_waiting_time DESC;

-- Advanced Q5
-- Analyze problem trends over time
WITH monthly_problems AS (
SELECT DATE_FORMAT(actual_treatment_date, '%Y-%m') AS treatment_month,
COUNT(treatment_id) AS total_treatments,
SUM(CASE
WHEN status IN ('Cancelled', 'No-Show', 'Rescheduled')
THEN 1 ELSE 0
END) AS problem_treatments
FROM treatments WHERE actual_treatment_date IS NOT NULL
GROUP BY DATE_FORMAT(actual_treatment_date, '%Y-%m')),
problem_trend AS (
SELECT treatment_month,total_treatments,problem_treatments,
LAG(problem_treatments) OVER (ORDER BY treatment_month) AS previous_month_problems
FROM monthly_problems)
SELECT treatment_month,total_treatments,problem_treatments,previous_month_problems,
(problem_treatments - previous_month_problems)AS change_from_previous_month
FROM problem_trend ORDER BY treatment_month;

/*
============================================================
            BUSINESS FINDINGS & ANALYTICS
			CAREPLUS HOSPITAL
============================================================

============================================================
4.5 TREATMENT AND APPOINTMENT PROBLEMS
============================================================

FINDING 1 - Multiple treatment attempts require monitoring 500 out of 3,000 appointments had more than one treatment attempt, representing approximately 16.7% of appointments.
The average waiting time was approximately:
Multiple Attempts - 15.96 minutes
Single Attempt   - 15.48 minutes

BUSINESS INSIGHT:
Appointments requiring multiple treatment attempts showed slightly higher average waiting time in this dataset.
However, the difference is relatively small and does not by itself prove that repeated attempts cause longer waiting times.

------------------------------------------------------------

FINDING 2 - Rescheduling is the most common problem status
The problem-status counts were approximately:
Rescheduled - 366
Cancelled   - 283
No-Show     - 251

BUSINESS INSIGHT:
Rescheduling is the most frequent problem category.
Management can investigate why appointments are being rescheduled and whether specific cities, services or periods experience higher rescheduling activity.

------------------------------------------------------------

FINDING 3 - Problem rates differ across cities
The highest problem rates were observed in:
Bengaluru - approximately 26.96%
Pune      - approximately 26.65%
Kochi     - approximately 26.35%
Delhi recorded a lower problem rate of approximately
23.70%.

BUSINESS INSIGHT:
Problem rates vary across cities. 
Locations with higher problem rates can be investigated further to identify patterns related to cancellations, no-shows and rescheduling.

------------------------------------------------------------

FINDING 4 - Problem rates are relatively similar across priority levels
The observed problem rates were approximately:
High     - 25.80%
Routine  - 25.77%
Urgent   - 25.00%

BUSINESS INSIGHT:
The problem rates are relatively close across priority categories.
 Therefore, this dataset does not show a large difference in problem rate based only on appointment priority.

------------------------------------------------------------

FINDING 5 - Problem rates fluctuate over time
Monthly problem rates vary across the analysis period.
September 2025 recorded a relatively high problem rate of approximately 27.88%, while June recorded approximately 20.69%.

BUSINESS INSIGHT:
Operational problems fluctuate over time. Monthly monitoring of cancellations, no-shows and rescheduling can help management identify periods 
with unusually high operational problems and investigate their underlying causes.
*/


/*
============================================================
FINAL BUSINESS CONCLUSION
============================================================

The Hospital Patient Care Operations Analytics project demonstrates how relational healthcare data can be transformed
into meaningful operational insights using MySQL.

The analysis examined patient demand, appointment behaviour,treatment performance, doctor and room utilization, and
treatment-related operational problems.

The analysis identified differences in appointment demand across cities, patient types and booking channels. 
It also highlighted variations in treatment completion rates, doctor workload, room utilization and appointment problem rates.

The advanced analytical queries further demonstrate the use of CTEs, subqueries and window functions to compare entities against averages,
rank entities, analyze changes over time and identify operational patterns.

Overall, the project demonstrates the complete analytical process from understanding a healthcare business requirement to designing a relational database,
 writing SQL queries, interpreting results and communicating meaningful business insights.
 
============================================================
PRACTICAL RECOMMENDATIONS
============================================================

1. Monitor appointment demand by city and align staffing and appointment capacity with demand.

2. Monitor digital booking channels, particularly the App, because they represent an important source of appointment demand in the dataset.

3. Track treatment completion rates across cities and investigate locations with relatively lower completion performance.

4. Monitor doctor workload and treatment outcomes together rather than evaluating workload alone.

5. Monitor highly utilized rooms and rooms with high waiting times to identify possible capacity or scheduling issues.

6. Investigate the reasons behind cancellations, no-shows and rescheduling, particularly in locations or periods with higher problem rates.

7. Continue monthly monitoring of appointment demand,patient activity, treatment completion and operational problem rates to identify changes early.

============================================================
END OF BUSINESS FINDINGS & ANALYTICS
============================================================
*/