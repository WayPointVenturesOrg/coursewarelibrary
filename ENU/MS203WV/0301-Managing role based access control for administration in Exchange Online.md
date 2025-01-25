# Lab: Managing role-based access control for administration in Exchange Online

## Lab scenario

You need to review and validate role-based access control (RBAC) for the Exchange Online environment. To simplify user management for admin roles, you decide to configure a security group to support RBAC. You also plan to create a custom role group and configure a write scope to ensure that members of the role group can only modify users that have the Research department attribute configured. Finally, you will review and configure Role Assignment policies to control user access to changing personal or contact information.

>**Note:** This lab requires students to have completed the **Module 1 lab: Exploring Microsoft 365 and Exchange Online administration portals**, and **Module 2 Lab A:Creating and managing Exchange Online recipients**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234
## Exercise 1: Reviewing and assigning Admin Roles in Microsoft 365

### Scenario

To effectively plan for delegation of administration tasks in Microsoft Exchange, you need to review the built-in admin roles in Microsoft 365. You also plan to simplify role management by incorporating security groups with Exchange admin roles.

The main tasks for this exercise are as follows:

1. Review Admin Roles in Microsoft 365. 
2. Configure Security Groups for RBAC.
3. Validate access to the Exchange admin center.

### Task 1: Review Admin Roles in Microsoft 365

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

6.  Complete and close any notification prompts that might display.

7.  In the navigation menu, select **Show all**.

>**Note:** All options now display in the navigation menu.

8.  In the navigation menu, expand **Roles**, and then select **Role assignments**.

9.  On the **Role assignments** page, select **Microsoft Entra ID**.

10.  Scroll to review the various roles related to Microsoft Entra ID. At the end of the list, select **Show all roles**.

>**Note:** Each role provides permissions to perform specific tasks. For example, **Global Administrator** has unlimited access to all management features in Microsoft 365. The **Password Administrator** role is limited to only resetting passwords for non-admin users and some admin roles.

11.  On the **Role assignments** page, select **Exchange**.

12.  Scroll to review the Role groups related to Exchange.

>**Note:** Each role group contains a combination of Exchange roles that permit members to perform specific administrative tasks within Exchange. Also note that these role groups are used for permission for many other features within the Microsoft Purview compliance center and Microsoft Defender.

13.  On the **Role assignments** page, select **Billing**.

>**Note:** Billing account roles are used to assign permission for viewing, editing, and signing agreements with Microsoft.

### Task 2: Configure Security Groups for RBAC

1.  In the Microsoft 365 admin center, on the navigation menu, expand **Groups**, and then select **Active Groups**.

2.  On the **Active groups** page, select **Security groups**.

3.  On the **Security groups** tab, select **Add a security group**.

4.  On the **Set up the basics** page, in the **Name** field, enter **`Exchange Admins`**.

5.  In the **Description** field, enter **`Exchange Admins for Contoso`**, and then select **Next**.

6.  On the **Edit settings** page, select the checkbox for **Azure AD roles can be assigned to the group**, and then select **Next**.

>**Note:** This feature requires the Microsoft Entra ID P2 license. Once this setting is configured, role assignment is enabled for the group and cannot be disabled.

7.  On the **Review and finish adding group** page, select **Create group**, and then select **Close**.

8.  On the **Security groups** tab, select **Exchange Admins**.

>**Note:** The Exchange Admins details pane opens with the **General** tab selected. Notice that Role assignments are allowed.

9.  On the **General** tab, select **Add group owners**.

10.  On the **Owners** page, select **Add owners**, select your administrative username, and then select **Add**.

11.  At the top-left corner of the panel, select the back arrow icon.

12.  In the **Exchange Admins** details pane, select **Members**.

13.  On the **Members** tab, select **View all and manage members**.

14.  On the **Members** page, select **Add members**.

15.  On the **Add members** page, select **Alex Wilber**, and then select **Add**.

16.  At the top-left corner of the panel, select the back arrow.

17.  In the **Exchange Admins** details pane, select **General**.

18.  On the **General** tab, select **Manage roles**.

19.  Select the **Admin center access** option button.

>**Note:** When you hover over the information icon next to each role, a message displays, providing basic information on what the role permits.

20.  Under the **Admin center access** section, select **Exchange Administrator**, and then select **Save changes**.

21.  Close the **Manage admin roles** page.

>**Note:** Now that the **Exchange Admins** security group is assigned the **Exchange Administrator** role, any member of the security group will acquire permissions to manage the Exchange Online environment.

22.  Close Microsoft Edge.

### Task 3: Validate access to the Exchange admin center

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

3.  Sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

