USE SQLTutorial;
SELECT Demo.EmployeeId, Demo.FirstName, Demo.FirstName,
	Sal.JobTitle, Ware.Age
FROM [SQLTutorial].[dbo].EmployeeDemographics Demo
LEFT JOIN [SQLTutorial].[dbo].EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [SQLTutorial].[dbo].WareHouseEmployeeDemographics Ware
	ON Demo.EmployeeID = Ware.EmployeeID;