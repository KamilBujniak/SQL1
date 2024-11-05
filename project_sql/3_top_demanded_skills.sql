/*
Question: What are the most in-demand skills for data analyst?

*/

SELECT
    COUNT(job_postings_fact.job_id) AS job_offer,
    skills
FROM 
    job_postings_fact
INNER JOIN 
   skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
ORDER BY job_offer DESC
LIMIT 5;

/* ANSWER: 
Loolks like the most demanded skill on market is SQL. Then we have Python, AWS, Azure and R.
[
  {
    "job_offer": "385750",
    "skills": "sql"
  },
  {
    "job_offer": "381863",
    "skills": "python"
  },
  {
    "job_offer": "145718",
    "skills": "aws"
  },
  {
    "job_offer": "132851",
    "skills": "azure"
  },
  {
    "job_offer": "131285",
    "skills": "r"
  }
]*/
