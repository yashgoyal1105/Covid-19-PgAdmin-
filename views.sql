-- Simple View - using a single table 
CREATE VIEW covid_summary AS
SELECT 
    "Country/Region",
    "TotalCases",
    "TotalDeaths",
    "TotalRecovered"
FROM worldometer_data;

select * from covid_summary

-- Complex view - using 2 or more tables
CREATE VIEW covid_complex_view AS
SELECT 
    cwl."Country/Region",
    cwl."Confirmed",
    cwl."Deaths",
    cwl."Recovered",
    w."TotalCases",
    w."TotalDeaths",
    w."TotalRecovered",
    w."Population",
    ROUND((w."TotalRecovered" * 100.0) / NULLIF(w."TotalCases", 0), 2) AS "Global Recovery Rate (%)",
    ROUND((w."TotalDeaths" * 100.0) / NULLIF(w."TotalCases", 0), 2) AS "Global Fatality Rate (%)",
    ROUND((cwl."Recovered" * 100.0) / NULLIF(cwl."Confirmed", 0), 2) AS "Local Recovery Rate (%)",
    ROUND((cwl."Deaths" * 100.0) / NULLIF(cwl."Confirmed", 0), 2) AS "Local Fatality Rate (%)",
    ROUND((w."TotalCases" * 100.0) / NULLIF(w."Population", 0), 2) AS "Infected Population (%)"
FROM country_wise_latest cwl
JOIN worldometer_data w 
ON cwl."Country/Region" = w."Country/Region";

select * from covid_complex_view
