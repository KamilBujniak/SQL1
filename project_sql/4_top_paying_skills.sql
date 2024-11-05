/*
Question: What are the top skills based on Salary.
*/



SELECT
    ROUND(AVG(salary_year_avg),0) AS average_salary,
    skills
FROM 
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    average_salary DESC
limit 25;

/* ANSWER


    "average_salary": "400000",
    "skills": "svn"
  },
  {
    "average_salary": "179000",
    "skills": "solidity"
  },
  {
    "average_salary": "160515",
    "skills": "couchbase"
  },
  {
    "average_salary": "155486",
    "skills": "datarobot"
  },
  {
    "average_salary": "155000",
    "skills": "golang"
  },
  {
    "average_salary": "149000",
    "skills": "mxnet"
  },
  {
    "average_salary": "147633",
    "skills": "dplyr"
  },
  {
    "average_salary": "147500",
    "skills": "vmware"
  },
  {
    "average_salary": "146734",
    "skills": "terraform"
  },
  {
    "average_salary": "138500",
    "skills": "twilio"
  },
  {
    "average_salary": "134126",
    "skills": "gitlab"
  },
  {
    "average_salary": "129999",
    "skills": "kafka"
  },
  {
    "average_salary": "129820",
    "skills": "puppet"
  },
  {
    "average_salary": "127013",
    "skills": "keras"
  },
  {
    "average_salary": "125226",
    "skills": "pytorch"
  },
  {
    "average_salary": "124686",
    "skills": "perl"
  },
  {
    "average_salary": "124370",
    "skills": "ansible"
  },
  {
    "average_salary": "123950",
    "skills": "hugging face"
  },
  {
    "average_salary": "120647",
    "skills": "tensorflow"
  },
  {
    "average_salary": "118407",
    "skills": "cassandra"
  },
  {
    "average_salary": "118092",
    "skills": "notion"
  },
  {
    "average_salary": "117966",
    "skills": "atlassian"
  },
  {
    "average_salary": "116712",
    "skills": "bitbucket"
  },
  {
    "average_salary": "116387",
    "skills": "airflow"
  },
  {
    "average_salary": "115480",
    "skills": "scala"
  }
]*/