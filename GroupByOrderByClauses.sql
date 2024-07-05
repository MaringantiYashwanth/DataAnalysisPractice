/*
GROUP BY, ORDER BY
*/
USE [SQL Tutorial];
SELECT * FROM [SQL Tutorial].dbo.EmployeeDemographics;

SELECT Gender, Age, COUNT(Gender)
FROM [SQL Tutorial].dbo.EmployeeDemographics
GROUP BY Gender, Age;

SELECT Gender, Count(Gender) AS CountGender
FROM [EmployeeDemographics]
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC

SELECT * 
FROM [EmployeeDemographics]
ORDER BY 4 DESC, 5 DESC;