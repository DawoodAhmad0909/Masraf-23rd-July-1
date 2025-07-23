CREATE DATABASE MD23rdJ1_db;
USE MD23rdJ1_db;

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

INSERT INTO members (first_name, last_name, email, phone, join_date, membership_type, active_status) VALUES
	('Mohammed', 'Ali', 'mohammed.ali@email.com', '555-789-0123', '2023-06-10', 'Premium', TRUE),
	('Aisha', 'Khan', 'aisha.khan@email.com', '555-890-1234', '2023-07-05', 'VIP', TRUE),
	('Omar', 'Abdullah', 'omar.abd@email.com', '555-901-2345', '2023-08-15', 'Basic', TRUE),
	('Fatima', 'Rahman', 'fatima.r@email.com', '555-012-3456', '2023-09-20', 'Premium', TRUE),
	('Yusuf', 'Hassan', 'yusuf.h@email.com', '555-123-7890', '2023-10-12', 'VIP', FALSE),
	('Zainab', 'Ibrahim', 'zainab.i@email.com', '555-234-8901', '2023-11-01', 'Basic', TRUE),
	('Ahmed', 'Malik', 'ahmed.m@email.com', '555-345-9012', '2023-12-05', 'Premium', TRUE),
	('Leila', 'Osman', 'leila.o@email.com', '555-456-0123', '2024-01-18', 'VIP', TRUE),
	('Mustafa', 'Farouk', 'mustafa.f@email.com', '555-567-1234', '2024-02-22', 'Basic', TRUE),
	('Amina', 'Saleh', 'amina.s@email.com', '555-678-2345', '2024-03-30', 'Premium', FALSE);

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

INSERT INTO trainers (first_name, last_name, specialization, hire_date, certification, hourly_rate) VALUES
	('Abdul', 'Qadir', 'Strength Training', '2022-05-10', 'NASM Certified', 65.00),
	('Hafsa', 'Mohammed', 'Yoga and Flexibility', '2022-08-15', 'RYT 500', 55.00),
	('Tariq', 'Jamal', 'Functional Training', '2023-01-20', 'ACE Certified', 60.00),
	('Mariam', 'Yusuf', 'Pilates', '2023-04-05', 'Pilates Method Alliance', 50.00),
	('Idris', 'Hamza', 'Sports Conditioning', '2023-07-12', 'ISSA Certified', 70.00);

CREATE TABLE workoutPlans (
	plan_id           INT PRIMARY KEY AUTO_INCREMENT,
	plan_name         TEXT,
	description       TEXT,
	difficulty_level  TEXT,
	duration_week     INT
);

SELECT * FROM workoutPlans ;

INSERT INTO workoutPlans (plan_name, description, difficulty_level, duration_week) VALUES
	('Ramadan Fitness', 'Special program for maintaining fitness during fasting', 'Intermediate', 4),
	('Eid Challenge', 'Intensive 6-week program to get in shape for Eid', 'Advanced', 6),
	('Hajj Preparation', 'Strength and endurance training for pilgrimage', 'Beginner', 8),
	('Islamic New Year Reset', 'Detox and fitness program for the new year', 'Intermediate', 4);

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

INSERT INTO sessions (member_id, trainer_id, plan_id, session_date, start_time, end_time, status, notes) VALUES
	(8, 6, 5, '2024-04-01', '09:00:00', '10:00:00', 'Completed', 'Initial assessment'),
	(9, 7, 6, '2024-04-02', '11:00:00', '12:00:00', 'Scheduled', 'First session'),
	(10, 8, 5, '2024-04-03', '14:00:00', '15:00:00', 'Completed', 'Good progress'),
	(11, 9, 7, '2024-04-04', '16:00:00', '17:00:00', 'Scheduled', NULL),
	(12, 10, 6, '2024-04-05', '10:00:00', '11:00:00', 'Cancelled', 'Member rescheduled'),
	(13, 6, 8, '2024-04-06', '13:00:00', '14:00:00', 'Completed', 'Needs modification'),
	(14, 7, 5, '2024-04-07', '15:00:00', '16:00:00', 'Scheduled', NULL);

