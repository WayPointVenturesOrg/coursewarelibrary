# Lab 2A: Creating and managing Exchange Online recipients

## Lab scenario

To efficiently manage an Exchange Online environment, you need to understand the foundational tasks of creating and managing recipient objects. This includes accounts related to users, resources, and contacts. It's also important to understand how various group types are created and managed in the Exchange organization. 

>**Important:** This lab requires students to first complete the **Module 1 lab: Exploring Microsoft 365 and Exchange Online administration portals**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234

## Exercise 1: Assigning licenses and creating a new user mailbox

### Scenario

Now that you have provisioned a Microsoft 365 tenant, your next step is assigning licenses for cloud services. For this exercise, you'll assign licenses to users. You also need to add new users to your Microsoft 365 tenant. Two new users have been acquired from a partner organization named Adatum Corp. You plan to create the new users by using the Microsoft 365 admin center and Microsoft Graph for Windows PowerShell. Both new users are part of the Sales department.

The main tasks for this exercise are as follows:

1. Assign licenses to users.
2. Create a new user by using the Microsoft 365 admin center.
3. Create a new user by using MS Graph for Windows PowerShell.
4. Prepare Exchange Online.

### Task 1: Assign licenses to users

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you created in Exercise 1.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

6.  Complete and close any notification prompts that might display.

7.  From the navigation menu, select **Show all**.

>**Note:** All options now display on the navigation menu.

8.  In the Microsoft 365 admin center, use the navigation pane to expand **Users**, and then select **Active users**.

>**Important:** Notice the four new user accounts in addition to your Admin account. Also notice the Licenses column, which lists **Unlicensed** for the new users. Your Admin account should have Microsoft 365 E3 assigned.

9.  Select the checkboxes next to all of the users.

10.  On the menu bar, select the ellipse (...), and then select **Manage product licenses**.

11.  On the **Manage product licenses** page, verify that the five users are selected, and then select **Assign more**.

12.  Select the checkbox for **Microsoft 365 E3**.

13.  Select **Save changes**, and then select **Done**.

>**Important:** Notice that all users are now assigned the Microsoft 365 E3 license.

### Task 2: Create a new user by using the Microsoft 365 admin center

1.  In the navigation menu, expand **Users**, and then select **Active users**.

2.  On the **Active users** page, select **Add a user**.

>**Note:** The **Add a user** page opens.

3.  On the **Set up the basics** page, enter the following details, and then select **Next**:

    - **First name:** `Joni`
    - **Last name:** `Sherman`
    - **Display name:** `Joni Sherman`
    - **Username:** `Joni`@ddmmyyyourinitialsContoso.onmicrosoft.com
    - **Automatically create a password:** Not selected
    - **Password:** `Pa55w.rd1234`
    - **Require this user to change their password when they first sign in:** Not selected
    - **Send password in email upon completion:** Not selected

4.  On the **Assign product licenses** page, enter the following details, and then select **Next**:

    - **Select location:** Select the same location that you used when you signed up for the Microsoft 365 tenant.
    - **Assign user a product license:** Select the **Microsoft 365 E3** checkbox.

5.  On the **Optional settings** page, expand the **Profile info** section.

6.  In the **Department** field, enter **`Sales`**, and then select **Next**.

7.  On the **Review and finish** page, review your settings, select **Finish adding**, and then select **Close** on the confirmation page.

>**Note:** **Joni Sherman** should now display in the **Active users** list. Take note of Joni's username and the assigned licenses.

### Task 3: Create a new user by using MS Graph for Windows PowerShell

1.  On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2.  In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3.  At the **User Account Control**, select **Yes**.

4.  To enable the running of scripts, at the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Set-ExecutionPolicy RemoteSigned`

5.  At the **Execution Policy Change** prompt, select **Yes to All**.

6.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Import-Module PowerShellGet`

7.  To install the module for Microsoft 365, at the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Install-Module Microsoft.Graph`

>**Note:** It might take several minutes to complete the installation.

8.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-MgGraph -Scopes "User.ReadWrite.All","Organization.ReadWrite.All"`

