-- Add a column titled "flname" to the table named "employee"
ALTER TABLE employee
ADD flname varchar(50);

-- Retrieve the entire "employee" table, including the newly-added "flname" column full of NULL values 
SELECT * FROM employee;

-- Change all entries in the "employee" table so their value for the "flname" field is the combination of their "fname" and "lname" fields with a space between them
UPDATE employee
SET flname = CONCAT(fname, ' ', lname);

-- Retrieve the entire "employee" table, including the "flname" column filled with full names
SELECT * FROM employee;