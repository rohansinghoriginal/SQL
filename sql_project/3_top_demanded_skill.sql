/*
 Question: What are the top demanded skills for the Data Analyst role?
 - join job postings to inner join table simolar to the one used in the previous query to find the most commonly required skills for Data Analyst positions.
 - identify the top 5 in demand skills for Data Analyst based on the frequency of their occurrence in job postings.
 - Why? Retrieves the top 5 skills with the highest demand for Data Analyst roles, 
 providing insights into the key competencies that employers are seeking in candidates for these positions.
 */
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;