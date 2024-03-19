# Lab: Exploring Microsoft 365 and Exchange Online admin portals

## Lab scenario

You are the Microsoft 365 Messaging Administrator for a company named Contoso Inc. You need to deploy a new Microsoft 365 tenant to be used for email communication with Microsoft Exchange Online. Your goal for this lab is to provision the new tenant and explore the Microsoft 365 admin center and the Exchange admin center.

>**Important:** This course requires students to provision a Microsoft 365 E3 trial tenant. You will need a mobile phone and a credit card. Microsoft requires credit card verification during the trial tenant provisioning. No charges will be applied if recurred billing is disabled as instructed in the lab steps. Students who don't have a credit card can use the Microsoft 365 Developer program to apply for a trial. More details are available at [Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program).
## Exercise 1: Provisioning a Microsoft 365 tenant 

### Scenario

Before you configure and manage the Exchange Online messaging environment, you need to first provision and prepare your Microsoft 365 tenant. In this exercise, you'll create a new Microsoft account and use it to provision a Microsoft 365 E3 trial subscription.

The main task for this exercise is as follows:

- Create a Microsoft 365 E3 trial subscription.

### Task 1: Create a Microsoft 365 E3 trial subscription

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter the following address and then press Enter:

**`https://www.microsoft.com/en-us/microsoft-365/enterprise/e3`**

4.  Select the **Try free for one month** link.

5.  On the **Let's get you started** page, in the **Email** text box, enter an email address in the form of **mmddyyyourinitials@outlook.com** (where mmddyy represents the month, day, and year in two digits), and then select **Next**. 

>**Note:** You'll be directed to create a new account.

6.  On the **Let's get you started** page, select **Set up account**.

7.  On the **Tell us about yourself** page, fill in the form as follows, and then select **Next**:

   - **First name:** Your choice
   - **Last name:** Your choice
   - **Job title:** `Messaging Administrator`
   - **Business phone number:** Your cell phone number
   - **Company name:** `Contoso`
   - **Company size:** 10-24 people
   - **Country or Region:** Select your country or region of residence

8.  On the **Security check** page, select **Text me**. In the **Phone number** text box, enter your phone number, and then select **Send verification code**.

9.  Enter the verification code from your phone in the **Enter your verification code** text box, and then select **Verify**.

10.  On the **How you'll sign in** page, enter the following details, and then select **Next**:

    - Username: *Your choice*
    - Domain name: **mmddyyyourinitialsContoso.onmicrosoft.com**, and then select **Save**.
    - Password and Confirm password: **`Pa55w.rd1234`**

11.  On the **Quantity and payment** page, ensure that the license quantity is set to **1**, and then select **Add payment method**.

>**Note:** Be sure that you note the trial expiration date at the end of the page. You'll not be charged during the trial period. 

12.  On the **Add payment method** page, fill in your personal details and your credit card number&#151;your credit card will not be charged at this moment. It is used for verification purposes only. Select **Save** when you're done.

13.  On the **Review and confirm** page, review your details. Be sure to note the date when your trial expires, and then select **Start trial**. 

>**Important:** If a message displays that states **Something happened: We need more information to verify your order**, skip to **Task 2 Workaround: Create a Microsoft 365 trial subscription.** 

14.  On the **Thanks for choosing Microsoft 365 E3 Trial** page, ensure that you note your username, and then select **Start using Microsoft 365 E3 Trial**.

15.  On the **Install Microsoft 365** page, select **Exit setup**. Provide a reason for exiting setup, and then select **Send and exit**.

16.  When the Microsoft 365 admin center opens, in the navigation menu, select **Show all**.

>**Note:** All options now display on the navigation menu.

17.  In the navigation menu, select **Setup**.

>**Note:** Review the **Setup** page. Notice that it provides a list of recommended tasks to assist with securing sign-in, apps, and email. 

18.  In the navigation menu, select **Home** to access the **Home** page.

### Task 2 Workaround: Create a Microsoft 365 E3 trial subscription
>**Important:** Only complete this task if you receive an error message stating **Something happened: We need some more information to verify your order.**

1.  On the Microsoft 365 E3 - Trial page, under **Something happenend**, select **Click here to open a support ticket**.

>**Note:** The Microsoft 365 admin center opens.

2.  Close the **How can we help?** panel.

3.  On the navigation menu, under **Billing**, select **Purchase services**.

>**Note:** The **Purchase services** page is where you'll review the products and services that you can add on to your subscription.

4.  On the **Purchase services** page, select **All products**.

5.  In the **Search all products** field, enter **E3** and then press Enter.

6.  In the **Microsoft 365 E3** section, select **Details**.

7.  On the **Microsoft 365 E3** page, in the **Select a plan** section, select **Microsoft 365 E5 (Trial)**.

8.  On the **Check out** page, select **Place order**.

9.  Close the **Thanks for your order** page.

10.  On the navigation menu, expand **Users**, and then select **Active users**.

11.  On the **Active users** page, select the check box next to your user name.

12.  Select the elipses (...), and then select **Manage product licenses**.

