SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM
    job_postings_fact
LIMIT 20;


SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'CET' AT time ZONE 'CST'
FROM
    job_postings_fact
LIMIT 5;

SELECT 
    EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM job_postings_fact;


SELECT
    Count(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
     job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
LIMIT 40;

-- Exercise 1:

In your SQL query, there are a couple of issues that need to be addressed:

Issues:
GROUP BY Clause:

You are grouping by job_schedule_type but not including it in the SELECT statement. Any non-aggregated columns in the SELECT clause must also be included in the GROUP BY clause.
Aggregation Functions:

You are using Count(job_schedule_type) without specifying what to count. If you want to count the number of records, you should use Count(*) instead.
Selecting Non-Aggregated Columns:

The columns salary_year_avg, salary_hour_avg, and the extracted date parts should either be aggregated or included in the GROUP BY clause.
Suggested Correction:
Here is a corrected version of your SQL query:

SELECT
    job_schedule_type,
    COUNT(*) AS job_count,
    AVG(salary_year_avg) AS year_avg,
    AVG(salary_hour_avg) AS hour_avg,
    EXTRACT(DAY FROM job_posted_date) AS day,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM 
    job_postings_fact
WHERE 
    EXTRACT(DAY FROM job_posted_date) > 1 AND 
    EXTRACT(MONTH FROM job_posted_date) > 6 AND
    EXTRACT(YEAR FROM job_posted_date) >= 2023
GROUP BY 
    job_schedule_type,
    day,
    month,
    year;

CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT
    job_title_short,
    job_location
FROM job_postings_fact
LIMIT 10;




-- Create new columne as follows:
-- Anywhere jobs as Remonte
--New York, NY jobs as 'Local'
-- Otherwise 'Onsite'

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'REMOTE'
        WHEN job_loca2tion = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY COUNT(job_id) DESC;

--SUBQUERIES/CTES

SELECT * 
FROM ( SELECT *
    FROM job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

sELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = true
)
LIMIT 10;


WITH company_job_count AS (SELECT
    company_id,
    COUNT(*)
FROM 
    job_postings_fact
GROUP BY
    company_id)

SELECT name
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id;

-- Identify top 5 skil from skills_job_dim
SELECT *
FROM
    skills_dim;


SELECT 
    COUNT(job_id),
    skill_id
FROM skills_job_dim
GROUP BY skill_id
ORDER BY COUNT(job_id) DESC
Limit 5;

WITH top_5_skill_job AS (SELECT 
    COUNT(job_id),
    skill_id

FROM skills_job_dim
GROUP BY skill_id
ORDER BY COUNT(job_id) DESC
Limit 5)
SELECT 
    skills,
FROM skills_dim 
JOIN top_5_skill_job ON top_5_skill_job.skill_id = skills_dim.skill_id


-- Problem 2

-- Determining Size Category BY cOMPANY

SELECT *
FROM
    job_postings_fact
LIMIT 10;

SELECT *
FROM
    company_dim;




WITH company_postings_size AS (SELECT-- 
    company_id,

    CASE -- Adding names for specific values (Small,Medium,Large)
        WHEN job_postings < 10 THEN 'Small' 
        WHEN job_postings BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS posting_size
FROM
    (SELECT -- Calculating job postings per company id (1)
        COUNT(job_id) AS job_postings,  
        company_id
        FROM job_postings_fact
    GROUP BY company_id
    ORDER BY COUNT(job_id) DESC))
SELECT 
    name AS company_name,
    posting_size
FROM company_dim
JOIN company_postings_size ON company_postings_size.company_id = company_dim.company_id;


-- UNIONS
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

git config --global user.name "KamilBujniak"
git config --global user.email "kamilbujniak@gmail.com"
