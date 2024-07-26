SELECT 
    p.name AS patient_name,
    ph.name AS physician_name,
    i.description AS treatment,
    po.order_date
FROM 
    Patient p
JOIN PhysicianOrder po ON p.patient_id = po.patient_id
JOIN Physician ph ON po.physician_id = ph.physician_id
JOIN Instruction i ON po.instruction_id = i.instruction_id
ORDER BY p.name, po.order_date;