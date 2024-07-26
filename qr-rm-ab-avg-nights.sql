SELECT 
    r.room_number,
    COUNT(pr.assignment_id) AS total_occupancy
FROM 
    PatientRoom pr
JOIN Room r ON pr.room_number = r.room_number
GROUP BY r.room_number
HAVING total_occupancy > (SELECT AVG(total_occupancy) FROM (SELECT COUNT(assignment_id) AS total_occupancy FROM PatientRoom GROUP BY room_number) AS subquery)
ORDER BY total_occupancy DESC;
