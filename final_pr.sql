 use UniversityCourseManagement;

-- =========================================================
-- TASK 1: CRUD OPERATIONS ON ALL TABLES
-- =========================================================


-- -------------------------
-- CREATE / INSERT
-- -------------------------

INSERT INTO Departments
VALUES (99, 'Test Department');
SELECT * FROM Departments;


INSERT INTO Students
VALUES
(99, 'Test', 'Student', 'test.student@email.com',
 '2000-01-01', '2024-01-01');
 SELECT * FROM Students;


INSERT INTO Courses
VALUES
(199, 'Test Course', 99, 3);
SELECT * FROM Courses;


INSERT INTO Instructors
VALUES
(99, 'Test', 'Instructor', 'test.instructor@univ.com',
 99, 60000);
 SELECT * FROM Instructors;

INSERT INTO Enrollments
VALUES
(99, 99, 199, '2024-01-01');
SELECT * FROM Enrollments;


-- -------------------------
-- READ / SELECT
-- -------------------------

SELECT * FROM Departments;

SELECT * FROM Students;

SELECT * FROM Courses;

SELECT * FROM Instructors;

SELECT * FROM Enrollments;


-- -------------------------
-- UPDATE
-- -------------------------

UPDATE Departments
SET DepartmentName = 'Test Department Updated'
WHERE DepartmentID = 99;
SELECT * FROM Departments;

UPDATE Students
SET FirstName = 'Updated'
WHERE StudentID = 99;
SELECT * FROM Students;


UPDATE Courses
SET Credits = 4
WHERE CourseID = 199;
SELECT * FROM Courses;


UPDATE Instructors
SET Salary = 65000
WHERE InstructorID = 99;
SELECT * FROM Instructors;


UPDATE Enrollments
SET EnrollmentDate = '2024-02-01'
WHERE EnrollmentID = 99;
SELECT * FROM Enrollments;


-- -------------------------
-- DELETE
-- -------------------------

DELETE FROM Enrollments
WHERE EnrollmentID = 99;
SELECT * FROM Enrollments;


DELETE FROM Instructors
WHERE InstructorID = 99;
SELECT * FROM Instructors;

DELETE FROM Courses
WHERE CourseID = 199;
SELECT * FROM Courses;

DELETE FROM Students
WHERE StudentID = 99;
SELECT * FROM Students;

DELETE FROM Departments
WHERE DepartmentID = 99;
SELECT * FROM Departments;


-- =========================================================
-- TASK 2
-- Retrieve students who enrolled after 2022
-- =========================================================

SELECT *
FROM Students
WHERE EnrollmentDate >= '2023-01-01';


-- =========================================================
-- TASK 3
-- Retrieve courses offered by Mathematics department
-- Limit of 5 courses
-- =========================================================

SELECT
    c.CourseID,
    c.CourseName,
    c.Credits,
    d.DepartmentName
FROM Courses c
INNER JOIN Departments d
ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;


-- =========================================================
-- TASK 4
-- Number of students enrolled in each course
-- Only courses having more than 5 students
-- =========================================================

SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
JOIN Enrollments e
ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5;


-- =========================================================
-- TASK 5
-- Students enrolled in BOTH Introduction to SQL
-- and Data Structures
-- =========================================================

SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e1
ON s.StudentID = e1.StudentID
JOIN Courses c1
ON e1.CourseID = c1.CourseID
JOIN Enrollments e2
ON s.StudentID = e2.StudentID
JOIN Courses c2
ON e2.CourseID = c2.CourseID
WHERE c1.CourseName = 'Introduction to SQL'
AND c2.CourseName = 'Data Structures';


-- =========================================================
-- TASK 6
-- Students enrolled in EITHER Introduction to SQL
-- OR Data Structures
-- =========================================================

SELECT DISTINCT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
JOIN Courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName IN
('Introduction to SQL', 'Data Structures');


-- =========================================================
-- TASK 7
-- Calculate average credits of all courses
-- =========================================================

SELECT
    AVG(Credits) AS AverageCredits
FROM Courses;


-- =========================================================
-- TASK 8
-- Maximum salary of instructors
-- in Computer Science department
-- =========================================================

SELECT
    MAX(i.Salary) AS MaximumSalary
FROM Instructors i
JOIN Departments d
ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';


-- =========================================================
-- TASK 9
-- Count number of students enrolled in each department
-- =========================================================

SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS NumberOfStudents
FROM Departments d
JOIN Courses c
ON d.DepartmentID = c.DepartmentID
JOIN Enrollments e
ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;


-- =========================================================
-- TASK 10
-- INNER JOIN
-- Retrieve students and their corresponding courses
-- =========================================================

SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName
FROM Students s
INNER JOIN Enrollments e
ON s.StudentID = e.StudentID
INNER JOIN Courses c
ON e.CourseID = c.CourseID;


-- =========================================================
-- TASK 11
-- LEFT JOIN
-- Retrieve all students and their courses, if any
-- =========================================================

SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName
FROM Students s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID
LEFT JOIN Courses c
ON e.CourseID = c.CourseID;


-- =========================================================
-- TASK 12
-- SUBQUERY
-- Students enrolled in courses having
-- more than 10 students
-- =========================================================

SELECT DISTINCT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
WHERE e.CourseID IN
(
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 10
);


-- =========================================================
-- TASK 13
-- Extract year from EnrollmentDate
-- =========================================================

SELECT
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;


-- =========================================================
-- TASK 14
-- Concatenate instructor first and last name
-- =========================================================

SELECT
    InstructorID,
    CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;


-- =========================================================
-- TASK 15
-- Running total of students enrolled in courses
-- Using Window Function
-- =========================================================

SELECT
    EnrollmentID,
    StudentID,
    CourseID,
    EnrollmentDate,
    SUM(1) OVER (
        ORDER BY EnrollmentDate, EnrollmentID
    ) AS RunningTotal
FROM Enrollments
ORDER BY EnrollmentDate, EnrollmentID;


-- =========================================================
-- TASK 16
-- Label students as Senior or Junior
--
-- More than 4 years old enrollment = Senior
-- Otherwise = Junior
-- =========================================================

SELECT
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    CASE
        WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
        THEN 'Senior'
        ELSE 'Junior'
    END AS StudentLevel
FROM Students
ORDER BY EnrollmentDate;