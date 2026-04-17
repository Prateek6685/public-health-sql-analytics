-- REGIONS TABLE
CREATE TABLE regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    continent VARCHAR(50) NOT NULL,
    population BIGINT
);

-- DISEASES TABLE
CREATE TABLE diseases (
    disease_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),         -- e.g. Infectious, Chronic, Respiratory
    is_contagious BOOLEAN
);

-- HOSPITALS TABLE
CREATE TABLE hospitals (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_name VARCHAR(150) NOT NULL,
    region_id INT,
    total_beds INT,
    icu_beds INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- OUTBREAKS TABLE
CREATE TABLE outbreaks (
    outbreak_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_id INT,
    region_id INT,
    start_date DATE,
    end_date DATE,
    total_cases INT,
    total_deaths INT,
    FOREIGN KEY (disease_id) REFERENCES diseases(disease_id),
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- HOSPITAL ADMISSIONS TABLE
CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT,
    disease_id INT,
    admission_date DATE,
    discharge_date DATE,
    age_group VARCHAR(20),        -- e.g. 0-18, 19-40, 41-60, 60+
    outcome VARCHAR(20),          -- Recovered, Deceased, Ongoing
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id),
    FOREIGN KEY (disease_id) REFERENCES diseases(disease_id)
);





-- REGIONS
INSERT INTO regions (region_name, country, continent, population) VALUES
('Maharashtra', 'India', 'Asia', 128000000),
('Kerala', 'India', 'Asia', 35000000),
('Bavaria', 'Germany', 'Europe', 13000000),
('São Paulo', 'Brazil', 'South America', 46000000),
('California', 'USA', 'North America', 39000000),
('Hubei', 'China', 'Asia', 58000000),
('Lombardy', 'Italy', 'Europe', 10000000),
('Lagos State', 'Nigeria', 'Africa', 15000000);

-- DISEASES
INSERT INTO diseases (disease_name, category, is_contagious) VALUES
('COVID-19', 'Infectious', TRUE),
('Tuberculosis', 'Infectious', TRUE),
('Dengue Fever', 'Infectious', FALSE),
('Diabetes Type 2', 'Chronic', FALSE),
('Influenza', 'Respiratory', TRUE),
('Malaria', 'Infectious', FALSE),
('Hypertension', 'Chronic', FALSE),
('Cholera', 'Infectious', TRUE);

-- HOSPITALS
INSERT INTO hospitals (hospital_name, region_id, total_beds, icu_beds) VALUES
('KEM Hospital', 1, 1800, 120),
('Lilavati Hospital', 1, 320, 45),
('AIIMS Kerala', 2, 960, 80),
('Klinikum Munich', 3, 1200, 200),
('Hospital das Clinicas', 4, 2200, 310),
('Cedars-Sinai', 5, 886, 150),
('Wuhan Central Hospital', 6, 800, 90),
('Ospedale Maggiore', 7, 1050, 175),
('Lagos Island General', 8, 530, 40);

-- OUTBREAKS
INSERT INTO outbreaks (disease_id, region_id, start_date, end_date, total_cases, total_deaths) VALUES
(1, 6, '2020-01-01', '2020-06-30', 68000, 4512),
(1, 7, '2020-02-15', '2020-08-01', 95000, 16523),
(1, 1, '2021-03-01', '2021-06-30', 580000, 14200),
(1, 4, '2021-01-01', '2021-07-31', 430000, 11800),
(2, 1, '2020-01-01', '2020-12-31', 74000, 1300),
(2, 8, '2020-01-01', '2020-12-31', 130000, 4700),
(3, 2, '2021-06-01', '2021-10-31', 28000, 85),
(3, 8, '2021-06-01', '2021-11-30', 92000, 310),
(6, 8, '2022-04-01', '2022-09-30', 210000, 890),
(5, 3, '2022-11-01', '2023-02-28', 45000, 320),
(8, 8, '2023-01-01', '2023-04-30', 18000, 540),
(1, 5, '2021-01-01', '2021-09-30', 380000, 6300);

-- ADMISSIONS
INSERT INTO admissions (hospital_id, disease_id, admission_date, discharge_date, age_group, outcome) VALUES
(1, 1, '2021-03-05', '2021-03-18', '60+', 'Recovered'),
(1, 1, '2021-03-10', '2021-03-25', '41-60', 'Recovered'),
(1, 2, '2021-04-01', '2021-05-15', '19-40', 'Recovered'),
(2, 1, '2021-03-20', '2021-04-02', '60+', 'Deceased'),
(2, 4, '2021-05-01', '2021-05-10', '41-60', 'Recovered'),
(3, 3, '2021-07-15', '2021-07-28', '0-18', 'Recovered'),
(3, 3, '2021-08-01', '2021-08-10', '19-40', 'Recovered'),
(4, 5, '2022-12-01', '2022-12-07', '60+', 'Recovered'),
(5, 1, '2021-02-10', '2021-02-28', '41-60', 'Deceased'),
(6, 1, '2021-04-05', '2021-04-20', '19-40', 'Recovered'),
(7, 1, '2020-01-25', '2020-02-15', '60+', 'Deceased'),
(8, 6, '2022-05-10', '2022-05-24', '0-18', 'Recovered'),
(9, 8, '2023-02-01', '2023-02-12', '41-60', 'Deceased'),
(1, 1, '2021-04-10', '2021-04-22', '19-40', 'Recovered'),
(1, 7, '2022-01-15', '2022-01-20', '60+', 'Ongoing'),
(2, 2, '2022-03-01', '2022-04-10', '41-60', 'Recovered'),
(6, 4, '2022-07-20', '2022-07-25', '60+', 'Recovered'),
(3, 6, '2022-06-05', '2022-06-18', '0-18', 'Recovered'),
(9, 1, '2021-05-01', '2021-05-14', '19-40', 'Recovered'),
(5, 8, '2023-01-15', '2023-01-28', '60+', 'Deceased');