5.  Complete and close any notification prompts that might display.

6.  In the navigation menu, select **Show all**.

>**Note:** Notice that in the **Admin centers** section, only the **Identity** and **Exchange admin center** Admin centers display.

7.  In **Admin centers**, select **Exchange**.

8.  Browse through the various menu options for the Exchange admin center.

>**Note:** Alex is a member of the Exchange Administrators security group and therefore has full administrative access to Exchange.

9.  Close Microsoft Edge.

**Results:** After completing this exercise, you'll have reviewed Admin roles and configured and assigned an admin role to a security group.

## Exercise 2: Creating and managing role groups in Exchange Online

### Scenario

You need to review the role groups that are available specifically in Exchange Online. You then plan to create a custom role group for the Research department. Members of this custom role group will only be able to manage Exchange recipients that contain the Research department attribute.

The main tasks for this exercise are as follows:

1. Review role groups in Exchange Online.
2. Create a custom write scope.
3. Create a custom role group.
4. Validate Role group permissions.

### Task 1: Review role groups in Exchange Online

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Exchange admin center opens.

5.  Complete and close any notification prompts that might display.

6.  In the Exchange navigation pane, expand **Roles**, and then select **Admin roles**.

7.  Scroll to review the Role groups related to Exchange.

>**Note:** These are the same role groups that you reviewed in the Microsoft 365 admin center.

8.  On the **Admin roles** page, select **Organization Management**.

9.  On the **Organization Management** page, select the **Assigned** tab.

>**Note:** Notice that **Global Administrator** is assigned by default. You might also have other assigned users or groups as per previous lab tasks.

10.  On the **Organization Management** page, select the **Permissions** tab, and then review the various roles.

>**Note:** Only Roles that have been selected are part of the Organization Management role group.

11.  Close the **Organization Management** page.

12.  On the **Admin roles** page, select **Help Desk**.

13.  On the **Help Desk** page, select the **Assigned** tab.

>**Note:** Notice that no members are assigned by default.

14.  On the **Help Desk** page, select the **Permissions** tab, and then review the various roles.

>**Note:** By default, only the **Reset Password**, **User Options**, and **View-Only Recipients** roles are assigned to the Help Desk role group.

15.  Close the **Help Desk** page.

### Task 2: Create a custom write scope

1.  On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2.  In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3.  At the **User Account Control**, select **Yes**.

4.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-ExchangeOnline`

5.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

6.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `New-ManagementScope -Name "Research" -RecipientRestrictionFilter {Department -like "Research"}`

>**Note:** The **New-ManagementScope** cmdlet creates a scope based upon the department attribute.

7.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Get-ManagementScope `

>**Note:** The **Get-ManagementScope** cmdlet lists all of the existing management scopes.

### Task 3: Create a custom role group

1.  In the Exchange admin center, expand **Roles**, and then select **Admin roles**.

2.  On the **Admin roles** page, select **Add role group**.

>**Note:** If **Add role group** is not visible, be sure to deselect any Role groups that might be selected.

3.  On the **Set up the basics** page, under **Name**, change the text to **`Research Help Desk`**.

4.  In the **Description** text box, change the text to **`Role group for the Research Help Desk`**.

5.  Under **Write scope,** select the drop-down menu, and then select **Research**.

>**Note:** **Research** is the write scope that you created in the previous task.

6.  On the **Set up the basics** page, select **Next**.

7.  On the **Add permissions** page, scroll to, and select the **Mail Recipients** checkbox.

>**Note:** Review the description for details on what the **Mail Recipients** role enables.

8.  On the **Add permissions** page, select **Next**.

9.  On the **Assign admins** page, select the **Members** field, select **Lee Gu**, and then select **Next**.

10.  On the **Review role group and finish** page, select **Add role group**, and then select **Done**.

11.  On the **Admin roles** page, scroll to and select **Research Help Desk**.

>**Note:** The details display for the **Research Help Desk** role group.

12.  Close Microsoft Edge.

### Task 4: Validate Role group permissions

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

5.  In the Exchange admin center, expand **Recipients**, and then select **Mailboxes**.

6.  On the **Manage mailboxes** page, select **Adele Vance**.

7.  On the **Adele Vance** page, select the **Organization** tab, and then select **Manage Organization Information**.

8.  On the **Edit organization** page, in the **Company** field, enter **`Contoso`**, and then select **Save**.

>**Note:** Notice that the operation fails. This is because Adele Vance is a member of the Sales group and is outside the management scope for Lee.

9.  Close the **Edit organization** page.

10.  On the **Manage mailboxes** page, select **Megan Bowen**.

