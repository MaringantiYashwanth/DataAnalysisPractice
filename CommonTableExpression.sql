/*
Today's Topic: CTEs
*/

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Salary) AS AvgSalary
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)

SELECT * FROM CTE_Employee; -- CTE is not stored anywhere


WITH CTE_Employee2 AS 
(SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER(PARTITION BY Gender) AS TotalGender,
SUM(Salary) OVER (PARTITION BY Salary) AS TotalSalary
FROM SQLTutorial.dbo.EmployeeDemographics dem
INNER JOIN SQLTutorial.dbo.EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID
) SELECT * FROM CTE_Employee2;








