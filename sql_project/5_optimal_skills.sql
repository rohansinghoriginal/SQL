/*
Question: What are the most Optimal skills to learn (Skill in high demand and high salary associated with it)?  
- Identify the skills in demand and associated with high average salary for data analyst roles.
- Concentrates on remote positions to with specified salaries
- Why? Targets skills that offer job security and financial benefits (High Salaries),
Offering strategic insights for career development in the data analytics field. 
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY average_salary DESC,
    demand_count DESC
LIMIT 25;