-- 1. Database Creation
-- Create database used for task 1
CREATE DATABASE TASK1;
USE TASK1;

-- 2. Data Creation
-- Create tables
-- StudentInfo Table
CREATE TABLE StudentInfo (
	STU_ID INT PRIMARY KEY,
    STUDENT_NAME VARCHAR(50),
    DOB DATE,
    PHONE_NO INT,
    EMAIL_ID VARCHAR(20),
    ADDRESS VARCHAR(50)
);
ALTER TABLE StudentInfo
MODIFY COLUMN PHONE_NO VARCHAR(20);
ALTER TABLE StudentInfo
RENAME COLUMN STUDENT_NAME to STU_NAME;

-- CourseInfo Table
CREATE TABLE CourseInfo (
	COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(20),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);

-- Table EnrollmentInfo
CREATE TABLE EnrollmentInfo(
	ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CourseInfo(COURSE_ID)
);

-- Insert Sample Data
INSERT INTO StudentInfo VALUES
(1,"Kate","1999-01-02","1234567789","kate@email.com","23 Workhaven Lane"),
(2,"John","2000-03-03","2344567891","john@email.com","1411 Lillydale Drive"),
(3,"Mary","1997-04-30","5677891234","mary@email.com","777 Brockton Avenue"),
(4,"Nancy","1998-06-28","7899123567","nancy@email.com","30 Memorial Drive"),
(5,"Steve","2000-10-17","7654321899","steve@email.com","700 Oak Street");

INSERT INTO CourseInfo VALUES
(2001,"Math","Ms.Hillyer"),
(2002,"Logic","Mr.Stephens"),
(2006,"Writing","Ms.Wilson"),
(2008,"Reading","Mr.Peacock");

INSERT INTO EnrollmentInfo VALUES
(1,1,2001),
(2,1,2002),
(3,1,2008),
(4,2,2001),
(5,2,2006),
(6,3,2002),
(7,3,2006),
(8,3,2008),
(9,4,2001),
(10,4,2002),
(11,4,2006),
(12,4,2008),
(13,5,2002),
(14,5,2008);

-- Over the data creation
SELECT * FROM StudentInfo;
SELECT * FROM CourseInfo;
SELECT * FROM EnrollmentInfo;

-- 3. Retrieve the Student Information
-- a.1)Student details
SELECT STU_ID, STU_NAME, PHONE_NO, EMAIL_ID FROM StudentInfo;

-- a.2)Enrollment status
SELECT ENROLLMENT_ID, STU_ID, COURSE_ID FROM EnrollmentInfo;

-- b) Write a query to retrieve a list of courses in which a specific student is enrolled.
SELECT ENROLLMENT_ID, STU_ID, COURSE_ID FROM EnrollmentInfo WHERE STU_ID = 3;

-- c) Write a query to retrieve course information, including course name, instructor information.
SELECT * FROM CourseInfo;

-- d) Write a query to retrieve course information for a specific course .
SELECT * FROM CourseInfo WHERE COURSE_ID = 2006;

-- e) Write a query to retrieve course information for multiple courses.
SELECT * FROM CourseInfo WHERE COURSE_ID IN (2002, 2006, 2008);


-- 4. Reporting and Analytics (Using joining queries)
-- a) Write a query to retrieve the number of students enrolled in each course
SELECT e.COURSE_ID, c.COURSE_NAME, COUNT(e.STU_ID)
FROM EnrollmentInfo e JOIN CourseInfo c
ON e.COURSE_ID = c.COURSE_ID
GROUP BY 1,2;

-- b) Write a query to retrieve the list of students enrolled in a specific course
SELECT e.COURSE_ID, e.STU_ID, s.STU_NAME
FROM EnrollmentInfo e JOIN StudentInfo s
ON e.STU_ID = s.STU_ID
WHERE e.COURSE_ID = 2002;

-- c) Write a query to retrieve the count of enrolled students for each instructor.
SELECT c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID)
FROM EnrollmentInfo e JOIN CourseInfo c
ON e.COURSE_ID = c.COURSE_ID
GROUP BY 1;

-- d) Write a query to retrieve the list of students who are enrolled in multiple courses
SELECT e.STU_ID, s.STU_NAME, COUNT(e.COURSE_ID)
FROM EnrollmentInfo e JOIN StudentInfo s
ON e.STU_ID = s.STU_ID
GROUP BY 1,2
HAVING COUNT(e.COURSE_ID) > 1;

-- e) Write a query to retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)
SELECT e.COURSE_ID, c.COURSE_NAME, COUNT(e.STU_ID)
FROM EnrollmentInfo e JOIN CourseInfo c
ON e.COURSE_ID = c.COURSE_ID
GROUP BY 1,2
ORDER BY COUNT(e.STU_ID) DESC;


