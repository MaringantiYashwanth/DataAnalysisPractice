/*
Today's Topic: Partition By
In Group By Statement we can only show GENDER, COUNT(Gender)
Where as in Partition By we can show FirstName, LastName, Gender, Salary, COUNT(Gender) ...
*/

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial..EmployeeDemographics dem
JOIN SQLTutorial..EmployeeSalary sal
	ON dem.EmployeeId = sal.EmployeeID;
--SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender 
--FROM SQLTutorial..EmployeeDemographics dem
--JOIN SQLTutorial..EmployeeSalary sal
--	on dem.EmployeeID = sal.EmployeeID;
SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM SQLTutorial..EmployeeDemographics dem
JOIN SQLTutorial..EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary;

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) 
FROM SQLTutorial..EmployeeDemographics dem
JOIN SQLTutorial..EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary;

SELECT Gender, COUNT(Gender) 
FROM SQLTutorial.dbo.EmployeeDemographics dem
JOIN SQLTutorial.dbo.EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender;

