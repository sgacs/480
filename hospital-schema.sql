DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE Physician (
    physician_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    certification_number VARCHAR(50) UNIQUE NOT NULL,
    field_of_expertise VARCHAR(100),
    address VARCHAR(200),
    phone VARCHAR(20)
);

CREATE TABLE Nurse (
    nurse_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    certification_number VARCHAR(50) UNIQUE NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20)
);

CREATE TABLE Room (
    room_number INT PRIMARY KEY,
    capacity INT NOT NULL,
    nightly_fee DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20),
    balance DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE HealthRecord (
    record_id INT PRIMARY KEY,
    patient_id INT,
    disease VARCHAR(100),
    diagnosis_date DATE,
    status ENUM('ongoing', 'resolved'),
    description TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE PatientRoom (
    assignment_id INT PRIMARY KEY,
    patient_id INT,
    room_number INT,
    check_in_date DATE,
    check_out_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (room_number) REFERENCES Room(room_number)
);

CREATE TABLE PhysicianPatientMonitoring (
    monitoring_id INT PRIMARY KEY,
    physician_id INT,
    patient_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (physician_id) REFERENCES Physician(physician_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Medication (
    medication_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE MedicationAdministration (
    administration_id INT PRIMARY KEY,
    patient_id INT,
    nurse_id INT,
    medication_id INT,
    administration_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (nurse_id) REFERENCES Nurse(nurse_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);

CREATE TABLE Instruction (
    instruction_id INT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    fee DECIMAL(10, 2) NOT NULL
);

CREATE TABLE PhysicianOrder (
    order_id INT PRIMARY KEY,
    physician_id INT,
    patient_id INT,
    instruction_id INT,
    order_date DATE,
    FOREIGN KEY (physician_id) REFERENCES Physician(physician_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (instruction_id) REFERENCES Instruction(instruction_id)
);

CREATE TABLE NurseExecution (
    execution_id INT PRIMARY KEY,
    order_id INT,
    nurse_id INT,
    execution_date DATE,
    status ENUM('pending', 'executed', 'cancelled'),
    FOREIGN KEY (order_id) REFERENCES PhysicianOrder(order_id),
    FOREIGN KEY (nurse_id) REFERENCES Nurse(nurse_id)
);

CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY,
    patient_id INT,
    account_number VARCHAR(50) NOT NULL,
    issue_date DATE,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Payable (
    payable_id INT PRIMARY KEY,
    invoice_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    description TEXT,
    date DATE,
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

DELIMITER //

CREATE PROCEDURE GenerateInvoice(IN p_patient_id INT, IN p_start_date DATE, IN p_end_date DATE)
BEGIN
    DECLARE v_invoice_id INT;
    
    -- Create new invoice
    INSERT INTO Invoice (patient_id, issue_date, start_date, end_date)
    VALUES (p_patient_id, CURDATE(), p_start_date, p_end_date);
    
    SET v_invoice_id = LAST_INSERT_ID();
    
    -- Insert room charges
    INSERT INTO Payable (invoice_id, amount, description, date)
    SELECT 
        v_invoice_id,
        DATEDIFF(LEAST(pr.check_out_date, p_end_date), GREATEST(pr.check_in_date, p_start_date)) * r.nightly_fee,
        CONCAT('Room charge: ', r.room_number),
        GREATEST(pr.check_in_date, p_start_date)
    FROM 
        PatientRoom pr
        JOIN Room r ON pr.room_number = r.room_number
    WHERE 
        pr.patient_id = p_patient_id
        AND pr.check_in_date <= p_end_date
        AND (pr.check_out_date >= p_start_date OR pr.check_out_date IS NULL);
    
    -- Insert medication charges
    INSERT INTO Payable (invoice_id, amount, description, date)
    SELECT 
        v_invoice_id,
        ma.amount * m.price,
        CONCAT('Medication: ', m.name),
        ma.administration_date
    FROM 
        MedicationAdministration ma
        JOIN Medication m ON ma.medication_id = m.medication_id
    WHERE 
        ma.patient_id = p_patient_id
        AND ma.administration_date BETWEEN p_start_date AND p_end_date;
    
    -- Insert instruction charges
    INSERT INTO Payable (invoice_id, amount, description, date)
    SELECT 
        v_invoice_id,
        i.fee,
        CONCAT('Instruction: ', i.description),
        po.order_date
    FROM 
        PhysicianOrder po
        JOIN Instruction i ON po.instruction_id = i.instruction_id
    WHERE 
        po.patient_id = p_patient_id
        AND po.order_date BETWEEN p_start_date AND p_end_date
        AND po.status = 'executed';
END;//

CREATE PROCEDURE AssignRoom(IN p_patient_id INT, IN p_room_number INT, IN p_check_in_date DATE, IN p_check_out_date DATE)
BEGIN
    DECLARE v_capacity INT;
    DECLARE v_current_occupancy INT;
    
    -- Get room capacity
    SELECT capacity INTO v_capacity
    FROM Room
    WHERE room_number = p_room_number;
    
    -- Get current room occupancy
    SELECT COUNT(*) INTO v_current_occupancy
    FROM PatientRoom
    WHERE room_number = p_room_number
    AND check_in_date <= p_check_in_date
    AND (check_out_date >= p_check_in_date OR check_out_date IS NULL);
    
    -- Check if room is available
    IF v_current_occupancy < v_capacity THEN
        INSERT INTO PatientRoom (patient_id, room_number, check_in_date, check_out_date)
        VALUES (p_patient_id, p_room_number, p_check_in_date, p_check_out_date);
        SELECT 'Room assigned successfully.' AS message;
    ELSE
        SELECT 'Room is fully occupied for the specified dates.' AS message;
    END IF;
END;//

DELIMITER ;