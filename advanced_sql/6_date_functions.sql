/*
SELECT 
    COUNT(job_id) as job_posted_count,
    EXTRACT (MONTH FROM job_posted_date) as month
FROM job_postings_fact

    WHERE job_title_short = 'Data Scientist'
    GROUP BY month
    ORDER BY job_posted_count DESC;
*/
/*

SELECT job_title_short as title,
    job_location as location,
    job_posted_date  AT TIME ZONE 'UTC' AT TIME ZONE 'IST' AS date_time
FROM job_postings_fact
LIMIT 50;
*/

/*
SELECT '2024-06-01'::DATE,
'123'::INTEGER,
true::BOOLEAN,
30.81::REAL
;
*/

-- PRACTICE PROBLEM
CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

