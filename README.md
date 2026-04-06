# Introduction
This project analyzes Data Analyst job postings to uncover insights about high-paying roles and the skills required to secure them. Using SQL, the dataset was explored to identify the top-paying remote Data Analyst jobs, the most demanded skills, and the skills associated with higher salaries.

The goal of this analysis is to help aspiring and current Data Analysts understand which skills are most valuable in the job market and make informed decisions about their learning and career development.

Check out my sql project here - [SQL Projects](/sql_project/)

# Background

The data analytics job market is highly competitive, and understanding which roles pay the most and which skills employers value can help data professionals focus their learning strategically. This project explores job posting data using SQL to uncover insights about salary trends and skill demand for Data Analyst roles.

## To guide the analysis, the following key questions were explored:

**1. What are the top highest paying Data Analyst jobs?**

- Identify the top 10 highest-paying remote Data Analyst roles with specified salaries.

**2. What skills are required for the top paying Data Analyst jobs?**

- Analyze the skills required for the top 10 highest-paying Data Analyst positions.

**3. What are the most in-demand skills for Data Analysts?**
- Identify the top 5 most frequently requested skills in Data Analyst job postings.

**4. Which skills are associated with the highest salaries?**

- Analyze the average salary linked to different skills in Data Analyst roles.

**5. What are the most optimal skills to learn?**
- Identify skills that are both highly demanded and associated with higher salaries, helping guide strategic career development.

# Tools I Used

* **SQL** – The core tool used to query and analyze the job postings dataset. SQL was used to filter, aggregate, and extract insights about **salary trends and skill demand** for Data Analyst roles.

* **PostgreSQL** – Used as the database management system to store and run queries on the job postings dataset efficiently.

* **Joins (INNER JOIN & LEFT JOIN)** – Applied to combine data from multiple tables such as **job postings, companies, and skills**, enabling deeper analysis of which companies offer high salaries and which skills are required.

* **Common Table Expressions (CTEs)** – Used to create temporary result sets (like identifying **top-paying jobs first**) and then performing further analysis on those results.

* **Aggregation Functions** – Functions such as **COUNT(), AVG(), and ROUND()** were used to measure **skill demand and calculate average salaries associated with specific skills**.

* **Filtering and Sorting Techniques** – Clauses like **WHERE, GROUP BY, ORDER BY, and LIMIT** were used to filter relevant records, rank salaries, and identify the most demanded or highest-paying skills.

# The Analyis
## 1. Top Highest Paying Remote Data Analyst Jobs

To identify the most lucrative opportunities for Data Analysts, I filtered job postings that:

- Have the title Data Analyst
- Include specified salary data
- Are listed as remote ("Anywhere")
- Ranked them by average yearly salary

**SQL Query:**
```sql
SELECT job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;
```
**Analysis**
<br>

![Query 1 Output Analysis](/assets/output_q1.png) 

**Key Insights**
- The highest paying role in the dataset offers around $650K/year, significantly higher than the rest, showing that certain niche analyst roles can command extremely high salaries.
- Major tech companies like Meta and AT&T appear among the top-paying employers, confirming that large tech firms often offer premium compensation for data roles.
- Many of the top-paying jobs come from tech-driven organizations and data-focused companies, indicating that businesses heavily dependent on data are willing to pay significantly more for skilled analysts.


**What This Tells Us?**

High-paying Data Analyst jobs are often associated with:

- Tech companies
- Advanced data infrastructure
- Remote-friendly organizations

This suggests that developing strong technical skills and targeting data-driven tech companies may significantly increase earning potential.

## 2. Skills Required for the Top Paying Data Analyst Jobs

To understand which skills lead to high salaries, I analyzed the skills required for the top 10 highest-paying remote Data Analyst roles by joining job postings with the skills dataset.

**SQL Query:**
```sql
WITH top_paying_jobs AS(
    SELECT job_id,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*, skills 
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```
**Analysis**
<br>

![Query 2 Output Analysis](/assets/output_q2.png) 

