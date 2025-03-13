
--CREATE INDEX
CREATE INDEX idx_country_wise_latest ON country_wise_latest ("Country/Region");

CREATE INDEX idx_covid_19_clean_complete ON covid_19_clean_complete ("Country/Region", "Date");

CREATE INDEX idx_worldometer_country ON worldometer_data ("Country/Region");
CREATE INDEX idx_worldometer_continent ON worldometer_data ("Continent");

-- DROP INDEX 
DROP INDEX idx_country_wise_latest

-- ANALYZE: 
EXPLAIN ANALYZE
SELECT * FROM country_wise_latest
WHERE "Country/Region" = 'India';

-- Turn off the default seqence scan
SET enable_seqscan = OFF;


EXPLAIN ANALYZE
SELECT * FROM country_wise_latest 
WHERE "Country/Region" = 'India';

SELECT "Country/Region", SUM("Confirmed") as total_confirmed_cases 
FROM covid_19_clean_complete 
GROUP BY "Country/Region";

SELECT "Country/Region", SUM("Confirmed") as total_confirmed_cases 
FROM covid_19_clean_complete 
GROUP BY "Country/Region" having SUM("Confirmed")>200000;