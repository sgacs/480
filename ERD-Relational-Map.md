Physician(physician_id, name, certification_number, field_of_expertise, address, phone)
primary key: {physician_id}

Nurse(nurse_id, name, certification_number, address, phone)
primary key: {nurse_id}

Room(room_number, capacity, nightly_fee)
primary key: {room_number}

Patient(patient_id, name, address, phone, balance)
primary key: {patient_id}

HealthRecord(record_id, patient_id, disease, diagnosis_date, status, description)
primary key: {record_id}
foreign key: {patient_id references Patient(patient_id)}

PatientRoom(assignment_id, patient_id, room_number, check_in_date, check_out_date)
primary key: {assignment_id}
foreign key: {patient_id references Patient(patient_id), room_number references Room(room_number)}

PhysicianPatientMonitoring(monitoring_id, physician_id, patient_id, start_date, end_date)
primary key: {monitoring_id}
foreign key: {physician_id references Physician(physician_id), patient_id references Patient(patient_id)}

Medication(medication_id, name, description, price)
primary key: {medication_id}

MedicationAdministration(administration_id, patient_id, nurse_id, medication_id, administration_date, amount)
primary key: {administration_id}
foreign key: {patient_id references Patient(patient_id), nurse_id references Nurse(nurse_id), medication_id references Medication(medication_id)}

Instruction(instruction_id, code, description, fee)
primary key: {instruction_id}

PhysicianOrder(order_id, physician_id, patient_id, instruction_id, order_date)
primary key: {order_id}
foreign key: {physician_id references Physician(physician_id), patient_id references Patient(patient_id), instruction_id references Instruction(instruction_id)}

NurseExecution(execution_id, order_id, nurse_id, execution_date, status)
primary key: {execution_id}
foreign key: {order_id references PhysicianOrder(order_id), nurse_id references Nurse(nurse_id)}

Invoice(invoice_id, patient_id, account_number, issue_date, start_date, end_date)
primary key: {invoice_id}
foreign key: {patient_id references Patient(patient_id)}

Payable(payable_id, invoice_id, amount, description, date)
primary key: {payable_id}
foreign key: {invoice_id references Invoice(invoice_id)}

Payment(payment_id, patient_id, amount, payment_date)
primary key: {payment_id}
foreign key: {patient_id references Patient(patient_id)}