13.  On the **Licenses and apps** page, select your location, select the check box next to **Microsoft 365 E3**, and then select **Save changes**.

14.  Close the user panel for your user account.

**Results:** After completing this exercise, you'll have provisioned a Microsoft 365 tenant by using the Microsoft 365 E3 trial subscription.

> **Important:** Be sure to complete **Exercise 2: Disabling recurring billing for the Microsoft 365 trial subscription**. Ensure that you follow all steps to disable recurring billing on your subscription before the trial expires. 

>
>To assist with your sign-in process for the remainder of the lab, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234

## Exercise 2: Disabling recurring billing for the Microsoft 365 trial subscription

### Scenario

Now that you've provisioned a Microsoft 365 tenant, your next step is disable recurring billing so that you will not be charged additional charges after the trial. You will also disable Security Defaults for the lab environment.

The main tasks for this exercise are as follows:

1. Disable recurring billing for the Microsoft 365 trial subscription.
2. Customize Security Defaults.

### Task 1: Disable recurring billing for the Microsoft 365 trial subscription

>**Important:** Ensure that you follow all the steps listed in this task to disable recurring billing on your subscription before the trial expires.

1.  In the Microsoft 365 admin center, use the navigation pane to expand **Billing**, and then select **Your products**.

2.  Select the **Microsoft 365 E3** item.

3.  On the **Microsoft 365 E3** page, select **Edit recurring billing**. 

4.  On the **Edit recurring billing** page, select **Off**, and then select **Save**. Select **Yes** at the confirmation prompt.

>**Note:** By disabling recurring billing, you ensure that your subscription will not automatically renew when the trial expires.

### Task 2: Customize Security Defaults

1.  In the Microsoft 365 admin center, on the navigation menu, select **Show all**.

2.  In the navigation menu, under **Admin centers**, select **Identity**.

>**Note:** Microsoft Entra admin center opens.

3.  On the navigation pane, expand **Identity**, and then select **Overview**.

4.  On the **Contoso** page, select **Properties**.

5.  At the end of the page, select **Manage security defaults**.

6.  On the **Security defaults** page, select the drop-down menu, and then select **Disabled**.

7.  On the **Reason for disabling** list, select **My organization is using Conditional Access**, and then select **Save**.

8.  Select **Disable** to close the **Security defaults** window.

9.  Close Microsoft Edge.

>**Note:** Security Defaults are enabled by default to provide extra security such as multifactor authentication for the tenant. In a production environment, you would only disable this setting if you plan to use Conditional Access policies. 

**Results**: After completing this exercise, you should have disabled recurring billing and disabled Security defaults for the tenant.

## Exercise 3: Reviewing Microsoft 365 and Exchange admin centers

### Scenario

You need to become familiar with the Microsoft 365 admin center, the Exchange admin center, and how the two administrative portals are used to manage recipient settings and email.

The main tasks for this exercise are as follows:

1. Review the Microsoft 365 admin center.
2. Review the Exchange admin center.


### Task 1: Review the Microsoft 365 admin center

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**.  

>**Note:** Use the credentials that you created in Exercise 1.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

5.  Complete and close any notification prompts that might display

6.  In the navigation menu, select **Show all**.

>**Note:** All options now display on the navigation menu.

7.  In the navigation pane, expand **Users**.

>**Note:** The **Users** node is where you will create and manage user accounts for users, contacts, and guest users. 

8.  Select the **Active users** node and take note of the options to add and manage new users.

9.  Select the **Contacts** node and take note of the options to add and manage contacts.

10.  Select the **Guest users** node and take note of the options to add and manage guest users to the tenant.

11.  In the navigation pane, expand **Teams & groups**. 

>**Note:** The **Teams & groups** node is where you create and manage group recipients and Shared mailboxes. 

12.  Select the **Active teams & groups** node and take note of the options to add and manage Teams & Microsoft 365 groups, distribution lists, and security groups.

13.  Select the **Shared mailboxes** node and take note of the options to add and manage shared mailboxes for team collaboration.

14.  In the navigation pane, expand **Resources**, and then select **Rooms & equipment**.

>**Note:** The **Rooms & equipment** node is where you create and manage resources such as conference rooms or equipment that can be scheduled along with users for meetings.

15.  In the navigation pane, expand **Settings**, and then select **Org settings**.

16.  On the **Org settings** page, select **Services**.

17.  On the **Services** page, select **Calendar**.

18.  When the **Calendar** page opens, under **External sharing**, verify that the **Show all calendar appointment information** option is selected.

19.  Close the **Calendar** page.

20.  On the **Services** page, select **Mail**.

21.  When the **Mail** page opens, notice the links to configure Auditing, Mail flow, and spam and malware protection.

22.  Close the **Mail** page.

### Task 2: Review the Exchange admin center

1.  In the navigation pane, under **Admin centers**, select **Exchange**.

>**Note:** Exchange admin center opens.

2.  On the navigation pane, expand **Recipients**, and then select **Mailboxes**.

