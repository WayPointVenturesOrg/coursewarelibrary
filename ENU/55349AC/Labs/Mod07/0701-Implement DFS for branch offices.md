# Lab A: Implement DNS for branch offices

## Lab scenario

Contoso corporation has several key shared folders that must be accessible to users in Sydney and Toronto. The folders are accessed by users in Sydney only a few times per day, but are accessed from Toronto constantly throughout the day. To ensure that users have the optimal experience when accessing the files, Contoso has decided to implement DFSR for the users in Toronto.

## Exercise 1: Implementing DFS

### Scenario

The Toronto office has a single server, **TOR-SVR1**. To support branch staff requirements, you need to configure DFS to replicate a shared folder named BranchDocs between **LON-SVR1** and **TOR-SVR1**. To avoid having to perform backups remotely, the BranchDocs folder in the London location is replicated with **TOR-SVR1** to provide quicker access to the files, while still maintaining the files in London for centralized backup.

The main tasks for this exercise are as follows:

1. Install the DFS role on LON-SVR1 and TOR-SVR1.
2. Create the BranchDocs DFS Namespace.
3. Add the DataFiles folder to the BranchDocs namespace.
4. Create a folder target for DataFiles on TOR-SVR1.
5. Configure replication for the namespace.

### Task 1: Install the DFS role on LON-SVR1 and TOR-SVR1

1. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**.

3. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

4. In the **Add Roles and Features Wizard**, select **Next**.

5. On the **Select installation type** page, select **Next**.

6. On the **Select destination server** page, select **Next**.

7. On the **Select server roles** page, expand **File and Storage Services (installed)**, expand **File and iSCSI Services**, and then select the **DFS Namespaces** check box.

8. In the **Add Roles and Features** pop-up window, select **Add Features**.

9. Select the **DFS Replication** check box, and then select **Next**.

10. On the **Select features** page, select **Next**.

11. On the **Confirm installation selections** page, select **Install**.

12. When the installation completes, select **Close**.

13. Repeat steps 1 through 12 on **TOR-SVR1**.


### Task 2: Create the BranchDocs DFS Namespace

1. Switch to **LON-SVR1**.

2. In **Server Manager**, select **Tools**, and then select **DFS Management**. 

3. In the navigation pane, select **Namespaces**.

4. Right-click **Namespaces**, and then select **New Namespace**.

5. In the **New Namespace Wizard**, on the **Namespace Server** page, under **Server**, enter **LON-SVR1**, and then select **Next**.

6. On the **Namespace Name** **and** **Settings** page, under **Name**, enter **BranchDocs**, and then select **Next**.

7. On the **Namespace Type** page, ensure that **Domain-based namespace** is selected. 

   > Note that the namespace will be accessed by **\\\\Contoso.com\\BranchDocs**. 

8. Ensure that the **Enable Windows Server 2008** **mode** check box is selected, and then select **Next**.

9. On the **Review Settings and Create Namespace** page, select **Create**.

10. In the **New Namespace Wizard** window, select **Close**.


### Task 3: Add the DataFiles folder to the BranchDocs namespace

1. On **LON-SVR1**, in **DFS Management**, right-click **Contoso.com\\BranchDocs**, and then select **New Folder**. 

2. In the **New Folder** dialog box, under **Name**, enter **DataFiles**, and then select **Add**.

3. In the **Add Folder Target** dialog box, enter **\\\\LON-SVR1\\DataFiles**, and then select **OK**.

4. In the **Warning** dialog box, select **Yes**.

5. In the **Create Share** dialog box, in the **Local** **path of shared folder** box, enter **C:\\BranchDocs\\DataFiles**. 

6. Select **All users have read and write permissions**, and then select **OK**. 

7. In the **Warning** dialog box, select **Yes**.

8. To close the **New Folder** dialog box, select **OK**.


### Task 4: Create a folder target for DataFiles on TOR-SVR1

1. On **LON-SVR1**, in **DFS Management**, expand **Namespaces**, **\\\\Contoso.com\\BranchDocs**, and then select **DataFiles**. 

   > In the details pane, notice that there is currently only one folder target.

2. Right-click **DataFiles**, and then select **Add Folder Target**.

3. In the **New Folder Target** dialog box, under **Path to folder target**, enter **\\\\TOR-SVR1\\DataFiles**, and then select **OK**.

4. To create the shared folder on **TOR-SVR1**, in the **Warning** dialog box, select **Yes**.

5. In the **Create Share** dialog box, under **Local path** **of shared folder**, enter **C:\\BranchDocs\\DataFiles**.

6. In the **Create Share** dialog box, under **Shared folder permissions**, select **All users have read and write permissions**, and then select **OK**.

7. To create the folder on **TOR-SVR1**, in the **Warning** dialog box, select **Yes**.

8. In the **Replication** dialog box, select **Yes**. 

   > The **Replicate Folder Wizard** starts.


### Task 5: Configure replication for the namespace

1. In **DFS Management**, in the **Replicate Folder Wizard**, on the **Replication Group and Replicated Folder Name** page, accept the default settings, and then select **Next**.

2. On the **Replication Eligibility** page, select **Next**.

3. On the **Primary Member** page, select **LON-SVR1**, and then select **Next**.

4. On the **Topology Selection** page, select **No topology**, and then select **Next**.

5. In the **Warning** dialog box, select **OK**.

6. On the **Review Settings** **and** **Create Replication Group** page, select **Create**.

7. On the **Confirmation** page, select **Close**.

8. In the **Replication Delay** dialog box, select **OK**.

9. In the **DFS Management** console, expand **Replication**, and then select **Contoso.com\\BranchDocs\\DataFiles**.

10. In the **Action** pane, select **New Topology**.

11. In the **New Topology Wizard**, on the **Topology Selection** page, select **Full mesh**, and then select **Next**.

12. On the **Replication Group Schedule and Bandwidth** page, select **Next**.

13. On the **Review Settings and Create Topology** page, select **Create**.

14. On the **Confirmation** page, select **Close**, and in the **Replication Delay** dialog box, select **OK**.

15. In the details pane, on the **Memberships** tab, verify that the replicated folder appears on both **TOR-SVR1** and **LON-SVR1**.


**Results:** Upon completion of this exercise, you will have implemented DFS.

## Exercise 2: Validating the deployment

### Task 1: Verify DFSR functionality for TOR-SVR1

1. On **LON-SVR1**, on the taskbar, select the **File Explorer** icon.

2. In **File Explorer**, in the address bar, enter **\\\\Contoso.com\\BranchDocs\\DataFiles**, and then press Enter.

3. In **File Explorer**, right-select the empty space in the details pane, select **New**, and then select **Text Document**.

4. Type **Repltest**, and then press Enter.

5. In **File Explorer**, in the address bar, enter **C:\\BranchDocs\\Datafiles**, and then press Enter. 

   > Confirm that the **Repltest.txt** file is located in the folder.

6. Switch to **TOR-SVR1**.

7. Open **File Explorer**, and in the address bar, enter **C:\\BranchDocs\\Datafiles**, and then press Enter. 

   > Confirm that the **Repltest.txt** file is located in the folder. If **Repltest.txt** does not appear within one minute or after refreshing the view, restart **TOR-SVR1**.

**Results**: Upon completion of this exercise, you will have validated the deployment of DFS in branch offices.