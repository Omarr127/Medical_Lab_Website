

------All queries needed for website-----



--For patient view--



--------Medical tests---------------



SELECT 
                MedicalTests.MedicalTestID, 
                MedicalTests.NameofTest, 
                MedicalTests.Descriptionn,  
                MedicalTests.Instructions,  
                MedicalTests.TotalCost, 
                STRING_AGG(Typees.Typee, ', ') AS Types  
                FROM MedicalTests 
                LEFT JOIN Typees ON Typees.MedicalId = MedicalTests.MedicalTestID 
                GROUP BY MedicalTests.MedicalTestID, 
                MedicalTests.NameofTest, 
                MedicalTests.Descriptionn, 
                MedicalTests.Instructions,  
                MedicalTests.TotalCost 
                ORDER BY MedicalTests.NameofTest;


				-----------------------------------Sign-------------------------------------------


				INSERT INTO Patientss (
     PatientID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, AdmissionDate
 )
 VALUES (
     (SELECT ISNULL(MAX(PatientID), 0) + 1 FROM Patientss),
     @Fname, @Lname, @Email, @Password, @Gender, @DateOfBirth, @Address, @Username, @PhoneNumber, GETDATE()
 );

 --------------------------------------------Report------------------------------------------------

 SELECT 
     nt.TaskID,      -- Retrieve TaskID
     nt.BookingID,   -- Retrieve BookingID
     p.PatientID     -- Retrieve PatientID
 FROM 
     NurseTaskss nt
 JOIN 
     Patientss p ON nt.PatientName = CONCAT(p.Fname, ' ', p.Lname)
 WHERE 
     nt.TaskID = @TaskID



SELECT dc.CommentText
 FROM DoctorComments dc
 JOIN NurseTaskss nt ON dc.TaskID = nt.TaskID
 WHERE nt.TaskID = @TaskID
 



 SELECT CommentText AS PDFPath
FROM DoctorComments
WHERE TaskID = @TaskID AND CommentText LIKE '%.pdf'



INSERT INTO HistoryReports (PatientID, BookingID, TestName, Date)
VALUES (@PatientID, @BookingID, @TestName, @Date)



---------------------Log in----------------------------------



SELECT TOP 1 UserType, UserID, Fname, Lname, Username
 FROM (
     SELECT 'Doctor' AS UserType, DoctorID AS UserID, Fname, Lname, Username
     FROM Doctors
     WHERE Username = @Username AND Passwordd = @Password
     UNION ALL
     SELECT 'Nurse' AS UserType, NurseID AS UserID, Fname, Lname, Username
     FROM Nurses
     WHERE Username = @Username AND Passwordd = @Password
     UNION ALL
     SELECT 'Patient' AS UserType, PatientID AS UserID, Fname, Lname, Username
     FROM Patientss
     WHERE Username = @Username AND Passwordd = @Password
     UNION ALL
     SELECT 'Receptionist' AS UserType, ReceptionistID AS UserID, Fname, Lname, Username
     FROM Receptionists
     WHERE Username = @Username AND Passwordd = @Password
     UNION ALL
     SELECT 'Admin' AS UserType, NULL AS UserID, Username AS Fname, NULL AS Lname, Username
     FROM Adminns
     WHERE Username = @Username AND Passwordd = @Password
 ) AS CombinedResults



 ---------------History of tests----------------------

 SELECT TOP 1 PatientID FROM Patientss WHERE Username = @Username



SELECT 
     nt.TaskID,
     CONCAT(p.Fname, ' ', p.Lname) AS PatientName,
     nt.MedicalTests AS TestName,
     nt.Time AS Date
 FROM 
     NurseTaskss nt
 JOIN 
     Patientss p ON nt.PatientName = CONCAT(p.Fname, ' ', p.Lname)
 WHERE 
     p.PatientID = @PatientID
 AND 
     nt.IsChecked = 1


