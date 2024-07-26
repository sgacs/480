SELECT 
    p.name,
    DATEDIFF(pr.check_out_date, pr.check_in_date) AS length_of_stay
FROM 
    Patient p
JOIN PatientRoom pr ON p.patient_id = pr.patient_id
WHERE 
    DATEDIFF(pr.check_out_date, pr.check_in_date) > 
    (SELECT AVG(DATEDIFF(check_out_date, check_in_date))
     FROM PatientRoom)
ORDER BY length_of_stay DESC;