-- 1. Database Setup
CREATE DATABASE student_database;
USE student_database;

CREATE TABLE student_table(
	Student_id INT PRIMARY KEY,
    Stu_name VARCHAR(20),
    Department VARCHAR(20),
    Email_id VARCHAR(20),
    Phone_no VARCHAR(10),
    Address VARCHAR(50),
    Date_of_birth DATE,
    Gender VARCHAR(10),
    Major VARCHAR(20),
    GPA FLOAT(2),
    Grade VARCHAR(5)
);
ALTER TABLE student_table
MODIFY COLUMN Email_id VARCHAR(50);

-- 2. Data Entry
INSERT INTO student_table VALUES
(1,"Harry","Gryffindor","harry@hogwarts.com","2345678890","591 Memorial Dr","1980-07-31","Male","Flying",3.9,"A"),
(2,"Hermione","Gryffindor","hermione@hogwarts.com","2323118904","121 Worcester Rd","1979-09-19","Female","History of Magic",4.0,"A"),
(3,"Ron","Gryffindor","ron@hogwarts.com","6719202623","137 Teaticket Hwy","1980-03-01","Male","Muggle Studies",3.0,"B"),
(4,"Cho","Ravenclaw","chozhang@hogwarts.com","7469348354","677 Timpany Blvd","1980-06-16","Female","Acient Studies",3.8,"A"),
(5,"Luna","Ravenclaw","lunalovegood@hogwarts.com","8777920818","11 Jungle Road","1981-02-13","Female","Charms",3.6,"A"),
(6,"Draco","Slytherin","dracorepu@hogwarts.com","6542163141","742 Main Street","1980-05-06","Male","Flying",2.9,"C"),
(7,"Cedric","Hufflepuff","cedric@hogwarts.com","4657717785","295 Plymouth Street","1977-09-08","Male","Acient Studies",3.7,"A"),
(8,"Ginny","Gryffindor","ginnygold@hogwarts.com","3951299645","137 Teaticket Hwy","1981-08-11","Female","Charms",3.3,"B"),
(9,"Norris","Ravenclaw","norrismeow@hogwarts.com","1224237032","301 Falls Blvd","1985-12-23","Female","History of Magic",2.5,"C"),
(10,"Rubeus","Gryffindor","rubeushagrid@hogwarts.com","9069427836","297 Grant Avenue","1928-06-12","Male","Acient Studies",2.7,"C");

-- 3. Student Information Retrieval: Develop a query to retrieve all students' information from the "student_table" and sort them in descending order by their grade.
SELECT * FROM student_table ORDER BY Grade DESC;

-- 4. Query for Male Students:Implement a query to retrieve information about all male students from the "student_table."
SELECT * FROM student_table WHERE Gender = "Male";

-- 5. Query for Students with GPA less than 5.0: Create a query to fetch the details of students who have a GPA less than 5.0 from the "student_table."
SELECT * FROM student_table WHERE GPA < 5;

-- 6. Update Student Email and Grade: Write an update statement to modify the email and grade of a student with a specific ID in the "student_table."
UPDATE student_table
SET Email_id = "ronron@hogwarts.com", GPA = 3.1
WHERE Student_id = 3;

SELECT * FROM student_table;

-- 7. Query for Students with Grade "B" Develop a query to retrieve the names and ages of all students who have a grade of "B" from the "student_table."
SELECT Stu_name, FLOOR(DATEDIFF("2000-12-12",Date_of_birth)/365) AS Stu_age
FROM student_table
WHERE Grade = "B";

-- 8. Grouping and Calculation: Create a query to group the "student_table" by the "Department" and "Gender" columns and calculate the average GPA for each combination.
SELECT Department, Gender, ROUND(AVG(GPA), 2) AS avg_GPA
FROM student_table
GROUP BY 1,2;

-- 9. Table Renaming: Rename the "student_table" to "student_info" using the appropriate SQL statement.
RENAME TABLE student_table TO student_info;

SHOW TABLES;

-- 10.Retrieve Student with Highest GPA: Write a query to retrieve the name of the student with the highest GPA from the "student_info" table.
SELECT Stu_name, GPA FROM student_info
ORDER BY GPA DESC LIMIT 1;