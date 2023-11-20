# Lab: Managing roles and permissions in Microsoft 365

## Lab scenario

You plan to delegate administrative tasks by using Microsoft 365 roles and role assignments. You need to review the types of roles available and perform the task of managing role assignments. You also have been asked to implement administrative units to help scope delegated administration. Finally, you'll review Microsoft 365 Defender and Microsoft Purview to help enhance security and compliance for your Microsoft 365 tenant.

>**NOTE:** This lab requires students to first complete the following:
>
>- Module 1 lab: **Provisioning and configuring a Microsoft 365 tenant** 
>- Module 2 lab: **Managing user, resource, and group objects in Microsoft 365**
>
>To assist with your sign-in process, enter your Microsoft 365 sign-in username and password as follows:
>
>- **Microsoft 365 Username:**    __________________________________________________________________
>
>- **Password:** **`Pa55w.rd1234`**

## Exercise 1: Configuring roles and role assignments 

### Scenario

You need to delegate the task of resetting passwords. You decide to create a new security group named **Help Desk Admins**, and assign an administrative role to the group. You need to compare the **Helpdesk Administrator**, **Service Support Administrator**, and **User Administrator** roles to determine which role would be the most appropriate and use the principle of least privilege.

The main task for this exercise is as follows:

1. Review roles and permissions by using the Microsoft 365 admin center.
2. Validate permissions by using **Run As**.
3. Create a new user and group for role delegation.
4. Manage role assignments.

### Task 1: Review roles and permissions by using the Microsoft 365 admin center

1. Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2. From the taskbar, select **Microsoft Edge**.

3. In the address bar, enter the following URL and then select Enter: **`https://admin.microsoft.com`**.

