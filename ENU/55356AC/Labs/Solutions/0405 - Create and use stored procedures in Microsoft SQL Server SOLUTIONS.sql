-- Create the stored procedure named "add_new_hire" with three input parameters
CREATE PROCEDURE add_new_hire
@fname varchar(20),
@minit char(1),
@lname varchar(30)
AS
INSERT INTO employee (emp_id, fname, minit, lname, job_id, job_lvl, pub_id, hire_date)
VALUES ('A-Z12345F', @fname, @minit, @lname, 1, 10, 1389, GETDATE());

-- Retrieve the entire "employee" table
SELECT * FROM employee;

-- Run the stored procedure "add_new_hire" inputting 'Jane', '', and 'Doe' for the parameters
EXEC add_new_hire
@fname = 'Jane',
@minit = '',
@lname = 'Doe';

-- Retrieve the entire "employee" table, including the added entry for Jane Doe
SELECT * FROM employee;