11.  On the **Megan Bowen** page, select the **Organization** tab, and then select **Manage Organization Information**.

12.  On the **Edit organization** page, in the **Company** field, enter **`Contoso`**, and then select **Save**.

>**Note:** Notice that the operation is successful. This is because Megan Bowen is a member of the Research group and is in management scope for Lee.

13.  Close the **Edit organization** page.

14.  Close Microsoft Edge.

**Results**: After completing this exercise, you should have reviewed the built-in Exchange role groups, and created a custom role group that's scoped to a specific department.

## Exercise 3: Managing user roles with role assignment policies

### Scenario

You need to ensure that Lee Gu and Megan Bowen are restricted from modifying personal information in Exchange Online. You will perform this task by creating a custom Role Assignment Policy, and then assigning the policy to users.

The main tasks for this exercise are as follows:

1. Review the Default Role Assignment Policy.
2. Create a custom Role Assignment Policy.
3. Assign a Role Assignment Policy to users.
4. Validate Role Assignment Policy.


### Task 1: Review the Default Role Assignment Policy

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Exchange admin center opens.

5.  Complete and close any notification prompts that might display.

6.  In the Exchange navigation pane, expand **Roles**, and then select **User roles**.

7.  On the **User roles** page, select **Default Role Assignment Policy**.

8.  On the **Default Role Assignment Policy** page, select **Manage general settings**.

>**Note:** General settings include the **Name** and **Description** of the policy.

9.  At the top-left corner of the **Default Role Assignment Policy**, select the back arrow.

10.  On the **Default Role Assignment Policy** page, select **Manage permissions**.

11.  Review the end-user permissions that can be enabled or disabled for users.

>**Note:** The **Default Role Assignment Policy** enables users to have full control of their own Exchange mailboxes and any distribution groups that they own. This policy is automatically assigned to all users when their mailbox is created.

12.  Close the **Default Role Assignment Policy** page.

### Task 2: Create a custom Role Assignment Policy

1.  In the Exchange admin center, on the **User roles** page, select **New role assignment policy**.

2.  On the **Set up the basics** page, under **Name**, enter `Contoso Role Assignment Policy`.

3.  In the **Description** field, enter **`Role assignment policy only permitting Distribution Groups, Base Options, and Retention Policy self-management for users.`**, and then select **Next**.

4.  On the **Add permissions** page, select the checkboxes for the following permissions, and then select **Next**:

   - **MyDistributionGroups**
   - **MyDistributionGroupMembership**
   - **MyBaseOptions**
   - **MyRetentionPolicies**

>**Note:** Hover over the information icons for additional information about each permission.

5.  On the **Review** page, select **Create**.

6.  On the **Status** page, select **Done**. 

>**Note:** Verify that the Contoso Role Assignment Policy is listed in the **User roles** list.

### Task 3: Assign a Role Assignment Policy to users

1.  In the Exchange admin center, expand **Recipients**, and then select **Mailboxes**.

2.  On the **Manage mailboxes** page, select the checkboxes for **Lee Gu** and **Megan Bowen**.

>**Note:** Ensure that both **Lee Gu** and **Megan Bowen** are selected and have checkmarks next to their name.

3.  On the menu bar, select **Mailbox policies**.

4.  On the **Mailbox policies** page, under **Role assignment policy**, select the down arrow.

5.  From the drop-down list, select **Contoso Role Assignment Policy**, and then select **Save**.

6.  Close the panel, and then close Microsoft Edge.

### Task 4: Validate Role Assignment Policy

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`Joni@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The My account control panel opens. However, it might take a minute or two to display.

5.  On the **account** page, select **Manage information**.

6.  On the account information for Joni Sherman, select **Contact numbers** and then select **Manage contact numbers**.

7.  In the **Home phone** field, enter **`555-555-5555`**, and then select **Save**.

>**Note:** Joni is able to modify contact information because the **Default Role Assignment Policy** is assigned to the account.

8.  Close Microsoft Edge.

9.  From the taskbar, select **Microsoft Edge**.

10.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

11.  Sign in as **`Megan@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

12.  At the **Stay signed in** prompt, select **No**.

>**Note:** The My account control panel opens. However, it might take a minute or two to display.

13.  On the **account** page, select **Manage information**.

14.  On the account information for Megan Bowen, select **Contact numbers** and then select **Manage contact numbers**.

>**Note:** Megan is NOT able to modify contact information because the **Contoso Role Assignment Policy** is assigned to the account, which restricts the ability to modify personal information.

15.  Close Microsoft Edge.

**Results**: After completing this exercise, you'll have created and assigned a custom Role Assignment Policy.