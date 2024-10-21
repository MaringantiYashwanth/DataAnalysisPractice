USE [SQL Tutorial];
SELECT * 
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC;

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender;