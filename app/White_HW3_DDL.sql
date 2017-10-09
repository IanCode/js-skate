.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

CREATE TABLE Student(
	studentID INTEGER UNIQUE PRIMARY KEY NOT NULL,
	studentName STRING NOT NULL,
	major STRING, 
	class STRING NOT NULL, 
	gpa REAL,
	CHECK (class IN ('Freshman', 'Sophomore', 'Junior', 'Senior')),
	CHECK (gpa >= 0.0 AND gpa <= 4.0),
	FOREIGN KEY(major) REFERENCES Dept(deptID) ON DELETE SET NULL
	);

CREATE TABLE Course(
	courseNum INTEGER NOT NULL,
	deptID INTEGER NOT NULL, 
	courseName STRING NOT NULL, 
	location STRING NOT NULL,
	meetDay STRING NOT NULL,
	meetTime TIME NOT NULL,
	CHECK (meetTime BETWEEN '07:00' AND '17:00'),
	FOREIGN KEY(deptID) REFERENCES Dept(deptID) ON DELETE CASCADE,
	PRIMARY KEY(courseNum, deptID)
	);

CREATE TABLE Dept(
	deptID STRING UNIQUE NOT NULL PRIMARY KEY,
	name STRING UNIQUE NOT NULL,
	building STRING NOT NULL,
	CHECK (length(deptID) <= 4)

	);

CREATE TABLE Enroll(
	courseNum INTEGER NOT NULL, 
	deptID STRING, 
	studentID INTEGER NOT NULL,
	FOREIGN KEY(studentID) REFERENCES Student(studentID),
	FOREIGN KEY(courseNum, deptID) REFERENCES Course(courseNum, deptID) ON DELETE CASCADE,
	PRIMARY KEY(studentID, deptID, courseNum)
	);
