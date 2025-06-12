Select *
From PortfolioProject1..CovidDeaths$
Where continent is not null
order by 3,4

--Select *
--From PortfolioProject1..CovidVaccinations$
--order by 3,4


-- Select Data that we are going to be using 

Select Location, date, total_cases, new_cases, total_deaths, population 
From PortfolioProject1..CovidDeaths$
Where continent is not null
order by 1,2


--Looking at Total Cases vs Total Deaths 
--Displays the likelihood of dying due to contracting covid in your country
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject1..CovidDeaths$
Where location like '%states%'
and continent is not null
order by 1,2


-- Comparing Total Cases and Population
--Shows the percentage of population getting covid
Select Location, date, population, total_cases,(total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
order by 1,2



-- Looking at Countries with the highest infection rate compared to the population

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
Group by Location, population
order by PercentPopulationInfected desc


--Looking at the highest Death Count per Population 

Select Location,MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
Where continent is not null
Group by Location
order by TotalDeathCount desc


--Breaking things down by continent

Select location,MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
Where continent is null
Group by location
order by TotalDeathCount desc

--Continents with the highest death counts by population

Select continent,MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
Where continent is not null
Group by continent
order by TotalDeathCount desc



--Global Numbers 

Select date,SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
where continent is not null
Group by date
Order by 1,2

Select SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject1..CovidDeaths$
--Where location like '%states%'
where continent is not null
--Group by date
Order by 1,2



--Comparing Total Population and Vaccination 

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date) as VaccinationRollingCount
--, (VaccinationRollingCount/population)*100
From PortfolioProject1..CovidDeaths$ dea
Join PortfolioProject1..CovidVaccinations$ vac
	On dea.location = vac.location 
	and dea.date = vac.date 
where dea.continent is not null
order by 2,3




--CTE 


With PopVsVac (Continent, Location, Date, Population, New_Vaccinations, VaccinationRollingCount)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date) as VaccinationRollingCount
--, (VaccinationRollingCount/population)*100
From PortfolioProject1..CovidDeaths$ dea
Join PortfolioProject1..CovidVaccinations$ vac
	On dea.location = vac.location 
	and dea.date = vac.date 
where dea.continent is not null
--order by 2,3
)
Select *, (VaccinationRollingCount/Population)*100
From PopVsVac



-- TEMP Table 

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric, 
New_Vaccinations numeric, 
VaccinationRollingCount numeric, 
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date) as VaccinationRollingCount
--, (VaccinationRollingCount/population)*100
From PortfolioProject1..CovidDeaths$ dea
Join PortfolioProject1..CovidVaccinations$ vac
	On dea.location = vac.location 
	and dea.date = vac.date 
--where dea.continent is not null
--order by 2,3
Select *, (VaccinationRollingCount/Population)*100
From #PercentPopulationVaccinated


-- Creating view to store data for later visuals


Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date) as VaccinationRollingCount
--, (VaccinationRollingCount/population)*100
From PortfolioProject1..CovidDeaths$ dea
Join PortfolioProject1..CovidVaccinations$ vac
	On dea.location = vac.location 
	and dea.date = vac.date 
where dea.continent is not null
--order by 2,3

Select * 
From PercentPopulationVaccinated









