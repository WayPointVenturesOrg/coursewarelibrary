# Lab 7: Denormalize a table by adding a redundant column of computed data

## Scenario

You work at a publishing house managing information about books and publishers. You've been asked to combine data about employees in the publishing house's database so that one column contains both first and last names. This will create redundancy, **denormalizing** the table. You'll add a column to the **employees** table to store this data, and fill it with computed data from the table.

## Objectives

By completing this lab, you’ll achieve the knowledge and skills to:

- Connect to the database.
- Denormalize a table by adding a column and populate it with computed data.

Estimated time: 10 minutes

## Exercise 1: Connect to the database

### Scenario

You'll begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, named **pubs**. This will allow you to alter a table within the database.

The main tasks for this exercise are as follows:

1. Prepare the lab environment.
2. Connect to the database.

#### Task 1: Prepare the lab environment.

1. Sign in to MIA-SQL as **Administrator** with the password of **Pa55w.rd**.

2. On the taskbar, select **Microsoft SQL Server Management Studio 18**. 

   > The Microsoft SQL Server Management Studio opens.

####  Task 2: Connect to the database

1. From Microsoft SQL Server Management Studio, in the **Connect to Server** dialog box, verify the following selections, and then select **Connect**.

   - Server type: **Database Engine**

   - Server name: **MIA-SQL**

   - Authentication: **Windows Authentication**

   >The **Object Explorer** opens.

2. From the **Object Explorer**, expand the **Databases** node.

3. Right-click or access the context menu for the **pubs** database, and then select **New Query**.

   > The **SQLQuery1.sql** window opens. In this query window, you can run SQL code against the **pubs** database.

### Results

You've connected to the **pubs** database and have opened a new query window.

## Exercise 2: Denormalize a table by adding a column and populate it with computed data

### Scenario

Now that you've successfully connected to the **pubs** database, you'll add a column to the **employees** table that stores the combination of the first and last name columns.

The main task for this exercise is the following:

Add a column to a table and populate it with computed data.

#### Task 1: Add a column to a table and populate it with computed data

1. In a new query to the **pubs** database, enter the following `ALTER TABLE` statement in the **query** window:

   ```sql
   ALTER TABLE employee
   ADD flname varchar(50);
   ```

2. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > The new column is created.

3. Delete the previous statement. Enter the following `SELECT` statement:

   ```sql
   SELECT * FROM employee;
   ```

4. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > You should receive a table containing employee information, with the newly added **flname** column full of NULL values.
   >
   > The table should have 9 columns and 43 rows.

5. Delete the previous statement. Enter and then execute the following UPDATE statement:

   ```sql
   UPDATE employee
   SET flname = CONCAT(fname, ' ', lname);
   ```

   > The `CONCAT` function adds strings together. Here, it will combine the `fname` and `lname` fields with a space between them.  

6. Delete the previous statement. Enter the following `SELECT` statement:

   ```sql
   SELECT * FROM employee;
   ```

7. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > You should receive a table containing employee information, with each entry's value in the **flname** column equaling the combination of that entry's **fname** and **lname** fields, separated by a space. This newly created column will need to be updated periodically, or a trigger will have to be created to populate it with data automatically when data is added or changed. Otherwise, its data will fail to accurately represent the values in the table.
   >
   > The table should have 9 columns and 43 rows.

8. Close Microsoft SQL Server Management Studio without saving changes.


### Results

You can now use Microsoft SQL Server Management Studio to denormalize a table.
