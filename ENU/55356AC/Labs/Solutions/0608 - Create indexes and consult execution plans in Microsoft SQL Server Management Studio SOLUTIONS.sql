-- Retrieves information about books from the titles table
SELECT title_id, title, type FROM titles 
ORDER BY title ASC;

/* 
Creates a nonclustered index on the title field of the titles table in ascending order
Includes the fields title_id and type
*/
CREATE NONCLUSTERED INDEX IX_titles_title 
ON titles(title ASC) INCLUDE (title_id, type);

-- Retrieves information about books from the titles table, now the index is active
SELECT title_id, title, type FROM titles 
ORDER BY title ASC;

-- Runs one query with the index, and one without, allowing for comparison
SELECT titles.title_id, titles.title, titles.type FROM titles ORDER BY titles.title ASC;
ALTER INDEX IX_titles_title ON titles DISABLE; 
SELECT titles.title_id, titles.title, titles.type FROM titles ORDER BY titles.title ASC;