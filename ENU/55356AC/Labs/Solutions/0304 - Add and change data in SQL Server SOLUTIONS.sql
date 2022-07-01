-- Retrieve the entire "employee" table
SELECT * FROM employee;

-- Add an entry into the "employee" table with the name 'John Doe'
INSERT INTO employee (emp_id, fname, minit, lname, job_id, job_lvl, pub_id, hire_date)
VALUES ('JDD55356M', 'John', 'D', 'Doe', 14, 25, 1389, GETDATE());

-- Retrieve the entire "employee" table, including the addition of John Doe
SELECT * FROM employee;

-- Change the "job_lvl" value to 100 for the employee with "emp_id" equal to 'JDD55356M'
UPDATE employee
SET job_lvl = 100
WHERE emp_id = 'JDD55356M';

-- Retrieve the entire "employee" table, including John Doe with changed "job_lvl" value
SELECT * FROM employee;