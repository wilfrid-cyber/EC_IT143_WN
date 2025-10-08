/*
------------------------------------------
EC_IT143_W5.2_My_Community_SportsClub_jd.sql
Author: Wilfrid N'DAMBI MBOUILOU
Date: 8 October 2025
Description: Question
for the Sports Club community dataset.
------------------------------------------
*/

SELECT GETDATE() AS my_date;


/* Question 1 
What is the total number of members in each club?
*/

SELECT club_name, COUNT(member_id) AS total_members
FROM members
GROUP BY club_name;

/* Question 2 
Which club collected the highest total membership fees?
*/

SELECT TOP 1 club_name, SUM(membership_fee) AS total_fees
FROM members
GROUP BY club_name
ORDER BY total_fees DESC;

/* Question 3 
What is the average age of members by club?
*/

SELECT club_name, AVG(age) AS avg_age
FROM members
GROUP BY club_name;

/* Question 4 
How many events has each club hosted this year?
*/

SELECT club_name, COUNT(event_id) AS total_events
FROM events
WHERE YEAR(event_date) = 2025
GROUP BY club_name;
