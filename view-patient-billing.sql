CREATE VIEW PatientBillingOverview AS
SELECT 
    p.patient_id, 
    p.name, 
    SUM(pa.amount) AS total_billed,
    SUM(pay.amount) AS total_paid,
    p.balance AS current_balance
FROM 
    Patient p
LEFT JOIN Invoice i ON p.patient_id = i.patient_id
LEFT JOIN Payable pa ON i.invoice_id = pa.invoice_id
LEFT JOIN Payment pay ON p.patient_id = pay.patient_id
GROUP BY p.patient_id;