CREATE TABLE payments (
	payment_id       INT PRIMARY KEY AUTO_INCREMENT,
	member_id        INT,
	amount           DECIMAL (10,2),
	payment_date     DATE,
	payment_method   TEXT,
	payment_type     TEXT
);

SELECT * FROM payments ;

INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type) VALUES
	(8, 120.00, '2024-03-25', 'Credit Card', 'Personal Training'),
	(9, 200.00, '2024-03-26', 'Bank Transfer', 'Membership'),
	(10, 75.00, '2024-03-27', 'Debit Card', 'Personal Training'),
	(11, 150.00, '2024-03-28', 'Cash', 'Membership'),
	(12, 90.00, '2024-03-29', 'Credit Card', 'Personal Training'),
	(13, 180.00, '2024-03-30', 'Bank Transfer', 'Membership'),
	(14, 60.00, '2024-03-31', 'Debit Card', 'Personal Training');

-- 1. List all active members with their membership types.
 SELECT 
	CONCAT(first_name,' ',last_name) AS Member_name,membership_type
FROM members
WHERE active_status=TRUE;

-- 2. Count how many VIP members are in the database.
SELECT 
	membership_type,COUNT(*) AS Total_members
FROM members
WHERE UPPER(membership_type)='VIP'
GROUP BY membership_type;

-- 3. Show all trainers and their specializations.
SELECT 
	CONCAT(first_name,' ',last_name) AS Trainer_name,specialization
FROM trainers;

-- 4. List all workout plans with duration longer than 4 weeks.
SELECT 
	* 
FROM workoutplans
WHERE duration_week>4;

-- 6. Display all completed sessions with member and trainer names.
SELECT 
	CONCAT(m.first_name,' ',m.last_name) AS Member_name,
	CONCAT(t.first_name,' ',t.last_name) AS Trainer_name,
    session_date,start_time,end_time,status
FROM sessions s
JOIN members m ON s.member_id=m.member_id
JOIN trainers t ON s.trainer_id=t.trainer_id
WHERE LOWER(s.status)='completed';

-- 7. Calculate the total revenue from personal training payments.
SELECT 
	payment_type,SUM(amount) AS Total_revenue
FROM payments
WHERE LOWER(payment_type)='personal training'
GROUP BY payment_type;

-- 8. Find members who haven't attended any sessions yet.
SELECT 
	CONCAT(m.first_name,' ',m.last_name) AS Member_name,membership_type
FROM members m
LEFT JOIN sessions s ON m.member_id=s.member_id
WHERE s.session_id IS NULL;

-- 11. Calculate the monthly revenue for each payment type (Membership, Personal Training, Other).
SELECT 
	YEAR(payment_date) AS Year,MONTH(payment_date)AS Month,
	payment_type,SUM(amount) AS Total_revenue
FROM payments
GROUP BY payment_type,Year,Month
ORDER BY Year,Month;

-- 12. Find trainers who have conducted sessions for all membership types (Basic, Premium, VIP).
SELECT 
	CONCAT(t.first_name,' ',t.last_name) AS Trainer_name,
    specialization,hire_date,certification,hourly_rate
FROM sessions s
JOIN members m ON s.member_id = m.member_id
JOIN trainers t ON s.trainer_id = t.trainer_id
GROUP BY Trainer_name,specialization,hire_date,certification,hourly_rate
HAVING COUNT(DISTINCT m.membership_type) = 3;

-- 19. Show the revenue growth month-over-month for the past year.
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

-- 20. Find members who attended sessions during Ramadan (specific date range) and their preferred workout plans.
SELECT 
    CONCAT(m.first_name,' ',m.last_name) AS Member_name,
    wp.plan_name,
    s.session_date
FROM sessions s
JOIN members m ON s.member_id = m.member_id
JOIN workoutPlans wp ON s.plan_id = wp.plan_id
WHERE s.session_date BETWEEN '2024-03-10' AND '2024-04-09';