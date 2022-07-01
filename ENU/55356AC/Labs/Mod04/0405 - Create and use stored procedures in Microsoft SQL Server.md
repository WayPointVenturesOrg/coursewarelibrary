# Lab 5: Create and use stored procedures in Microsoft SQL Server

## Scenario

You work at a publishing house handling information about books and publishers. The business has recently expanded and many new employees are being hired. To simplify the process of adding information about new hires to the database, you will create a **stored procedure** that streamlines this process. You will then test it with a new hire's information to ensure it works.

## Objectives

After completing this lab, you will be able to:

- Connect to the database
- Create and run a stored procedure in Microsoft SQL Server

Estimated time: 10 minutes

## Exercise 1: Connect to the database

### Scenario

You will begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, called **pubs**. This will allow you to create and run a stored procedure within the database.

The main tasks for this exercise are as follows:

1. Prepare the lab environment
2. Connect to the database

#### Task 1: Prepare the lab environment.

1. Sign in to MIA-SQL as **Administrator** with the password of **Pa55w.rd**.

2. On the taskbar, select **Microsoft SQL Server Management Studio 18**. 

   > The Microsoft SQL Management Studio opens.

####  Task 2: Connect to the database

1. From Microsoft SQL Server Management Studio, in the **Connect to Server** dialog box, verify the following selections, and then select **Connect**.

   - Server type: **Database Engine**

   - Server name: **MIA-SQL**

   - Authentication: **Windows Authentication**

   >The **Object Explorer** opens.

2. From the **Object Explorer**, expand the **Databases** node.

3. Right-click or access the context menu for the **pubs** database, and then select **New Query**.

   > The SQLQuery1.sql window opens. In this query window you can run SQL code against the **pubs** database.

### Results

You have connected to the **pubs** database and have opened a new query window.

## Exercise 2: Create and run a stored procedure in Microsoft SQL Server

### Scenario

Now that you have successfully connected to the **pubs** database, you will create a stored procedure that adds information about a new hire to the **employee** table. You will implement several input parameters in the stored procedure, then test it with a new hire's information. 

The main tasks for this exercise are as follows:

1. Create a stored procedure with input parameters in Microsoft SQL Server
1. Run a stored procedure in Microsoft SQL Server

#### Task 1: Create a stored procedure with input parameters in Microsoft SQL Server

1. In a new query to the **pubs** database, write the following `CREATE PROCEDURE` statement in the **query** window:

   ```sql
   CREATE PROCEDURE add_new_hire
   @fname varchar(20),
   @minit char(1),
   @lname varchar(30)
   AS
   INSERT INTO employee (emp_id, fname, minit, lname, job_id, job_lvl, pub_id, hire_date)
   VALUES ('A-Z12345F', @fname, @minit, @lname, 1, 10, 1389, GETDATE());
   ```

   > This creates the stored procedure named **add_new_hire** with the input parameters `fname`, `minit`, and `lname`.
   > When the stored procedure is run, it supplies the values in the input parameters to the `INSERT` statement.

2. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement.

   > The stored procedure is created.

#### Task 2: Run a stored procedure in Microsoft SQL Server

1. Create a new query or delete the code from the previous task. 

2. Write and then execute the following `SELECT` statement:

   ```sql
   SELECT * FROM employee;
   ```

   > You should receive a table containing employee information.
   >
   > The table should have 8 columns and 43 rows.

3. Delete the previous statement and then write the following code:

   ```sql
   EXEC add_new_hire
   @fname = 'Jane',
   @minit = '',
   @lname = 'Doe';
   ```

4. Select the **Execute** button, or press **`F5`** on the keyboard to run the statement.

   > The stored procedure is run.
   > An entry is created for the new hire.

5. Delete the previous statement and then write and execute the following `SELECT` statement:

   ```sql
   SELECT * FROM employee;
   ```

   > You should receive a table containing employee information, including the row you added.
   >
   > The table should have 8 columns and 44 rows.

6. Close Microsoft SQL Server Management Studio without saving changes.

### Results

You can now use Microsoft SQL Server Management Studio to create and run a stored procedure.