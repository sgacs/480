START TRANSACTION;

UPDATE PatientRoom
SET check_out_date = CURDATE()
WHERE patient_id = 1 AND check_out_date IS NULL;

INSERT INTO Invoice (invoice_id, patient_id, account_number, issue_date, start_date, end_date)
VALUES (6, 1, 'ACC006', CURDATE(), 
        (SELECT check_in_date FROM PatientRoom WHERE patient_id = 1 ORDER BY check_in_date DESC LIMIT 1),
        CURDATE());

INSERT INTO Payable (payable_id, invoice_id, amount, description, date)
SELECT 
    (SELECT COALESCE(MAX(payable_id), 0) FROM Payable) + ROW_NUMBER() OVER () AS payable_id,
    6 AS invoice_id,
    CASE 
        WHEN p.type = 'room' THEN r.nightly_fee * DATEDIFF(pr.check_out_date, pr.check_in_date)
        WHEN p.type = 'medication' THEN m.price * ma.amount
        WHEN p.type = 'instruction' THEN i.fee
    END AS amount,
    p.description,
    p.date
FROM (
    SELECT 'room' AS type, pr.check_in_date AS date, CONCAT('Room charge: ', pr.room_number) AS description
    FROM PatientRoom pr WHERE pr.patient_id = 1
    UNION ALL
    SELECT 'medication' AS type, ma.administration_date AS date, CONCAT('Medication: ', m.name) AS description
    FROM MedicationAdministration ma JOIN Medication m ON ma.medication_id = m.medication_id
    WHERE ma.patient_id = 1
    UNION ALL
    SELECT 'instruction' AS type, po.order_date AS date, i.description
    FROM PhysicianOrder po JOIN Instruction i ON po.instruction_id = i.instruction_id
    WHERE po.patient_id = 1
) p
LEFT JOIN PatientRoom pr ON p.type = 'room' AND p.date = pr.check_in_date AND pr.patient_id = 1
LEFT JOIN Room r ON pr.room_number = r.room_number
LEFT JOIN MedicationAdministration ma ON p.type = 'medication' AND p.date = ma.administration_date AND ma.patient_id = 1
LEFT JOIN Medication m ON ma.medication_id = m.medication_id
LEFT JOIN PhysicianOrder po ON p.type = 'instruction' AND p.date = po.order_date AND po.patient_id = 1
LEFT JOIN Instruction i ON po.instruction_id = i.instruction_id;

COMMIT;