>**Note:** You can manage mailbox-related settings. However, to add or delete user mailboxes, you need to use the Microsoft 365 admin center. You can still add a shared mailbox using the Exchange admin center.

3.  On the navigation pane, select **Groups**.

>**Note:** You can create and manage Microsoft 365 groups, Distribution lists, Dynamic distribution lists, and Mail-enabled security groups.

4.  On the navigation pane, select **Resources**.

>**Note:** Similar to the Microsoft 365 admin center, you can use the Exchange admin center to create resources such as meeting rooms or equipment.

5.  On the navigation pane, select **Contacts**.

>**Note:** Exchange admin center provides additional features in relation to contacts. You can choose to create a standard contact, also known as a mail contact, which will publish contact information in the Global Address List. A mail user is similar to a mail contact, but is also provided a mailbox within the tenant.

6.  On the navigation pane, expand **Mail flow**.

>**Note:** The **Mail flow** section provides options to configure email domains, connectors, and monitoring features related to message trace and alerts.

7.  In the **Mail flow** section of the navigation pane, select **Accepted domains**.

>**Note:** Take note of the Accepted domain for your tenant. This is the authoritative domain used to send and receive email. You would use the **Domains** page of the Microsoft 365 admin center to add or remove additional accepted domains.

8.  In the **Mail flow** section of the navigation pane, select **Remote domains**.

9.  On the **Remote domains** page, select **Default**.

>**Note:** The default Remote domains policy is configured to allow automatic replies such as out of office and forwarding to external domains. It's also enabled to allow delivery and non-delivery reports.

10.  Close the **Default** policy page.

11.  Close Microsoft Edge.

**Results**: After completing this exercise, you'll have reviewed both the Microsoft 365 admin center and the Microsoft Exchange admin center.

## Exercise 4: Managing Exchange Online with PowerShell

### Scenario

You plan to perform some tasks by using Exchange Online PowerShell. These tasks could include settings that are not available in the Exchange Admin center, or tasks that you need to perform bulk operations for and that could be time-consuming if performed by using a console.

The main tasks for this exercise are as follows:

1. Install Exchange Online PowerShell.
2. Run scripts by using Exchange Online PowerShell.

### Task 1: Install Exchange Online PowerShell

1.  On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2.  In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3.  At the **User Account Control**, select **Yes**.

4.  To enable the running of scripts, at the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Set-ExecutionPolicy RemoteSigned`

5.  At the **Execution Policy Change** prompt, select **Yes to All**.

6.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Import-Module PowerShellGet`

7.  To install the module for Exchange Online PowerShell, at the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Install-Module -Name ExchangeOnlineManagement`

8.  To import the module for Exchange Online PowerShell, at the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Import-Module -Name ExchangeOnlineManagement`

9.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-ExchangeOnline` 

10.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

>**Note:** You're now connected to Exchange Online.

11.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-Mailbox -ResultSize unlimited`

>**Note:** The command returns a list of all the mailboxes in your organization.

12.  At the Windows PowerShell ISE command prompt, enter the following commands, and then select Enter after each command:

    `Enable-OrganizationCustomization`

>**Note:** The command enables the ability to modify certain settings for the Exchange organization. These settings take time to process and will be required during the remainder of the course.

13.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-OrganizationConfig`

>**Note:** The command returns a list of configuration settings for the Exchange organization. Search for the **IsDehydrated** entry and verify that the setting is **False**. This confirms that the **Enable-OrganizationCustomization** command completed successfully.

### Task 2: Run scripts by using Exchange Online PowerShell

1.  In Windows PowerShell ISE, select **File**, and then select **Open**.

2.  Browse to **C:\\Labfiles**, select **Names.ps1**, and then select **Open**.

>**Note:** The content of **Names.ps1** displays in the script pane. Notice that this script sets the execution policy, assigns a password variable to **Pa55w.rd1234**, connects to Exchange Online, and then creates four mailboxes.

3.  From the Windows PowerShell ISE menu, select **Edit**, and then select **Replace in Script**.

4.  In the **Replace** box, in the **Find what** field, enter **`<YourDomain>`**. 

5.  In the **Replace** box, in the **Replace with** field, enter **`ddmmyyyourinitialsContoso.onmicrosoft.com`**.

6.  In the **Replace** box, select **Replace All**.

7.  Close the **Replace** box.

8.  From the Windows PowerShell ISE menu select **File**, and then select **Run**.

9.  When the Windows PowerShell ISE message to save the script displays, select **OK**.

10.  At the **Sign in to your account** page, select your Admin account for the tenant.

>**Note:** The script continues and creates four user accounts with associated mailboxes. Take note of the warning messages that state to assign each account a license. You might also receive a warning that the mailbox might not be available for a small amount of time.

11.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

    `Get-Mailbox -ResultSize unlimited`

>**Note:** The command returns a list of all the mailboxes in your organization. Notice the new mailboxes that you created by using the script.

12.  Close Windows PowerShell ISE.

**Results:** After completing this exercise, you'll have installed Exchange Online PowerShell and used a PowerShell script to create new user mailboxes.