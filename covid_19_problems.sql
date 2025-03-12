-- Q1 To find out the death percentage locally and globally
SELECT 
    c."Country/Region",
    w."Continent",
    SUM(c."Confirmed") AS "Total Cases",
    SUM(c."Deaths") AS "Total Deaths",
    ROUND((SUM(c."Deaths") * 100.0) / NULLIF(SUM(c."Confirmed"), 0), 2) AS "Death Percentage (%)"
FROM public."country_wise_latest" c
JOIN public."worldometer_data" w
ON c."Country/Region" = w."Country/Region"
GROUP BY c."Country/Region", w."Continent"
ORDER BY "Death Percentage (%)" DESC;


-- Q2 To find out the infected population percentage locally and globally
SELECT 
    c."Country/Region",
    w."Continent",
    w."Population",
    SUM(c."Confirmed") AS "Total Cases",
    ROUND((SUM(c."Confirmed") * 100.0) / NULLIF(w."Population", 0), 2) AS "Local Infected Population (%)"
FROM public."country_wise_latest" c
JOIN public."worldometer_data" w
ON c."Country/Region" = w."Country/Region"
WHERE w."Population" IS NOT NULL
GROUP BY c."Country/Region", w."Continent", w."Population"
ORDER BY "Local Infected Population (%)" DESC;

-- Global Inflated Population:
SELECT 
    SUM(c."Confirmed") AS "Global Total Cases",
    SUM(w."Population") AS "Global Population",
    ROUND((SUM(c."Confirmed") * 100.0) / NULLIF(SUM(w."Population"), 0), 2) AS "Global Infected Population (%)"
FROM public."country_wise_latest" c
JOIN public."worldometer_data" w
ON c."Country/Region" = w."Country/Region"
WHERE w."Population" IS NOT NULL;


--Q3 To find out the countries with the highest infection rates
SELECT 
    c."Country/Region",
    w."Continent",
    w."Population",
    SUM(c."Confirmed") AS "Total Cases",
    ROUND((SUM(c."Confirmed") * 100.0) / NULLIF(w."Population", 0), 2) AS "Infection Rate (%)"
FROM public."country_wise_latest" c
JOIN public."worldometer_data" w
ON c."Country/Region" = w."Country/Region"
WHERE w."Population" IS NOT NULL
GROUP BY c."Country/Region", w."Continent", w."Population"
ORDER BY "Infection Rate (%)" DESC
LIMIT 10;


--Q4 To find out the countries and continents with the highest death counts
SELECT 
    c."Country/Region",
    w."Continent",
    SUM(c."Deaths") AS "Total Deaths"
FROM public."country_wise_latest" c
JOIN public."worldometer_data" w
ON c."Country/Region" = w."Country/Region"
GROUP BY c."Country/Region", w."Continent"
ORDER BY "Total Deaths" DESC
LIMIT 10;

-- Continents with the Highest Death Counts
SELECT 
    w."Continent",
    SUM(c."Deaths") AS "Total Deaths"
FROM public."country_wise_latest" c
JOIN public."worldometer_data" w
ON c."Country/Region" = w."Country/Region"
GROUP BY w."Continent"
ORDER BY "Total Deaths" DESC;


--Q5 Average number of deaths by day (Continents and Countries)
-- Average Deaths Per Day by Country
SELECT 
    f."Country/Region",
    w."Continent",
    ROUND(AVG(f."Deaths"), 2) AS "Avg Deaths Per Day"
FROM public."full_grouped" f
JOIN public."worldometer_data" w
ON f."Country/Region" = w."Country/Region"
GROUP BY f."Country/Region", w."Continent"
ORDER BY "Avg Deaths Per Day" DESC
LIMIT 10;

--Average Deaths Per Day by Continent
SELECT 
    w."Continent",
    ROUND(AVG(f."Deaths"), 2) AS "Avg Deaths Per Day"
FROM public."full_grouped" f
JOIN public."worldometer_data" w
ON f."Country/Region" = w."Country/Region"
GROUP BY w."Continent"
ORDER BY "Avg Deaths Per Day" DESC;


--Q6 Average of cases divided by the number of population of each country (TOP 10)
SELECT 
    w."Country/Region",
    w."Continent",
    ROUND(AVG(f."Confirmed")::numeric / NULLIF(w."Population", 0) * 100, 4) AS "Avg Infection Rate (%)"
FROM public."full_grouped" f
JOIN public."worldometer_data" w
ON f."Country/Region" = w."Country/Region"
WHERE w."Population" IS NOT NULL AND w."Population" > 0
GROUP BY w."Country/Region", w."Continent", w."Population"
ORDER BY "Avg Infection Rate (%)" DESC
LIMIT 10;
