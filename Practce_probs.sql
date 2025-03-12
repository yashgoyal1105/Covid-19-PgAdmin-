--CLEANING THE DATA: 
DELETE FROM public."worldometer_data"
WHERE "TotalCases" IS NULL 
   OR "TotalDeaths" IS NULL 
   OR "TotalRecovered" IS NULL 
   OR "Continent" IS NULL 
   OR "TotalCases" = 0;

   
-- Top 10 Countries By COVID-19 Recovery Rates

SELECT 
    "Country/Region",
    "TotalRecovered",
    "TotalCases",
    ROUND(("TotalRecovered" * 100.0) / ("TotalCases")) AS "Recovery Rate (%)"
FROM public."worldometer_data"
WHERE "TotalCases" > 0
ORDER BY "Recovery Rate (%)" DESC
LIMIT 10;

-- Comparison Of Recovery And Fatality Rates By Country:
SELECT 
    "Country/Region",
    "TotalCases",
    "TotalRecovered",
    "TotalDeaths",
    ROUND(("TotalRecovered" * 100.0) / "TotalCases", 2) AS "Recovery Rate (%)",
    ROUND(("TotalDeaths" * 100.0) / "TotalCases", 2) AS "Fatality Rate (%)"
FROM public."worldometer_data"
ORDER BY "Recovery Rate (%)" DESC;

-- Countries with the Lowest Number of COVID-19 Deaths
SELECT 
    "Country/Region",
    "TotalCases",
    "TotalDeaths"
FROM public."worldometer_data"
WHERE "TotalDeaths" > 0
ORDER BY "TotalDeaths" ASC
LIMIT 10;

-- Countries with the Highest Number of COVID-19 Cases
SELECT 
    "Country/Region",
    "TotalCases",
    "TotalDeaths",
    "TotalRecovered"
FROM public."worldometer_data"
ORDER BY "TotalCases" DESC
LIMIT 10;

-- Global Recovery Rate
SELECT 
    SUM("TotalRecovered") AS "Global Total Recovered",
    SUM("TotalCases") AS "Global Total Cases",
    ROUND((SUM("TotalRecovered") * 100.0) / SUM("TotalCases"), 2) AS "Global Recovery Rate (%)"
FROM public."worldometer_data";

-- COVID-19 Trends By Continent
SELECT "Continent",
    SUM("TotalCases") AS "Total Cases",
    SUM("TotalRecovered") AS "Total Recovered",
    SUM("TotalDeaths") AS "Total Deaths",
    ROUND((SUM("TotalRecovered") * 100.0) / SUM("TotalCases"), 2) AS "Recovery Rate (%)",
    ROUND((SUM("TotalDeaths") * 100.0) / SUM("TotalCases"), 2) AS "Fatality Rate (%)"
FROM public."worldometer_data"
WHERE "Continent" IS NOT NULL
GROUP BY "Continent"
ORDER BY "Total Cases" DESC;

-- Continent That Has The Lowest Cases
SELECT 
    "Continent",
    SUM("TotalCases") AS "Total Cases"
FROM public."worldometer_data"
WHERE "Continent" IS NOT NULL
GROUP BY "Continent"
ORDER BY "Total Cases" ASC
LIMIT 1;

-- Recovery Rate by Continent
SELECT 
    "Continent",
    SUM("TotalCases") AS "Total Cases",
    SUM("TotalRecovered") AS "Total Recovered",
    ROUND((SUM("TotalRecovered") * 100.0) / SUM("TotalCases"), 2) AS "Recovery Rate (%)"
FROM public."worldometer_data"
WHERE "Continent" IS NOT NULL
GROUP BY "Continent"
ORDER BY "Recovery Rate (%)" DESC;