USE SpecialClinic;

INSERT INTO Doctor VALUES
(1, 'Ahmed',   'Hassan', 'Cardiology',  '1980-05-12', 'Cairo'),
(2, 'Sara',    'Ali',    'Pediatrics',  '1985-09-23', 'Giza'),
(3, 'Omar',    'Khaled', 'Dermatology', '1978-02-02', 'Alexandria'),
(4, 'Mahmoud', 'Nabil',  'Neurology',   '1975-08-18', 'Cairo'),
(5, 'Heba',    'Fathy',  'Orthopedics', '1988-12-05', 'Giza');

INSERT INTO DoctorPhone VALUES
(1, '01011111111'),
(1, '01022222222'),
(2, '01033333333'),
(3, '01044444444'),
(4, '01055555551'),
(5, '01066666661');

INSERT INTO Patient VALUES
(1, 'Mona',    'Samir',   '1995-03-15', 'Cairo'),
(2, 'Youssef', 'Adel',    '2000-07-20', 'Giza'),
(3, 'Laila',   'Mostafa', '1990-11-30', 'Alexandria'),
(4, 'Karim',   'Fouad',   '1998-01-10', 'Cairo'),
(5, 'Nour',    'Hany',    '2002-06-25', 'Giza');

INSERT INTO PatientPhone VALUES
(1, '01155555555'),
(1, '01266666666'),
(2, '01077777777'),
(3, '01188888888'),
(4, '01299999999'),
(5, '01100000000');

INSERT INTO Schedule VALUES
(1, 1, '2026-11-10 09:00:00', '2026-11-10 09:30:00', FALSE),
(2, 1, '2026-11-10 09:30:00', '2026-11-10 10:00:00', TRUE),
(3, 2, '2026-11-11 11:00:00', '2026-11-11 11:30:00', FALSE),
(4, 3, '2026-11-12 13:00:00', '2026-11-12 13:30:00', FALSE),
(5, 4, '2026-11-13 10:00:00', '2026-11-13 10:30:00', FALSE),
(6, 5, '2026-11-14 12:00:00', '2026-11-14 12:30:00', FALSE);

INSERT INTO Appointment VALUES
(1, 1, 1, 1),
(2, 2, 2, 3),
(3, 3, 3, 4),
(4, 4, 4, 5),
(5, 5, 5, 6);

INSERT INTO MedicalRecord VALUES
(1, 1, 1, '2026-11-10', 'Chest pain, mild', 'ECG and rest'),
(2, 2, 2, '2026-11-11', 'Fever and cough',  'Antibiotics for 5 days'),
(3, 3, 3, '2026-11-12', 'Skin rash',        'Topical cream'),
(4, 4, 4, '2026-11-13', 'Severe headache',  'MRI and painkillers'),
(5, 5, 5, '2026-11-14', 'Knee pain',        'Physiotherapy');

SELECT a.AppointmentID,
       CONCAT(p.FirstName, ' ', p.LastName) AS Patient,
       CONCAT(d.FirstName, ' ', d.LastName) AS Doctor,
       s.StartTime, s.EndTime
FROM Appointment a
JOIN Patient  p ON a.PatientID  = p.PatientID
JOIN Doctor   d ON a.DoctorID   = d.DoctorID
JOIN Schedule s ON a.ScheduleID = s.ScheduleID;

SELECT s.ScheduleID, d.FirstName, d.LastName, s.StartTime, s.EndTime
FROM Schedule s
JOIN Doctor d ON s.DoctorID = d.DoctorID
WHERE s.IsAvailable = TRUE;

SELECT m.RecordID, m.VisitDate, m.Notes, m.Treatment
FROM MedicalRecord m
JOIN Patient p ON m.PatientID = p.PatientID
WHERE p.FirstName = 'Mona';

SELECT d.DoctorID, d.FirstName, d.LastName, COUNT(a.AppointmentID) AS TotalAppointments
FROM Doctor d
LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName;

SELECT d.DoctorID, d.FirstName, d.LastName, COUNT(dp.Phone) AS PhoneCount
FROM Doctor d
JOIN DoctorPhone dp ON d.DoctorID = dp.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName
HAVING COUNT(dp.Phone) > 1;