# Lab: Configuring clients for Exchange Online

## Lab scenario

You need to create and assign a custom Microsoft Outlook Web App policy that restricts specific features from Outlook on the web. You also need to configure Microsoft 365 settings to control Microsoft 365 app installation options. Finally, you need to download and install Microsoft 365 apps and configure Outlook to connect to Exchange Online. 

>**Note:** This lab requires students to first complete the **Module 1 Lab: Exploring Microsoft 365 and Exchange Online administration portals**, and **Module 2, Lab A: Creating and managing Exchange Online recipients**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234

## Exercise 1: Configuring Outlook Web App Policies

### Scenario

You need to configure a custom Outlook Web App policy to restrict specific features from Outlook on the web. To validate how an Outlook Web App policy is configured, you decide to create a new Outlook Web App policy, assign the policy to Adele Vance, and then have Adele confirm that settings are restricted. You will also disable the IMAP and POP3 protocols for Adele.

The main tasks for this exercise are as follows:

1. Create an Outlook on the web mailbox policy.
2. Manage settings for email apps.
3. Validate the Outlook on the web mailbox policy.

### Task 1: Create an Outlook on the web mailbox policy

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Exchange admin center opens.

6.  In the navigation pane, expand **Roles**, and then select **Outlook web app policies**.

>**Note:** Note that the **OwaMailboxPolicy-Default** policy is configured with all settings enabled and assigned to all users by default.

7.  On the **Outlook web app policies** page, select **New OWA policy**.

8.  In the **New Outlook web app policy** panel, on the **Set up the basics** page, enter **`Contoso Research OWA Policy`** in the **Name** field, and then select **Next**.

9.  On the **Features** page, configure the following details, and then select **Next**:

   - Communication management:
     - **Contacts:** Not selected
     - **All address lists:** Not selected
   - Information management:
     - **Notes:** Not selected
   - User experience:
     - **Weather:** Not selected
     - **Premium client:** Not selected
   - Time management:
     - **Tasks:** Not selected

>**Note:** Leave all other settings configured with the default selections. 

10.  On the **View and access attachments** page, under **Public or shared computers**, clear the **Let users open files attached to email messages when using a public or shared computer** checkbox, and then select **Next**.

11.  On the **Review policy and finish** page, review the settings, select **Create**, and then select **Done**.

>**Note:** The **Outlook web app policies** page now displays the **Contoso Research OWA Policy**.

### Task 2: Manage settings for email apps

1.  In the Exchange admin center, in the navigation menu, expand **Recipients**, and then select **Mailboxes**.

2.  On the **Manage mailboxes** page, select **Adele Vance**.

3.  In the **Adele Vance** panel, on the **General** tab, scroll to the **Email apps & mobile devices** section, and then select **Manage email apps settings**.

4.  On the **Manage settings for email apps** panel , configure the following options:

   - **IMAP:** Disabled
   - **POP3:** Disabled 

>**Note:** Leave all other settings configured with the default selections. 

5.  In the **Outlook web app mailbox policy** field, select the **X** to remove the **OwaMailboxPolicy-Default** policy.

6.  In the **Outlook web app mailbox policy** field, enter and select **`Contoso Research OWA Policy`**, and then select **Save**.

7.  Close the **Manage settings for email apps** panel.

8.  Close Microsoft Edge.

### Task 3: Validate the Outlook on the web mailbox policy

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

3.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

5.  In Outlook, in the **Inbox** navigation pane, expand **Folders**, and then confirm that the **Notes** app is available.

6.  On the **Outlook** navigation pane, confirm that the **To Do** app is available.

7.  On the **Outlook** navigation pane, select the **People** icon, and confirm that Contacts and address lists are available.

8.  Select the **Settings** button.

9.  On the **Settings** page, select **Calendar**, and then verify that **Weather** is listed.

10.  Close the **Settings** page, and then close Microsoft Edge.

11.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

12.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

