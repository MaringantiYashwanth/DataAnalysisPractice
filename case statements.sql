/*
Today's topic: Case statement
*/

SELECT FirstName, LastName, Age,
CASE
	WHEN Age = 38 THEN 'Stanley'
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'YOUNG'
	ELSE 'Baby'
END
FROM SQLTutorial.dbo.EmployeeDemographics 
WHERE Age IS NOT NULL ORDER BY AGE;

SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .00001)
	ELSE Salary + (Salary * 0.03)
END AS SalaryAfterRaise
FROM SQLTutorial.dbo.EmployeeDemographics 
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;