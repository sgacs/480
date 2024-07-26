SELECT 
    ph.name AS physician_name,
    COUNT(ppm.patient_id) AS total_patients
FROM 
    PhysicianPatientMonitoring ppm
JOIN Physician ph ON ppm.physician_id = ph.physician_id
GROUP BY ph.name
ORDER BY total_patients DESC;
