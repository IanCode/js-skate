--Find all department codes and the department names in this university (5pts)
SELECT DeptID, name FROM Dept;
.print '' 
--Find all student, enrollment, and course info (joined together) (5pts)
SELECT * FROM Student NATURAL JOIN Dept, Course;
.print '' 
--Get all courses being taught by the MATH department that start in the afternoon. You may assume that time is always in 24hr military-style. (5pts)
SELECT courseName FROM Course WHERE (meetTime > '12:00' AND deptID == 'MATH');
.print '' 
--Retrieve all courses in which Alexis is currently enrolled. Project only the course information. (5pts)
SELECT courseNum, deptID, courseName, location, meetDay, meetTime FROM Course NATURAL JOIN Enroll WHERE (studentID == 1247);
.print '' 
--Find all the students who are only taking classes only in their major. Sort the results by the students' class and then major. (10pts)
SELECT * FROM Enroll NATURAL JOIN Student WHERE major == deptID EXCEPT SELECT * FROM Enroll NATURAL JOIN Student WHERE major != deptID ORDER BY class;
.print '' 
SELECT * FROM Enroll NATURAL JOIN Student WHERE major == deptID EXCEPT SELECT * FROM Enroll NATURAL JOIN Student WHERE major != deptID ORDER BY major;
.print '' 

--Find the average GPA for each of the student classes (freshman, sophomore, junior, senior). Rename the average GPA field to AvgClassGPA
--in the output. (5pts)
SELECT AVG(gpa) AS AvgClassGpa FROM Student GROUP BY Class;
.print ''

SELECT AVG(gpa) AS AvgClassGpa, class FROM Student GROUP BY Class;
.print ''
--Return the students who currently have a GPA less than the average of his/her respective class. (10pts)
SELECT AVG(gpa) AS AvgClassGpa, studentName FROM Student NATURAL JOIN Student GROUP BY class; --GROUP BY Class HAVING AVG(gpa) CROSS JOIN Student;
.print ''
--Find the names, IDs, and the number of courses they are taking, for the students who are taking the most number of courses. (10pts)
SELECT MAX(numCourses) AS numCourses, studentID, studentName FROM (SELECT COUNT(studentName) AS numCourses, studentID, studentName FROM Enroll NATURAL JOIN Student GROUP BY studentName);
.print ''
--Find the departments with the lowest and the highest overall student enrollment. (10pts)
SELECT name FROM (SELECT MAX(deptID), name FROM (SELECT COUNT(deptID) as deptID, name FROM Dept NATURAL JOIN Enroll GROUP BY deptID));
.print ''
SELECT name FROM (SELECT MIN(deptID), name FROM (SELECT COUNT(deptID) as deptID, name FROM Dept NATURAL JOIN Enroll GROUP BY deptID));
.print ''
/*You found a vulnerability to the Students table, and 
because you haven't taken an Ethics course yet, you 
decide to give every CS major a 0.5 bump in her GPA, 
and give every non-CS major a 0.5 reduction. (3pts)*/
UPDATE Student
    	SET gpa = 0.5 + gpa
    WHERE 
		major == 'CS' AND 0.5 + gpa <= 4.0;

UPDATE Student
	SET gpa = -0.5 + gpa
	WHERE 
	major != 'CS' AND -0.5 + gpa >= 0;

SELECT * FROM STUDENT;

SELECT * FROM STUDENT WHERE major == 'CS';


/*After the GPA mishap, the university now wants to add a new department, Philosophy,
 which will housed in a newly constructed building called Plato's Cave. They will 
 offer a course on PHIL 101: Ethics taught in room CAVE, and all CS majors are now 
 required to take it, effective immediately. Add the new department, course, and 
 student-course enrollments. (13pts) Enrolling CS students in PHIL 101 is harder 
 than it looks. It is worth reminding you that there could be hundreds of CS majors
  at a given university, and you certainly wouldn't want to enroll each person by 
  hand. This insert must be done using a single query.*/

INSERT INTO Dept (deptID, name, building) VALUES ('PHIL', 'Philosophy', 'Plato''s Cave');
SELECT * FROM Dept;

INSERT INTO Course (courseNum, deptID, courseName, location, meetDay, meetTime)
	VALUES(101, 'PHIL', 'Ethics', 'CAVE', 'MW', '09:00');
.print ''

SELECT * FROM Course;

INSERT INTO Enroll(courseNum, deptID, studentID) 
	SELECT courseNum, deptID, studentID FROM 
	Dept NATURAL JOIN (SELECT courseNum, deptID, studentID FROM Student
	CROSS JOIN Course WHERE major == 'CS' AND deptID == 'PHIL' AND courseNum == 101);

.print 'testing enroll stuff'
SELECT * FROM Enroll WHERE deptID == 'PHIL';
/*After an investigation, the university has decided to drop the CS department altogether. If your foreign keys are set properly, 
all CS courses, student enrollments in CS courses are also removed automatically. For students majoring in CS, 
their majors are now set to NULL. (4pts) */
.print ''
DELETE FROM Dept WHERE deptID == 'CS';
SELECT * FROM Dept;