SELECT COUNT(job_id) AS job_count,
    CASE
        WHEN job_location = 'India' THEN 'Local'
        WHEN job_location = 'Anywhere' THEN 'On Site'
        ELSE 'Other'
    END AS job_location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_location_category;