-- employees.sql
-- SQL Script for Team Directory Database
-- This file contains the schema and initial data for the Employees table
-- Note: This is a reference file. The application uses JSON file storage.

-- Create Employees Table
CREATE TABLE IF NOT EXISTS Employees (
    ID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(100) NOT NULL
);

-- Insert 100 Employee Records
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (1, 'Ali', 'Khan', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (2, 'Ahmed', 'Raza', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (3, 'Usman', 'Ali', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (4, 'Hamza', 'Sheikh', 'Full Stack Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (5, 'Bilal', 'Hussain', 'UI/UX Designer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (6, 'Ahsan', 'Malik', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (7, 'Hassan', 'Iqbal', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (8, 'Fahad', 'Khan', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (9, 'Saad', 'Ahmed', 'React Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (10, 'Umer', 'Farooq', 'ColdFusion Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (11, 'Zain', 'Butt', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (12, 'Adeel', 'Shah', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (13, 'Shahzaib', 'Khan', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (14, 'Asad', 'Mehmood', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (15, 'Taha', 'Yousaf', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (16, 'Noman', 'Riaz', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (17, 'Arslan', 'Javed', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (18, 'Imran', 'Ali', 'Project Manager');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (19, 'Kamran', 'Akhtar', 'Tech Lead');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (20, 'Rizwan', 'Malik', 'Software Architect');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (21, 'Maryam', 'Khan', 'UI/UX Designer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (22, 'Ayesha', 'Iqbal', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (23, 'Fatima', 'Sheikh', 'React Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (24, 'Hina', 'Raza', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (25, 'Sara', 'Ahmed', 'Product Manager');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (26, 'Noor', 'Fatima', 'Business Analyst');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (27, 'Anum', 'Malik', 'HR Executive');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (28, 'Sana', 'Khalid', 'UI Designer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (29, 'Iqra', 'Yousaf', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (30, 'Laiba', 'Hussain', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (31, 'Danish', 'Ali', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (32, 'Waqas', 'Khan', 'Database Administrator');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (33, 'Shahbaz', 'Ahmed', 'System Analyst');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (34, 'Farhan', 'Raza', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (35, 'Adnan', 'Latif', 'Tech Lead');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (36, 'Zubair', 'Mehmood', 'ColdFusion Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (37, 'Yasir', 'Iqbal', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (38, 'Naveed', 'Butt', 'QA Lead');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (39, 'Salman', 'Khan', 'Scrum Master');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (40, 'Owais', 'Junaid', 'Mobile App Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (41, 'Haris', 'Nadeem', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (42, 'Rehan', 'Akram', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (43, 'Sameer', 'Ali', 'Full Stack Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (44, 'Shayan', 'Khan', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (45, 'Faizan', 'Raza', 'React Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (46, 'Talha', 'Aslam', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (47, 'Ibrahim', 'Younis', 'Cloud Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (48, 'Ammar', 'Saeed', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (49, 'Zeeshan', 'Kamal', 'Security Analyst');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (50, 'Jawad', 'Hassan', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (51, 'Khurram', 'Shah', 'Project Manager');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (52, 'Umair', 'Rashid', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (53, 'Moiz', 'Khan', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (54, 'Arham', 'Ali', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (55, 'Huzaifa', 'Ahmed', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (56, 'Basit', 'Mehmood', 'Database Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (57, 'Tariq', 'Latif', 'Technical Writer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (58, 'Shahid', 'Iqbal', 'Support Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (59, 'Afzal', 'Hussain', 'IT Manager');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (60, 'Kashif', 'Raza', 'System Administrator');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (61, 'Muneeb', 'Khan', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (62, 'Hasnain', 'Ali', 'React Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (63, 'Shariq', 'Ahmed', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (64, 'Azhar', 'Mehmood', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (65, 'Rameez', 'Khalid', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (66, 'Farooq', 'Hassan', 'Tech Lead');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (67, 'Najeeb', 'Ullah', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (68, 'Abrar', 'Sheikh', 'Cloud Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (69, 'Faisal', 'Yousaf', 'Product Owner');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (70, 'Waleed', 'Akhtar', 'Business Analyst');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (71, 'Zarak', 'Khan', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (72, 'Haider', 'Raza', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (73, 'Sufyan', 'Ali', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (74, 'Jibran', 'Mehmood', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (75, 'Ehsan', 'Latif', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (76, 'Mustafa', 'Iqbal', 'Mobile Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (77, 'Rauf', 'Khan', 'ColdFusion Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (78, 'Asif', 'Ahmed', 'Integration Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (79, 'Nouman', 'Shafi', 'System Analyst');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (80, 'Shakeel', 'Anwar', 'IT Support');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (81, 'Farrukh', 'Jamal', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (82, 'Yahya', 'Khan', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (83, 'Dawood', 'Ali', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (84, 'Rayyan', 'Ahmed', 'Intern');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (85, 'Hammad', 'Raza', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (86, 'Abdullah', 'Khan', 'React Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (87, 'Ismail', 'Mehmood', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (88, 'Aamir', 'Naseer', 'Tech Consultant');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (89, 'Shoaib', 'Malik', 'Delivery Manager');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (90, 'Kaleem', 'Uddin', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (91, 'Ubaid', 'Khan', 'Backend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (92, 'Nashit', 'Ali', 'Frontend Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (93, 'Taimoor', 'Ahmed', 'Full Stack Developer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (94, 'Zahid', 'Rashid', 'QA Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (95, 'Haroon', 'Latif', 'DevOps Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (96, 'Saif', 'Ullah', 'Security Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (97, 'Adeel', 'Khan', 'Software Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (98, 'Nisar', 'Ahmed', 'Database Admin');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (99, 'Asghar', 'Ali', 'System Engineer');
INSERT INTO Employees (ID, FirstName, LastName, Role) VALUES (100, 'Shayan', 'Iqbal', 'Intern');
