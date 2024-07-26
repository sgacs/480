CREATE VIEW PhysicianPerformance AS
SELECT 
    ph.physician_id, 
    ph.name,
    COUNT(DISTINCT po.patient_id) AS patients_treated,
    COUNT(po.order_id) AS orders_given,
    AVG(i.fee) AS avg_instruction_fee
FROM 
    Physician ph
LEFT JOIN PhysicianOrder po ON ph.physician_id = po.physician_id
LEFT JOIN Instruction i ON po.instruction_id = i.instruction_id
GROUP BY ph.physician_id;