4. Sign in as **`Username@mmddyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

   > **Note:** Use the credentials that you provided at the start of this lab.

5. At the **Stay signed in** prompt, select **No**.

   > **Note:** The Microsoft 365 admin center opens.

6. Complete and close any notification prompts that might be displayed.

7. In the navigation menu, select **Show all**.

   > **Note:** All options are now displayed on the navigation menu.

8. In the navigation menu, expand **Roles**, and then select **Role assignments**.

9. Review the roles available on each of the tabs on the **Role assignments** page. 

   > **Note:** There are roles that relate to **Microsoft Entra ID**, **Exchange**, **Intune**, and **Billing**.

10. On the **Microsoft Entra ID** tab, scroll towards the end and select **Show all roles**.

    > **Note:** Additional roles are displayed. These roles permit administrative delegation to both Microsoft 365 and Microsoft Entra ID services. 

11. At the end of the list, select **Show suggested roles** to display a smaller number of suggested roles.

12. On the **Role assignments** page, with the **Microsoft Entra ID** tab selected, select the check box next to **Helpdesk Administrator**.

13. In the list of Microsoft Entra ID roles, select the check box next to **Service Support Administrator**.

14. In the list of Microsoft Entra ID roles, select the check box next to **User Administrator**.

    > **Note:** You should have all three of the **Helpdesk Administrator**, **Service Support Administrator** and **User Administrator** roles selected.

15. On the **Role assignments** page, select **Compare roles**.

16. Scroll down the list to compare permissions provided by the three roles.

    > **Note:** The Helpdesk Administrator role has permission to reset passwords. User Administrator can also reset passwords, but also provides permission to perform other tasks such as adding and deleting users. Service Support Administrator does not provide the ability to reset passwords.

### Task 2: Validate permissions by using Run As

1. In the navigation menu, expand **Roles**, and then select **Role assignments**.

2. On the **Role assignments** page, select **Helpdesk Administrator** to open the properties for the role.

3. On the **Helpdesk Administrator** properties page, select **Run As**.

   > **Note:** A new page opens in Microsoft Edge. Notice that a notification banner displays, stating that you are running as a Helpdesk Administrator.

4. In the navigation menu, expand **Users**, and then select **Active users**.

   > **Note:** There are no options for adding a user or creating a user template. There is an option to reset password.

5. On the **Active users** page, select any user.

   > **Note:** You can review most options, but cannot change them. Options that can be changed include signing out the user and managing licenses.

6. Close the **Helpdesk Administrator** page in Microsoft Edge and return to the main Microsoft 365 admin center page.

### Task 3: Create a new user and group for role delegation

1. In the Microsoft 365 admin center, expand **Users**, and then select **Active users**.

2. On the **Active users** page, select **Add a user**.

   > **Note:** The **Add a user** page opens.

3. On the **Set up the basics** page, enter the following details, and then select **Next**:

   - **First name:** `User`
   - **Last name:** `5`
   - **Display name:** `User 5`
   - **Username:** `User5`@mmddyyyourinitialsContoso.onmicrosoft.com
   - **Automatically create a password:** Not selected
   - **Password:** `Pa55w.rd1234`
   - **Require this user to change their password when they first sign in:** Not selected
   - **Send password in email upon completion:** Not selected

4. On the **Assign product licenses** page, enter the following details, and then select **Next**:

   - **Select location:** Select the same location that you used when you signed up for the Microsoft 365 tenant.
   - **Assign user a product license:** Select check boxes next to **Enterprise Mobility + Security E5** and **Office 365 E5**

5. On the **Optional settings** page, expand the **Profile info** section.

6. In the **Department** field, enter **`Help Desk`**, and then select **Next**.

7. On the **Review and finish** page, review your settings, select **Finish adding**, and then select **Close** on the confirmation page.

   > **Note:** **User 5** should now display in the **Active users** list.

8. In the navigation menu, expand **Teams & groups**, and then select **Active teams & groups**.

9. On the **Active teams & groups** page, select **Security groups**.

10. On the **Security groups** tab, select **Add a security group**.

11. On the **Set up the basics** page, under **Name**, enter **`Help Desk Admins`**, and then select **Next**.

12. On the **Edit settings** page, select the check box next to **Azure AD roles can be assigned to the group**, and then select **Next**.

    > **Note:** If you do not select this option, you would not be able to review and select this group when adding the group to a specific role assignment.

13. On the **Review and finish adding group** page, review your settings, select **Create group**, and then select **Close** on the confirmation page.

    > **Note:** Verify that the **Help Desk Admins** security group is listed on the **Security groups** tab. You may need to refresh the page.

14. Select **Help Desk Admins** to open the properties page for the group.
15. On the **Help Desk Admins** page, select the **Members** tab.
16. On the **Members** tab, select **View all and manage members**.
17. On the **Members** page, select **Add members**.
18. In the **Add members** list, select **User 5**, and then select **Add**.
19. Close the **Members** page.

### Task 4: Manage role assignments

1. In the navigation menu, expand **Roles**, and then select **Role assignments**.

2. On the **Role assignments** page, select **Helpdesk Administrator** to open the properties for the role.

3. On the **Helpdesk Administrator** properties page, select the **General** tab.

   > **Note:** Review the information on who should be assigned this role.

4. On the **Helpdesk Administrator** properties page, select the **Permissions** tab.

   > **Note:** Review the permissions associated with this role. 

5. On the **Helpdesk Administrator** properties page, select the **Assigned** tab.

   > **Note:** You can add individual users or groups to this role assignment. 

6. On the **Assigned** tab, select **Add groups**.

   > **Note:** The **Help Desk Admins** group is displayed. 

7. On the **Add groups** page, select the check box next to **Help Desk Admins**, and then select **Add**.

8. On the **Helpdesk Administrator** properties page, select the refresh button.

   > **Note:** The Help Desk Admins group displays as an assigned member of the Helpdesk Administrator role.

**Results:** After completing this exercise, you'll have compared the **Helpdesk Administrator**, **Service Support Administrator** and **User Administrator** roles to determine which role would use the principle of least privilege. You'll then have assigned the Help Desk Admins security group to the Helpdesk Administrator role.

## Exercise 2: Configuring administrative units

### Scenario

The Sales department has requested that User 1 be able to reset passwords for the only members of the Sales team. You decide to create an administrative unit and add the Sales security group as members. User1 will be assigned the Password Administrator role for the unit.

The main tasks for this exercise are as follows:

1. Add an administrative unit.
2. Validate permissions.


### Task 1: Add an administrative unit

1. In the Microsoft 365 admin center, on the navigation menu, expand **Roles**, and then select **Administrative units**.

2. On the **Administrative units** page, select **Add unit.**

   > **Note:** The **Add administrative unit** dialog box opens.

3. On the **Basics** page, under **Name**, enter **`Sales - Password Admin`**.

4. Enter a description, and then select **Next**.

5. On the **Add members** page, select the **Add up to 20 users and groups** option.

6. On the **Add members** page, select **Add groups**.

7. In the **Add groups** page, select the **Sales** group, and then select **Add**.

8. On the **Add members** page, select **Next**.

9. On the **Assign admins to scoped roles** page, select **Password Administrator**.

10. On the **Assign admins to scoped roles** page, select **Assign admins**.

11. On the **Password Administrator** properties page, select the **General** tab.

    > **Note:** Review the information on who should be assigned this role.

12. On the **Password Administrator** properties page, select the **Permissions** tab.

    > **Note:** Review the permissions associated with this role. 

13. On the **Password Administrator** properties page, select the **Assigned** tab.

14. On the **Assigned** tab, select **Add users**.

15. On the **Add admin assignments** page, select the check box next to **User 1**, select **Add**, and then select **Close**.

16. On the **Assign admins to scoped roles** page, select **Next**.

17. On the **Review and finish** page, review your settings, and then select **Add**.

18. On the confirmation page, select **Done**.

    > **Note:** User 1 will now only be able to reset passwords for members of the Sales team security group.

### Task 2: Validate permissions

1. In the navigation menu, expand **Roles**, and then select **Role assignments**.

2. On the **Role assignments** page, select **Show all roles**, and then select **Password Administrator** to open the properties for the role.

3. On the **Helpdesk Administrator** properties page, select the **Assigned** tab.

4. On the **Assigned** tab, verify that **User 1** is listed.

   > **Note:** Review the **Scope** column. This column shows that User 1's role is only scoped to the **Sales - Password Admin** Administrative unit.

**Results**: After completing this exercise, you should have created an Administrative unit and validated that User 1 is assigned the Password Administrator role and is only scoped to the unit.

## Exercise 3: Reviewing Microsoft Secure Score and Information Governance

### Scenario

You need to review security and compliance features for your Microsoft 365 tenant. For this exercise, you will review your Microsoft Secure Score and determine recommended actions to take to increase your score. You will also review Microsoft Purview compliance features to assist with data loss prevention and data lifecycle management.

The main tasks for this exercise are as follows:

1. Review Microsoft Secure Score.
2. Review Microsoft Purview Compliance.
3. Configure Data Lifecycle management using Microsoft Purview.


### Task 1: Review Microsoft Secure Score

   > **Note:** It may take some time for Microsoft to calculate your Secure Score. If no data displays for your Secure Score, complete this task at a later time in the course.

1. In the **Microsoft 365 admin center**, on the navigation menu, if necessary, select **Show all**.

2. Under the **Admin centers** section, select **Security**.

   > **Note:** A new web browser page opens and the **Microsoft 365 Defender** portal opens.

3. Complete and close any notification prompts that might be displayed.

4. On the Navigation pane, select **Secure score**.

   > **Note:** Review the information on the **Overview** page. Your secure score may vary.

5. On the **Microsoft Secure Score** page, select the **Recommended actions** tab.

   > **Note:** Review all of the recommended actions and the impact of addressing each action will make on your current secure score.

6. Select the text for the first recommended action.

   > **Note:** The Action plan and details page opens for the recommended action. Notice that the status is currently listed as **To address**.

7. On the action plan page, select **Edit status and action plan**.

8. On the **Status & action plan** page, select **Planned**.

9. In the **Action plan** text box, enter **Implement Next Monday**, and then select **Save and close**.

   > **Note:** Verify that the status at the beginning of the Action plan page displayed **Planned**.

10. At the top right-hand corner, select **Next item**.

11. For the next recommended action, select **Edit status and action plan**.

12. On the **Status & action plan** page, select **Planned**.

13. In the **Action plan** text box, enter **Implement Next Friday**, and then select **Save and close**.

    > **Note:** Verify that the status at the top of the Action plan page displayed **Planned**.

14. Close the action plan page.

15. Refresh the **Microsoft Secure Score** page, and then select the **Recommended actions** tab.

    > **Note:** Verify that the first two recommended actions both have a status of **Planned**. All other recommended actions have a status of **To address**.

16. On the **Microsoft Secure Score** page, select the **Overview** tab.

17. On the **Overview** page, next to **Your secure score**, select the **Include** filter.

18. Select the check box next to **Planned score**.

19. On the **Overview** page, review the Secure Score graph. 

20. Place your cursor on the last dotted line of the graph. Take note of what your secure score will be when you have addressed the planned actions.

    > **Note:** Your secure score should increase from approximately 17% to 47%. These numbers may vary based upon what is detected for your secure score and what the first two recommended actions are that you changed to **Planned**.

21. Close the **Microsoft 365 Defender** portal tab. 

    > **Note:** Leave Microsoft Edge open with the **Microsoft 365 admin center** page open.

### Task 2: Review Microsoft Purview Compliance

1. In the **Microsoft 365 admin center** navigation menu, in the **Admin centers** section, select **Compliance**.

   > **Note:** A new web browser page opens and the **Microsoft Purview compliance portal** opens.

2. Complete and close any notification prompts that might be displayed.

3. On the navigation pane, under **Solutions**, expand **Data loss prevention**, and then select **Policies**.

   > **Note:** Two default policies are created and enabled.

4. On the **Policies** page, select the check box next to **Default Office 365 DLP policy**, and then select the **Edit policy** button.

   > The **Edit policy** dialog box opens.

5. On the **Name your DLP policy**, notice that the name is disabled, and then select **Next**.

   > **Note:** You cannot change the name of the default policy; however. you can change settings.

6. On the **Assign admin units** page, select **Next**.

7. On the **Locations** page, verify that the **Exchange email**, **SharePoint sites**, and **OneDrive accounts** locations are selected.

8. Select the check box next to **Teams chat and channel messages**, and then select **Next**.

9. On the **Customize advanced DLP rules** page, review the rules that are configured for the policy.

   > **Note:** This default policy contains rules related to credit card detection, source code detection, and intellectual property detection. For this lab, we do not need to have HIPAA or source code detection.

10. Next to **Content matches U.S HIPAA Enhanced Default Rule**, change the status to **Off**.

11. Next to **Content matches Source Code Default Rule**, change the status to **Off**.

12. On the **Customize advanced DLP rules** page, select **Next**.

13. On the **Policy mode** page, verify that **Turn the policy on immediately** is selected, and then select **Next**.

14. On the **Review and finish** page, review your settings, and then select **Submit**.

15. On the **Policy updated** page, select **Done**.

16. On the **Policies** page, select the **Default Office 365 DLP policy** text to review the properties for the policy. 

    > **Note:** Review the updated locations and policy settings.

17. Close the **Default Office 365 DLP policy** page.

### Task 3: Configure Data Lifecycle management using Microsoft Purview

1. In the **Microsoft Purview compliance portal** navigation menu, expand **Data lifecycle management**, and then select **Microsoft 365**.

2. On the **Data lifecycle management** page, select the **Retention policies** tab.

3. On the **Retention policies** tab, select **New retention policy**.

   > **Note:** The **Create retention policy** dialog box opens.

4. On the **Name your retention policy** page, under **Name**, enter **SharePoint Site Document Retention**.

5. Provide a description, and then select **Next**.

6. On the **Policy Scope** page, select **Next**.

7. On the **Type** page, review the options, and then select **Static**. Select **Next**.

8. On the **Locations** page, ensure that the status is set to **On** for the **SharePoint classic and communication sites** option. 

9. Set the status for all other locations to **Off**, and then select **Next**.

   > **Note:** The only location that should show a status of **On** should be the **SharePoint classic and communication sites** option.

10. On the **Retention settings** page, configure the following settings, and then select **Next**.

    - **Retain items for a specific period:** 10 years
    - **Start the retention period based on**: When items were last modified
    - **At the end of the retention period**: Delete items automatically

11. On the **Review and finish** page, review your settings, and then select **Submit**.

    > **Note:** Be sure to review the alert which states that any items currently older than 10 years will be deleted after you turn on the policy.

12. On the **Finish** page, select **Done**.

**Results**: After completing this exercise, you'll have reviewed Microsoft Secure Score and Microsoft Purview compliance and information governance.