9.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

10.  On the **Permissions requested** page, select the **Consent on behalf of your organization** checkbox, and then select **Accept**.

>**Note:** You're now connected to the Microsoft 365 tenant.

11.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-MgUser -All | Format-List DisplayName, UserPrincipalName, ID, Department`

>**Note:** The command returns a list of all active users. 

12.  In the Windows PowerShell ISE script pane, enter the following script, and then select **Run Script**: 

>[!alert] Be sure to enter the following in the script pane of the Windows PowerShell ISE. 

```
$PasswordProfile = @{Password = 'Pa55w.rd1234'}

New-MgUser -DisplayName "Raul Razo" -GivenName "Raul" -SurName "Razo" -UserPrincipalName Raul@ddmmyyyourinitialsContoso.onmicrosoft.com -UsageLocation <YourLocation> -MailNickName Raul -PasswordProfile $PasswordProfile -Department Sales -AccountEnabled
```

>**Note:** Replace the **YourLocation** (including the brackets) variable with the two-letter code for the location specified when you created the tenant. You might need to research your two-letter location code. For example, United States uses the **US** location code.

>**Note:** The command returns confirmation that Raul Razo was created in the tenant.

13.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-MgUser -All | Format-List DisplayName, UserPrincipalName, ID, Department`

>**Note:** The command returns a list of all active users. The users should include Raul Razo.

14.  Open a new the Windows PowerShell ISE script pane, enter the following script, and then select **Run Script**: 

    ```
    $e3Sku = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'SPE_E3'
    $addLicenses = @(
        @{SkuId = $e3Sku.SkuId})
    Set-MgUserLicense -UserId "Raul@ddmmyyyourinitialsContoso.onmicrosoft.com" -AddLicenses $addLicenses -RemoveLicenses @()
    ```
>**Note:** The command assigns the Microsoft 365 E3 license to Raul Razo.

15.  Close Windows PowerShell ISE.

16.  Switch to the **Microsoft 365 admin center**.

17.  In the Navigation pane, under **Users**, select **Active users**. 

>**Note:** **Raul Razo** should now display in the **Active users** list. Take note of the assigned licenses. You may need to refresh the Active user list.

### Task 4: Prepare Exchange Online

1.  On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2.  In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3.  At the **User Account Control**, select **Yes**.

