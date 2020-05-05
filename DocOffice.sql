drop database if exists DocOffice;
create database DocOffice;

use DocOffice;

DROP TABLE IF EXISTS PATIENT;
CREATE TABLE PATIENT (
  pat_fname    varchar(25) not null,
  pat_lname    varchar(25) not null,
  ssn          char(9) not null,
  patId		   char(10) not null,   
  lastVisit	   date,
  phone        char(12) not null,
  PRIMARY KEY  (patId, ssn)				   #composite key
);

DROP TABLE IF EXISTS DOCTOR;
CREATE TABLE DOCTOR (
  doc_fname       varchar(25) not null,
  doc_lname       varchar(25) not null,
  specialty       varchar(10),
  ssn             char(9) not null,
  docId		      char(6) not null,   
  PRIMARY KEY     (docId, ssn)				#composite key   
);

DROP TABLE IF EXISTS PRESCRIPTION;
CREATE TABLE PRESCRIPTION (
  scriptname        varchar(25) not null,
  scriptId          char(7) not null,
  dosage		    varchar(30), 
  pat_Id            char(10) not null,
  doc_Id            char(10) not null,
  PRIMARY KEY  (scriptId),
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);

DROP TABLE IF EXISTS TEST;
CREATE TABLE TEST (
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

DROP TABLE IF EXISTS OFFICE;
CREATE TABLE OFFICE (
  address          varchar(25) not null,
  sqFootage  	   int,         
  facilityType     varchar(10) not null,
  doc_Id           char(7) not null,
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId)
);

#indicates if a patient has been seen
DROP TABLE IF EXISTS SEEN;
CREATE TABLE SEEN (
  pat_Id           char(10) not null,
  doc_Id           char(10) not null,
  PRIMARY KEY  (pat_Id, doc_Id),
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);


INSERT INTO PATIENT VALUES ('Jacob','Schneider','444333222','1234512345','2019-01-17', '714-900-6598');
INSERT INTO PATIENT VALUES ('Mark','Roberts','444555666','1878784833','2018-04-29', '616-978-8865');
INSERT INTO PATIENT VALUES ('Vanessa','Lin','309222576','9984562331','2019-09-10', '714-332-1008');
INSERT INTO PATIENT VALUES ('Jeremy','Prendo','404553229','9555400782','2019-11-16', '410-779-4437');

INSERT INTO DOCTOR VALUES ('Frank','Ocean','eyes','334660082','FR9999');
INSERT INTO DOCTOR VALUES ('Robert','Stevens','lungs','910319844','RO8888');
INSERT INTO DOCTOR VALUES ('Drake','Henry','muscles','344882061','DR7777');
INSERT INTO DOCTOR VALUES ('Joshua','Oswald',null,'100745333','JO6666');


# INSERTING PATIENTS THAT HAVE BEEN SEEN BY A DOCTOR
INSERT INTO SEEN VALUES ((select patId from PATIENT where patId = '1234512345'), (select docId from DOCTOR where docId = 'FR9999'));
INSERT INTO SEEN VALUES ((select patId from PATIENT where patId = '1878784833'), (select docId from DOCTOR where docId = 'FR9999'));
INSERT INTO SEEN VALUES ((select patId from PATIENT where patId = '9984562331'), (select docId from DOCTOR where docId = 'RO8888'));
INSERT INTO SEEN VALUES ((select patId from PATIENT where patId = '9555400782'), (select docId from DOCTOR where docId = 'DR7777'));


#################################################
# INSERTING INTO PRESCRIPTION
#################################################

INSERT INTO PRESCRIPTION VALUES ('Benedril','P000001','once a day', 
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '1234512345'),
# Make patient's doctor in SEEN, doctor for benedril
(select doc_Id from SEEN where pat_Id = '1234512345'));

INSERT INTO PRESCRIPTION VALUES ('Advil','P000002','twice a day',
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '1878784833'),
# Make patient's doctor in SEEN, doctor for Advil
(select doc_Id from SEEN where pat_Id = '1878784833'));

INSERT INTO PRESCRIPTION VALUES ('Codeine','P000003','60mL once every 4 days',
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '9984562331'),
# Make patient's doctor in SEEN, doctor for Codeine
(select doc_Id from SEEN where pat_Id = '9984562331'));

INSERT INTO PRESCRIPTION VALUES ('Vicodin','P000004','once a day',
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '9555400782'),
# Make patient's doctor in SEEN, doctor for Codeine
(select doc_Id from SEEN where pat_Id = '9555400782'));



#################################################
# INSERTING INTO TEST,  assuming the patient's doctor is the same one that gives them prescriptions and tests?
#################################################

INSERT INTO TEST VALUES ('Blood Test','T000001','30.00', 
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '1234512345'),
# Make patient's doctor in SEEN, doctor for blood test
(select doc_Id from SEEN where pat_Id = '1234512345'), '2020-10-12');

INSERT INTO TEST VALUES ('Throat Swab','T000002','05.00',
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '1878784833'),
# Make patient's doctor in SEEN, doctor for Advil
(select doc_Id from SEEN where pat_Id = '1878784833'), '2020-08-08');

INSERT INTO TEST VALUES ('CAT Scan','T000003','75.00',
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '9984562331'),
# Make patient's doctor in SEEN, doctor for Codeine
(select doc_Id from SEEN where pat_Id = '9984562331'), '2020-06-24');

INSERT INTO TEST VALUES ('Lung XRAY','T000004','60.00',
# Inserting pat_id into prescription as foreign key 
(select patId from PATIENT where patId = '9555400782'),
# Make patient's doctor in SEEN, doctor for Codeine
(select doc_Id from SEEN where pat_Id = '9555400782'), '2020-08-08');



#################################################
# INSERTING INTO OFFICE
#################################################

INSERT INTO OFFICE VALUES ('6302 Orange Dr', 950, 'building', 
(select docId from DOCTOR where docId = 'JO6666')); 

INSERT INTO OFFICE VALUES ('6302 Orange Dr', 950, 'building', 
(select docId from DOCTOR where docId = 'FR9999')); 

INSERT INTO OFFICE VALUES ('1800 Vista Marge Rd', 1200, 'labratory', 
(select docId from DOCTOR where docId = 'DR7777')); 

INSERT INTO OFFICE VALUES ('2950 Catalina Ct', 1600, 'building', 
(select docId from DOCTOR where docId = 'DR7777')); 

INSERT INTO OFFICE VALUES ('2950 Catalina Ct', 1600, 'building', 
(select docId from DOCTOR where docId = 'JO6666')); 

