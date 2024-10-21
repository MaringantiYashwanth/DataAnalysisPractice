/***** Script for SelectTopNRows command from SSMS *****/
USE [SQL Tutorial];
SELECT TOP (1000) [EmployeeID]
	,[FirstName]
	,[LastName]
	,[Age]
	,[Gender]
	FROM [SQL Tutorial].[dbo].[EmployeeDemographics];