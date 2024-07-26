SELECT 
    p.name,
    COUNT(ma.administration_id) AS num_medications
FROM 
    MedicationAdministration ma
JOIN Patient p ON ma.patient_id = p.patient_id
GROUP BY p.name
ORDER BY num_medications DESC
LIMIT 5;