START TRANSACTION;

INSERT INTO Patient (patient_id, name, address, phone) 
VALUES (6, 'Frank Williams', '600 New St, Newtown', '555-6666');

INSERT INTO HealthRecord (record_id, patient_id, disease, diagnosis_date, status, description)
VALUES (6, 6, 'Influenza', CURDATE(), 'ongoing', 'Patient admitted with severe flu symptoms');

INSERT INTO PatientRoom (assignment_id, patient_id, room_number, check_in_date, check_out_date)
VALUES (6, 6, 101, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY));

COMMIT;