SELECT 
    ph.field_of_expertise AS department,
    SUM(i.fee) AS total_revenue
FROM 
    PhysicianOrder po
JOIN Physician ph ON po.physician_id = ph.physician_id
JOIN Instruction i ON po.instruction_id = i.instruction_id
GROUP BY ph.field_of_expertise
ORDER BY total_revenue DESC;