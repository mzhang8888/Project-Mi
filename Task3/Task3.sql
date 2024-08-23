# 1. Database Creation

-- Create a database named "EventsManagement."
CREATE DATABASE EventsManagement;
USE EventsManagement;

-- Create tables for Events, Attendees, and Registrations.
CREATE TABLE Events(
	Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(30),
    Event_Date DATE,
    Event_Location VARCHAR(50),
    Event_Description VARCHAR(200)
);
    
CREATE TABLE Attendees(
	Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(20),
    Attendee_Phone VARCHAR(10),
    Attendee_Email VARCHAR(40),
    Attendee_City VARCHAR(15)
);

CREATE TABLE Registrations(
	Registration_Id INT PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount INT,
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);


# 2. Data Creation
-- Insert some sample data for Events, Attendees, and Registrations tables with respective fields.
INSERT INTO Events VALUES
(1,"College Quidditch Final","1995-04-30","Playground","Final match of college between Gryffindor and Slytherin."),
(2,"Goblet of Fire Final","1995-07-23","Forbidden Forest","Final Triwizard tournament."),
(3,"Outing to Hogsmeade","1995-09-19","Hogsmeade Village","The first outing in fall 1990 for students.");

INSERT INTO Attendees VALUES
(101,"Harry","2345678890","harry@hogwarts.com","London"),
(102,"Hermione","2323118904","hermione@hogwarts.com","London"),
(103,"Ron","6719202623","ron@hogwarts.com","Devon"),
(104,"Cho","7469348354","chozhang@hogwarts.com","Scotland"),
(105,"Draco","6542163141","dracorepu@hogwarts.com","Wiltshire");

INSERT INTO Registrations VALUES
(1,1,101,"1995-01-03",1),
(2,2,101,"1995-03-31",3),
(3,3,102,"1995-08-12",1),
(4,3,103,"1995-08-06",1),
(5,3,104,"1995-07-20",1),
(6,1,105,"1995-02-19",1);

SELECT * FROM Events;
SELECT * FROM Attendees;
SELECT * FROM Registrations;


# 3. Manage Event Details

-- a) Inserting a new event.
INSERT INTO Events VALUES
(4,"Triwizard Ball","1995-06-15","Hogwarts Hall","Let's dance and party with our sisters and brothers!");

-- b) Updating an event's information.
UPDATE Events
SET Event_Date = "1995-09-20"
WHERE Event_Id = 3;

SELECT * FROM Events;

-- c) Deleting an event.
DELETE FROM Events WHERE Event_Id = 4;


# 4. Manage Track Attendees & Handle Events

-- a) Inserting a new attendee.
INSERT INTO Attendees VALUES
(106,"Fleur","1977101330","fleurflower@hogwarts.com","Pyrenees");

SELECT * FROM Attendees;

-- b) Registering an attendee for an event
INSERT INTO Registrations VALUES
(7,2,106,"1995-03-31",3);

SELECT * FROM Registrations;


# 5. Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.

-- a) Write a query to retrieve the number of attendees registrated and total registration amount in each event
SELECT Event_Id, COUNT(Attendee_Id), SUM(Registration_Amount) FROM Registrations
GROUP BY 1;

-- b) Write a query to retrieve the list of attendee names who registrated in event "Outing to Hogsmeade".
SELECT e.Event_Name, a.Attendee_Name FROM Attendees a
JOIN Registrations r ON a.Attendee_Id = r.Attendee_ID
JOIN Events e ON e.Event_Id = r.Event_ID
WHERE e.Event_Name = "Outing to Hogsmeade";

-- c) Write a query to retrieve the list of attendee names who registrated in multiple envents
SELECT a.Attendee_Name, COUNT(r.Event_Id)
FROM Attendees a
JOIN Registrations r ON r.Attendee_Id = a.Attendee_Id
GROUP BY 1
HAVING COUNT(r.Event_Id) > 1;

-- d) Write a query to calculate the total attendees registrated in event by event month and event location(ROLLUP function)
SELECT MONTH(e.Event_Date) AS Event_Month, e.Event_Location, COUNT(r.Attendee_Id) AS total_Attendees
FROM Registrations r JOIN Events e
ON r.Event_Id = e.Event_Id
GROUP BY 1,2  WITH ROLLUP;




    
