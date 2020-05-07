USE DocOffice;

# FRANK OCEAN IS RETIRING, get his patients' names and numbers 
CREATE VIEW Patients_New_Doc_VIEW AS
SELECT phone, pat_fname, pat_lname
FROM PATIENT
WHERE patId in (SELECT pat_Id from SEEN where doc_Id = 'FR9999');

SELECT * FROM Patients_New_Doc_VIEW;

# FIND ALL DOCTORS WHO GAVE OUT VICODIN, first and last names 
CREATE VIEW Doctors_Vicodin_Script_VIEW AS
SELECT doc_fname, doc_lname
FROM DOCTOR
WHERE docId in (SELECT doc_Id from PRESCRIPTION where scriptname = 'Vicodin');

SELECT * FROM Doctors_Vicodin_Script_VIEW;

#ALL DOCTORS AND THEIR SPECIALTY, first and last name
CREATE VIEW Doctors_Specialty_VIEW AS
SELECT doc_fname, doc_lname, specialty
FROM DOCTOR, DOCTORSPECIALTY
WHERE DOCTOR.docId = DOCTORSPECIALTY.doc_Id and specialty is not NULL;

SELECT * FROM Doctors_Specialty_VIEW;

#ALL DOCTORS AND THEIR SPECIALTY (even if no specialty), first and last name
CREATE VIEW Doctors_Specialty_Null_VIEW AS
SELECT doc_fname, doc_lname, specialty
FROM DOCTOR, DOCTORSPECIALTY
WHERE DOCTOR.docId = DOCTORSPECIALTY.doc_Id;

SELECT * FROM Doctors_Specialty_Null_VIEW;



select *
FROM AUDIT;


