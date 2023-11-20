# Lab: Managing user, resource, and group objects in Microsoft 365

## Lab scenario

You've just completed a Microsoft 365 provisioning task as a proof-of-concept. You need to test the process of adding and configuring user accounts and groups to your new tenant. You'll also review the email resource and collaboration features included in Microsoft 365.

>**Note:** This lab requires students to first complete the Module 1 lab: **Provisioning and configuring a Microsoft 365 tenant**.
>
>To assist with your sign-in process, enter your Microsoft 365 sign-in username and password as follows:
>
>- **Microsoft 365 Username:**    __________________________________________________________________
>
>- **Password:** **`Pa55w.rd1234`**

## Exercise 1: Adding and configuring a new user 

### Scenario

You need to add new users to your Microsoft 365 tenant. You plan to create your users by using the Microsoft 365 admin center and Windows PowerShell.

The main tasks for this exercise are as follows:

1. Create a new user by using the Microsoft 365 admin center.
2. Create a new user by using Windows PowerShell.

### Task 1: Create a new user by using the Microsoft 365 admin center

1. Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2. From the taskbar, select **Microsoft Edge**.

3. In the address bar, enter the following URL and then select Enter: **`https://admin.microsoft.com`**.

4. Sign in as **`Username@mmddyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

   > **Note:** Use the credentials that you provided at the start of this lab.

5. If you receive an **Action Required** prompt, select **Ask later**.

6. At the **Stay signed in** prompt, select **No**.

   > **Note:** The Microsoft 365 admin center opens.

7. Complete and close any notification prompts that might be displayed.

8. In the navigation menu, select **Show all**.

   > **Note:** All options are now displayed on the navigation menu.

9. In the navigation menu, expand **Users**, and then select **Active users**.

10. Review the **Active users** page. 

    > **Note:** All active users are listed. Initially there is only your own user account listed with the display name, username, and the licenses assigned.

11. Select your username to open the user properties page. 

12. On the properties page, select **Licenses and apps**.

    > **Note:** **Office 365 E5** is currently selected. You need to ensure that you can also benefit from the features related to the Enterprise Mobility + Security E5 license.

13. On the **Licenses** page, select the check box next to **Enterprise Mobility + Security E5**, and then select **Save changes**.

14. Close the user properties page.

15. On the **Active users** page, select **Add a user**.

    > **Note:** The **Add a user** page opens.

16. On the **Set up the basics** page, enter the following details, and then select **Next**:

    - **First name:** `User`
    - **Last name:** `1`
    - **Display name:** `User 1`
    - **Username:** `User1`@mmddyyyourinitialsContoso.onmicrosoft.com
    - **Automatically create a password:** Not selected
    - **Password:** `Pa55w.rd1234`
    - **Require this user to change their password when they first sign in:** Not selected
    - **Send password in email upon completion:** Not selected

17. On the **Assign product licenses** page, enter the following details, and then select **Next**:

    - **Select location:** Select the same location that you used when you signed up for the Microsoft 365 tenant.
    - **Assign user a product license:** Select the check boxes next to **Enterprise Mobility + Security E5** and **Office 365 E5**.

18. On the **Optional settings** page, expand the **Profile info** section.

19. In the **Department** field enter **Sales**, and then select **Next**.

20. On the **Review and finish** page, review your settings, select **Finish adding**, and then select **Close** on the confirmation page.

    > **Note:** **User 1** should now display in the **Active users** list.

### Task 2: Create a new user by using Windows PowerShell

1. On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2. In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3. At the **User Account Control**, select **Yes**.

4. To install the module for Microsoft 365, at the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Install-Module Microsoft.Graph`

5. At the **NuGet provider** prompt, select **Yes**.

6. At the **Untrusted repository** prompt, select **Yes to All**.

   > **Note:** It may take several minutes to complete the installation.

7. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"`

8. Sign in as **`Username@mmddyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

   > **Note:** Use the credentials that you provided at the start of this lab.

9. If you receive an **Action Required** prompt, select **Ask later**.

10. On the **Permissions requested** page, select the check box next to **Consent on behalf of your organization**, and then select **Accept**.

    > **Note:** You are now connected to the Microsoft 365 tenant.

11. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-MgUser -All | Format-List DisplayName, UserPrincipalName, ID, Department`

    > **Note:** The command returns a list of all active users. The users should include your user name and User 1.

