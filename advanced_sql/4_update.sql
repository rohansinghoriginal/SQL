UPDATE job_applied
SET contact = 'Peter Anderson'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Sahil Ahmed'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Aditya Verma'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Shivendra Chaurasia'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Shreyansh Pandey'
WHERE job_id = 5;

SELECT * FROM job_applied;

-- Rename functions:

ALTER TABLE job_applied 
RENAME COLUMN contact TO contact_name;

SELECT * FROM job_applied;


DROP TABLE job_applied;