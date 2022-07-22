# Lab 4: Add and change data in Microsoft SQL Server

## Scenario

You work at a publishing house managing information about books and publishers. Your managers are impressed with your knowledge and SQL skills, and want to offer you a promotion. They want you to add an entry to their **employee** table with your information. You'll use the `INSERT` statement to add a row with your data. After you do so, you'll use the `UPDATE` statement to change the information in that row to reflect your enhanced role.

## Objectives

By completing this lab, you’ll achieve the knowledge and skills to:

- Connect to the database.
- Inspect a table using Microsoft SQL Server Management Studio.
- Add and change data in a database using INSERT and UPDATE statements.


Estimated time: 20 minutes

## Exercise 1: Connect to the database

### Scenario

You'll begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, named **pubs**. This will allow you to add, retrieve, and change information within the database.

The main tasks for this exercise are as follows:

1. Prepare the lab environment.
2. Connect to the database.

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

   > The **SQLQuery1.sql** window opens. In this query window, you can run SQL code against the **pubs** database.

### Results

You've connected to the **pubs** database and have opened a new query window.

## Exercise 2: Inspect a table using Microsoft SQL Server Management Studio

### Scenario

Now that you've successfully connected to the **pubs** database, you'll inspect the **employee** table to determine what data types, constraints, and properties it has. This step will allow you to accurately predict what values it can accept.

The main tasks for this exercise are as follows:

1. Inspect a table using the Object Explorer window.
1. Inspect a table using the Design window.

#### Task 1: Inspect a table using the Object Explorer window

1. In the **Object Explorer** window, select the **pubs** database. 

2. Select the right arrow key to expand the database folder.

   > The database folder expands.

3. Inside the **pubs** database folder, locate the **Tables** folder and select it. Select the right arrow key to expand the folder.

   > The folder expands.

4. Inside the **Tables** folder, locate the **dbo.employee** table folder and select it. Select the right arrow key to expand the table folder.

   > The table folder expands.

5. Inside the **dbo.employee** table folder, locate and expand the **Columns** folder.

   > The folder expands.
   > In this folder, each item represents a single column in the table. Each column's name is followed by abbreviated information about the column, such as its data type and whether it's nullable.
   > For example, the **minit** column is entered `minit (char(1), null)`, which indicates the data type is **char(1)** and the column accepts NULL values.
   > Open an item to learn more about a specific column.

6. Inside the **dbo.employee** table folder, locate and expand the **Keys** folder.

   > The folder expands.
   > In this folder, each item represents a primary key or foreign key constraint.
   > For example, the **emp_id** column is included here as `PK_emp_id`, which indicates the column is a primary key.
   > Open an item to learn more about each key.

7. Inside the **dbo.employee** table folder, locate and expand the **Constraints** folder.

   > The folder expands.
   > In this folder, each item represents a constraint.
   > For example, the `DF__employee__job_id__47DBAE45` entry indicates on the **job_id** column has a *default* constraint.
   > Some constraint items can be opened to learn more.

8. Inside the **Constraints** folder, select and open the **CK_emp_id** entry.

   > The **MIA-SQL.pubs - dbo.employee** page opens and a popup window, named **Check Constraints**, opens.
   > In the **Check Constraints** window, information about this constraint is detailed.
   > Under the **General** dropdown menu, the **Expression** contains information about what values are accepted by this **Check** constraint.

9. Close the **Check Constraints** window.

10. Close the **MIA-SQL.pubs - dbo.employee** page.

#### Task 2: Inspect a table using the Design window

1. In the **Object Explorer** window, select the **dbo.employee** table . 

2. Right-click or access the context menu for the **dbo.employee** table, and select **Design**.

   > The **Design** command opens the the **MIA-SQL.pubs - dbo.employee** page.
   > On this page, a table details column names, their data types, and whether they accept NULL values.
   > Select a column name to observe additional details in the **Column Properties** window.

3. Select the **emp_id** column. Inspect the **Column Properties** window.

   > This window contains additional information that might be difficult to find through the **Object Explorer**.
   > For example, a value of `YES` in the **Identity Specification** row indicates an `IDENTITY` property is active on that column.

4. Close the **MIA-SQL.pubs - dbo.employee** page.


### Results

You can now use Microsoft SQL Server Management Studio to closely inspect a table to determine its features and the values it can accept.

## Exercise 3: Add and change data in a database using INSERT and UPDATE statements

### Scenario

Now that you've inspected the **employee** table, you'll add a new entry with an `INSERT` statement that matches the table's data type requirements and constraints. After you've added the entry, you'll change it using an `UPDATE` statement.

The main tasks for this exercise are as follows:

1. Add an entry to a table using an INSERT statement.
1. Change an entry in a table using an UPDATE statement.

#### Task 1: Add an entry to a table using an INSERT statement

1. In a new query to the **pubs** database, enter the following `SELECT` statement in the **query** window:

   ```
   SELECT * FROM employee;
   ```

2. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > You should receive a table containing employee information.
   >
   > The table should have 8 columns and 43 rows.

3. Delete the previous statement and then enter the following `INSERT` statement:

   ```sql
   INSERT INTO employee (emp_id, fname, minit, lname, job_id, job_lvl, pub_id, hire_date)
   VALUES ('JDD55356M', 'John', 'D', 'Doe', 14, 25, 1389, GETDATE());
   ```

   > The `GETDATE()` function supplies the current date and time.

4. Alter the statement by replacing `John` with your first name, `Doe` with your last name, and `D` with the first letter of your middle name. If you don't have a middle name, you can replace it with an empty string by entering `''`.

   > If you don't want to use your real name, you can use a famous individual's name instead.

5. Select the **Execute** button, or select **`F5`** on the keyboard to run the statements.

   > The row is added.
   > If errors prevent you from running the code, compare your values to the constraints placed upon the *dbo.employee* table. Ensure the values meet their requirements.

6. Retrieve the resulting table by entering and executing the following `SELECT` statement:

   ```sql
   SELECT * FROM employee;
   ```

   > You should receive a table containing employee information, including the row you added.
   >
   > The table should have 8 columns and 44 rows.

#### Task 2: Change an entry in a table using an UPDATE statement

1. In a new query to the **pubs** database, enter the following `UPDATE` statement in the **query** window:

   ```sql
   UPDATE employee
   SET job_lvl = 100
WHERE emp_id = 'JDD55356M';
   ```
   
   > Ensure the `emp_id` value matches the field in the row you added during **Task 1**.

3. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > The value is changed.

4. Delete the previous statement, and then enter and execute the following `SELECT` statement:

   ```sql
   SELECT * FROM employee;
   ```
   
   > You should receive a table containing employee information, including the changed value in the row you added.
   >
   > The table should have 8 columns and 44 rows.

5. Close Microsoft SQL Server Management Studio without saving changes.

### Results

You can now use Microsoft SQL Server Management Studio to add and change information within a table.
