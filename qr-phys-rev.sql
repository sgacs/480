SELECT 
    ph.name AS physician_name,
    SUM(i.fee) AS total_revenue
FROM 
    PhysicianOrder po
JOIN Physician ph ON po.physician_id = ph.physician_id
JOIN Instruction i ON po.instruction_id = i.instruction_id
GROUP BY ph.name
ORDER BY total_revenue DESC;
