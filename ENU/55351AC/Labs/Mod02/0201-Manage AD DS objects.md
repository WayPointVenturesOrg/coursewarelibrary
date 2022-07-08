# Lab: Manage AD DS objects

## Lab scenario

You are a server support specialist for Contoso Corporation. You've been assigned to help configure the infrastructure for a new branch office for the Research department. To begin the new branch office's deployment, you're preparing Active Directory Domain Services (AD DS) objects. 

You need to create users and groups for the new Research department branch office and test the ability to reset the secure channel for a branch-office computer account that's lost connectivity to the Contoso.com domain.

## Exercise 1: Create and manage groups in AD DS

### Scenario

You need to create groups for the Research department, and you require a distribution global group to facilitate email delivery to Research users. Carlos Tijerina will manage this group. You will also create a Research Managers group and add Carlos Tijerina and Susan Kemp as members of the group. You also need to create a universal group in the Managers organizational unit (OU) that will contain all the departmental managers’ global groups. After creating the research distribution group, you realize that the group needs access to network resources, so you must convert the group to a security group.

The main tasks for this exercise are as follows:

1. Create groups and add members.

2. Configure group nesting.

3. Convert a group type from **Distribution** to **Security**.


### Task 1: Create groups and add members

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager starts automatically.

2. In **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**. Maximize the **Active Directory Administrative Center** window.

3. Select **Contoso (local)**, and then select **Managers**.

4. In the **Tasks** pane, under **Managers**, select **New**, and then select **Group**.

5. In the **Group name:** field, enter **Enterprise Managers**.

6. Under **Group scope**, select **Universal**.

7. Select **OK** to close the **Create Group: Enterprise Managers** window.

8. Select **Contoso (local)**, and then select the **Research** OU.

9. In the **Tasks** pane, under **Research**, select **New**, and then select **Group**.

10. In the **Group name:** field, enter **Research Mail**.

11. In the **Group type** section, select **Distribution**.

12. In the **E-mail** field, enter **`Research@Contoso.com`**.

13. In the **Managed By** section, select **Edit**.

14. In the **Select User, Contact, or Group** dialog box, in **Enter the object nams to select (examples)**, enter **Carlos**, select **Check Names**, and then select **OK**.

15. Select the **Manager can update membership list** check box.

16. Select **OK** to close the **Create Group: Research Mail** window.

17. In the **Tasks** pane, under **Research**, select **New**, and then select **Group**.

18. In the **Group name:** field, enter **Research Managers**.

19. Scroll to the **Members** section, and then select **Add**.

20. In the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box, in **Enter the object names to select (examples)**, enter **Carlos; Susan**, select **Check Names**, and then select **OK**.

21. Select **OK** to close the **Create Group: Research Managers** window.


### Task 2: Configure group nesting

1. Select **Contoso(Local)**, and then open the **Managers** OU.

2. Right-click or access the context menu for the **Enterprise Managers** group, and then select **Properties**.

3. In the navigation pane, select **Members**, and then select **Add**.

4. In the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box, in **Enter the object names to select (examples)**, enter **Managers; Research Managers**, select **Check Names**, and then select **OK**.

5. Select **OK** to close the **Enterprise Managers** window.


### Task 3: Convert a group type from Distribution to Security

1. In the navigation pane, select **Research**.

2. Open the **Research Mail** group.

3. Under **Group type**, select **Security**, and then select **OK**.

**Results:** After completing this exercise, you'll have created groups and added members, configured group nesting, and converted a group type.

## Exercise 2: Create and configure user accounts in AD DS

### Scenario

You have a list of new users that you must create for the branch office, and ou're going to create a template to facilitate quick creation of branch users. You'll validate that template by creating a new test user and checking the properties.

The main tasks for this exercise are as follows:

1. Create and configure a user template for the Research department.

2. Create new users for the Research branch office based on the template.

3. Validate the template.


### Task 1: Create and configure a user template for the Research department

1. In the **Active Directory Administrative Center**, select the **Research** OU. 

2. In the **Tasks** pane, under **Research**, select **New**, and then select **User**.

3. In the **Create User** window, in the **First name** field, enter **_Research Template**.

4. In the **User UPN logon** field, enter **ResearchTemplate**.

