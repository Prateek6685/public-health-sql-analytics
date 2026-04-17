-- 4. Regions with highest death rate per 100k population
SELECT 
    r.region_name,
    r.country,
    SUM(o.total_deaths) AS total_deaths,
    r.population,
    ROUND(SUM(o.total_deaths) / r.population * 100000, 2) AS deaths_per_100k
FROM outbreaks o
JOIN regions r ON o.region_id = r.region_id
GROUP BY r.region_name, r.country, r.population
ORDER BY deaths_per_100k DESC;

-- 5. Most affected age group across all admissions
SELECT 
    age_group,
    COUNT(*) AS total_admissions,
    SUM(CASE WHEN outcome = 'Deceased' THEN 1 ELSE 0 END) AS total_deaths,
    ROUND(SUM(CASE WHEN outcome = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS death_rate_pct
FROM admissions
GROUP BY age_group
ORDER BY death_rate_pct DESC;

-- 6. Hospitals that treated the most critical outcomes
SELECT 
    h.hospital_name,
    r.region_name,
    COUNT(*) AS total_admissions,
    SUM(CASE WHEN a.outcome = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(SUM(CASE WHEN a.outcome = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS fatality_rate_pct
FROM admissions a
JOIN hospitals h ON a.hospital_id = h.hospital_id
JOIN regions r ON h.region_id = r.region_id
GROUP BY h.hospital_name, r.region_name
ORDER BY fatality_rate_pct DESC;

-- 7. Diseases with outbreaks in more than one continent (subquery)
SELECT 
    d.disease_name,
    COUNT(DISTINCT r.continent) AS continents_affected
FROM outbreaks o
JOIN diseases d ON o.disease_id = d.disease_id
JOIN regions r ON o.region_id = r.region_id
GROUP BY d.disease_name
HAVING continents_affected > 1
ORDER BY continents_affected DESC;