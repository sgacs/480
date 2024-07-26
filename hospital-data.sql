-- hospital-data.sql

USE hospital;

-- Insert Physicians
INSERT INTO Physician VALUES
(1, 'Dr. John Smith', 'CERT001', 'Cardiology', '123 Main St, Anytown', '555-1234'),
(2, 'Dr. Sarah Johnson', 'CERT002', 'Pediatrics', '456 Oak Ave, Somewhere', '555-5678'),
(3, 'Dr. Michael Brown', 'CERT003', 'Orthopedics', '789 Elm St, Nowhere', '555-9012'),
(4, 'Dr. Emily Davis', 'CERT004', 'Neurology', '321 Pine Rd, Elsewhere', '555-3456'),
(5, 'Dr. Robert Wilson', 'CERT005', 'Oncology', '654 Maple Dr, Anyplace', '555-7890');

-- Insert Nurses
INSERT INTO Nurse VALUES
(1, 'Jane Doe', 'NCERT001', '111 First St, Anytown', '555-2345'),
(2, 'Mark Johnson', 'NCERT002', '222 Second Ave, Somewhere', '555-6789'),
(3, 'Lisa Brown', 'NCERT003', '333 Third St, Nowhere', '555-0123'),
(4, 'Tom Davis', 'NCERT004', '444 Fourth Rd, Elsewhere', '555-4567'),
(5, 'Amy Wilson', 'NCERT005', '555 Fifth Dr, Anyplace', '555-8901');

-- Insert Rooms
INSERT INTO Room VALUES
(101, 2, 100.00),
(102, 2, 100.00),
(103, 1, 150.00),
(201, 2, 120.00),
(202, 1, 180.00);

-- Insert Patients
INSERT INTO Patient (patient_id, name, address, phone) VALUES
(1, 'Alice Johnson', '100 Patient St, Sickville', '555-1111'),
(2, 'Bob Smith', '200 Ill Ave, Unwell City', '555-2222'),
(3, 'Carol Brown', '300 Health Rd, Recover Town', '555-3333'),
(4, 'David Wilson', '400 Care Dr, Healing Springs', '555-4444'),
(5, 'Eve Davis', '500 Wellness Blvd, Mend City', '555-5555');

-- Insert Health Records
INSERT INTO HealthRecord VALUES
(1, 1, 'Hypertension', '2024-01-15', 'ongoing', 'Patient experiencing high blood pressure'),
(2, 2, 'Fractured arm', '2024-02-20', 'ongoing', 'Left arm fracture, cast applied'),
(3, 3, 'Pneumonia', '2024-03-10', 'resolved', 'Patient fully recovered from pneumonia'),
(4, 4, 'Diabetes Type 2', '2024-04-05', 'ongoing', 'Managing with diet and medication'),
(5, 5, 'Appendicitis', '2024-05-01', 'resolved', 'Appendix removed, patient recovered');

-- Insert Patient Room Assignments
INSERT INTO PatientRoom VALUES
(1, 1, 101, '2024-07-01', '2024-07-05'),
(2, 2, 102, '2024-07-02', '2024-07-07'),
(3, 3, 103, '2024-07-03', '2024-07-06'),
(4, 4, 201, '2024-07-04', '2024-07-09'),
(5, 5, 202, '2024-07-05', '2024-07-08');

-- Insert Physician Patient Monitoring
INSERT INTO PhysicianPatientMonitoring VALUES
(1, 1, 1, '2024-07-01', '2024-07-05'),
(2, 2, 2, '2024-07-02', '2024-07-07'),
(3, 3, 3, '2024-07-03', '2024-07-06'),
(4, 4, 4, '2024-07-04', '2024-07-09'),
(5, 5, 5, '2024-07-05', '2024-07-08');

-- Insert Medications
INSERT INTO Medication VALUES
(1, 'Aspirin', 'Pain reliever', 5.00),
(2, 'Amoxicillin', 'Antibiotic', 10.00),
(3, 'Lisinopril', 'Blood pressure medication', 15.00),
(4, 'Metformin', 'Diabetes medication', 12.00),
(5, 'Ibuprofen', 'Anti-inflammatory', 6.00);

-- Insert Medication Administrations
INSERT INTO MedicationAdministration VALUES
(1, 1, 1, 3, '2024-07-02', 1),
(2, 2, 2, 5, '2024-07-03', 2),
(3, 3, 3, 2, '2024-07-04', 1),
(4, 4, 4, 4, '2024-07-05', 1),
(5, 5, 5, 1, '2024-07-06', 2);

-- Insert Instructions
INSERT INTO Instruction VALUES
(1, 'CBC001', 'Complete blood count', 50.00),
(2, 'XRAY001', 'X-ray', 100.00),
(3, 'MRI001', 'MRI scan', 500.00),
(4, 'PT001', 'Physical therapy session', 75.00),
(5, 'NUTR001', 'Nutritional counseling', 60.00);

-- Insert Physician Orders
INSERT INTO PhysicianOrder VALUES
(1, 1, 1, 1, '2024-07-02'),
(2, 2, 2, 2, '2024-07-03'),
(3, 3, 3, 3, '2024-07-04'),
(4, 4, 4, 4, '2024-07-05'),
(5, 5, 5, 5, '2024-07-06');

-- Insert Nurse Executions
INSERT INTO NurseExecution VALUES
(1, 1, 1, '2024-07-02', 'executed'),
(2, 2, 2, '2024-07-03', 'executed'),
(3, 3, 3, '2024-07-04', 'pending'),
(4, 4, 4, '2024-07-05', 'executed'),
(5, 5, 5, '2024-07-06', 'pending');

-- Insert Invoices
INSERT INTO Invoice VALUES
(1, 1, 'ACC001', '2024-07-05', '2024-07-01', '2024-07-05'),
(2, 2, 'ACC002', '2024-07-07', '2024-07-02', '2024-07-07'),
(3, 3, 'ACC003', '2024-07-06', '2024-07-03', '2024-07-06'),
(4, 4, 'ACC004', '2024-07-09', '2024-07-04', '2024-07-09'),
(5, 5, 'ACC005', '2024-07-08', '2024-07-05', '2024-07-08');

-- Insert Payables
INSERT INTO Payable VALUES
(1, 1, 400.00, 'Room charge: 101 for 4 nights', '2024-07-05'),
(2, 1, 50.00, 'Medication: Lisinopril', '2024-07-02'),
(3, 2, 500.00, 'Room charge: 102 for 5 nights', '2024-07-07'),
(4, 2, 100.00, 'X-ray', '2024-07-03'),
(5, 3, 450.00, 'Room charge: 103 for 3 nights', '2024-07-06'),
(6, 3, 500.00, 'MRI scan', '2024-07-04'),
(7, 4, 600.00, 'Room charge: 201 for 5 nights', '2024-07-09'),
(8, 4, 75.00, 'Physical therapy session', '2024-07-05'),
(9, 5, 540.00, 'Room charge: 202 for 3 nights', '2024-07-08'),
(10, 5, 60.00, 'Nutritional counseling', '2024-07-06');

-- Insert Payments
INSERT INTO Payment VALUES
(1, 1, 200.00, '2024-07-10'),
(2, 2, 300.00, '2024-07-11'),
(3, 3, 500.00, '2024-07-12'),
(4, 4, 400.00, '2024-07-13'),
(5, 5, 300.00, '2024-07-14');