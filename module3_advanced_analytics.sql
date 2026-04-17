-- 8. Rank diseases by total cases within each continent (WINDOW FUNCTION)
SELECT 
    r.continent,
    d.disease_name,
    SUM(o.total_cases) AS total_cases,
    RANK() OVER (PARTITION BY r.continent ORDER BY SUM(o.total_cases) DESC) AS rank_in_continent
FROM outbreaks o
JOIN diseases d ON o.disease_id = d.disease_id
JOIN regions r ON o.region_id = r.region_id
GROUP BY r.continent, d.disease_name
ORDER BY r.continent, rank_in_continent;

-- 9. Outbreak duration vs death toll correlation (CTE)
WITH outbreak_duration AS (
    SELECT 
        o.outbreak_id,
        d.disease_name,
        r.region_name,
        o.total_cases,
        o.total_deaths,
        DATEDIFF(o.end_date, o.start_date) AS duration_days,
        ROUND(o.total_deaths / o.total_cases * 100, 2) AS mortality_pct
    FROM outbreaks o
    JOIN diseases d ON o.disease_id = d.disease_id
    JOIN regions r ON o.region_id = r.region_id
)
SELECT *,
    CASE 
        WHEN duration_days > 180 THEN 'Long (6m+)'
        WHEN duration_days > 90  THEN 'Medium (3-6m)'
        ELSE 'Short (<3m)'
    END AS outbreak_category
FROM outbreak_duration
ORDER BY mortality_pct DESC;

-- 10. Running total of cases over time per disease (WINDOW FUNCTION)
SELECT 
    d.disease_name,
    o.start_date,
    o.total_cases,
    SUM(o.total_cases) OVER (
        PARTITION BY d.disease_name 
        ORDER BY o.start_date
    ) AS running_total_cases
FROM outbreaks o
JOIN diseases d ON o.disease_id = d.disease_id
ORDER BY d.disease_name, o.start_date;

-- 11. Hospital capacity vs outbreak pressure — CRITICAL INSIGHT QUERY
WITH region_outbreak_load AS (
    SELECT 
        region_id,
        SUM(total_cases) AS total_cases,
        SUM(total_deaths) AS total_deaths
    FROM outbreaks
    GROUP BY region_id
),
region_capacity AS (
    SELECT 
        region_id,
        SUM(total_beds) AS total_beds,
        SUM(icu_beds) AS total_icu
    FROM hospitals
    GROUP BY region_id
)
SELECT 
    r.region_name,
    r.country,
    COALESCE(rc.total_beds, 0) AS hospital_beds,
    COALESCE(rc.total_icu, 0) AS icu_beds,
    COALESCE(rol.total_cases, 0) AS outbreak_cases,
    ROUND(COALESCE(rol.total_cases, 0) / NULLIF(rc.total_beds, 0), 1) AS cases_per_bed,
    CASE 
        WHEN COALESCE(rol.total_cases, 0) / NULLIF(rc.total_beds, 0) > 100 THEN '🔴 Critical'
        WHEN COALESCE(rol.total_cases, 0) / NULLIF(rc.total_beds, 0) > 50  THEN '🟡 High'
        ELSE '🟢 Manageable'
    END AS pressure_level
FROM regions r
LEFT JOIN region_capacity rc ON r.region_id = rc.region_id
LEFT JOIN region_outbreak_load rol ON r.region_id = rol.region_id
ORDER BY cases_per_bed DESC;