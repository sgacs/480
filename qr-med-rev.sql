SELECT 
    m.name AS medication_name,
    SUM(m.price) AS total_revenue
FROM 
    MedicationAdministration ma
JOIN Medication m ON ma.medication_id = m.medication_id
GROUP BY m.name
ORDER BY total_revenue DESC;
