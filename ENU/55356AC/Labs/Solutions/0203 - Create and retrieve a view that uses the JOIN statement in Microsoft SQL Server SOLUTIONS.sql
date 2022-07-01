-- Retrieve the entirety of the "titles" and "publishers" tables
SELECT * FROM titles;
SELECT * FROM publishers;

-- Retrieve the titles matched to their publisher names from the "titles" and "publishers" tables
SELECT title, pub_name FROM titles
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id;

-- Create a view from the JOIN statement combining the "titles" and "publishers" tables
CREATE VIEW titles_and_publisher_names
AS
SELECT title, pub_name FROM titles
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id;

-- Retrieve the newly-created view
SELECT * FROM titles_and_publisher_names;