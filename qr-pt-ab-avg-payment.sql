SELECT 
    p.name,
    SUM(pay.amount) AS total_payments
FROM 
    Patient p
JOIN Payment pay ON p.patient_id = pay.patient_id
GROUP BY p.name
HAVING total_payments > (SELECT AVG(total_payments) FROM (SELECT SUM(amount) AS total_payments FROM Payment GROUP BY patient_id) AS subquery)
ORDER BY total_payments DESC;
