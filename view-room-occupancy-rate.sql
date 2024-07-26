CREATE VIEW RoomOccupancyRate AS
SELECT 
    r.room_number,
    r.capacity,
    COUNT(DISTINCT pr.patient_id) AS occupied_beds,
    (COUNT(DISTINCT pr.patient_id) / r.capacity) * 100 AS occupancy_rate
FROM 
    Room r
LEFT JOIN PatientRoom pr ON r.room_number = pr.room_number
WHERE 
    pr.check_out_date IS NULL OR pr.check_out_date >= CURDATE()
GROUP BY r.room_number;