SELECT 
    n.name AS nurse_name,
    COUNT(ma.administration_id) AS total_medications_administered
FROM 
    MedicationAdministration ma
JOIN Nurse n ON ma.nurse_id = n.nurse_id
GROUP BY n.name
ORDER BY total_medications_administered DESC;
