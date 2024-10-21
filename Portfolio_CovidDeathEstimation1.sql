-- Exploratory Data Analysis or Data exploration
-- 1
SELECT * 
FROM PortfolioProject.dbo.CovidDeaths$ ORDER BY 3, 4;
SELECT * 
FROM PortfolioProject.dbo.CovidVaccinations$ ORDER BY 3, 4;

-- Select data that we are going to be using
-- 2
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths$
ORDER BY 1, 2;

SELECT * FROM PortfolioProject.dbo.CovidDeaths$;
-- 3
-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT [location], [date], total_cases, total_deaths, 
	TRY_CAST(total_deaths AS INT)/TRY_CAST(total_cases AS INT) * 100 AS PercentagePopulationInfected
FROM [PortfolioProject].[dbo].CovidDeaths$
WHERE location like '%states%'
ORDER BY location, date;

SELECT * FROM PortfolioProject..CovidDeaths$;
-- Shows what percentage of population got Covid
SELECT Location,date, Population, total_cases, (total_cases/population)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths$
WHERE location LIKE '%states%'
ORDER BY 1, 2;

-- Look at Total Cases VS Population 4
SELECT 
	Location, date, total_cases, population, 
	(TRY_CAST(total_cases AS NUMERIC(18, 2)) / TRY_CAST(population AS INT)) * 100 
	AS PercentagePopulationInfected 
FROM PortfolioProject.dbo.CovidDeaths$;

-- Looking at Countries with Highest Infection Rate compared to Population 5 
SELECT 
	location, population, MAX(total_cases) AS HighestInfectionCount, 
	MAX(TRY_CAST(total_cases AS NUMERIC(18, 2)) / TRY_CAST(population AS INT) * 100) 
	AS PercentagePopulationInfected
FROM PortfolioProject.dbo.CovidDeaths$
GROUP BY Location, population
order by PercentagePopulationInfected DESC;

-- Showing Countries with Highest Death count per population 6
SELECT location, MAX(TRY_CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Let's break that down by continent 7
SELECT continent, MAX(cast(Total_deaths AS INT)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS 8
SELECT date, SUM(new_cases) as total_cases, 
	SUM(CAST(new_deaths AS INT)) as total_deaths, 
	SUM(cast(new_deaths AS INT)) / SUM(New_cases) * 100 --, total_deaths, 
--TRY_CAST(total_deaths AS NUMERIC(18, 2)) / TRY_CAST(total_cases AS INT) * 100 
	AS PercentageOfPopulationInfected
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- 9
SELECT * FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	ON dea.location = vac.location
	AND dea.date = vac.date;

-- looking at Total Population vs Vaccinations 10
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(INT, vac.new_vaccinations)) 
OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

-- 11
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,
	dea.Date) AS RollingPeopleVaccinated
	-- (RollingPeopleVaccinated / population) * 100
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	on dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
-- order by 2, 3
)

-- 12
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac

-- Temp table
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent varchar(255),
Location varchar(255),
Date datetime, 
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric,
);

-- 13
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
-- , SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
, SUM(TRY_CAST(vac.new_vaccinations AS INT)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

-- 14
Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
-- WHERE dea.continent IS NOT NULL
-- order by 2, 3
-- SELECT *, (TRY_CAST(RollingPeopleVaccinated AS int) / CAST(Population AS INT) * 100)
-- FROM #PercentPopulationVaccinated;

-- Creating views to store data for later visualizations 15
CREATE VIEW PercentPopulationVaccinated1 AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date)
AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
	ON dea.location = vac.location
	AND dea.date = vac.date;

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(COALESCE(CONVERT(BIGINT, vac.new_vaccinations), 0)) 
    OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
    ON dea.location = vac.location
    AND dea.date = vac.date;

SELECT * FROM PercentPopulationVaccinated;