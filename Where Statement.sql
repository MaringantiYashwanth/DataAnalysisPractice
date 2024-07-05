--SELECT TOP(1000) [EmployeeID]
--	,[FirstName]
--	,[LastName]
--	,[Age]
--	,[Gender]
--	FROM [SQL Tutorial].dbo.EmployeeDemographics;

/*
WHERE STATEMENT
=, <>, <, >, AND, OR, Like, NULL, NOT NULL, IN
*/
SELECT * FROM 
[EmployeeDemographics]
WHERE Age > 30 AND Gender='MALE';

SELECT * FROM 
[EmployeeDemographics]
WHERE LastName LIKE 'S%';

SELECT * FROM [EmployeeDemographics] WHERE FirstName IS NOT NULL;

SELECT * FROM [EmployeeDemographics] WHERE FirstName IN ('JIM', 'Michael');

SELECT * FROM [EmployeeDemographics] WHERE Gender IN ('FEMALE');
