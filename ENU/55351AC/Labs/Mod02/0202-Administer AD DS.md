# Lab: Administer AD DS

## Lab scenario

You're preparing AD DS objects as part of a deployment for a new branch office. As part of this preparation, you need to create an OU for the branch office and delegate permission to manage it. Also, you need to evaluate Windows PowerShell to manage AD DS more efficiently.

## Exercise 1: Delegate administration for OUs

### Scenario

Contoso Corporation delegates management of each branch office to a specific group. This allows IT employees who work onsite to be branch administrators. Each branch office has a branch administrators group that can perform full administration within the branch office OU, and there's also a branch office helpdesk group that can only manage users in the branch office OU. 

You need to create the OU and groups for the new branch office and delegate permissions to the groups. You'll also validate the permissions.

The main tasks for this exercise are as follows:

1. Create a new OU for the branch office.

2. Create groups for branch administrators and branch help-desk personnel.

3. Add members to the group.

4. Delegate permissions to the group.

5. Test permissions.


### Task 1: Create a new OU for the branch office

1. If necessary, sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55wr.d**.

2. From **Server Manager**, open **Active Directory Users and Computers**.

3. In **Active Directory Users and Computers**, right-click or access the context menu for **Contoso.com**, select **New**, and then select **Organizational Unit**.

4. In the **New Object – Organizational Unit** dialog box, type **London** in the **Name** field, and then select **OK**.


### Task 2: Create groups for branch administrators and branch help-desk personnel

1. Right-click or access the context menu for the **London** OU, select **New**, and then select **Group**.

2. In the **New Object – Group** dialog box, type **London Admins**, and then select **OK**.

3. Repeat steps 1 and 2 to create a group named **London Helpdesk**.


### Task 3: Add members to the group

1. Select the **IT** OU.

2. Right-click or access the context menu for the **Alberto Hermosilla** user account, and then select **Add to a group**.

3. In the **Select Groups** dialog box, in **Enter the object names to select (examples):**, type **London Admins**, select **Check Names**, and then select **OK**.

4. In the **Active Directory Domain Services** message box, select **OK**.

5. Right-click or access the context menu for the **Tonnie Thomsen** user account, and then select **Add to a group**.

6. In the **Select Groups** dialog box, in **Enter the object names to select (example):**, type **London Helpdesk**, select **Check Names**, and then select **OK**.

7. In the **Active Directory Domain Services** message box, select **OK**.


### Task 4: Delegate permissions to the group

1. In **Active Directory Users and Computers**, select **View**, and then select **Advanced Features**.

2. Right-click or access the context menu for the **London** OU, and then select **Properties**.

3. Select the **Security** tab, and then select **Add**.

4. In the **Select Users, Computers, Service Accounts or Groups** dialog box, in **Enter the object names to select (example):**, type **London Admins**, select **Check Names**, and then select **OK**.

5. Ensure that the **London Admins** group is selected, select **Full Control** in the **Allow** column, and then select **OK**.

6. Right-click or access the context menu for the **London** OU, and then select **Delegate Control**.

7. In the **Delegation of Control Wizard**, select **Next**.

8. On the **Users or Groups** page, select **Add**.

9. In the **Select Users, Computers, or Groups** dialog box, in **Enter the object names to select (example):**, type **London Helpdesk**. select **Check Names**, select **OK**, and then select **Next**.

10. On the **Tasks to Delegate** page, select **Create a custom task to delegate**, and then select **Next**.

11. On the **Active Directory Object Type** page, select **Only the following object in this folder**.

12. Scroll to the bottom of the list, select **User objects**, select the check boxes for **Create selected objects in this folder** and **Delete selected objects in this folder**, and then select **Next**.

13. On the **Permissions** page, select **Full Control**, and then select **Next**.

14. Select **Finish**.


### Task 5: Test permissions

1. Switch to **LON-SVR1**.

2. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. Select **Start**, select **Server Manager**, and then select **Add roles and features**.

4. In the **Add Roles and Features Wizard**, select **Next**.

5. On the **Select installation type** page, select **Next**.

6. On the **Select destination server** page, select **Next**. 

7. On the **Select server roles** page, select **Next**. 

8. On the **Select features** page, expand **Remote Server Administration Tools**, and then expand **Role Administration Tools**. 

9. Expand **AD DS and AD LDS Tools**. Select the check box beside **AD DS Tools**, and then select **Next**.

10. Select **Install**. 

    > Wait for the installation to complete.

11. When the installation is complete, select **Close**.

12. Sign out of **LON-SVR1**.


#### Test permissions for London Admins

1. Sign in to **LON-SVR1** as **Alberto** with the password **Pa55w.rd**.

2. Select **Start**, and then select the **Server Manager** tile.

3. Select **Tools**, and then select **Active Directory Users and Computers**.

4. Expand **Contoso.com**, and then select the **Research** OU. 

   > Notice that the icons on the toolbar to create users, groups, or OUs are dimmed.

5. Select the **London** OU. 

   > Notice that the icons on the toolbar to create users, groups, or OUs are available now.

