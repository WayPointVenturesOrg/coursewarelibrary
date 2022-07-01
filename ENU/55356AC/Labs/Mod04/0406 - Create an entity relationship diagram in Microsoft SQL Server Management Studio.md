# Lab 6: Create an entity relationship diagram in Microsoft SQL Server Management Studio

## Scenario

You work at a publishing house handling information about books and publishers. You have been asked to introduce several new hires to the **pubs** database that stores information about the business. You will create an **entity relationship diagram**, or **database diagram**, in order to visually explain relationships in the database.

## Objectives

After completing this lab, you will be able to:

- Connect to the database
- Create a database diagram in Microsoft SQL Server Management Studio

Estimated time: 5 minutes

## Exercise 1: Connect to the database

### Scenario

You will begin by using Microsoft SQL Server Management Studio to connect to the publishing house's database, called **pubs**. This will allow you to create a database diagram within the database.

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

   >The **Object Explorer** opens.

2. From the **Object Explorer**, expand the **Databases** node.

### Results

You have connected to the **pubs** database.

## Exercise 2: Create a database diagram in Microsoft SQL Server Management Studio

### Scenario

Now that you have successfully connected to the **pubs** database, you will create a database diagram that depicts the relationships between the **titles** table and other tables in the database.

The main tasks for this exercise are as follows:

1. Create a database diagram

#### Task 1: Create a database diagram

1. In the **Object Explorer** window, select the **pubs** database folder. Press the right arrow key to expand the database folder.

   > The database folder expands.

2. Inside the expanded database folder, locate the *Database Diagrams* folder. Right-click or access the context menu, and select **New Database Diagram.** In the Microsoft SQL Server Management Studio message, select **Yes** to create the supported objects.

   > A **diagram** window opens.
   > A popup window titled **Add Table** opens.

3. Inside the **Add Table** popup window, select the **titles** table and select the **Add** button.

   > A box with the title **titles** appears in the **diagram** window.

4. Close the **Add Table** popup window.

5. Inspect the diagram.

   > Inside the **titles** box, each row is a column in the **titles** table.
   > Rows marked with keys are fields with *primary key* constraints.
   > For example, the `title_id` row is marked with a key because it is the **titles** table's primary key.

6. Select the **titles** box in the **diagram** window. Right-click or access the context menu, and select **Add Related Tables.**

   > Boxes join the **titles** box in the **diagram** window.

7. Right-click or access the context menu for the **titles** box, and select **Arrange Selection**.

   > The boxes arrange around the **titles** box.

8. Inspect the diagram.

   > You should see five boxes: **titles**, **sales**, **publishers**, **titleauthor**, and **roysched**.
   > Lines connect the latter four boxes to the **titles** box. The line end shaped like two empty circles connects to the box with a *foreign key* constraint. The foreign key references the table the key-shaped line end connects to.
   > For example, the line between **titles** and **publishers** touches titles with two empty circles, and publishers with a key. This depicts a foreign key in titles that references a primary key in publishers.

9. Right-click or access the context menu for the line between **titles** and **publishers**, and select **Properties**.

   > The **Properties** window opens in the right side of the Microsoft SQL Server Management Studio application.

10. In the **Properties** window select the **Tables and Columns Specification** cell and press the right arrow key to expand it.

   > Four rows are revealed. They detail the tables and columns the foreign key constraint affects. 

11. Close Microsoft SQL Server Management Studio without saving changes.

### Results

You can now use Microsoft SQL Server Management Studio to create an entity relationship diagram.