-- =========================================================
-- UNIVERSITY COURSE MANAGEMENT SYSTEM
-- FINAL SQL PROJECT
-- =========================================================

-- STEP 1: Create Database
DROP DATABASE IF EXISTS UniversityCourseManagement;

CREATE DATABASE UniversityCourseManagement;

USE UniversityCourseManagement;


-- =========================================================
-- STEP 2: CREATE TABLES
-- =========================================================

-- 1. Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);


-- 2. Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE
);


-- 3. Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);


-- 4. Instructors Table
-- Salary added because Task 8 requires salary
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);


-- 5. Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);


-- =========================================================
-- STEP 3: INSERT DATA
-- =========================================================


-- Departments
INSERT INTO Departments
(DepartmentID, DepartmentName)
VALUES
(1, 'Computer Science'),
(2, 'Mathematics');


-- Students
INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01'),
(3, 'Rahul', 'Sharma', 'rahul.sharma@email.com', '2001-03-10', '2023-01-10'),
(4, 'Priya', 'Patel', 'priya.patel@email.com', '2000-07-18', '2023-02-15'),
(5, 'Amit', 'Verma', 'amit.verma@email.com', '2001-11-20', '2024-01-15'),
(6, 'Neha', 'Gupta', 'neha.gupta@email.com', '2000-09-12', '2022-09-05'),
(7, 'Rohan', 'Mehta', 'rohan.mehta@email.com', '1999-12-01', '2021-07-20'),
(8, 'Anjali', 'Singh', 'anjali.singh@email.com', '2001-04-22', '2023-03-12'),
(9, 'Vikas', 'Kumar', 'vikas.kumar@email.com', '2000-06-30', '2023-04-18'),
(10, 'Sneha', 'Joshi', 'sneha.joshi@email.com', '2001-02-14', '2024-02-20'),
(11, 'Karan', 'Malhotra', 'karan.malhotra@email.com', '2000-10-08', '2022-10-10'),
(12, 'Pooja', 'Agarwal', 'pooja.agarwal@email.com', '2001-08-16', '2023-05-11'),
(13, 'Arjun', 'Kapoor', 'arjun.kapoor@email.com', '2000-03-27', '2024-03-05'),
(14, 'Simran', 'Kaur', 'simran.kaur@email.com', '2001-01-19', '2022-06-15'),
(15, 'Aditya', 'Rao', 'aditya.rao@email.com', '2000-05-09', '2023-06-20');


-- Courses
INSERT INTO Courses
(CourseID, CourseName, DepartmentID, Credits)
VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4),
(103, 'Database Management', 1, 4),
(104, 'Calculus', 2, 3),
(105, 'Statistics', 2, 3);


-- Instructors
INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 75000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 68000),
(3, 'David', 'Brown', 'david.brown@univ.com', 1, 82000),
(4, 'Emma', 'Wilson', 'emma.wilson@univ.com', 2, 70000),
(5, 'Michael', 'Taylor', 'michael.taylor@univ.com', 1, 78000);


-- Enrollments
INSERT INTO Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 101, '2022-08-02'),
(3, 3, 101, '2023-01-10'),
(4, 4, 101, '2023-02-15'),
(5, 5, 101, '2024-01-15'),
(6, 6, 101, '2022-09-05'),
(7, 7, 101, '2021-07-20'),
(8, 8, 101, '2023-03-12'),
(9, 9, 101, '2023-04-18'),
(10, 10, 101, '2024-02-20'),
(11, 11, 101, '2022-10-10'),

(12, 1, 102, '2022-08-05'),
(13, 2, 102, '2021-08-05'),
(14, 3, 102, '2023-01-15'),
(15, 4, 102, '2023-02-20'),
(16, 5, 102, '2024-01-20'),
(17, 6, 102, '2022-09-10'),
(18, 7, 102, '2021-07-25'),
(19, 8, 102, '2023-03-15'),

(20, 9, 103, '2023-04-20'),
(21, 10, 103, '2024-02-22'),
(22, 12, 103, '2023-05-15'),
(23, 13, 103, '2024-03-10'),

(24, 2, 104, '2021-08-10'),
(25, 4, 104, '2023-02-25'),
(26, 6, 104, '2022-09-15'),

(27, 3, 105, '2023-01-20'),
(28, 5, 105, '2024-01-25');


-- =========================================================
-- STEP 4: CHECK TABLES
-- =========================================================

SELECT * FROM Departments;

SELECT * FROM Students;

SELECT * FROM Courses;

SELECT * FROM Instructors;

SELECT * FROM Enrollments;
