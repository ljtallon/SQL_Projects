-- Create backup with full data
SELECT *
INTO energy_consumption_backup
FROM energy_consumption;

-- Begin Data Cleaning
-- 1. Check number of rows
SELECT COUNT(*) AS total_rows
FROM energy_consumption_backup;

-- 2. Check NULL values per column to see which to keep or remove (if 80-90% NULL values, then drop column)
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN biofuel_elec_per_capita IS NULL THEN 1 ELSE 0 END) AS biofuel_elec_per_capita_nulls,
    CAST(100.0 * SUM(CASE WHEN biofuel_elec_per_capita IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS biofuel_elec_per_capita_null_pct
FROM energy_consumption;

-- 3. Drop columns with 80-90% NULL values
ALTER TABLE energy_consumption
DROP COLUMN 
    biofuel_cons_change_pct,
    biofuel_cons_change_twh,
    biofuel_cons_per_capita,
    biofuel_consumption,
    biofuel_share_energy,
    electricity_share_energy,
    fossil_energy_per_capita,
    hydro_energy_per_capita,
    net_elec_imports,
    net_elec_imports_share_demand,
    nuclear_cons_change_pct,
    nuclear_cons_change_twh,
    nuclear_consumption,
    nuclear_energy_per_capita,
    nuclear_share_energy,
    other_renewable_consumption,
    other_renewables_cons_change_pct,
    other_renewables_energy_per_capita,
    other_renewables_share_energy,
    solar_cons_change_pct,
    solar_energy_per_capita,
    solar_share_energy,
    wind_cons_change_pct,
    wind_energy_per_capita,
    wind_share_energy;

-- 4. Compare new column count (104) to source data (129)
SELECT COUNT(*) AS column_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'energy_consumption';

-- 5. Check for duplicate rows (can adjust variables)
SELECT country, 
		year, 
		COUNT(*) as row_count
FROM energy_consumption
GROUP BY country, year
HAVING COUNT(*) > 1;

-- 5. Review irrelevant country records
SELECT * FROM energy_consumption
WHERE country LIKE '%America'
   OR country LIKE 'Africa%'
   OR country LIKE '%African%'
   OR country LIKE '%Europ%'
   OR country LIKE '% and %'
   OR country LIKE '%Asia%'
   OR country LIKE '%ASEAN%'
   OR country LIKE '% and %'
   OR country LIKE '%&%'
   OR country LIKE '%income%'
   OR country LIKE '%(EI)%'
   OR country LIKE '%(Shift)%'
   OR country LIKE '%(EIA)%'
   OR country LIKE '%(Ember)%'
   OR country LIKE '%Trade%'
   OR country LIKE '%Country%'
   OR country LIKE '%Antilles%'
   OR country LIKE 'Ocean%'
   OR country LIKE 'OECD%'
   OR country LIKE 'Other%'
   OR country LIKE 'USSR';

-- 6. Delete irrelevant countries
DELETE FROM energy_consumption
WHERE country LIKE '%America'
   OR country LIKE 'Africa%'
   OR country LIKE '%African%'
   OR country LIKE '%Europ%'
   OR country LIKE '% and %'
   OR country LIKE '%Asia%'
   OR country LIKE '%ASEAN%'
   OR country LIKE '% and %'
   OR country LIKE '%&%'
   OR country LIKE '%income%'
   OR country LIKE '%(EI)%'
   OR country LIKE '%(Shift)%'
   OR country LIKE '%(EIA)%'
   OR country LIKE '%(Ember)%'
   OR country LIKE '%Trade%'
   OR country LIKE '%Country%'
   OR country LIKE '%Antilles%'
   OR country LIKE 'Ocean%'
   OR country LIKE 'OECD%'
   OR country LIKE 'Other%'
   OR country LIKE 'USSR';

-- 7. Confirm deletion of irrelevant countries
SELECT *
FROM energy_consumption
WHERE country LIKE '%(EI)%';

-- Begin EDA
-- 1. List the top 10 energy consuming countries from the most recent year
SELECT TOP 10 country, 
		year, 
		ROUND(primary_energy_consumption, 0) AS primary_energy_consumption
FROM energy_consumption
WHERE year = (SELECT MAX(year) FROM energy_consumption)
	AND country NOT LIKE 'World' 
ORDER BY primary_energy_consumption DESC;

-- 2. List top 10 energy consumption per capita from the most recent year
SELECT TOP 10 country, 
		year, 
		ROUND(energy_per_capita, 0) AS energy_per_capita
FROM energy_consumption
WHERE year = (SELECT MAX(year) FROM energy_consumption)
ORDER BY energy_per_capita DESC;

-- 3. List the total energy consumption by year
SELECT year,  
		ROUND(SUM(primary_energy_consumption), 0) AS total_consumption
FROM energy_consumption
WHERE primary_energy_consumption IS NOT NULL
GROUP BY year
ORDER BY year DESC;

-- 4. Show the energy trend per country (can alter country to compare)
SELECT year, 
		country,
		ROUND(primary_energy_consumption, 0) AS energy_consumption
FROM energy_consumption
WHERE primary_energy_consumption IS NOT NULL
	AND country = 'United States'
ORDER BY year;

-- 5. Compare each country's GDP against energy consumption
SELECT country,
    ROUND(AVG(gdp), 0) AS avg_gdp,
    ROUND(AVG(primary_energy_consumption), 0) AS avg_primary_consumption
FROM energy_consumption
WHERE gdp IS NOT NULL 
  AND primary_energy_consumption IS NOT NULL
GROUP BY country
ORDER BY avg_primary_consumption DESC;

-- 6. Compare each country's population against energy consumption
SELECT country,
	ROUND(AVG(population), 0) AS avg_population, 
	ROUND(AVG(primary_energy_consumption), 0) AS avg_primary_consumption,
	ROUND(AVG(primary_energy_consumption) / NULLIF(AVG(population), 0), 5) AS energy_per_capita
FROM energy_consumption
WHERE population IS NOT NULL 
	AND primary_energy_consumption IS NOT NULL
	AND country NOT LIKE 'World'
GROUP BY country
ORDER BY energy_per_capita DESC;

-- 7. Compare fossil fuels vs renewable energy
SELECT year,
       ROUND(AVG(fossil_share_energy), 0) AS avg_fossil,
       ROUND(AVG(renewables_share_energy), 0) AS avg_renewables
FROM energy_consumption
WHERE fossil_share_energy IS NOT NULL
	AND renewables_share_energy IS NOT NULL
GROUP BY year
ORDER BY year;

-- 8. Show top 10 countries with the highest percent growth in energy usage in the most recent year
SELECT TOP 10 country, 
		year,
		ROUND(energy_cons_change_pct, 0) AS energy_percent_change
FROM energy_consumption
WHERE year = (SELECT MAX(year) FROM energy_consumption)
ORDER BY energy_cons_change_pct DESC;

-- 9. Show top 10 countries with the lowest carbon share in the most recent year
SELECT TOP 10 country, 
		year,
		ROUND(low_carbon_share_energy, 0) AS lowest_carbon
FROM energy_consumption
WHERE year = (SELECT MAX(year) FROM energy_consumption)
ORDER BY low_carbon_share_energy DESC;

-- 10. Show the global energy consumption over time
SELECT 
    year,
    ROUND(SUM(primary_energy_consumption), 0) AS total_energy
FROM energy_consumption
WHERE country = 'World'
	AND primary_energy_consumption IS NOT NULL
GROUP BY year
ORDER BY total_energy DESC;

-- 11. Compare different countries' fossil fuel consumption from the latest 10 years
SELECT year,
    country,
    ROUND(fossil_fuel_consumption, 0) AS fossil_fuels_consumed
FROM energy_consumption
WHERE fossil_fuel_consumption IS NOT NULL
  AND country IN ('Russia', 'Japan', 'China', 'India', 'United States')
  AND year BETWEEN '2012' AND '2022'
ORDER BY country, year;

-- 12. Compare different energy source consumptions
SELECT 
	year,
	ROUND(SUM(coal_consumption), 0) AS coal_consumption,
	ROUND(SUM(wind_consumption), 0) AS wind_consumption,
	ROUND(SUM(solar_consumption), 0) AS solar_consumption,
	ROUND(SUM(gas_consumption), 0) AS gas_consumption,
	ROUND(SUM(low_carbon_consumption), 0) AS low_carbon_consumption,
	ROUND(SUM(hydro_consumption), 0) AS hydro_consumption,
	ROUND(SUM(oil_consumption), 0) AS oil_consumption,
	ROUND(SUM(renewables_consumption), 0) AS renewables_consumption
FROM energy_consumption
WHERE year BETWEEN 2013 AND 2022
GROUP BY year
ORDER BY year DESC;
	

-- Finalize data cleaning and preparation before beginning visualizations
-- 1. Check key columns for remaining NULL values
SELECT COUNT(*) AS null_count,
		'population' AS column_name
FROM energy_consumption
WHERE population IS NULL
UNION
	SELECT COUNT(*), 'gdp' 
	FROM energy_consumption 
	WHERE gdp IS NULL
	UNION
		SELECT COUNT(*), 'primary_energy_consumption' 
		FROM energy_consumption 
		WHERE primary_energy_consumption IS NULL;

-- 2. If any numeric fields are nvarchar data type, change to float
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'energy_consumption';

-- Use this code to ensure that the data loaded into BI platform matches this table
SELECT COUNT(*) AS total_rows
FROM energy_consumption;