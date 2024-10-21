-- CREATE TABLE EmployeeDemographics
-- (EmployeeID int,
-- FirstName varchar(50),
-- LastName varchar(50),
-- Age int,
-- Gender varchar(50)
-- );
-- CREATE TABLE EmployeeSalary 
-- (EmployeeID int,
-- JobTitle varchar(50),
-- Salary int);
-- INSERT INTO EmployeeDemographics VALUES
-- (1001, 'Jim', 'Halpert', 30, 'Male');
/***** Script for SelectTopNRows command from SSMS ******/
-- ALTER DATABASE 'SQL Tutorial' SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- ALTER DATABASE 'SQLTutorial' SET MULTI_USER WITH ROLLBACK IMMEDIATE;

-- ALTER DATABASE 'SQL Tutorial' MODIFY NAME = 'SQLTutorial';

SELECT TOP(1000) [EmployeeID]
	,[FirstName]
	,[LastName]
	,[Age]
	,[Gender]
	FROM [SQL Tutorial].[dbo].[EmployeeDemographics];
INSERT INTO EmployeeDemographics VALUES 
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male');