5. In the **Password** and **Confirm password** fields, enter **Pa55w.rd**.

6. In the navigation pane, select **Organization**, and then in the **Department** field, enter **Research**.

7. In the **Company** field, enter **Contoso**.

8. In the **Manage**r field, select **Edit**. 

9. In the **Select User or Contact** dialog box, in **Enter the object name to select (examples)**, enter **Carlos**, select **Check Names**, and then select **OK**.

10. In the navigation pane, select **Member Of** and then select **Add**.

12. In the **Select Groups** dialog box, in **Enter the object names to select (examples)**, enter **Research**, and then select **Check Names**. In the **Multiple Names Found** dialog box, select **Research**, and then select **OK** twice.

13. In the navigation pane, select **Profile**.

14. In the **Log on script** field, enter **\\\\LON-DC1\\Netlogon\\Logon.bat**, and then select **OK**.

15. Select the **_Research Template** account, and then in the **Tasks** pane, under **_Research Template**, select **Disable**.

16. Close **Active Directory Administrative Center**.


### Task 2: Create new users for the Research branch office based on the template

1. In **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

2. Expand **Contoso.com**, and then select the **Research** OU.

3. Right-click or access the context menu for the **_Research Template** account, and then select **Copy**.

4. In the **Copy Object – User** dialog box, enter **Research** in the **First name** field, and then enter **User** in the **Last name** field.

5. In the **User logon name** field, enter **ResearchUser**, and then select **Next**.

6. In the **Password** and **Confirm password** fields, enter **Pa55w.rd**.

7. Clear the **Account is disabled** check box, and then select **Next**.

8. Select **Finish**.


### Task 3: Validate the template

1. Open **Research User**.

2. Select the **Profile** tab, and then ensure that the Logon script path is **\\\\LON-DC1\\Netlogon\\Logon.bat**.

3. Select the **Organization** tab, and then ensure that the **Department** is **Research**, the **Company** is **Contoso**, and the **Manager** is **Carlos Tijerina**.

4. Select the **Member Of** tab, and then ensure that the user is a member of the **Research** group.

5. Select **Cancel** to close the **Research** **User** **Properties** dialog box.

**Results**: After completing this exercise, you'll have created and configured a user template, created a user based upon the template, and verified attributes copied from the template. 

## Exercise 3: Manage computer objects in AD DS

### Scenario

A user is unable to sign in, and a workstation has lost its connectivity to the domain and can't authenticate users properly. When users attempt to access resources from this workstation, access is denied. You need to repair the trust relationship between the computer and the domain.

The main tasks for this exercise are as follows:

1. Reset a computer account.

2. Observe the behavior when a client attempts to sign in.

3. Resolve the computer issue.


### Task 1: Reset a computer account

1. In Active Directory Users and Computers, select the **Computers** container.

2. In the details pane, right-click or access the context menu for the **LON-CL1** computer account, and then select **Reset Account**.

3. In the **Active Directory Domain Services** dialog box, select **Yes**.

4. In the **Active Directory Domain Services** message box, select **OK**.


### Task 2: Observe the behavior when a client attempts to sign in

1. Switch to **LON-CL1**.
1. Attempt to sign in as **Contoso\\Oscar** with the password **Pa55w.rd**. 


> **Question**: What is the message that displays?
>
> **Answer**: The trust relationship between this workstation and the primary domain failed.

### Task 3: Resolve the computer issue

1. Sign in to **LON-CL1** as **Contoso\\Administrator** with the password **Pa55w.rd**.

   > The Administrator account is able to sign in due to cached credentials.

2. Right-click or access the context menu for the **Start** button, and then select **Run**.

3. Enter **PowerShell**, and then select Enter.

4. In the **Administrator: Windows PowerShell** window, enter the following cmdlet, and then select Enter:

   ```
   Test-ComputerSecureChannel –Repair
   ```

5. Close the **Windows PowerShell** window, and then sign out.

6. Sign in as **Contoso\\Oscar** with the password **Pa55w.rd**. The sign in will now succeed.

7. Sign out of **LON-CL1**.

   > Keep the lab environment running for the next lab.

**Results**: After completing this exercise, you'll have reset a computer account, and resolved computer account issues.
