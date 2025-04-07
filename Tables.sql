create table Doctors
(
DoctorID    int not null,
Fname varchar(50),
Lname varchar(50),
Email varchar(50),
Passwordd varchar(50),
`DateofBirth Date,
Addresss text,
Username varchar(50),
PhoneNumber varchar(50),
workingHours varchar(50),
SSN   int unique ,
Primary key (DoctorID),
);


CREATE TABLE DoctorComments (
    CommentID INT IDENTITY(1,1) PRIMARY KEY, 
    DoctorID INT NOT NULL,                  
    PatientID INT NOT NULL,                 
    BookingID INT NOT NULL,                 
    CommentText NVARCHAR(MAX),             
    CreatedAt DATETIME DEFAULT GETDATE(),   
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patientss(PatientID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

ALTER TABLE DoctorComments
ADD PDFPath NVARCHAR(255) NULL;

ALTER TABLE DoctorComments
ADD TaskID INT NULL;

ALTER TABLE DoctorComments
ADD CONSTRAINT FK_DoctorComments_TaskID FOREIGN KEY (TaskID) REFERENCES NurseTaskss(TaskID);

create table Receptionists
(
ReceptionistID    int not null,
Fname varchar(50),
Lname varchar(50),
Email varchar(50),
Passwordd varchar(50),
Gender varchar(50),
DateofBirth Date,
Addresss text,
Username varchar(50),
PhoneNumber varchar(50),
workingHours varchar(50),
SSN   int unique ,
Primary key (ReceptionistID) 
);

create table Nurses
(
NurseID    int not null,
Fname varchar(50),
Lname varchar(50),
Email varchar(50),
Passwordd varchar(50),
Gender varchar(50),
DateofBirth Date,
Addresss text,
Username varchar(50),
PhoneNumber varchar(50),
workingHours varchar(50),
SSN   int unique ,
Primary key (NurseID)
);
create table Patientss
(
PatientID    int not null,
Fname varchar(50),
Lname varchar(50),
Email varchar(50),
Passwordd varchar(50),
Gender varchar(50),
DateofBirth Date,
Addresss text,
Username varchar(50),
PhoneNumber varchar(50),
SSN   int unique ,
Admissiondate date,
Primary key (PatientID)
);



create table Adminns (
Username varchar(50) not null,
passwordd varchar(50),
Primary key(Username),
);
create table MedicalTests(
MedicalTestID int not null,
Descriptionn VARCHAR(100),
patientID    int,
NameofTest varchar(50),
Instructions VARCHAR(100),
TotalCost float,
Primary key(MedicalTestID),
Foreign key(patientID) references patientss(patientID)
);
Create table typees(
Typee varchar(50),
MedicalId int not null,
Primary key(Typee,MedicalId),
Foreign key(MedicalId) references MedicalTests(MedicalTestId)
);
create table Booking(
BookingID int not null,
TIMEE  Datetime,
locationn varchar(50),
FirstTime Bit Not null,
CheckAttendance Bit not null,
NurseId int ,
Primary key(BookingID),
PatientID int ,
PayMethod varchar(50)
Foreign key(NurseID) references Nurses(NurseID)
);

ALTER TABLE Booking
ALTER COLUMN CheckAttendance BIT not NULL;


CREATE TABLE TestsThatBooked (
    BookingID INT NOT NULL,
    TestName  VARCHAR(100) NOT NULL,
    PRIMARY KEY (BookingID, TestName),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);



CREATE TABLE HistoryReports (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    BookingID INT NOT NULL,
    TestName NVARCHAR(255) NOT NULL,
    Date DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patientss(PatientID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

create table choosee(
BookID int not null,
MedicalId int not null,
Results text,
Primary key(BookID,MedicalID),
Foreign key(BookID)references Booking(BookingId),
Foreign key (MedicalID) references MedicalTests(MedicalTestId),
)

CREATE TABLE NurseTaskss (
    TaskID INT IDENTITY(1,1) PRIMARY KEY, 
    BookingID INT NOT NULL,               
    PatientName NVARCHAR(255) NOT NULL,   
    Time DATETIME NOT NULL,               
    Location NVARCHAR(255) NOT NULL,      
    MedicalTests NVARCHAR(MAX),           
    IsChecked BIT DEFAULT 0               
);



ALTER TABLE NurseTaskss
    ADD NurseID INT NULL; 
select* from Nurses
 





IF NOT EXISTS (SELECT 1 FROM Doctors WHERE DoctorID = 1)
BEGIN
    INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
    VALUES (1, 'John', 'Doe', 'john.doe@example.com', 'password1', 'Male', '1985-02-15', '123 Main St, City', 'johndoe', '5551234567', '9AM - 5PM', 123456789);
END;

IF NOT EXISTS (SELECT 1 FROM Doctors WHERE DoctorID = 2)
BEGIN
    INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
    VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', 'password2', 'Female', '1990-04-22', '456 Elm St, City', 'janesmith', '5552345678', '9AM - 5PM', 234567890);
END;

IF NOT EXISTS (SELECT 1 FROM Doctors WHERE DoctorID = 3)
BEGIN
    INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
    VALUES (3, 'Michael', 'Johnson', 'michael.johnson@example.com', 'password3', 'Male', '1980-08-30', '789 Oak St, City', 'mjohnson', '5553456789', '10AM - 6PM', 345678901);
END;

IF NOT EXISTS (SELECT 1 FROM Doctors WHERE DoctorID = 4)
BEGIN
    INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
    VALUES (4, 'Emily', 'Davis', 'emily.davis@example.com', 'password4', 'Female', '1987-12-10', '101 Pine St, City', 'emilydavis', '5554567890', '8AM - 4PM', 456789012);
END;

IF NOT EXISTS (SELECT 1 FROM Doctors WHERE DoctorID = 5)
BEGIN
    INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
    VALUES (5, 'David', 'Martinez', 'david.martinez@example.com', 'password5', 'Male', '1992-06-17', '202 Birch St, City', 'davidm', '5555678901', '9AM - 5PM', 567890123);
END;


INSERT INTO Nurses (NurseId, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
VALUES
(1, 'Emma', 'Johnson', 'emma.johnson@example.com', 'password1', 'Female', '1990-05-12', '123 Elm St', 'emmajohnson', '5551234567', '9AM - 5PM', 123456789),
(2, 'Liam', 'Brown', 'liam.brown@example.com', 'password2', 'Male', '1988-08-23', '456 Maple St', 'liambrown', '5552345678', '8AM - 4PM', 234567890),
(3, 'Sophia', 'Davis', 'sophia.davis@example.com', 'password3', 'Female', '1993-07-15', '789 Oak St', 'sophiadavis', '5553456789', '9AM - 5PM', 345678901),
(4, 'Noah', 'Garcia', 'noah.garcia@example.com', 'password4', 'Male', '1995-12-20', '101 Birch St', 'noahgarcia', '5554567890', '9AM - 5PM', 456789012),
(5, 'Olivia', 'Martinez', 'olivia.martinez@example.com', 'password5', 'Female', '1991-04-22', '202 Cedar St', 'oliviamartinez', '5555678901', '9AM - 5PM', 567890123);

INSERT INTO Receptionists(ReceptionistID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
VALUES
(1, 'Emma', 'Johnson', 'emma.johnson@example.com', 'password1', 'Female', '1990-05-12', '123 Elm St, City', 'R-emmajohnson', '5551234567', '9AM - 5PM', 123456789),
(2, 'Liam', 'Brown', 'liam.brown@example.com', 'password2', 'Male', '1988-03-25', '456 Maple St, City', 'R-liambrown', '5552345678', '8AM - 4PM', 234567890),
(3, 'Sophia', 'Davis', 'sophia.davis@example.com', 'password3', 'Female', '1993-07-15', '789 Oak St, City', 'R-sophiadavis', '5553456789', '10AM - 6PM', 345678901),
(4, 'Noah', 'Garcia', 'noah.garcia@example.com', 'password4', 'Male', '1995-12-10', '101 Birch St, City', 'R-noahgarcia', '5554567890', '9AM - 5PM', 456789012),
(5, 'Olivia', 'Martinez', 'olivia.martinez@example.com', 'password5', 'Female', '1991-04-22', '202 Cedar St, City', 'R-oliviamartinez', '5555678901', '8AM - 4PM', 567890123),
(6, 'James', 'Clark', 'james.clark@example.com', 'password6', 'Male', '1987-01-15', '303 Pine St, City', 'R-jamesclark', '5556789012', '9AM - 5PM', 678901234),
(7, 'Ava', 'Wilson', 'ava.wilson@example.com', 'password7', 'Female', '1992-09-10', '404 Elm St, City', 'R-avawilson', '5557890123', '10AM - 6PM', 789012345),
(8, 'Mason', 'Taylor', 'mason.taylor@example.com', 'password8', 'Male', '1989-06-18', '505 Maple St, City', 'R-masontaylor', '5558901234', '9AM - 5PM', 890123456),
(9, 'Isabella', 'Anderson', 'isabella.anderson@example.com', 'password9', 'Female', '1994-02-05', '606 Oak St, City', 'R-isabellaanderson', '5559012345', '8AM - 4PM', 901234567),
(10, 'Elijah', 'Thomas', 'elijah.thomas@example.com', 'password10', 'Male', '1990-08-20', '707 Birch St, City', 'R-elijahthomas', '5550123456', '9AM - 5PM', 123456788);


INSERT INTO Patientss (PatientID, Fname, Lname, Email, Passwordd, Gender, DateofBirth, Addresss, Username, PhoneNumber, SSN)
VALUES 
(1, 'Mia', 'Parker', 'mia.parker@example.com', 'parkerpass2', 'Female', '1990-08-15', '456 Walnut Ave', 'miaparker', '5552341098', 60069),
(2, 'Liam', 'Mitchell', 'liam.mitchell@example.com', 'mitchellpass3', 'Male', '1985-12-20', '789 Willow Blvd', 'liammitchell', '5553452109', 60062),
(3, 'Emma', 'Wright', 'emma.wright@example.com', 'wrightpass4', 'Female', '1992-06-18', '101 Chestnut Ln', 'emmawright', '5554563210', 62061),
(4, 'Noah', 'Carter', 'noah.carter@example.com', 'carterpass5', 'Male', '1988-03-25', '202 Spruce St', 'noahcarter', '5555674321', 61053),
(5, 'Sophia', 'Davis', 'sophia.davis@example.com', 'davispass6', 'Female', '1993-10-10', '303 Redwood Dr', 'sophiadavis', '5556785432', 6406),
(6, 'James', 'Baker', 'james.baker@example.com', 'bakerpass7', 'Male', '1987-11-30', '404 Cypress Ct', 'jamesbaker', '5557896543', 6105),
(7, 'Olivia', 'Adams', 'olivia.adams@example.com', 'adamspass8', 'Female', '1991-02-14', '505 Sycamore Ln', 'oliviaadams', '5558907654', 70065),
(8, 'Elijah', 'Ward', 'elijah.ward@example.com', 'wardpass9', 'Male', '1989-07-22', '606 Magnolia Dr', 'elijahward', '5559018765', 30065),
(9, 'Isabella', 'Green', 'isabella.green@example.com', 'greenpass10', 'Female', '1994-12-05', '707 Birch Ln', 'isabellagreen', '5550129876', 20065),
(10, 'William', 'Hill', 'william.hill@example.com', 'hillpass11', 'Male', '1983-05-17', '808 Oak Ct', 'williamhill', '5551234560', 61065);

INSERT INTO Adminns (Username, Passwordd) VALUES
('A-admin1', 'adminpass1'),
('A-admin2', 'adminpass2'),
('A-admin3', 'adminpass3'),
('A-admin4', 'adminpass4'),
('A-admin5', 'adminpass5');



INSERT INTO MedicalTests (MedicalTestID, Descriptionn, NameofTest, Instructions, TotalCost) VALUES
(1, 'Blood sugar level test', 'Blood Test', 'Fasting required for 12 hours', 50.0),
(2, 'Lung function test', 'Spirometry', 'Avoid heavy meals before the test', 80.0),
(3, 'Heart rate monitoring', 'ECG', 'No special preparation needed', 120.0),
(4, 'Liver enzyme levels test', 'Liver Function Test', 'Avoid alcohol 24 hours before', 70.0),
(5, 'Kidney function test', 'Renal Function Test', 'Stay hydrated before test', 60.0);
INSERT INTO MedicalTests (MedicalTestID, Descriptionn, NameofTest, Instructions, TotalCost) VALUES
(6, 'Thyroid hormone levels test', 'Thyroid Function Test', 'No special preparation needed', 100.0),
(7, 'Blood cholesterol levels test', 'Lipid Profile', 'Fasting required for 8-12 hours', 90.0),
(8, 'A group of tests that measure different chemicals in the blood', 'Basic Metabolic Panel (BMP)', 'Fasting required for 8 hours', 50.0),
(9, 'Bone density test for osteoporosis', 'DEXA Scan', 'Avoid calcium supplements 24 hours before', 150.0),
(10, 'Vitamin D levels in the blood', 'Vitamin D Test', 'No special preparation needed', 80.0),
(11, 'Prostate-specific antigen levels', 'PSA Test', 'Avoid ejaculation 48 hours before test', 70.0),
(12, 'Detection of infectious diseases', 'HIV Test', 'No special preparation needed', 60.0),
(13, 'Blood pressure monitoring', 'BP Check', 'Relax for 5 minutes before test', 20.0),
(14, 'Allergy test for allergens', 'Allergy Panel', 'Discontinue antihistamines 7 days before', 200.0),
(15, 'Pregnancy detection', 'Pregnancy Test', 'No special preparation needed', 25.0);


INSERT INTO Typees (Typee, MedicalId) VALUES
('Diagnostic', 1), 
('Blood Analysis', 1), 
('Respiratory', 2),
('Pulmonary Function', 2), 
('Cardiology', 3),
('Heart Health', 3), 
('Hepatology', 4),
('Nephrology', 5);
INSERT INTO Typees (Typee, MedicalId) VALUES
('Endocrinology', 6),
('Hormone Levels', 6),
('Lipid Management', 7),
('Cholesterol Analysis', 7),
('Basic Health', 8),
('Metabolic Function', 8),
('Osteoporosis Screening', 9),
('Bone Health', 9),
('Vitamin Analysis', 10),
('Nutritional Status', 10),
('Oncology', 11),
('Prostate Screening', 11),
('Infectious Diseases', 12),
('HIV Screening', 12),
('Hypertension', 13),
('Blood Pressure', 13),
('Allergy Testing', 14),
('Immune Response', 14),
('Pregnancy Detection', 15),
('Reproductive Health', 15);





INSERT INTO Booking (BookingID, TIMEE, Locationn, FirstTime, CheckAttendance, NurseId, PatientID, PayMethod) 
VALUES
(1, '2024-11-24 09:00:00', 'Lab', 1, 0, 1, 101, 'Cash'),
(2, '2024-11-24 10:30:00', 'Home', 0, 1, 2, 102, 'Visa'),
(3, '2024-11-25 14:00:00', 'Lab', 1, 1, 3, 103, 'Cash'),
(4, '2024-11-25 16:00:00', 'Home', 0, 0, 4, 104, 'Visa'),
(5, '2024-11-26 08:00:00', 'Lab', 1, 1, 5, 105, 'Cash');

  SELECT 
    CONCAT(p.Fname, ' ', p.Lname) AS PatientName,
    STRING_AGG(mt.NameofTest, ', ') AS MedicalTests,
    CONCAT(n.Fname, ' ', n.Lname) AS NurseAssigned
FROM 
    Patientss p
LEFT JOIN 
    Booking b ON p.PatientID = b.PatientID
LEFT JOIN 
    choosee c ON b.BookingID = c.BookID
LEFT JOIN 
    MedicalTests mt ON c.MedicalID = mt.MedicalTestID

LEFT JOIN 
    Nurses n ON b.NurseID = n.NurseID
GROUP BY 
    CONCAT(p.Fname, ' ', p.Lname), CONCAT(n.Fname, ' ', n.Lname);



INSERT INTO Choosee (BookID, MedicalId, Results) VALUES
(1, 1, 'Normal glucose levels'),
(2, 2, 'Lung function below average'),
(3, 3, 'Heart rate normal'),
(4, 4, 'Liver enzyme levels slightly elevated'),
(5, 5, 'Kidney function normal');

DELETE FROM Doctors WHERE DoctorID = 3
select *from Doctors

 INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN)
    VALUES (5, 'zaher', 'Martinez', 'david.martinez@example.com', 'password5', 'Male', '1992-06-17', '202 Birch St, City', 'D-zaher', '5555678901', '9AM - 5PM', 567890849123);
	select*from Doctors



	select*from Patientss

update Doctors
	set Username='D-David' where DoctorID=5

	update Nurses 
	set NurseID=10 where fname='Sophia'

		update Receptionists 
	set ReceptionistID=15 where fname='Olivia'
	select *from nurses
	select*from Receptionists




select* from booking;
select* from TestsThatBooked;