
--------------------------------------------------------------------------------------------------------------------------------------

select * from [dbo].[World_bank_Data]

--------------------------------------------------------------------------------------------------------------------------------------

--Check the data types and null values:
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'World_bank_Data' ;

--------------------------------------------------------------------------------------------------------------------------------------

--Summarize the numerical variables:
SELECT 
    COUNT(*) AS count_Death_Rate, 
    AVG([Death_Rate]) AS mean_Death_Rate, 
    MIN([Death_Rate]) AS min_Death_Rate, 
    MAX([Death_Rate]) AS max_Death_Rate, 
    STDEV([Death_Rate]) AS sd_Death_Rate
FROM World_bank_Data;

--------------------------------------------------------------------------------------------------------------------------------------

--Group the data by categorical variables and summarize the numerical variables within each group
SELECT 
    [Country], 
    COUNT(*) AS count_Death_Rate, 
    AVG([Death_Rate]) AS mean_var1, 
    MIN([Death_Rate]) AS min_var1, 
    MAX([Death_Rate]) AS max_var1, 
    STDEV([Death_Rate]) AS sd_var1
FROM [World_bank_Data]
GROUP BY [Country];


--------------------------------------------------------------------------------------------------------------------------------------

--Selecting top 10 populated countries
select top 10 [Total_Population],[Female_Population],[Male_Population],[Country],[Year]
from [dbo].[World_bank_Data]
order by [Total_Population] Desc

--------------------------------------------------------------------------------------------------------------------------------------

--Selecting top 10 populated countries in 2017 and 2018
select top 10 [Total_Population],[Female_Population],[Male_Population],[Country],[Year]
from [dbo].[World_bank_Data]
where [Year] in ('2018','2017')
order by [Total_Population] Desc

--------------------------------------------------------------------------------------------------------------------------------------

--Cheking range of year
SELECT MIN([Year]) AS 'Min Year', MAX([Year]) AS 'Max Year'
from [dbo].[World_bank_Data]

--------------------------------------------------------------------------------------------------------------------------------------

--Checking population of china at 1960 and 2018
SELECT [Country],
  MAX(CASE WHEN [Year] = 1960 THEN [Total_Population] END) AS [1960 Total Pop],
  MAX(CASE WHEN [Year] = 2018 THEN [Total_Population] END) AS [2018 Total Pop],
  MAX(CASE WHEN [Year] = 2018 THEN [Total_Population] END)-MAX(CASE WHEN [Year] = 1960 THEN [Total_Population] END) AS Difference_1960_20188
FROM [dbo].[World_bank_Data]
WHERE [Year] IN (1960, 2018) AND [Country] IN  ('China','India','USA','Japan','Great Britain')
GROUP BY [Country];

--------------------------------------------------------------------------------------------------------------------------------------

-- Checking the increase in population of china from 1960 to 2018  
Select Max([Total_Population])-Min([Total_Population]) as difference 
from [dbo].[World_bank_Data]
where [Country]='China'

--------------------------------------------------------------------------------------------------------------------------------------

--Unemployment rate in 2018 
select [GDP_in_USD],[Unemployment],[Country],[Year]
from [dbo].[World_bank_Data]
where [Year]='2018'
order by [GDP_in_USD] Desc

--------------------------------------------------------------------------------------------------------------------------------------

--Ranking countries by its fossil fuel consumption 
SELECT 
  [ID],
  [Country],
  [Fossil_Fuel_Consumption],
  [Year],
  RANK() OVER (ORDER BY [Fossil_Fuel_Consumption] DESC) as ranking
FROM [dbo].[World_bank_Data]
ORDER BY ranking