4.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-ExchangeOnline` 

5.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

6.  At the Windows PowerShell ISE command prompt, enter the following commands, and then select Enter after each command:

    `Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true`

>**Important:** The command enables auditing. This setting take time to process and will be required during the remainder of the course.

**Results:** After completing this exercise, you'll have created new users by using the Microsoft 365 admin center and Microsoft Graph for Windows PowerShell.

## Exercise 2: Managing user mailbox settings

### Scenario

You need to modify contact information and add the Department for each of your user mailboxes. You have also been asked to modify the default message size for both received and sent messages. Finally, you have been asked to ensure that Raul Razo and Joni Sherman's company information is set to **Adatum**, and that Megan Bowen has an additional alias name of **MeganBowen**. Megan has also requested that her contact information does not display in the Global address list.

The main tasks for this exercise are as follows:

1. Manage mailbox settings by using the Microsoft 365 admin center.
2. Manage mailbox settings by using the Exchange admin center.

### Task 1: Manage mailbox settings by using the Microsoft 365 admin center

1.  In the Microsoft 365 admin center, on the navigation pane, under **Users**, select **Active users**.

2.  On the **Active users** page, select **Megan Bowen**.

>**Note:** The **User Details Panel** for Megan Bowen opens.

3.  On the **Megan Bowen** page, on the **Account** tab, in the **Aliases** section, select **Manage username and email**.

4.  On the **Manage username and email** page, in the **Username** field, enter **`MeganBowen`**.

5.  Verify that your domain is listed, and then select **Add**.

>**Note:** You can add additional email address aliases for user accounts as needed. Email can also be sent to the user by using the alias.

6.  On the **Manage username and email** page, select **Save changes**, and then select the **Back** button.

7.  On the **Megan Bowen** page, select the **Mail** tab.

>**Note:** The **Mail** tab provides basic mailbox settings and information for the user. Notice the Mailbox storage information related to Megan Bowen that indicates that the mailbox is set with a 100 gigabytes (GB) storage quota by default.

8.  On the **Megan Bowen** page, on the **Mail** tab, in the **Show in global address list** section, select **Manage global address list visibility**.

9.  On the **Manage global address list visibility** page, clear the checkbox for  **Show in my organization address list**, and then select **Save changes**.

>**Note:** With this setting disabled, Megan Bowen will not appear in the organization's address list, however the user can still receive and send email.

10.  Close the **Manage global address list visibility** page.

### Task 2: Manage mailbox settings by using the Exchange admin center

1.  In the Microsoft 365 admin center, on the navigation menu, under **Admin centers**, select **Exchange**.

>**Note:** The Exchange admin center opens on a new tab.

2.  In the **Exchange admin center** navigation pane, expand **Recipients**, and then select **Mailboxes**.

3.  On the **Manage mailboxes** page, select **Mailflow setting**, and then select **Message size restriction**.

>**Note:** The **Default message size restrictions** page opens. These settings specify the default maximum size for sent and recieved messages.

4.  On the **Default message size restrictions** page, configure the following settings, and then select **Save**:

   - **Sent messages maximum size(KB):** `30000`
   - **Received messages maximum size(KB):** `32000`

5.  Close the **Default message size restrictions** page.

6.  On the **Manage mailboxes** page, select **Adele Vance**.

7.  On the **Adele Vance** user panel, select the **Organization** tab.

8.  On the **Organization** page, select **Manage Organization Information**.

9.  On the **Edit organization** page, in the **Department** field, enter **`Sales`**, and then select **Save**, and then close the panel.

10.  On the **Manage mailboxes** page, select the **Alex Wilber**, **Lee Gu**, and **Megan Bowen** mailboxes.

>**Note:** All three user mailboxes should be selected with a check mark.

11.  On the **Manage mailboxes** page, select **Edit**, and then select **Contact information**.

12.  On the **Edit contact information** page, in the **Department** field, enter **`Research`**, and then select **Save**.

13.  Close the **Edit contact information** page.

14.  On the **Manage mailboxes** page, select **Joni Sherman**.

15.  On the **Joni Sherman** details panel, select the **Organization** tab, and then select **Manage Organization Information**.

16.  On the **Edit organization** panel, in the **Company** field, enter **`Adatum`**, and then select **Save**.

17.  Close the **Edit organization** page for Joni Sherman.

18.  On the **Manage mailboxes** page, select **Raul Razo**.

19.  On the **Raul Razo** details panel, select the **Organization** tab, and then select **Manage Organization Information**.

20.  On the **Edit organization** panel, in the **Company** field, enter **`Adatum`**, and then select **Save**.

21.  Close the **Edit organization** page for Raul Razo.

**Results**: After completing this exercise, you should have managed mailbox settings by using both the Microsoft 365 admin center and the Exchange admin center.

## Exercise 3: Creating and managing groups by using the Exchange admin center

### Scenario

To simplify user management, you need to create groups. For this exercise, you'll create a Microsoft 365 group, a distribution list, a dynamic distribution list, and a Mail-enabled security group. 

The main tasks for this exercise are as follows:

1. Create a Microsoft 365 group.
2. Create a Distribution list.
3. Create a Dynamic distribution list.
4. Use Exchange Online PowerShell to create a Mail-enabled Security group.

### Task 1: Create a Microsoft 365 group

1.  In the Exchange admin center, on the navigation menu, expand **Recipients**, and then select **Groups**.

>**Note:** The **Groups** page is displayed. By default, the **Microsoft 365** tab is selected and displays a default **Contoso** Microsoft 365 group that contains all users in the organization.

2.  On the **Microsoft 365** tab, select **Add a group**.

3.  On the **Choose a group type** page, select **Microsoft 365 (recommended)**, and then select **Next**.

4.  On the **Set up the basics** page, under **Name**, enter `Cloud Migration Project`, select the **Description** text box, and then select **Next**.

5.  On the **Assign owners** page, select **Assign owners**.

6.  Select the checkbox next to your username, and then select **Add**. 

7.  Verify that your username displays as an Assigned owner, and then select **Next**.

8.  On the **Add members** page, select **Add members**.

9.  Select the checkboxes for **Joni Sherman** and **Lee Gu**, select **Add**, and then select **Next**.

10.  On the **Edit settings** page, configure the following settings, and then select **Next**:

    - **Group email address:** `CloudMigration`@ddmmyyyourinitialsContoso.onmicrosoft.com
    - **Privacy:** Private
    - **Create a team for this group:** Not selected

11.  On the **Review and finish adding group** page, review your settings, select **Create group**, and then select **Close** on the confirmation page.

>**Note:** Verify that the **Cloud Migration Project** group is listed on the **Microsoft 365** tab. You might need to refresh the page.

### Task 2: Create a Distribution list

1.  In the Exchange admin center, on the **Groups** page, select the **Distribution list** tab.

2.  On the **Distribution list** tab, select **Add a group**.

3.  On the **Choose a group type** page, select **Distribution**, and then select **Next**.

4.  On the **Set up the basics** page, under **Name**, enter `Managers_Dist`, select the **Description** field, and then select **Next**.

5.  On the **Assign owners** page, select **Assign owners**.

6.  Select the checkbox next to your username, and then select **Add**. 

7.  Verify that your username displays as an Assigned owner, and then select **Next**.

8.  On the **Add members** page, select **Add members**.

9.  Select the checkboxes for **Alex Wilber** and **Joni Sherman**, and then select **Add**. 

10.  On the **Add members** page, select **Next**.

11.  On the **Edit settings** page, configure the following settings, and then select **Next**:

    - **Group email address:** `Managers`@ddmmyyyourinitialsContoso.onmicrosoft.com
    - **Allow people outside of my organization to send email to this Distribution group:** Not selected
    - **Joining the group:** Closed
    - **Leaving the group:** Open

12.  On the **Review and finish adding group** page, review your settings, select **Create group**, and then select **Close** on the confirmation page.

>**Note:** Verify that the **Managers_Dist** group is listed on the **Distribution list** tab. You might need to refresh the page.

### Task 3: Create a Dynamic distribution list

1.  In the Exchange admin center, on the **Groups** page, select the **Dynamic distribution list** tab.

2.  On the **Dynamic distribution list** tab, select **Add a group**.

3.  On the **Choose a group type** page, select **Dynamic distribution**, and then select **Next**.

4.  On the **Set up the basics** page, under **Name**, enter `Sales_Dist`, select the **Description** field, and then select **Next**.

5.  On the **Assign users** page, in the **Owner** field, select your username. 

6.  On the **Assign users** page, configure the following settings, and then select **Next**:

   - **Only the following recipient types:** Users with Exchange mailboxes
   - **Select Condition:** Department
   - **Enter words:** `Sales`

7.  On the **Edit settings** page, under **Group email address**, enter **`Sales`**, and then select **Next**.

8.  On the **Review and finish adding group** page, review your settings, select **Create group**, and then select **Close** on the confirmation page.


>**Note:** Verify that the **Sales_Dist** group is listed on the **Distribution list** tab. You might need to refresh the page.

### Task 4: Use Exchange Online PowerShell to create a Mail-enabled Security group

1.  Switch to the Windows PowerShell ISE window.

2.  At the PowerShell ISE command prompt, enter the following commnand, and then select Enter:

   `Connect-ExchangeOnline`

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the PowerShell ISE command prompt, enter the following command, and then select Enter:

   `New-DistributionGroup -Name 'Research' -Type 'Security'`

>**Note:** The **New-DistributionGroup** cmdlet is used to create both distribution lists and mail-enabled security groups.

5.  At the PowerShell ISE command prompt, enter the following commands, selecting Enter after each command:

   `Add-DistributionGroupMember -Identity "Research" -Member "Alex@ddmmyyyourinitialsContoso.onmicrosoft.com"`

   `Add-DistributionGroupMember -Identity "Research" -Member "Lee@ddmmyyyourinitialsContoso.onmicrosoft.com"`

   `Add-DistributionGroupMember -Identity "Research" -Member "Megan@ddmmyyyourinitialsContoso.onmicrosoft.com"`

>**Note:** The **Add-DistributionGroupMember** cmdlet is used to add recipients to groups.

6.  At the PowerShell ISE command prompt, enter the following command, and then select Enter:

```
New-ManagementRoleAssignment -SecurityGroup "Organization Management" -Role "Address Lists" -RecipientRelativeWriteScope Organization
```

>**Note:** This command is needed for the next lab and you will run this command now as it takes a while to process. If you receive an error message continue on with the rest of the steps.

7.  Switch to the Exchange admin center.

8.  On the **Groups** page, on the **Mail-enabled security** tab, review the groups.

>**Note:** The **Research** group is now listed with a Group email address. You might need to refresh the page.

**Results**: After completing this exercise, you'll have created various types of groups by using the Exchange admin center.

## Exercise 4: Creating Exchange Resources and Contacts

### Scenario

You need to add additional Exchange recipients in your Microsoft 365 tenant. In this exercise, you'll create room and equipment resources to be used for department meeting email requests. You will also create a mail contact and a mail user to identify the differences between Contact recipients.

The main tasks for this exercise are as follows:

1. Create a room resource mailbox.
2. Create an equipment resource mailbox.
3. Create Mail Contacts and Mail Users.

### Task 1: Create a room resource mailbox

1.  In the Exchange admin center, on the navigation menu, expand **Recipients**, and then select **Resources**.

2.  On the **Resources** page, select **Add a room resource**. 

>**Note:** The **Set up room mailbox** page opens.

3.  On the **Set up room mailbox** page, configure the following settings, and then select **Next**:

   - **Name:** `ContosoRoom1`
   - **Resource email address:** `ContosoRoom1`
   - **Select domain:** ddmmyyyourinitialsContoso.onmicrosoft.com

4.  On the **Set properties** page, configure the following settings, and then select **Next**:

   - **Capacity:** `10`
   - **Location:** `Head Office`

5.  On the **Booking delegate settings** page, configure the following settings, and then select **Next**:

   - **Booking window (days):** `90`
   - **Maximum duration (hours):** `12`
   - **Enter an automatic reply to be sent to meeting organizers:** `Thank you for booking ContosoRoom1.`

>**Note:** Leave all other settings configured at the default setting.

6.  On the **Review resource** page, select **Create**.

7.  On the **Status** page, verify that the creation was successful, and then select **Done**.

### Task 2: Create an equipment resource mailbox

1.  In the Exchange admin center, on the navigation menu, expand **Recipients**, and then select **Resources**.

2.  On the **Resources** page, select **Add an equipment resource**. 

>**Note:** The **Set up equipment mailbox** page opens.

3.  On the **Set up equipment mailbox** page, configure the following settings, and then select **Next**:

   - **Name:** `Projector1`
   - **Resource email address:** `Projector1`
   - **Select domain:** ddmmyyyourinitialsContoso.onmicrosoft.com

4.  On the **Set properties** page, select **Next**.

5.  On the **Booking delegate settings** page, leave all default settings, and then select **Next**.

6.  On the **Review resource** page, select **Create**.

7.  On the **Status** page, verify that the creation was successful, and then select **Done**.

>**Note:** The **Resources** page should now display **Projector1** and **Room1** resources.

### Task 3: Create Mail Contacts and Mail Users

1.  In the Exchange admin center navigation menu, expand **Recipients**, and then select **Contacts**.

2.  On the **Contacts** page, select **Add a mail contact**. 

>**Note:** The **New Mail Contact** page opens.

3.  On the **Basic information** page, configure the following settings, and then select **Next**:

   - **First name:** `Contact`
   - **Last name:** `User`
   - **Display name:** `Contact User`
   - **Alias:** `Contact1`
   - **External email address:** `Contact1@fabrikam.com`

4.  On the **Mail contact information** page, select **Next**.

5.  On the **Review mail contact** page, select **Create**.

6.  On the **Status** page, select **Done**.

>**Note:** You return to the **Contacts** page. Select the **Refresh** button, and notice the new Contact User. This user is listed in the Global Address List for access to the user contact information.

7.  On the **Contacts** page, select **Add a mail user**. 

>**Note:** The **New Mail User** page opens.

8.  On the **Basic information** page, configure the following settings, and then select **Next**:

   - **First name:** `Mail`

   - **Last name:** `User`

   - **Display name:** `Mail User`

   - **External email address:** `MailUser1@fabrikam.com`

   - **Alias:** `MailUser1`

   - **User ID:** `MailUser1`@ddmmyyyourinitialsContoso.onmicrosoft.com

   - **Password** and **Confirm Password**: `Pa55w.rd1234`

9.  On the **Review mail user** page, select **Create**.

10.  On the **Status** page, select **Done**.

>**Note:** You return to the **Contacts** page. Select the **Refresh** button and notice the new Mail User. This user is listed in the Global Address List for access to the user contact information. This user also has a mailbox in the tenant.

11.  Close Microsoft Edge.

**Results**: After completing this exercise, you'll have configured created email resources and contacts for the Exchange Online environment.

## Exercise 5: Validating Email Functionality

### Scenario

You have created user and group recipients, and resource mailboxes. In this exercise, you will validate that email messages can be delivered successfully. You will also schedule a meeting to verify that the room resource works as expected.

The main tasks for this exercise are as follows:

- Validate email.

### Task 1: Validate email

1.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter the following URL, and then select Enter: **`https://outlook.office.com`**.

