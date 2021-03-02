DROP TABLE IF EXISTS AgeGroup;
CREATE TABLE AgeGroup (
	AgeGroupID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Age_0_9 bit NOT NULL,
	Age_10_19 bit NOT NULL,
	Age_20_24 bit NOT NULL,
	Age_25_59 bit NOT NULL,
	Age_60_up bit NOT NULL
	);

DROP TABLE IF EXISTS Contact_Tracing;
CREATE TABLE Contact_Tracing (
	ContractTracingID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Contact_DontKnow bit NOT NULL,
	Contact_No bit NOT NULL,
	Contact_Yes bit NOT NULL
	);

DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
	CountryID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	CountryName nvarchar NOT NULL
	);

DROP TABLE IF EXISTS Gender;
CREATE TABLE Gender (
	GenderID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Gender_Male bit NOT NULL,
	Gender_Female bit NOT NULL,
	Gender_Transgender bit NOT NULL
	);

DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
	SymptomsID int NOT NULL,
	AgeGroupID int NOT NULL,
	GenderID int NOT NULL,
	CountryID int NOT NULL,
	ContractTracingID int NOT NULL,
	SeverityID int NOT NULL
	);

DROP TABLE IF EXISTS Severity;
CREATE TABLE Severity (
	SeverityID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Symptom_Mild bit NOT NULL,
	Symptom_Moderate bit NOT NULL,
	Symptom_None bit NOT NULL,
	Symptom_Severe bit NOT NULL
	);

DROP TABLE IF EXISTS Symptoms;
CREATE TABLE Symptoms (
	SymptomsID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Fever bit NOT NULL,
	Tiredness bit NOT NULL,
	Dry_Cough bit NOT NULL,
	Difficulty_in_Breathing bit NOT NULL,
	Sore_Throat bit NOT NULL,
	None_Sympton bit NOT NULL,
	Pains bit NOT NULL,
	Nasal_Congestion bit NOT NULL,
	Runny_Nose bit NOT NULL,
	Diarrhea bit NOT NULL,
	None_Experiencing bit NOT NULL
	);

ALTER TABLE Patient ADD CONSTRAINT FKPatient180077 FOREIGN KEY (SymptomsID) REFERENCES Symptoms (SymptomsID);

ALTER TABLE Patient ADD CONSTRAINT FKPatient842945 FOREIGN KEY (AgeGroupID) REFERENCES AgeGroup (AgeGroupID);

ALTER TABLE Patient ADD CONSTRAINT FKPatient939057 FOREIGN KEY (GenderID) REFERENCES Gender (GenderID);

ALTER TABLE Patient ADD CONSTRAINT FKPatient25616 FOREIGN KEY (CountryID) REFERENCES Country (CountryID);

ALTER TABLE Patient ADD CONSTRAINT FKPatient871368 FOREIGN KEY (ContractTracingID) REFERENCES Contact_Tracing (ContractTracingID);

ALTER TABLE Patient ADD CONSTRAINT FKPatient190775 FOREIGN KEY (SeverityID) REFERENCES Severity (SeverityID);