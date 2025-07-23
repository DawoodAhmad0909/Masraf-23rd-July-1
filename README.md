# Fitness center management system
## Overview 

This fitness center database is designed to manage member engagement, trainer assignments, workout plans, sessions, and payments efficiently. It consists of five interconnected tables:

1. members
Stores personal and membership information of individuals enrolled at the fitness center, including their active status and membership tier (Basic, Premium, or VIP).

2. trainers
Captures trainer details, including their specialization, certification, hire date, and hourly rates.

3. workoutPlans
Lists structured workout programs tailored to different goals, difficulty levels, and durations — including seasonal and religiously themed plans like "Ramadan Fitness."

4. sessions
Tracks scheduled or completed workout sessions between members and trainers, linking them to specific workout plans and session notes.

5. payments
Logs financial transactions made by members, with details about payment types (e.g., Membership or Personal Training), method, and date.

## Objectives 

To design a MySQL database for efficiently managing fitness center operations, including member registrations, trainer schedules, workout plans, session bookings, and payment tracking, while enabling data-driven business insights.

## Creating Database 
``` sql
CREATE DATABASE MD23rdJ1_db;
USE MD23rdJ1_db;
```
## Creating Tables 
### Table:members
``` sql
CREATE TABLE members (
        member_id        INT PRIMARY KEY AUTO_INCREMENT,
        first_name       TEXT,
        last_name        TEXT,
        email            TEXT,
        phone            TEXT,
        join_date        DATE,
        membership_type  TEXT,
        active_status    BOOLEAN
);

SELECT * FROM members ;
```
### Table:trainers
``` sql
CREATE TABLE trainers (
        trainer_id      INT PRIMARY KEY AUTO_INCREMENT,
        first_name      TEXT,
        last_name       TEXT,
        specialization  TEXT,
        hire_date       DATE,
        certification   TEXT,
        hourly_rate     DECIMAL (10,2)
);

SELECT * FROM trainers ;
```
### Table:workoutPlans
``` sql
CREATE TABLE workoutPlans (
        plan_id           INT PRIMARY KEY AUTO_INCREMENT,
        plan_name         TEXT,
        description       TEXT,
        difficulty_level  TEXT,
        duration_week     INT
);

SELECT * FROM workoutPlans ;
```
### Table:sessions
``` sql
CREATE TABLE sessions (
        session_id     INT PRIMARY KEY AUTO_INCREMENT,
        member_id      INT,
        trainer_id     INT,
        plan_id        INT,
        session_date   DATE,
        start_time     TIME,
        end_time       TIME,
        status         TEXT,
        notes          TEXT
);

SELECT * FROM sessions ;
```
### Table:payments
``` sql
CREATE TABLE payments (
        payment_id       INT PRIMARY KEY AUTO_INCREMENT,
        member_id        INT,
        amount           DECIMAL (10,2),
        payment_date     DATE,
        payment_method   TEXT,
        payment_type     TEXT
);

SELECT * FROM payments ;
``
## KEY Queries 

#### 1. List all active members with their membership types.
``` sql
SELECT 
        CONCAT(first_name,' ',last_name) AS Member_name,membership_type
FROM members
WHERE active_status=TRUE;
```
#### 2. Count how many VIP members are in the database.
``` sql
SELECT 
        membership_type,COUNT(*) AS Total_members
FROM members
WHERE UPPER(membership_type)='VIP'
GROUP BY membership_type;
```
#### 3. Show all trainers and their specializations.
``` sql
SELECT 
        CONCAT(first_name,' ',last_name) AS Trainer_name,specialization
FROM trainers;
```
#### 4. List all workout plans with duration longer than 4 weeks.
``` sql
SELECT 
        * 
FROM workoutplans
WHERE duration_week>4;
```
#### 6. Display all completed sessions with member and trainer names.
``` sql
SELECT 
        CONCAT(m.first_name,' ',m.last_name) AS Member_name,
        CONCAT(t.first_name,' ',t.last_name) AS Trainer_name,
    session_date,start_time,end_time,status
FROM sessions s
JOIN members m ON s.member_id=m.member_id
JOIN trainers t ON s.trainer_id=t.trainer_id
WHERE LOWER(s.status)='completed';
```
#### 7. Calculate the total revenue from personal training payments.
``` sql
SELECT 
        payment_type,SUM(amount) AS Total_revenue
FROM payments
WHERE LOWER(payment_type)='personal training'
GROUP BY payment_type;
```
#### 8. Find members who haven't attended any sessions yet.
``` sql
SELECT 
        CONCAT(m.first_name,' ',m.last_name) AS Member_name,membership_type
FROM members m
LEFT JOIN sessions s ON m.member_id=s.member_id
WHERE s.session_id IS NULL;
```
#### 11. Calculate the monthly revenue for each payment type (Membership, Personal Training, Other).
``` sql
SELECT 
        YEAR(payment_date) AS Year,MONTH(payment_date)AS Month,
        payment_type,SUM(amount) AS Total_revenue
FROM payments
GROUP BY payment_type,Year,Month
ORDER BY Year,Month;
```
#### 12. Find trainers who have conducted sessions for all membership types (Basic, Premium, VIP).
``` sql
SELECT 
        CONCAT(t.first_name,' ',t.last_name) AS Trainer_name,
    specialization,hire_date,certification,hourly_rate
FROM sessions s
JOIN members m ON s.member_id = m.member_id
JOIN trainers t ON s.trainer_id = t.trainer_id
GROUP BY Trainer_name,specialization,hire_date,certification,hourly_rate
HAVING COUNT(DISTINCT m.membership_type) = 3;
```
#### 19. Show the revenue growth month-over-month for the past year.
``` sql
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue,
    LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS previous_month_revenue,
    ROUND(
        (SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m'))) 
        / LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) * 100, 2
    ) AS revenue_growth_percent
FROM payments
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;
```
#### 20. Find members who attended sessions during Ramadan (specific date range) and their preferred workout plans.
``` sql
SELECT 
    CONCAT(m.first_name,' ',m.last_name) AS Member_name,
    wp.plan_name,
    s.session_date
FROM sessions s
JOIN members m ON s.member_id = m.member_id
JOIN workoutPlans wp ON s.plan_id = wp.plan_id
WHERE s.session_date BETWEEN '2024-03-10' AND '2024-04-09';
```
## Conclusion 

The database provides a solid foundation for analyzing and managing a fitness center’s operational workflow. It enables:

1. Tracking active memberships and tier distribution.

2. Monitoring trainer involvement and workout plan utilization.

3. Managing personal training sessions and performance feedback.

4. Analyzing monthly and categorized revenue for financial planning.

5. Identifying seasonal trends such as increased participation during Ramadan.