3.  Sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Outlook opens with the Inbox selected.

4.  In the menu, select **New mail**.

5.  On the message page, select the **To** button.

>**Note:** The **Add recipients** page opens to display the Address lists configured for the tenant. 

6.  On the **Add recipients** page, select **Default Global Address List**. 

>**Note:** The Default Global Address List displays all of the mail-enabled users, groups, and resources.

7.  On the **Default Global Address List**, select the plus symbol (+) next to **Lee Gu**, **Raul Razo**, and **Joni Sherman**, and then select **Save**.

8.  Complete the email message with the following settings, and then select **Send**:

    - **Add a subject:** `Welcome to Contoso!`
    - **Body of message:** `Hi everyone! Welcome to the company. Looking forward to working with you.`

9.  In the menu, select the **New mail** drop-down menu, and then select **Event**.

10.  Complete the event message with the following settings, and then select **Send**:

    - **Add a title:** `Orientation Meeting`
    - **Invite attendees:** Lee Gu, Raul Razo, Joni Sherman
    - **Suggested times:** Select a suggested time.
    - **Search for a room or location:** `ContosoRoom1`

11.  In the top-right corner, select the **AW** profile button, and then select **Sign in with a different account**.

12.  On the **Sign in to your account** page, select **Use another account**.

13.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** The Outlook page opens.

14.  In the Outlook Inbox, select the **Welcome to Contoso** message from Alex Wilber.

>**Note:** This is the email message that Alex sent to welcome Lee to the company.

15.  In the Outlook Inbox, select the **Orientation Meeting** message from Alex Wilber.

16.  On the message page, select the meeting accept (check mark) button. 

>**Note:** You have now accepted the meeting request. You can select the Calendar icon in the navigation bar to view the meeting details.

17.  Close Microsoft Edge and Windows PowerShell ISE.

**Results**: After completing this exercise, you'll have confirmed that email messages can be successfully delivered to email recipients.