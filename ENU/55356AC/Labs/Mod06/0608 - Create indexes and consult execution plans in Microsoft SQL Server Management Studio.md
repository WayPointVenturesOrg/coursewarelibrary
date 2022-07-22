# Lab 8: Create indexes and consult execution plans in Microsoft SQL Server Management Studio

## Scenario

You work at a publishing house managing information about books and publishers. You're notified that a query retrieving basic information about book titles runs slowly. To address this issue and fix it, you'll check the existing indexes in the database, create one to increase the speed of the query, and consult the execution plan that SQL Server prepares for the query. 

## Objectives

By completing this lab, you’ll achieve the knowledge and skills to:

- Connect to the database.
- Check and create indexes.
- Consult execution plans in Microsoft SQL Server Management Studio.

Estimated time: 15 minutes

## Exercise 1: Connect to the database

### Scenario

You'll begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, named **pubs**. This will allow you to create and consult indexes within the database.

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

### Results

You've connected to the **pubs** database.

## Exercise 2: Check and create indexes

### Scenario

Now that you've successfully connected to the **pubs** database, you'll check for existing indexes on the **titles** table and create a nonclustered index to improve the speed of the slow query.

The main tasks for this exercise are as follows:

1. Check existing indexes active on a table.
2. Create a nonclustered index to improve the speed of a query.

#### Task 1: Check existing indexes active on a table

1. In the **Object Explorer** window, locate and expand the **pubs** database folder.

2. In the **pubs** database folder, locate the **Tables** folder and select it. Select the right arrow key to expand the folder.

   > The folder expands.

3. In the **Tables** folder, locate the **dbo.titles** folder and select it. Select the right arrow key to expand the table folder.

   > The **dbo.titles** folder expands.

4. In the **dbo.titles** table folder, locate the **Indexes** folder and select it. Select the right arrow key to expand the folder.

   > The folder expands.
   > In this folder, each item represents an index.
   > The name of an index is followed by information about it in parentheses.
   > The folder should contain two items: **titleind (Non-Unique, Non-Clustered)** and **UPKCL_titleidind (Clustered)**.
   > You can open an item to learn more about it.

#### Task 2: Create a nonclustered index to improve the speed of a query

1. Right-click or access the context menu for the **pubs** database, and then select **New Query**.

   > The **SQLQuery1.sql** window opens. In this query window, you can run SQL code against the **pubs** database.

2. In a new query to the **pubs** database, enter the following `SELECT` statement in the **query** window:

   ```sql
   SELECT title_id, title, type FROM titles 
   ORDER BY title ASC;
   ```

   > This is the query you've been told runs slowly.
   > Though this query runs quickly in this small database, it would run more slowly if the dataset was larger or the query was more complicated. The query has been simplified in this example.

3. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > You should receive a table containing information about book titles.
   >
   > The table should have 3 columns and 18 rows.

4. Delete the previous statement. Enter the following `CREATE INDEX` statement in the **query** window:

   ```sql
   CREATE NONCLUSTERED INDEX IX_titles_title 
   ON titles(title ASC) INCLUDE (title_id, type);
   ```

5. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > The nonclustered index is created.

6. In the **dbo.titles** table, select the **Indexes** folder. Right-click or access the context menu and select **Refresh**.

   > The folder's contents are refreshed.
   > The folder should contain three items, including the new index reading **IX_titles_title (Non-Unique, Non-Clustered)**.

7. Open the **IX_titles_title** index.

   > The **Index Properties** pop-up window opens.
   > This window contains additional information about the index.
   > For example, the index type is noted as **Nonclustered**.

8. Close the **Index Properties** pop-up window.

   > The pop-up window closes.

### Results

You can now use Microsoft SQL Server Management Studio to check and create indexes.

## Exercise 3: Consult execution plans in Microsoft SQL Server Management Studio

### Scenario

Now that you've created a nonclustered index on the **titles** table, you'll consult the steps Microsoft SQL Server Management Studio must perform to run a statement. This process is called an **execution plan**. You'll compare an execution plan using the nonclustered index you've created against an execution plan that doesn't use the index.

The main task for this exercise is the following:

Consult and compare execution plans.

#### Task 1: Consult and compare execution plans

1. In the **SQLQuery1.sql** window, delete any existing text.

2. In a new query to the **pubs** database, enter the following `SELECT` statement in the **query** window:

   ```sql
   SELECT title_id, title, type FROM titles 
   ORDER BY title ASC;
   ```

3. From the **Query** menu, select **Include Actual Execution plan**.

   > If you don't see the **Query** menu, select the **SQLQuery1.sql** window and try again.

4. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > You should receive a table containing information about book titles.
   >
   > The table should have 3 columns and 18 rows.

5. In the bottom panel of Microsoft SQL Server Management Studio, select the **Execution Plan** tab.

   > This window depicts information about the process the application takes to run the statement.
   > The header contains overall information about the query cost, which is the time it took to run the statement.
   > Below the header is a flowchart depiction of the structures and operations that were consulted, and the cost of each step.
   > The header should depict a query cost of **100%**, because it was the only query in the batch.
   > The flowchart should depict an index scan with an arrow leading to an item marked **SELECT**.

6. Delete the previous statement. In the **query** window, enter the following statement:

   ```sql
   SELECT titles.title_id, titles.title, titles.type FROM titles ORDER BY titles.title ASC;
   ALTER INDEX IX_titles_title ON titles DISABLE; 
   SELECT titles.title_id, titles.title, titles.type FROM titles ORDER BY titles.title ASC;
   ```

   > The first and last statements are the same.
   > The middle statement disables the index you created in **Exercise 2**.
   > Reenable the index if you want to run this statement again.

7. Select the **Execute** button, or select **`F5`** on the keyboard to run the statement.

   > You should receive two identical tables containing information about book titles.
   >
   > The tables should have 3 columns and 18 rows.

8. Switch to the **Execution Plan** window.

   > You should receive information about two queries.
   >
   > The first query, which is the query that used the nonclustered index, should have a query cost of about 25%.
   > The second query, which is the query after the index was disabled, should have a query cost of about 75%.
   >
   > The first query's flowchart should depict two structures: **Index Scan**, which leads to **SELECT**.
   > The second query's flowchart should depict four structures: **Index Scan** and **Key Lookup**, which lead to **Nested Loops**, which leads to **SELECT**.

9. Close Microsoft SQL Server Management Studio without saving changes.

### Results

You can now use Microsoft SQL Server Management Studio to consult and compare execution plans.
