--INTERMEDIATE:

-- Joins
-- Unions
-- Case Statements
-- Updating/Deleting Data
-- Partition By
-- Data Types
-- Aliasing
-- Creating Views
-- Having vs Group By Statement
-- GETDATE()
-- Primary Key vs Foreign Key
SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
FULL OUTER JOIN SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
LEFT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
RIGHT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

SELECT JobTitle, AVG(Salary) FROM SQLTutorial.dbo.EmployeeDemographics INNER JOIN SQLTutorial.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle='Salesman'
GROUP BY JobTitle;