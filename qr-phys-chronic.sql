SELECT 
    ph.name AS physician_name,
    COUNT(hr.record_id) AS chronic_cases
FROM 
    HealthRecord hr
JOIN PhysicianPatientMonitoring ppm ON hr.patient_id = ppm.patient_id
JOIN Physician ph ON ppm.physician_id = ph.physician_id
WHERE hr.status = 'ongoing'
GROUP BY ph.name
ORDER BY chronic_cases DESC;
