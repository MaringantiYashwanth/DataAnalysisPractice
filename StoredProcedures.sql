/*
Today's Topic: Stored Procedure
*/

--CREATE PROCEDURE TEST
--AS 
--SELECT * 
--FROM EmployeeDemographics
--
--EXEC TEST

CREATE PROCEDURE Temp_Employee
AS 
CREATE TABLE #temp_employee (
JobTitle varchar(100),
EmployeePerJob int,
Average int,
AvgSalary int
);

INSERT INTO #temp_employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics dem
JOIN SQLTutorial.dbo.EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
WHERE JobTitle = @JobTitle
GROUP BY JobTitle;

SELECT * FROM #temp_employee;

SELECT * 
FROM #temp_employee
EXEC Temp_Employee @JobTitle = 'Salesman';

