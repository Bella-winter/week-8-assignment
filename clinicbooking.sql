CREATE DATABASE clinicbookingdb;
-- Clinic Booking System Database

-- Create Department table
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Doctor table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Doctor-Specialty (Many-to-Many: Doctor <-> Department)
CREATE TABLE Doctor_Specialty (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Patient table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

-- Appointment table (Many-to-One: Patient = Appointment, Doctor -> Appointment)
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(50) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Prescription table (One-to-One with Appointment)
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Medication table
CREATE TABLE Medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);
-- Prescription-Medication table (Many-to-Many)
CREATE TABLE Prescription_Medication (
    prescription_id INT,
    medication_id INT,
    dosage VARCHAR(50),
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);


-- Sample Data
-- Department
INSERT INTO Department (name) 
VALUES ('Cardiology'), ('Neurology'), ('General Medicine'), ('Paediatrics');

-- Doctors
INSERT INTO Doctor (name, email) VALUES 
('Dr. Alice Kariuki', 'alice.kariuki@example.com'),
('Dr. John Mutiso', 'john.mutiso@example.com');

-- Doctor Specialties
INSERT INTO Doctor_Specialty (doctor_id, department_id) VALUES
(1, 003), -- Alice - General Medicine
(2, 002); -- John - Neurology

-- Patients
INSERT INTO Patient (name, email, phone) VALUES 

-- Patients
-- INSERT INTO Patient (name, email, phone) VALUES 
('Pauline Mwangi', 'pauline@example.com', '0712345678'),
('Michael Otieno', 'michael@example.com', '0723456789');

-- Appointments
--- - INSERT INTO Appointment (patient_id, doctor_id, appointment_date, status) VALUES
-- -- (1, 1, '2025-05-05 10:00:00', 'Scheduled'),
-- -- (2, 2, '2025-05-06 14:00:00', 'Scheduled');


-- Prescriptions
INSERT INTO Prescription (appointment_id, notes) VALUES
(1, 'Take medication twice daily after meals.'),
(2, 'Prescribed bed rest and mild painkillers.');

-- Medications
INSERT INTO Medication (name, description) VALUES 
('Paracetamol', 'Pain reliever and fever reducer'),
('Aspirin', 'Used to reduce pain and inflammation');

-- Prescription-Medication
--- - INSERT INTO Prescription_Medication (prescription_id, medication_id, dosage) VALUES
-- -- (1, 1, '500mg'),
-- -- (2, 2, '100mg');