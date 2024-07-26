SELECT 
    p.name AS patient_name,
    m.name AS medication_name,
    ma.administration_date,
    n.name AS nurse_name
FROM 
    MedicationAdministration ma
JOIN Patient p ON ma.patient_id = p.patient_id
JOIN Medication m ON ma.medication_id = m.medication_id
JOIN Nurse n ON ma.nurse_id = n.nurse_id
ORDER BY ma.administration_date;
