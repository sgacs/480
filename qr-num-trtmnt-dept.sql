SELECT 
    ph.field_of_expertise AS department,
    COUNT(po.order_id) AS total_treatments
FROM 
    PhysicianOrder po
JOIN Physician ph ON po.physician_id = ph.physician_id
GROUP BY ph.field_of_expertise
ORDER BY total_treatments DESC;