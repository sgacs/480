SELECT 
    p.name AS patient_name,
    SUM(pay.amount) AS total_expenses
FROM 
    Payment pay
JOIN Patient p ON pay.patient_id = p.patient_id
GROUP BY p.name
ORDER BY total_expenses DESC;
