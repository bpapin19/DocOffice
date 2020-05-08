USE DocOffice;

DROP TABLE IF EXISTS PATIENT_COPY;
CREATE TABLE PATIENT_COPY (
  pat_fname    varchar(25) not null,
  pat_lname    varchar(25) not null,
  ssn          char(9) not null,
  patId		   char(10) not null,   
  lastVisit	   date,
  phone        char(12) not null,
  PRIMARY KEY  (patId, ssn)				   #composite key
);

DROP TABLE IF EXISTS DOCTOR_COPY;
CREATE TABLE DOCTOR_COPY (
  doc_fname       varchar(25) not null,
  doc_lname       varchar(25) not null,
  specialty       varchar(10),
  ssn             char(9) not null,
  docId		      char(6) not null,   
  PRIMARY KEY     (docId, ssn)				#composite key   
);

DROP TABLE IF EXISTS PRESCRIPTION_COPY;
CREATE TABLE PRESCRIPTION_COPY (
  scriptname        varchar(25) not null,
  scriptId          char(7) not null,
  dosage		    varchar(30), 
  pat_Id            char(10) not null,
  doc_Id            char(10) not null,
  PRIMARY KEY  (scriptId),
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);

DROP TABLE IF EXISTS TEST_COPY;
CREATE TABLE TEST_COPY (
  testname        varchar(25) not null,
  testId  		  char(7) not null,         
  price           decimal(4, 2), 
  pat_Id          char(10) not null,
  doc_Id          char(10) not null,
  testdate        date,
  PRIMARY KEY  (testname, testId),                    #composite key
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);

DROP TABLE IF EXISTS OFFICE_COPY;
CREATE TABLE OFFICE_COPY (
  address          varchar(25) not null,
  sqFootage  	   int,         
  facilityType     varchar(10) not null,
  doc_Id           char(7) not null,
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId)
);

#indicates if a patient has been seen
DROP TABLE IF EXISTS SEEN_COPY;
CREATE TABLE SEEN_COPY (
  pat_Id           char(10) not null,
  doc_Id           char(10) not null,
  PRIMARY KEY  (pat_Id, doc_Id),
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);

DROP TABLE IF EXISTS DOCTORSPECIALTY_COPY;
CREATE TABLE DOCTORSPECIALTY_COPY (
	specialty		varchar(10),
    doc_Id				char(7) not null,
    
    PRIMARY KEY			(doc_Id)
);

DROP TABLE IF EXISTS AUDIT_COPY;
CREATE TABLE AUDIT_COPY (
	doc_fname		varchar(25) not null,
    action_taken	varchar(25) not null,
    specialty		varchar(10) not null,
    date_of_modif	date
);

INSERT INTO PATIENT_COPY 
SELECT * FROM PATIENT;

INSERT INTO DOCTOR_COPY
SELECT * FROM DOCTOR;

INSERT INTO PRESCRIPTION_COPY
SELECT * FROM PRESCRIPTION;

INSERT INTO TEST_COPY
SELECT * FROM TEST;

INSERT INTO OFFICE_COPY
SELECT * FROM OFFICE;

INSERT INTO SEEN_COPY
SELECT * FROM SEEN_COPY;

INSERT INTO DOCTORSPECIALTY_COPY
SELECT * FROM DOCTORSPECIALTY_COPY;

INSERT INTO AUDIT_COPY
SELECT * FROM AUDIT_COPY;