13.  Sign in as **`Adele@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

14.  When Outlook opens, notice that the Premium client is not used for Adele.

15.  Notice that contacts, tasks, and Notes are not visible for Adele either.

>**Note:** If Adele does not show the Basic experience, sign-out and re-sign in to Outlook on the web. It may take several minutes for the policy to apply. The **Contoso Research OWA Policy** is assigned to Adele and restricts Adele to the Basic experience with settings disabled as per the policy. 

16.  Close Microsoft Edge.

**Results:** After completing this exercise, you'll have created and assigned an Outlook Web App policy and configured settings for email apps.

## Exercise 2: Managing Microsoft 365 app installations

### Scenario

You need to configure Microsoft 365 app installation options to ensure that only the Windows version of Microsoft 365 apps is available for users to download. You also need to ensure that the Microsoft 365 app installations are configured to use the Monthly Enterprise Channel.

The main tasks for this exercise are as follows:

1. Configure Microsoft 365 app installation options.
2. Install Microsoft 365 apps and configure Outlook.

### Task 1: Configure Microsoft 365 app installation options

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

6.  Complete and close any notification prompts that might display.

7.  In the navigation menu, select **Show all**.

>**Note:** All options now display on the navigation menu.

8.  In the navigation menu, expand **Settings**, and then select **Org settings**.

9.  On the **Org settings** page, on the **Services** tab, select **Microsoft 365 installation options**.

10.  In the **Microsoft 365 app installation options** panel, select the **Installation** tab.

11.  On the **Installation** tab, clear the checkboxes for the following options:

    - **Apps for Windows and mobile devices: Skype for Business (Standalone)**

    - **Apps for Mac: Office**

    - **Apps for Mac: Skype for Business** 

>**Note:** Only the checkbox for the **Office** option in **Apps for Windows and mobile devices** should remain selected.

12.  On the **Feature updates** tab, select **Once a month (Monthly Enterprise Channel)**, and then select **Save**.

13.  Close the **Microsoft 365 app installation options** panel.

14.  Close Microsoft Edge.

### Task 2: Install Microsoft 365 apps and configure Outlook

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://portal.office.com`**, and then select Enter.

3.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

5.  In the Microsoft 365 portal, select **Install and more**, and then select **Install Microsoft 365 apps**.

>**Note:** The **My account** site opens on a new browser tab to the **Apps & devices** page.

6.  On the **Apps & devices** page, select **Install Office**.

>**Note:** **OfficeSetup.exe** downloads.

7.  In the **Downloads** notification, under **OfficeSetup.exe**, select **Open file** to start the installation.

8.  At the **User Account Control**, select **Yes**.

>**Note:** The installation process for Microsoft 365 Apps will take several minutes to complete.

9.  After the installation is complete, on the **You're all set** page, select **Close**, and then close Microsoft Edge.

10.  On **LON-CL1**, from the taskbar, select the **Search** field, and then enter **`Outlook`**.

11.  In the **Search** results, select the **Outlook** app.

12.  On the **Sign in to get started with Office** page, select **Sign in or create account**.

13.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

14.  On the **Stay signed in to all your apps** page, select **OK**.

15.  On the **You're all set** page, select **Done**.

16.  At the **Outlook** page, enter **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** and then select **Connect**.

17.  On the **Account successfully added** page, clear the **Set up Outlook Mobile on my phone, too** checkbox, and then select **Done**.

    >**Note:** Outlook opens to Lee's inbox.

18.  On the **Accept the license agreement** page, select **Accept**.

19.  On the **Your privacy matters** page, select **Close**.

    >**Note:** Close all other notifications as needed.

20.  On the Windows taskbar, select the **Show hidden icons** button.

21.  Select the **Ctrl** key, and then right-click or access the context menu for the Outlook icon, and then select **Connection Status**.

22.  On the **Outlook Connection Status** window, verify that Lee's account is connected to Exchange Online using HTTP and is encrypted by using SSL.

23.  Close all open Windows.

**Results:** After completing this exercise, you will have configured Microsoft 365 app installation options, and then installed Microsoft 365 apps. You also will have configured Outlook to connect to Exchange Online.