-------------------Book---------------------------------------

 SELECT TOP 1 PatientID FROM Patientss WHERE Username = @Username



 INSERT INTO Booking (BookingID, TIMEE, locationn, FirstTime, CheckAttendance, NurseID, PatientID, PayMethod)

 VALUES (
     (SELECT ISNULL(MAX(BookingID), 0) + 1 FROM Booking), 
     @AppointmentDateTime, 
     @Location, 
     @IsFirstTime, 
     0, 
     NULL, 
     @PatientID, 
     @PaymentMethod
 );



 SELECT MAX(BookingID) FROM Booking;
 


 INSERT INTO TestsThatBooked (BookingID, TestName)
  VALUES (@BookingID, @TestName);


  SELECT NameofTest FROM MedicalTests ORDER BY NameofTest



  ----------Recep view----------------------

 
 --Users--
 "\r\nSELECT \r\n    DoctorID AS Id,\r\n    Username,\r\n    Email,\r\n    Fname AS FirstName,\r\n    Lname AS LastName,\r\n    SSN,\r\n    PhoneNumber,\r\n    Addresss AS Address,\r\n\tDateofBirth,\r\n    Gender,\r\n    workingHours AS WorkingHours,\r\n    'doctor' AS UserType\r\nFROM Doctors\r\n\r\nUNION ALL\r\n\r\nSELECT \r\n    ReceptionistID AS Id,\r\n    Username,\r\n    Email,\r\n    Fname AS FirstName,\r\n    Lname AS LastName,\r\n    SSN,\r\n    PhoneNumber,\r\n    Addresss AS Address,\r\n\tDateofBirth,\r\n    Gender,\r\n    workingHours AS WorkingHours,\r\n    'receptionist' AS UserType\r\nFROM Receptionists\r\n\r\nUNION ALL\r\n\r\nSELECT \r\n    NurseID AS Id,\r\n    Username,\r\n    Email,\r\n    Fname AS FirstName,\r\n    Lname AS LastName,\r\n    SSN,\r\n    PhoneNumber,\r\n    Addresss AS Address,\r\n\tDateofBirth,\r\n    Gender,\r\n    workingHours AS WorkingHours,\r\n    'nurse' AS UserType\r\nFROM Nurses;





 SELECT  +
                "PatientID, Username, Email, Fname AS FirstName, Lname AS LastName, SSN, PhoneNumber, Addresss AS Address, Gender, DateofBirth " +
                "FROM Patientss " +
                "ORDER BY FirstName, LastName


-----Edit User-----
UPDATE Doctors SET workingHours = '{workingHours}' WHERE DoctorID = {workerId};
UPDATE Receptionist SET workingHours = '{workingHours}' WHERE ReceptionistID = {workerId};
UPDATE Nurse SET workingHours = '{workingHours}' WHERE NurseID = {workerId};

---Delete User---

DELETE FROM Doctors WHERE DoctorID = @WorkerId;

DELETE FROM Receptionists WHERE ReceptionistID = @WorkerId;

DELETE FROM Nurses WHERE NurseID = @WorkerId;


--Appointments----

SELECT 
     b.BookingID,
     b.TIMEE,
     b.Locationn,
     b.FirstTime,
     b.CheckAttendance,
     b.PatientID,
     b.PayMethod,
     CONCAT(p.Fname, ' ', p.Lname) AS PatientName
 FROM Booking b
 JOIN Patientss p ON b.PatientID = p.PatientID
 WHERE CAST(b.TIMEE AS DATE) = CAST(GETDATE() AS DATE)
   AND (b.CheckAttendance IS NULL OR b.CheckAttendance = 0)



   SELECT 
     b.BookingID,
     b.TIMEE,
     b.Locationn,
     b.FirstTime,
     b.CheckAttendance,
     b.PatientID,
     b.PayMethod,
     CONCAT(p.Fname, ' ', p.Lname) AS PatientName
 FROM Booking b
 JOIN Patientss p ON b.PatientID = p.PatientID
 WHERE 
     b.TIMEE < @Today
     OR (
         CAST(b.TIMEE AS DATE) = @Today
         AND b.CheckAttendance = 1  -- Attended appointments from today
     )

	 SELECT 
     b.BookingID, 
     b.TIMEE, 
     b.Locationn, 
     b.FirstTime, 
     b.CheckAttendance, 
     b.PatientID, 
     b.PayMethod, 
     CONCAT(p.Fname, ' ', p.Lname) AS PatientName
 FROM 
     Booking b
 JOIN 
     Patientss p ON b.PatientID = p.PatientID
 WHERE 
     b.TIMEE >= @Tomorrow



	 SELECT TestName FROM TestsThatBooked WHERE BookingID = @BookingID

	 UPDATE Booking SET CheckAttendance = @CheckAttendance WHERE BookingID = @BookingID


	 INSERT INTO NurseTaskss (BookingID, PatientName, Time, Location, MedicalTests, IsChecked)
 SELECT 
     b.BookingID, 
     CONCAT(p.Fname, ' ', p.Lname) AS PatientName,
     b.TIMEE AS Time,
     b.Locationn AS Location,
     STRING_AGG(ttb.TestName, ', ') AS MedicalTests,
     0 AS IsChecked
 FROM Booking b
 JOIN Patientss p ON b.PatientID = p.PatientID
 LEFT JOIN TestsThatBooked ttb ON b.BookingID = ttb.BookingID
 WHERE b.BookingID = @BookingID
 GROUP BY b.BookingID, CONCAT(p.Fname, ' ', p.Lname), b.TIMEE, b.Locationn)




 UPDATE Booking 
  SET CheckAttendance = 0 
  WHERE BookingID = @BookingID



  DELETE FROM TestsThatBooked
