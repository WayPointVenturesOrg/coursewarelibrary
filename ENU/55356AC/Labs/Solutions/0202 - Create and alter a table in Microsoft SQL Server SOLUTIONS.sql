-- Create the instructional_class table
CREATE TABLE instructional_class (
	class_id int PRIMARY KEY IDENTITY,
	title varchar(100) NOT NULL,
	starting_date datetime2 NOT NULL,
	ending_time time NOT NULL,
);

-- Retrieve the newly-created instructional_class table
SELECT * FROM instructional_class;

-- Add the column titled "teacher" to the instructional_class table
ALTER TABLE instructional_class
ADD teacher nvarchar(100) NOT NULL;

-- Retrieve the newly]-altered instructional_class table
SELECT * FROM instructional_class;