**Key Insights**
- **SQL** is the most frequently required skill, highlighting its importance as a core data analysis tool.
- **Python** and **Tableau** appear frequently, showing that employers value both programming and data visualization capabilities.
- Other tools such as **R, Excel, Snowflake,** and **Azure** indicate that high-paying roles often involve statistical analysis and modern cloud-based data platforms.


**Conclusion**

High-paying Data Analyst roles typically require a combination of data querying, programming, and visualization skills, making SQL, Python, and BI tools essential for career growth.

## 3. Top Demanded Skills for Data Analysts

To identify the most in-demand skills, I analyzed the frequency of skills appearing in Data Analyst job postings.

**SQL Query:**
```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
**Analysis**
<br>

![Query 3 Output Analysis](/assets/output_q3.png) 

**Key Insights** 
- **SQL** is the most demanded skill by a large margin, making it the most essential skill for Data Analysts.
- **Excel** and **Python** remain highly demanded, showing that employers value both traditional data analysis tools and programming skills.
- **Tableau** and **Power BI** highlight the importance of data visualization and business intelligence tools in modern analytics roles.


**Conclusion**

The results show that the core skill set for Data Analysts includes SQL, Excel, Python, and BI tools, forming the foundation for most analytics roles.

## 4. Top Skills Based on Salary

To identify the most financially rewarding skills, I analyzed the average salary associated with each skill for Data Analyst roles where salary information was available.

**SQL Query:**
```sql
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
```
**Analyis**
<br>

![Query 4 Output Analysis](/assets/output_q4.png) 

**Key Insights**
- Some specialized technologies such as **SVN**, **Solidity**, and **Couchbase** are associated with the highest average salaries, indicating that niche technical expertise can significantly increase earning potential.
- Skills related to data infrastructure and backend technologies like Golang, Terraform, and VMware also appear among the highest-paying.
- Many of these high-paying skills are not traditional analyst tools, suggesting that analysts who expand into data engineering, cloud, or advanced technical tools may earn higher salaries.

**Conclusion**

While core analytics skills are essential, developing specialized technical skills in data infrastructure, cloud systems, or advanced technologies can lead to significantly higher salaries in the data field.

## 5. Most Optimal Skills to Learn (High Demand + High Salary)

To identify the most valuable skills for career growth, I analyzed skills that are both in high demand and associated with higher average salaries for remote Data Analyst roles.

**SQL Query**
```sql
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
```

**Analysis**
<br>
![Query 5 Output Analysis](/assets/output_q5.png) 

**Key Insights**
- Skills such as **Go, Snowflake, Hadoop, and Azure** offer a strong balance of demand and salary potential.
- **Cloud** and **data engineering** tools like **AWS, BigQuery, and Snowflake** appear frequently, showing the growing importance of modern data infrastructure skills.
- Some collaboration and workflow tools like **Confluence** and **Jira** also appear, indicating that project management and team collaboration tools are valuable in analytics environments.

**Conclusion**

The most optimal skills for Data Analysts are those that combine data analysis with cloud and data engineering technologies, helping professionals stay competitive while maximizing salary potential.

# What I Learned
Through this project, I strengthened both my **SQL querying skills and analytical thinking** while working with real-world job posting data. Key takeaways include:

- Improved my ability to write **complex SQL queries using JOINs, CTEs, aggregation functions, and filtering.**
- Learned how to **analyze job market data** to uncover insights about salaries, demand, and skill requirements.
- Gained a deeper understanding of the **skills that drive higher salaries and career growth in the Data Analyst field.**
- Practiced transforming raw data into **meaningful insights that can guide career decisions.**

# Conclusions
This analysis highlights several important trends in the Data Analyst job market:

- **SQL, Python, and BI tools (Tableau/Power BI)** remain the core skills required for most Data Analyst roles.
- **Cloud and data infrastructure technologies** such as Snowflake, Azure, and AWS are increasingly valuable and often linked with higher salaries.
- Combining **high-demand skills with high-paying technologies** can significantly improve career opportunities for aspiring Data Analysts.

Overall, this project demonstrates how **data-driven analysis can reveal valuable insights about the job market**, helping professionals focus on the skills that maximize both **employability and salary potential.**