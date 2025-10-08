/*
----------------------------------------------------------
EC_IT143_W5.2_NeighbourhoodGarden_jd.sql
Author: Wilfrid N'DAMBI MBOUILOU
Date: 8 October 2025
Description: SQL script answering 4 analysis questions 
for the Neighbourhood Garden community dataset.
----------------------------------------------------------
*/

/* Question 1 
How many members are assigned to each garden plot?
*/

SELECT p.plot_id,
       COUNT(gm.member_id) AS total_members_assigned
FROM Plots p
LEFT JOIN GardenMembers gm ON p.plot_id = gm.plot_id
GROUP BY p.plot_id
ORDER BY total_members_assigned DESC;


/* Question 2 
Which type of plant has produced the highest total yield so far this year?
*/

SELECT TOP 1 
       pl.plant_type,
       SUM(h.yield_kg) AS total_yield_kg
FROM Harvests h
JOIN Plants pl ON h.plant_id = pl.plant_id
WHERE YEAR(h.harvest_date) = 2025
GROUP BY pl.plant_type
ORDER BY total_yield_kg DESC;


/* Question 3 
What is the average number of events attended by each garden member?
*/

SELECT gm.member_id,
       gm.member_name,
       COUNT(e.event_id) AS total_events_attended,
       ROUND(COUNT(e.event_id) * 1.0 /
             (SELECT COUNT(DISTINCT member_id) FROM GardenMembers), 2) AS avg_events_per_member
FROM GardenMembers gm
LEFT JOIN Events e ON gm.member_id = e.member_id
GROUP BY gm.member_id, gm.member_name
ORDER BY total_events_attended DESC;


/* Question 4 
Which members have contributed the most total harvest weight to the garden?
*/

SELECT TOP 5 
       gm.member_name,
       SUM(h.yield_kg) AS total_harvest_contribution
FROM Harvests h
JOIN GardenMembers gm ON h.member_id = gm.member_id
GROUP BY gm.member_name
ORDER BY total_harvest_contribution DESC;
