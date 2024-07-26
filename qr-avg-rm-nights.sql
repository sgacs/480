SELECT 
    r.room_number,
    AVG(DATEDIFF(pr.check_out_date, pr.check_in_date)) AS avg_length_of_stay
FROM 
    PatientRoom pr
JOIN Room r ON pr.room_number = r.room_number
GROUP BY r.room_number
ORDER BY avg_length_of_stay DESC;
