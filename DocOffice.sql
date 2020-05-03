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
  ssn             char(9) not null,
  docId		      char(6) not null,   
  PRIMARY KEY     (docId, ssn)				#composite key   
);

DROP TABLE IF EXISTS PRESCRIPTION;
CREATE TABLE PRESCRIPTION (
  scriptname        varchar(25) not null,
  scriptId          char(7) not null,
  dosage		    varchar(30),   
  doc_Id            char(10) not null,
  pat_Id            char(10) not null,
  PRIMARY KEY  (scriptId),
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);

DROP TABLE IF EXISTS TEST;
CREATE TABLE TEST (
  testname        varchar(25) not null,
  testId  		  char(7) not null,         
  price           decimal(4, 2),       
  doc_Id          char(10) not null,
  pat_Id          char(10) not null,
  testdate        date,
  PRIMARY KEY  (testname, testId),                    #composite key
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId),
  FOREIGN KEY  (pat_Id) REFERENCES PATIENT(patId)
);

DROP TABLE IF EXISTS OFFICE;
CREATE TABLE OFFICE (
  address          varchar(25) not null,
  sqFootage  	   char(7) not null,         
  facilityType     varchar(10) not null,
  Doc_Id           char(10) not null,
  PRIMARY KEY  (address),
  FOREIGN KEY  (doc_Id) REFERENCES DOCTOR(docId)
);

INSERT INTO DOCTOR VALUES ('Frank','Ocean','334660082','FO9999');
INSERT INTO DOCTOR VALUES ('Edward','Lee','910319844','EL8888');
INSERT INTO DOCTOR VALUES ('Drake','Henry','344882061','DH7777');
INSERT INTO DOCTOR VALUES ('Joshua','Oswald','100745333','JO6666');

INSERT INTO PATIENT VALUES ('Jacob','Stevens','444333222','1234512345','2019-01-17', '714-900-6598');
INSERT INTO PATIENT VALUES ('Mark','Roberts','444555666','1878784833','2018-04-29', '616-978-8865');
INSERT INTO PATIENT VALUES ('Vanessa','Lin','309222576','9984562331','2019-09-10', '714-332-1008');
INSERT INTO PATIENT VALUES ('Jeremy','Prendo','404553229','9555400782','2019-11-16', '410-779-4437');


#################################################
# INSERTING INTO PRESCRIPTION
#################################################

INSERT INTO PRESCRIPTION VALUES ('Benedril','P000001','once a day', 
# Inserting doc_id into prescription and make Edward Lee DOCTOR foreign key to Benedril
(select docId from DOCTOR where docId = 'EL8888'),
# Inserting doc_id into prescription and make Jacob Stevens PATIENT foreign key to Benedril
(select patId from PATIENT where patId = '1234512345'));

INSERT INTO PRESCRIPTION VALUES ('Advil','P000002','twice a day',
# Inserting doc_id into prescription and make Frank Ocean DOCTOR foreign key to Advil 
(select docId from DOCTOR where docId = 'FO9999'), 
# Inserting doc_id into prescription and make Mark Roberts PATIENT foreign key to Advil
(select patId from PATIENT where patId = '1878784833'));

INSERT INTO PRESCRIPTION VALUES ('Codeine','P000003','60mL once every 4 days',
# Inserting doc_id into prescription and make Drake Henry DOCTOR foreign key to Advil
(select docId from DOCTOR where docId = 'DH7777'), 
# Inserting doc_id into prescription and make Venessa Lin PATIENT foreign key to Advil
(select patId from PATIENT where patId = '9984562331'));

INSERT INTO PRESCRIPTION VALUES ('Amoxil','P000004','once a day',
# Inserting doc_id into prescription and make Joshua Oswald DOCTOR foreign key to Advil
(select docId from DOCTOR where docId = 'JO6666'), 
# Inserting doc_id into prescription and make Jeremy Prendo PATIENT foreign key to Advil
(select patId from PATIENT where patId = '9555400782'));



#################################################
# INSERTING INTO TEST
#################################################

INSERT INTO TEST VALUES ('Blood Test','T000001','30.00', 
# Inserting doc_id into TEST and make Frank Ocean DOCTOR foreign key to Blood Test
(select docId from DOCTOR where docId = 'FO9999'), 
# Inserting doc_id into TEST and make Mark Roberts PATIENT foreign key to Blood Test
(select patId from PATIENT where patId = '1878784833'), '2020-10-12');

INSERT INTO TEST VALUES ('Throat Swab','T000002','05.00',
# Inserting doc_id into TEST and make Frank Ocean DOCTOR foreign key to Throat Swab
(select docId from DOCTOR where docId = 'FO9999'), 
# Inserting doc_id into TEST and make Jacob Stevens PATIENT foreign key to Throat Swab
(select patId from PATIENT where patId = '1234512345'), '2020-08-08');

INSERT INTO TEST VALUES ('CAT Scan','T000003','75.00',
# Inserting doc_id into TEST and make Drake Henry DOCTOR foreign key to CAT Scan
(select docId from DOCTOR where docId = 'DH7777'), 
# Inserting doc_id into TEST and make Venessa Lin PATIENT foreign key to CAT Scan
(select patId from PATIENT where patId = '9984562331'), '2020-06-24');

INSERT INTO TEST VALUES ('Lung XRAY','T000004','60.00',
# Inserting doc_id into TEST and make Joshua Oswald DOCTOR foreign key to Lung XRAY
(select docId from DOCTOR where docId = 'JO6666'), 
# Inserting doc_id into TEST and make Jacob Stevens PATIENT foreign key to Lung XRAY
(select patId from PATIENT where patId = '1234512345'), '2020-08-08');