6. Right-click or access the context menu for the **London** OU, select **New**, and then select **Organizational Unit**. 

7. In the **New Object – Organizational Unit** dialog box, type **Laptops** in the **Name** field, and then select **OK**. The creation will succeed. 

8. Sign out of **LON-SVR1**.


#### Test permissions for London Helpdesk

1. Sign in to **LON-SVR1** as **Tonnie** with the password **Pa55w.rd**.

2. Select **Start**, and then select the **Server Manager** tile.

3. Select **Tools**, and then select **Active Directory Users and Computers**.

4. Expand **Contoso.com**, and then select the **London** OU. 

   > Notice that the only available icon is the **create user** icon.

5. Sign out of **LON-SVR1**.


**Results:** After completing this exercise, you'll have created a new OU for the branch office, created and added members to groups for branch administrators and help-desk personnel, delegated permission to the groups, and installed AD DS tools and tested permissions.

## Exercise 2: Create and modify AD DS objects with Windows PowerShell

### Scenario

You have a .csv file that contains a large list of new users for the branch office. It's inefficient to create these users individually with graphical tools, so you'll use a Windows PowerShell script instead. A colleague who has experience with scripting has given you a script that they created. You need to sign in as branch administrator and modify the script to match the format of your .csv file.

The main tasks for this exercise are as follows:

1. Create a user account by using Windows PowerShell.

2. Create a new group by using Windows PowerShell.

3. Add a member to the group by using Windows PowerShell.

4. Modify the .csv file.

5. Modify the script.

6. Run the script.


### Task 1: Create a user account by using Windows PowerShell

1. Switch to **LON-DC1**.

2. Right-click or access the context menu for the **Start** button, and then select **Windows PowerShell (Admin)**.

3. Create a user account for **Ty Carlson** in the London OU by running the following command:

   ```
   New‑ADUser ‑Name Ty ‑DisplayName "Ty Carlson" ‑GivenName Ty ‑Surname Carlson ‑Path "ou=London,dc=Contoso,dc=com"
   ```

4. Set the password for the account by running the following command:

   ```
   Set-ADAccountPassword Ty
   ```

5. When you receive a prompt for the current password, select Enter.

6. When you receive a prompt for the desired password, type **Pa55w.rd**, and then select Enter.

7. When you receive a prompt to repeat the password, type **Pa55w.rd**, and then select Enter.

8. To enable the account, run the following command:

   ```
   Enable-ADAccount Ty
   ```

9. Test the account by switching to **LON-CL1**, and then sign in as **Ty** with the password **Pa55w.rd**.

10. Sign out of **LON-CL1**.

### Task 2: Create a new group by using Windows PowerShell

1. On **LON-DC1**, in the **Administrator: Windows PowerShell** window, run the following command:

   ```
   New‑ADGroup LondonBranchUsers ‑Path "ou=London,dc=Contoso,dc=com" ‑GroupScope Global ‑GroupCategory Security
   ```

### Task 3: Add a member to the group by using Windows PowerShell

1. In the **Administrator: Windows PowerShell** window, run the following command:

   ```
   Add‑ADGroupMember LondonBranchUsers ‑Members Ty
   ```

2. Confirm that the user is in the group by running the following command:

   ```
   Get‑ADGroupMember LondonBranchUsers
   ```

### Task 4: Modify the .csv file

1. On the taskbar, select the **File** **Explorer** icon.

2. In File Explorer, expand **Allfiles** **(E:)**, expand **Labfiles**, and then select **Mod02**.

3. Right-click or access the context menu for **LabUsers.ps1**, and then select **Edit**. 

4. In **Administrator: Windows PowerShell (ISE)**, read the comments at the top of the script, and then identify the requirements for the header in the .csv file.

5. In File Explorer, open **LabUsers.csv** with Notepad.

6. In **Notepad**, type the following line at the top of the file: 

   ```
   FirstName,LastName,Department,DefaultPassword
   ```

7. Select **File**, and then select **Save**.

8. Close **Notepad**.


### Task 5: Modify the script

1. In the **Administrator: Windows PowerShell (ISE)** window, under **Variables**, replace **C:\\path\\file.csv** with **E:\\Labfiles\\Mod02\\LabUsers.csv**.

2. Under **Variables**, replace "**ou=orgunit,dc=domain,dc=com"** with "**ou=London,dc=Contoso,dc=com**".

3. Select **File**, and then select **Save**. Scroll down, and then review the script's contents.

4. Close the **Administrator: Windows PowerShell (ISE)** window.


### Task 6: Run the script

1. Switch to the **Administrator: Windows PowerShell** window.

2. At the prompt, type **cd** **E:\\Labfiles\\Mod02**, and then select Enter.

3. Type **.\\LabUsers.ps1**, and then select Enter.

4. To view the users just created, type the following command, and then select Enter:

   ```
   Get‑ADUser ‑Filter * ‑SearchBase "ou=London,dc=Contoso,dc=com"
   ```

**Results**: After completing this exercise, you should have successfully created a user and group, and modified a group by using Windows PowerShell. You also used PowerShell and a .csv file to perform bulk administration. 
