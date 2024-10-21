/*
Today's topic: Subqueries.sql
*/
USE [SQLTutorial];
SELECT * FROM SQLTutorial..EmployeeSalary;

-- Subquery in SELECT
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM SQLTutorial..EmployeeSalary) AS AllAverageSalary FROM SQLTutorial..EmployeeSalary;

-- How to do it with Partition by
SELECT EmployeeID, Salary, AVG(Salary) OVER (PARTITION BY Salary) AS AllAverageSalary
FROM SQLTutorial..EmployeeSalary;

-- Why GROUP BY Doesn't work
SELECT EmployeeID, Salary, AVG(Salary) as ALLAvgSalary
FROM SQLTutorial..EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1, 2;

-- subquery in From
SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) over() AS AllAvgSalary 
FROM SQLTutorial..EmployeeSalary) a;

-- Subquery in WHERE statement
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial..EmployeeSalary
WHERE EmployeeID IN(
	SELECT EmployeeID
	FROM EmployeeDemographics
	WHERE Age > 30
);

