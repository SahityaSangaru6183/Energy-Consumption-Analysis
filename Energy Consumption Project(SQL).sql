CREATE DATABASE ENERGYDB2;
USE ENERGYDB2;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

SELECT * FROM COUNTRY;

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION_3;


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP_3;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM CONSUMPTION;




-- Data Analysis Questions
-- General & Comparative Analysis
-- 1. What is the total emission per country for the most recent year available?
SELECT country, year, SUM(emission) AS total_emission
FROM emission_3
WHERE year = (SELECT MAX(year) FROM emission_3)
GROUP BY country, year
ORDER BY total_emission DESC;

-- 2. What are the top 5 countries by GDP in the most recent year?
SELECT Country, year, Value AS GDP
FROM gdp_3
WHERE year = (SELECT MAX(year) FROM gdp_3)
ORDER BY GDP DESC
LIMIT 5;

-- 3. Compare energy production and consumption by country and year.
SELECT p.country, p.year,
SUM(p.production) AS total_production,
SUM(c.consumption) AS total_consumption
FROM production p
JOIN consumption c
ON p.country = c.country AND p.year = c.year
GROUP BY p.country, p.year
ORDER BY p.year DESC, p.country;

-- 4. Which energy types contribute most to emissions across all countries?
SELECT energy_type, SUM(emission) AS total_emission
FROM emission_3
GROUP BY energy_type
ORDER BY total_emission DESC;




--  Trend Analysis Over Time
-- 5. How have global emissions changed year over year?
SELECT year, SUM(emission) AS global_emission
FROM emission_3
GROUP BY year
ORDER BY year;

-- 6. What is the trend in GDP for each country over the given years?
SELECT Country, year, Value AS GDP
FROM gdp_3
ORDER BY Country, year;

-- 7. How has population growth affected total emissions in each country?
SELECT 
    p.countries AS country, 
    p.year, 
    MAX(p.Value) AS population, 
    SUM(e.emission) AS total_emission
FROM population p
JOIN emission_3 e
    ON p.countries = e.country 
   AND p.year = e.year
GROUP BY p.countries, p.year
ORDER BY p.countries, p.year;

-- 8. Has energy consumption increased or decreased over the years for major economies?
SELECT country, year, SUM(consumption) AS total_consumption
FROM consumption
WHERE country IN ('United States', 'China', 'India', 'Japan', 'Germany')
GROUP BY country, year
ORDER BY year, country;

-- 9. What is the average yearly change in emissions per capita for each country?
SELECT country, AVG(per_capita_emission) AS avg_per_capita_emission
FROM emission_3
GROUP BY country
ORDER BY avg_per_capita_emission DESC;



-- Ratio & Per Capita Analysis
-- 10. What is the emission-to-GDP ratio for each country by year?
SELECT e.country, e.year, SUM(e.emission) / SUM(g.Value) AS emission_to_gdp_ratio
FROM emission_3 e
JOIN gdp_3 g
ON e.country = g.Country AND e.year = g.year
GROUP BY e.country, e.year
ORDER BY e.year DESC;

-- 11. What is the energy consumption per capita for each country over the last decade?
SELECT c.country, c.year, 
    SUM(c.consumption) / MAX(p.Value) AS consumption_per_capita
FROM consumption c
JOIN population p
    ON c.country = p.countries 
   AND c.year = p.year
WHERE c.year >= YEAR(CURDATE()) - 10
GROUP BY c.country, c.year
ORDER BY c.country, c.year;

-- 12. How does energy production per capita vary across countries?
SELECT pr.country, pr.year,
    SUM(pr.production) / MAX(p.Value) AS production_per_capita
FROM production pr
JOIN population p
    ON pr.country = p.countries 
   AND pr.year = p.year
GROUP BY pr.country, pr.year
ORDER BY pr.country, pr.year;

-- 13. Which countries have the highest energy consumption relative to GDP?
SELECT c.country, c.year,
    SUM(c.consumption) / MAX(g.Value) AS consumption_to_gdp
FROM consumption c
JOIN gdp_3 g
    ON c.country = g.Country 
   AND c.year = g.year
GROUP BY c.country, c.year
ORDER BY consumption_to_gdp DESC
LIMIT 10;

-- 14. What is the correlation between GDP growth and energy production growth?
SELECT g.Country, g.year, 
    MAX(g.Value) AS GDP,            -- GDP is unique per country-year; MAX is safe
    SUM(p.production) AS total_production
FROM gdp_3 g
JOIN production p
  ON g.Country = p.country 
 AND g.year = p.year
GROUP BY g.Country, g.year
ORDER BY g.Country, g.year;





-- Global Comparisons

-- 15. What are the top 10 countries by population and how do their emissions compare?
SELECT p.countries AS country,p.year,
    MAX(p.Value) AS population,
    COALESCE(SUM(e.emission), 0) AS total_emission
FROM population p
LEFT JOIN emission_3 e
  ON p.countries = e.country
 AND p.year = e.year
WHERE p.year = (SELECT MAX(year) FROM population)
GROUP BY p.countries, p.year
ORDER BY population DESC
LIMIT 10;


-- 16. Which countries have improved (reduced) their per capita emissions the most over the last decade?
SELECT country,
       (MAX(per_capita_emission) - MIN(per_capita_emission)) AS reduction
FROM emission_3
WHERE year >= YEAR(CURDATE()) - 10
GROUP BY country
ORDER BY reduction DESC;

-- 17. What is the global share (%) of emissions by country?
SELECT country,
       SUM(emission) * 100.0 / (SELECT SUM(emission) FROM emission_3) AS global_share_percent
FROM emission_3
GROUP BY country
ORDER BY global_share_percent DESC;

-- 18. What is the global average GDP, emission, and population by year?
SELECT g.year, AVG(g.Value) AS avg_gdp, AVG(e.emission) AS avg_emission, AVG(p.Value) AS avg_population
FROM gdp_3 g
JOIN emission_3 e ON g.Country = e.country AND g.year = e.year
JOIN population p ON g.Country = p.countries AND g.year = p.year
GROUP BY g.year
ORDER BY g.year;

