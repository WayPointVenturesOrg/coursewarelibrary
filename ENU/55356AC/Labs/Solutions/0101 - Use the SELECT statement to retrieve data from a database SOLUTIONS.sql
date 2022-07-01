/* Retrieve the entire titles table. */
SELECT * FROM titles;

/* Retrieve only the title_id, title, type, and notes columns from the titles table. */
SELECT title_id, title, type, notes FROM titles;

/* Retrieve only the title column of the rows with type equal to 'business' from the titles table. */
SELECT title FROM titles WHERE type='business';