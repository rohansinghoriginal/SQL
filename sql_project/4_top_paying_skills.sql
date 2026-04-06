/*
Question: What are the top skills based on the salary?
- look at the average salary associated with each skill for data analyst roles.
- Focuses on the roles with specified salaries, regardless of the location.
- Why? Identify the most financially rewarding skills to acquire or improve.
*/

SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    -- AND job_work_from_home = 'True'
    -- AND job_location = 'India'
    -- AND job_location = 'United States'

    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;