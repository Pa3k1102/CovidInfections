select *
from dbo.covidDeaths$
order by 3,4;

--looking at total deaths vs Total cases
--Shows what percentage of the total cases have led to deaths

select location, date, total_deaths, total_cases, (CONVERT(decimal(15,3),total_deaths)/convert(decimal(15,3),total_cases))*100 AS DeathPercentage
FROM dbo.covidDeaths$
WHERE Location like '%STATES%'
ORDER BY 1,2;

--looking at the total sum of the cases

SELECT SUM(Convert(decimal(15,3), total_cases))
from dbo.covidDeaths$;

--Looking at total cases vs population
--Shows what percentage of the popultion got COVID

select location, date, total_deaths, total_cases,population_density,(CONVERT(decimal(15,3),total_cases)/convert(decimal(15,3),population_density))*100 AS DeathPercentage
FROM dbo.covidDeaths$
WHERE Location like '%STATES%'
ORDER BY 1,2;

select Location, (Cast(total_cases as INT))/(Cast(population_density as INT)) AS CasesByPopulation
from dbo.covidDeaths$;




--looking at countries with highest infection rate compared to population

SELECT location, population_density, MAX(total_cases) AS HighestInfectionCount, (CONVERT(decimal(15,3),total_cases)/convert(decimal(15,3),population_density)) AS PercentPopulationInfected
FROM dbo.covidDeaths$
where location like '%Nigeria%'
Group By location, population_density, total_cases
Order by PercentPopulationInfected desc;

--showing countries with highest death Count per population
--Original data had NULL values in Continent

SELECT Location, MAX(cast(total_deaths as INT)) as TotalDeathCount
FROM dbo.covidDeaths$
WHERE continent is NOT Null
Group by location
Order by TotalDeathCount DESC;

--Lets break things down by Continent

SELECT Continent, MAX(cast(total_deaths as INT)) as TotalDeathCount
FROM dbo.covidDeaths$
WHERE continent is not Null
Group by Continent
Order by TotalDeathCount DESC;

--lets drill down by Continents, focus on Africa

SELECT Location, Continent, MAX(cast(total_deaths as INT)) as TotalDeathCount
FROM dbo.covidDeaths$
WHERE continent is not Null and location like '%Nigeria%'
Group by Continent, location
Order by TotalDeathCount DESC;

--Global Numbers

SELECT SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from dbo.covidDeaths$
Where date is not null
Group by date;