12. At the Windows PowerShell ISE command prompt, enter the following commands and then select Enter after each command: 

    `$PasswordProfile = @{Password = 'Pa55w.rd1234'}`

    `New-MgUser -DisplayName "User 2" -GivenName "User" -SurName "2" -UserPrincipalName User2@mmddyyyourinitialsContoso.onmicrosoft.com -UsageLocation <YourLocation> -MailNickName user2 -PasswordProfile $PasswordProfile -Department Sales -AccountEnabled `

    > **Note:** Replace the **YourLocation** (including the brackets) variable with the location specified when you created the tenant. You may need to look up your two-letter location code.

    > **Note:** The command returns confirmation that User 2 is created in the tenant.

13. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter: 

    `New-MgUser -DisplayName "User 3" -GivenName "User" -SurName "3" -UserPrincipalName User3@mmddyyyourinitialsContoso.onmicrosoft.com -UsageLocation <YourLocation> -MailNickName user3 -PasswordProfile $PasswordProfile -Department Sales -AccountEnabled `

    > **Note:** Replace the **YourLocation** (including the brackets) variable with the location specified when you created the tenant. You may need to look up your two-letter location code.

    > **Note:** The command returns confirmation that User 3 is created in the tenant.

14. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-MgUser -All | Format-List DisplayName, UserPrincipalName, ID, Department`

    > **Note:** The command returns a list of all active users. The users should include User 2 and User 3.

15. Switch to the **Microsoft 365 admin center**.

    > **Note:** Do not close Windows PowerShell ISE.

16. In the Navigation bar, under **Users**, select **Active users**. 

    > **Note:** User 2 and User 3 are active. Also notice that they are currently unlicensed.

17. On the **Active Users** page, select the check boxes next to both User 2 and User 3.

18. At the beginning of the page, next to **Search active users list**, select the ellipse (three dots ... ), and then select **Manage product licenses**.

19. On the **Manage product licenses** page, select **Assign more**.

20. Under the **Licenses** section, select the check box next to **Enterprise Mobility + Security E5** and **Office 365 E5**, and then select **Save changes**.

21. Select **Done** to close the **Licenses assigned** page.

**Results:** After completing this exercise, you'll have created new users by using the Microsoft 365 admin center and Windows PowerShell.

## Exercise 2: Creating a user template

### Scenario

You decide to create a user template for the Research department. The template will then be used by admins to create new users that belong to the department.

The main tasks for this exercise are as follows:

1. Create a user template.
2. Create a new user by using a user template.


### Task 1: Create a user template

1. In the Microsoft 365 admin center, on the navigation menu, under **Users**, select **Active users**.

2. On the **Active users** page, select **User templates**, and then select **Add template.**

   > **Note:** The **Add user template** dialog box opens.

3. On the **Set up your template** page, in the **Name your template** box, enter **`Research User Template`**.

4. Verify that the check box is selected next to **Make this template available to other admins who manage users**, and then select **Next**.

5. On the **Basics** page, verify that your domain is listed, and then for **Password settings**, select **Let me create a password**.

6. Remove the check mark next to **Require the user to change their password when they first sign in**, and then select **Next**.

7. On the **Licenses** page, verify that the correct location is selected, and then for **Licenses**, select the check mark next to **Enterprise Mobility + Security E5** and **Office 365 E5.** Select **Next**.

8. On the **Optional settings** page, expand the **Profile info** section.

9. In the **Department** field enter `Research`, and then select **Next**.

10. On the **Review and finish creating your template** page, review your settings, select **Finish adding**, and then select **Close** on the confirmation page.

11. Select **User templates**.

    > **Note:** **Research User Template** should now display in the list.

### Task 2: Create a new user by using a user template

1. In the Microsoft 365 admin center, on the navigation menu, under **Users**, select **Active users**.

2. On the **Active users** page, select **User templates**, and then select **Research User Template**.

   > **Note:** The **Research User Template** dialog box opens.

3. Enter the following details, and then select **Add user**:

   - **First name:** `User`
   - **Last name:** `4`
   - **Display name:** `User 4`
   - **Username:** `User4`@mmddyyyourinitialsContoso.onmicrosoft.com
   - **New password:** `Pa55w.rd1234`
   - **Send password in email upon completion:** Not selected

4. Close the **Research User Template** page.

   > **Note:** Verify that User 4 is displayed on the **Active users** page. You may need to refresh the browser.

**Results**: After completing this exercise, you should have added additional services to the tenant by adding the Enterprise Mobility + Security E5 Trial subscription.

## Exercise 3: Creating and managing groups

### Scenario

To simplify user and device management, you need to create groups. For this exercise, you'll create a Microsoft 365 group, a distribution list, and a couple of security groups. 

The main tasks for this exercise are as follows:

1. Create a Microsoft 365 group.
2. Create a Distribution list.
3. Create a dynamic Security group.
4. Use Windows PowerShell to create a Security group.


### Task 1: Create a Microsoft 365 group

1. In the Microsoft 365 admin center, on the navigation menu, expand **Teams & groups**, and then select **Active teams and groups**.

   > **Note:** The **Active teams and groups** page is displayed. By default, the **Teams & Microsoft 365 groups** tab is selected and displays the **All Company** and **Contoso** Microsoft 365 groups.

2. On the **Teams & Microsoft 365 groups** tab, select **Add a Microsoft 365 group**.

3. On the **Set up the basics** page, under **Name**, enter `Cloud Migration Project`, and then select **Next**.

4. On the **Assign owners** page, select **Assign owners**.

5. Select the check box next to your user name, and then select **Add**. 

6. Verify that your user name is displayed as an Assigned owner, and then select **Next**.

7. On the **Add members** page, select **Add members**.

8. Select the check box next to **User 1** and **User 2**, and then select **Add**. 

9. Verify that User 1 and User 2 are both displayed as members, and then select **Next**.

10. On the **Edit settings** page, configure the following settings, and then select **Next**:

    - **Group email address:** `CloudMigration`@mmddyyyourinitialsContoso.onmicrosoft.com
    - **Privacy:** Private
    - **Create a team for this group:** Not selected

11. On the **Review and finish adding group** page, review your settings, select **Create group**, and then select **Close** on the confirmation page.

    > **Note:** Verify that the Cloud Migration Project group is listed on the **Teams & Microsoft 365 groups** tab. You may need to refresh the browser.

### Task 2: Create a Distribution list

1. In the Microsoft 365 admin center, on the navigation menu, expand **Teams & groups**, and then select **Active teams and groups**.

   > **Note:** The Active teams and groups page is displayed.

2. Select the **Distribution list** tab.

3. On the **Distribution list** tab, select **Add a distribution list**.

4. On the **Set up the basics** page, under **Name**, enter `Managers`, and then select **Next**.

5. On the **Assign owners** page, select **Assign owners**.

6. Select the check box next to your user name, and then select **Add**. 

7. Verify that your user name is displayed as an Assigned owner, and then select **Next**.

8. On the **Add members** page, select **Next**.

9. On the **Edit settings** page, configure the following settings and then select **Next**:

   - **Group email address:** `Managers`@mmddyyyourinitialsContoso.onmicrosoft.com
   - **Allow people outside of my organization to send email to this Distribution group:** Not selected

10. On the **Review and finish adding group** page, review your settings, select **Create group**, and then select **Close** on the confirmation page.

    > **Note:** Verify that the Managers group is listed on the **Distribution list** tab. You may need to refresh the browser.

### Task 3: Create a dynamic Security group

1. In the Microsoft 365 admin center, on the navigation menu, select **Show all**.

2. In the navigation menu, under Admin centers, select **Identity**.

3. If necessary, at the **Action Required** prompt, select **Ask later**.

   > **Note:** Microsoft Entra admin center opens.

4. In the navigation pane, expand **Groups**, and then select **All groups**.

   > **Note:** The Microsoft Entra admin center displays the groups created in the previous tasks.

5. On the **Groups|All groups** page, select **New group**.

6. On the **New Group** page, configure the following settings, and then select **Next**:

   - **Group type:** Security
   - **Group name:** Sales
   - **Membership type:** Dynamic User

7. On the **New Group** page, select **Add dynamic query**.

8. On the **Dynamic membership rules** page, select **Choose a Property**, and then from the drop-down list, select **department**.

9. Select **Choose an Operator**, and then from the drop-down list, select **Equals**.

10. Select **Add a value**, and then enter **`Sales`**.

11. On the **Dynamic membership rules** page, select **Save**.

12. On the **New Group** page, select **Create**.

13. On the **Groups|All groups** page, select **Refresh**. 

    > **Note:** It may take a minute or two for the Sales group to display.

14. Switch to the tab that displays the Microsoft 365 admin center.

15. On the **Active teams and groups** page, on the **Security groups** tab, review the groups.

    > **Note:** The **Sales** group is now listed.

16. Select the **Sales** group and then under the **Sales** name, take note of the number of members.

    > **Note:** There should be 3 members listed. This may take a while to display as it depends on when the dynamic membership rule has been processed.

17. Close the **Sales** window.

### Task 4: Use Windows PowerShell to create a Security group

1. Switch to the Windows PowerShell ISE window.

2. At the PowerShell ISE command prompt, enter the following and then select Enter:

   `New-MgGroup -DisplayName 'Research’ -MailEnabled:$false -MailNickName 'Research’ -SecurityEnabled`

3. Switch to the Microsoft 365 admin center.

4. On the **Active teams and groups** page, on the **Security groups** tab, review the groups.

   > **Note:** The **Research** group is now listed.

**Results**: After completing this exercise, you'll have created various types of groups in your Microsoft 365 tenant.

## Exercise 4: Creating and managing email and collaboration in Microsoft 365 

### Scenario

You need to configure email and collaboration services for your Microsoft 365 tenant. In this exercise, you'll review mail features and add room and equipment resources to be used for department meeting email requests. You'll also create a new SharePoint Online team site to provide new employee onboarding information. 

The main tasks for this exercise are as follows:

1. Review email services for Microsoft 365.
2. Create Mail Contacts and Mail Users.
3. Create Resource mailboxes.
4. Configure a SharePoint team site.


### Task 1: Review email services for Microsoft 365

1. In the Microsoft 365 admin center, on the navigation menu, if necessary, select **Show all**.

2. In the navigation menu, under **Admin centers**, select **Exchange**.

   > The Exchange admin center opens.

3. Click through or close all notification prompts for new features.

4. In the navigation menu, expand **Recipients**, and then select **Mailboxes**.

   > **Note:** The same user accounts that you created using the Microsoft 365 admin center should be listed on the **Manage mailboxes** page. Notice that each user account is configured with a user mailbox after being assigned the Office 365 E5 license.

5. In the navigation menu, expand **Mail flow**, and then select **Accepted domains**.

   > **Note:** This is the mail domain for the Microsoft 365 tenant. It is authoritative for the organization.

6. In the navigation menu, expand **Reports**, and then select **Mail flow**.

   > **Note:** Notice the various mail flow reports to assist in troubleshooting and maintenance.

### Task 2: Create Mail Contacts and Mail Users

1. In the Exchange admin center navigation menu, expand **Recipients**, and then select **Groups**.

   > **Note:** All mail-enabled groups are listed in the **Groups** page.

2. In the navigation menu, under **Recipients**, select **Contacts**.

3. On the **Contacts** page, select **Add a mail contact**. 

   > **Note:** The **New Mail Contact** page opens.

4. On the **Basic information** page, configure the following settings and then select **Next**:

   - **First name:** `Contact`
   - **Last name:** `User`
   - **Display name:** `Contact User`
   - **Alias:** `Contact1`
   - **External email address:** `Contact1@fabrikam.com`

5. On the **Mail contact information** page, select **Next**.

6. On the **Review mail contact** page, select **Create**.

7. On the **Status** page, select **Done**.

    > **Note:** You return to the **Contacts** page. Notice the new Contact User. This user is listed in the Global Address List for access to the user contact information.

8. On the **Contacts** page, select **Add a mail user**. 

   > **Note:** The **New Mail User** page opens.

9. On the **Basic information** page, configure the following settings and then select **Next**:

    - **First name:** `Mail`

    - **Last name:** `User`

    - **Display name:** `Mail User`

    - **External email address:** `MailUser1@fabrikam.com`

    - **Alias:** `MailUser1`

    - **External email address:** `Contact1@fabrikam.com`

    - **User ID:** `MailUser1`@mmddyyyourinitialsContoso.onmicrosoft.com

    - **Password** and **Confirm Password**: `Pa55w.rd1234`

10. On the **Review mail user** page, select **Create**.

11. On the **Status** page, select **Done**.

    > **Note:** You return to the **Contacts** page. Notice the new Mail User. This user is listed in the Global Address List for access to the user contact information. This user also has a mailbox in the tenant.

### Task 3: Create resource mailboxes

1. Switch to the **Microsoft 365 admin center**.

2. Expand **Resources**, and then select **Rooms & equipment**.

3. On the **Rooms & equipment** page, select **Add resource**. 

   > **Note:** The **Add resource** page opens.

4. On the **Add resource** page, configure the following settings and then select **Save**:

   - **Resource type:** Room
   - **Name:** `Room1`
   - **Email:** `Room1`
   - **Domains:** mmddyyyourinitialsContoso.onmicrosoft.com
   - **Capacity:** `10`
   - **Location:** Head Office

5. On the **Room1 is ready** page, select **Edit booking options**.

   > **Note:** Take note of the booking options. These options enable the room to automatically accept meeting requests, Allow repeated meetings, and automatically decline meeting requests outside of specific limits. You can also allow scheduling only during working hours.

6. Close the **Edit booking options** page.

7. On the **Rooms & equipment** page, select **Add resource**. 

8. On the **Add resource** page, configure the following settings, and then select **Save**:

   - **Resource type:** Equipment
   - **Name:** `Projector`
   - **Email:** `Projector`
   - **Domains:** mmddyyyourinitialsContoso.onmicrosoft.com
   - **Location:** Head Office

9. Close the **Projector is ready** page.

10. Switch to the **Exchange admin center**.

11. Expand **Recipients** and then select **Resources**.

    > **Note:** The same resources are listed in the Exchange admin center.

### Task 4: Configure a SharePoint team site

1. Switch to the **Microsoft 365 admin center**.

2. On the navigation menu, if necessary, select **Show all**.

3. In the navigation menu, under **Admin centers**, select **SharePoint**.

   > **Note:** The **SharePoint admin center** opens.

4. Click through or close all notification prompts for new features.

5. In the navigation menu, expand **Sites**, and then select **Active Sites**.

   > **Note:** The **Active Sites** page lists all of the active SharePoint Online sites in the tenant.

6. On the **Active sites** page, select **Create**.

7. On the **Create a site: Select the site type** page, select the **Team site** box.

8. On the **Select a template** page, select **Employee onboarding team**.

9. On the **Preview** page, select **Use template**.

10. On the **Give your site a name** page, under **Site name** enter `Contoso New Employee Onboarding Site`.

   > **Note:** The **Group email address** and the **Site address** is automatically entered.

11. On the **Give your site a name** page, enter the following information, and then select **Next**:

    - **Site description**: `Onboarding site to provide critical information for new employees.`
    - **Group owner**: Enter your user name

12. On the **Set language and other options** page, enter the following information, and then select **Create site**:

    - **Privacy settings**: Public - anyone in the organization can access this site.
    - **Set a language**: Set the language of your choice.
    - **Time zone:** Set your time zone.

    > **Note:** It may take a minute or two to create the site.

13. On the **Add site owners and members** page, select **Finish**.

    > **Note:** The Contoso New Employee Onboarding site listed on the **Active sites** page.

14. Select the **Contoso New Employee Onboarding Site** link.

    > **Note:** The various options that you can configure for the site include membership, settings, and adding Microsoft Teams to this site.

15. At the top of the page, select **View site.**

16. Review the links and options available on the site. 

    > **Note:** The **Next steps** window provides additional tasks for finalizing your site.

17. Close Microsoft Edge.

**Results**: After completing this exercise, you'll have configured created email resources and a SharePoint Online site in Microsoft 365.