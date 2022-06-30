# Lab 1: Use the SELECT statement to retrieve data from a database

## Scenario

You work at a publishing house handling information about books and publishers. A customer asks for a selection of books that meet various search criteria. You will connect to the publishing house's database, named **pubs**, using Microsoft SQL Server Management Studio. Once connected, you will retrieve information about the books that match the customer's search criteria.

## Objectives

After completing this lab, you will be able to:

- Connect to the database.

- Retrieve data from the database.


Estimated time: 10 minutes

## Exercise 1: Connect to the database

### Scenario

You will begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, called **pubs**. This will allow you to begin retrieving information from the database.

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


   > The **Object Explorer** opens.

2. From the **Object Explorer**, expand the **Databases** node.

3. Right-click or access the context menu for the **pubs** database, and then select **New Query**.

   > The SQLQuery1.sql window opens. In this query window you can run SQL code against the **pubs** database.

### Results

You have connected to the **pubs** database and have opened a new query window.

## Exercise 2: Retrieve data from the database

### Scenario

Now that you have successfully connected to the **pubs** database, you will run `SELECT` statements to gather data from the server in order to answer the customer's requests.

The main task for this exercise is as follows:

1. Use a SELECT statement to retrieve information from the database

#### Task 1: Use a SELECT statement to retrieve information from the database

1. In a new query to the **pubs** database, write the following `SELECT` statement in the **SQLQuery1** window:

   ```sql
   SELECT * FROM titles;
   ```

2. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement. 

   > You should receive a table containing information about books. The table should have 10 columns and 18 rows.
   >
   > Notice that the results show all columns from the `titles` table.
   
3. From the **SQLQuery1** window, delete the previous query and replace the text with the following `SELECT` statement:

   ```sql
   SELECT title_id, title, type, notes FROM titles;
   ```

4. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement.

   > You should receive a table containing information about books. The table should have 4 columns and 18 rows.
   >
   >  Notice that only the `title_id`, `title`, `type`, and `notes` columns are displayed from the `titles` table.
   
5. From the **SQLQuery1** window, delete the previous query and replace the text with the following `SELECT` statement:

   ```sql
   SELECT title FROM titles WHERE type='business';
   ```
   >
   > Note: Remember that strings are surrounded by single quotes in SQL.

7. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement. 

    > You should receive a table containing the titles of books. The table should have 1 column and 4 rows. 
    >
    > Notice that the query returns only the title of business books that are listed in the `titles` table.

8. Close Microsoft SQL Server Management Studio without saving changes.

### Results

You can now use Microsoft SQL Server Management Studio to retrieve data from a database using a SELECT statement.