WHERE BookingID IN (
    SELECT BookingID 
    FROM Booking 
    WHERE CheckAttendance = 0 AND CONVERT(DATE, TIMEE) = CONVERT(DATE, GETDATE())


	DELETE FROM Booking
 WHERE CheckAttendance = 0 AND CONVERT(DATE, TIMEE) = CONVERT(DATE, GETDATE())





  ------------Nurse view---------------


  ---Tasks----


  SELECT TaskID, BookingID, PatientName, Time, Location, MedicalTests, IsChecked
 FROM NurseTaskss
 WHERE IsChecked = 0  -- Only uncompleted tasks


 SELECT TOP 1 NurseID FROM Nurses WHERE Username = @Username



 UPDATE NurseTaskss 
SET IsChecked = @IsChecked
WHERE TaskID = @TaskID;

UPDATE Booking
SET NurseID = @NurseID
WHERE BookingID = (SELECT BookingID FROM NurseTaskss WHERE TaskID = @TaskID)



---Edit test---

UPDATE MedicalTests SET TotalCost = {Totalcost} WHERE MedicalTestID = {MedicalTestId};


--------------------Doctor view------------------------------



--report---


SELECT DoctorID FROM Doctors WHERE Username = @Username


INSERT INTO DoctorComments (TaskID, DoctorID, PatientID, BookingID, CommentText, CreatedAt)
SELECT 
    @TaskID, 
    @DoctorID,
    b.PatientID,
    nt.BookingID,
    @CommentText,
    GETDATE()
FROM NurseTaskss nt
INNER JOIN Booking b ON nt.BookingID = b.BookingID
WHERE nt.TaskID = @TaskID



MERGE INTO DoctorComments AS target
 USING (
     SELECT 
         nt.TaskID,
         nt.BookingID,
         b.PatientID,
         @DoctorID AS DoctorID
     FROM 
         NurseTaskss nt
     JOIN 
         Booking b ON nt.BookingID = b.BookingID
     WHERE 
         nt.TaskID = @TaskID
 ) AS source
 ON target.TaskID = source.TaskID
 WHEN MATCHED THEN
     UPDATE SET 
         CommentText = @CommentText, 
         CreatedAt = GETDATE()
 WHEN NOT MATCHED THEN
     INSERT (TaskID, BookingID, PatientID, DoctorID, CommentText, CreatedAt)
     VALUES (source.TaskID, source.BookingID, source.PatientID, source.DoctorID, @CommentText, GETDATE());



	 --Patients--

	 SELECT 
     nt.TaskID,
     nt.BookingID,
     p.PatientID,  -- Retrieve the PatientID
     CONCAT(p.Fname, ' ', p.Lname) AS PatientName,
     nt.Time,
     nt.Location,
     nt.MedicalTests,
     nt.IsChecked,
     ISNULL(b.NurseID, 0) AS NurseID -- Ensure NurseID is fetched
 FROM NurseTaskss nt
 INNER JOIN Booking b ON nt.BookingID = b.BookingID
 INNER JOIN Patientss p ON b.PatientID = p.PatientID
 WHERE nt.IsChecked = 1



 ----Index---

 SELECT TaskID, BookingID, PatientName, Time, Location, MedicalTests, IsChecked, NurseID
FROM NurseTaskss


-------------------Admin view---------------


---Index---
SELECT COUNT(*) FROM {tableName}


SELECT TOP 5 TestName, COUNT(*) AS Usage
FROM TestsThatBooked
GROUP BY TestName
ORDER BY Usage DESC




SELECT Gender, COUNT(*) AS Count FROM Patientss GROUP BY Gender





SELECT 
    CASE 
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 0 AND 18 THEN '0-18'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 19 AND 35 THEN '19-35'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 51 AND 70 THEN '51-70'
        ELSE '71+'
    END AS AgeGroup,
    COUNT(*) AS Count
FROM Patientss
GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 0 AND 18 THEN '0-18'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 19 AND 35 THEN '19-35'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        WHEN DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN 51 AND 70 THEN '51-70'
        ELSE '71+'
    END



	DELETE FROM Doctors WHERE Username = @Username

	DELETE FROM Nurses WHERE Username = @Username



--Add doctor--



	INSERT INTO Doctors (DoctorID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN) " +
                        "VALUES ((SELECT ISNULL(MAX(DoctorID), 0) + 1 FROM Doctors), @Fname, @Lname, @Email, @Passwordd, @Gender, @DateOfBirth, @Addresss, @Username, @PhoneNumber, @WorkingHours, @SSN)

--Add nurse--

INSERT INTO Nurses (NurseID, Fname, Lname, Email, Passwordd, Gender, DateOfBirth, Addresss, Username, PhoneNumber, WorkingHours, SSN) " +
                        "VALUES ((SELECT ISNULL(MAX(NurseID), 0) + 1 FROM Nurses), @Fname, @Lname, @Email, @Passwordd, @Gender, @DateOfBirth, @Addresss, @Username, @PhoneNumber, @WorkingHours, @SSN)








