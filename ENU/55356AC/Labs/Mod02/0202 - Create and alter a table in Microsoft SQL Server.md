# Lab 2: Create and alter a table in Microsoft SQL Server

## Scenario

You work at a publishing house handling information about books and publishers. Recently, the publishing house has begun offering instructive classes to teach the basics of publishing. The publishing house has a database named **pubs**. You have been asked to create a new table in the **pubs** database to store information about these classes. You will use Microsoft SQL Server Management Studio to create this table.

## Objectives

After completing this lab, you will be able to:

- Connect to the database
- Create and alter a table


Estimated time: 10 minutes

## Exercise 1: Connect to the database

### Scenario

You will begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, called **pubs**. This will allow you to create a table inside the database.

The main tasks for this exercise are as follows:

1. Prepare the lab environment
2. Connect to the database

#### Task 1: Prepare the lab environment.

1. Sign in to MIA-SQL as **Administrator** with the password of **Pa55w.rd**.

2. On the taskbar, select **Microsoft SQL Server Management Studio 18**. 

   > The Microsoft SQL Server Management Studio opens.

####  Task 2: Connect to the database

1. From Microsoft SQL Server Management Studio, in the **Connect to Server** dialog box, verify the following selections, and then select **Connect**.

   - Server type: **Database Engine**

   - Server name: **MIA-SQL**

   - Authentication: **Windows Authentication**

   >
   > The **Object Explorer** opens.

2. From the **Object Explorer**, expand the **Databases** node.

3. Right-click or access the context menu for the **pubs** database, and then select **New Query**.

   > The SQLQuery1.sql window opens. In this query window you can run SQL code against the **pubs** database.

### Results

You have connected to the **pubs** database and have opened a new query window.

## Exercise 2: Create and alter a table

### Scenario

Now that you have successfully connected to the **pubs** database, you will run a `CREATE TABLE` statement to produce a table that stores information about instructional classes. Once the table has been successfully created, you will add a new field to the table representing the name of the instructor who teaches the class.

The main tasks for this exercise are as follows:

1. Create a table using the `CREATE TABLE` statement
1. Alter a table using the `ALTER TABLE` statement

#### Task 1: Create a table using the CREATE TABLE statement

1. In a new query to the **pubs** database, write the following statement in the **SQLQuery1.sql** window:

   ```sql
   CREATE TABLE instructional_class (
       class_id int PRIMARY KEY IDENTITY,
       title varchar(100) NOT NULL,
       starting_date datetime2 NOT NULL,
       ending_time time NOT NULL,
   );
   ```

2. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement. 

   > The table is created.
   
3. Delete the previous query from the **SQLQuery1.sql** window and then write the following `SELECT` statement:

   ```sql
   SELECT * FROM instructional_class;
   ```

4. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement.

   > You should receive the empty table you just created. 
   >
   > The table should have 4 columns and 0 rows.
   

#### Task 2: Alter a table using the ALTER TABLE statement

1. Delete the previous query from the **SQLQuery1.sql** window and then write the following statement in the **SQLQuery1.sql** window:

   ```sql
   ALTER TABLE instructional_class
   ADD teacher nvarchar(100) NOT NULL;
   ```

2. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement. 

   > The table is created.

3. Delete the previous query from the **SQLQuery1.sql** window and then write the following `SELECT` statement:

   ```sql
   SELECT * FROM instructional_class;
   ```

4. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement.

   > You should receive the empty table you just created, with the additional **`teacher`** column. 
   >
   > The table should have 5 columns and 0 rows.

5. Close Microsoft SQL Server Management Studio without saving changes.

### Results

You can now use Microsoft SQL Server Management Studio to create and alter a table.
