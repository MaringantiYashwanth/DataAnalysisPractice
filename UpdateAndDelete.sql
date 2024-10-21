/*
Today's Topic
Having Clause
*/ 

SELECT JobTitle, COUNT(JobTitle) FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)
;

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012;

SELECT * FROM SQLTutorial.dbo.EmployeeDemographics;
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012;

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age=31, Gender='Female'
WHERE EmployeeID=1012;

DELETE FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1012;

SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1004;
-- WHERE FirstName = 'Holly' AND LastName = 'Flax';

/*
Today's Topic: Aliasing
*/
-- SELECT FirstName + ' ' + LastName As FullName
SELECT Demo.EmployeeID, Sal.Salary
FROM [SQLTutorial].[dbo].[EmployeeDemographics] Demo
JOIN [SQLTutorial].[dbo].[EmployeeSalary] AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID;

SELECT * FROM [SQLTutorial].[dbo].[EmployeeDemographics] Demo
LEFT JOIN [SQLTutorial].[dbo].EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [SQLTutorial].[dbo].WareHouseEmployeeDemographics Ware
	ON Demo.EmployeeID = Ware.EmployeeID;