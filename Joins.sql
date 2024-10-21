-- SELECT * 
-- FROM [SQL Tutorial].dbo.EmployeeDemographics;
-- 
-- SELECT *
-- FROM [SQL Tutorial].dbo.EmployeeSalary;
-- 
-- SELECT *
-- FROM [SQL Tutorial].dbo.EmployeeDemographics
-- INNER JOIN [SQL Tutorial].dbo.EmployeeSalary
-- 	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;
USE [SQL Tutorial];
SELECT *
FROM [SQL Tutorial].dbo.EmployeeDemographics
INNER JOIN [SQL Tutorial].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC;