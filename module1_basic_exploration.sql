-- 1. Total cases and deaths per disease (sorted by deadliest)
SELECT 
    d.disease_name,
    SUM(o.total_cases) AS total_cases,
    SUM(o.total_deaths) AS total_deaths,
    ROUND(SUM(o.total_deaths) / SUM(o.total_cases) * 100, 2) AS mortality_rate_pct
FROM outbreaks o
JOIN diseases d ON o.disease_id = d.disease_id
GROUP BY d.disease_name
ORDER BY mortality_rate_pct DESC;

-- 2. Total outbreaks per continent
SELECT 
    r.continent,
    COUNT(o.outbreak_id) AS total_outbreaks,
    SUM(o.total_cases) AS total_cases
FROM outbreaks o
JOIN regions r ON o.region_id = r.region_id
GROUP BY r.continent
ORDER BY total_cases DESC;

-- 3. Hospital bed capacity by region
SELECT 
    r.region_name,
    r.country,
    SUM(h.total_beds) AS total_beds,
    SUM(h.icu_beds) AS total_icu_beds,
    ROUND(SUM(h.icu_beds) / SUM(h.total_beds) * 100, 2) AS icu_pct
FROM hospitals h
JOIN regions r ON h.region_id = r.region_id
GROUP BY r.region_name, r.country
ORDER BY total_beds DESC;