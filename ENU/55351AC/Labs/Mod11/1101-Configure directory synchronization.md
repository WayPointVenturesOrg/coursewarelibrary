# Lab: Configure directory synchronization

## Lab scenario

As part of the proof-of-concept phase, your team must configure synchronization between the on-premises Active Directory Domain Services (AD DS) and Microsoft Entra ID. You plan to test and verify directory synchronization using both Microsoft Entra Cloud sync and Microsoft Entra Connect sync.

>**Important Notice:**
>
>To participate in this lab, you must set up an Office 365 trial tenant. Please be aware of the following requirements:
>
>- **Mobile Phone and Credit Card:** You will need both a mobile phone and a valid credit card. Microsoft requires credit card verification during the setup process. However, if you disable recurring billing as instructed in the lab steps, no charges will be applied.
>- **No Credit Card?** If you don't have a credit card, you can apply for a trial through the Microsoft 365 Developer Program. More details are available [here](https://developer.microsoft.com/en-us/microsoft-365/dev-program).
>
>**Security Requirements:**
>
>Due to security measures, you may be required to install and configure the Microsoft Authenticator app on your mobile device. Instructions are provided during the configuration process if this is necessary.

## Exercise 1: Prepare for directory synchronization

### Scenario

Before you configure directory synchronization, you must create and prepare your Microsoft Entra tenant. In this exercise, you'll create a new Microsoft Entra tenant by provisioning the Office 365 E5 trial subscription.

The main tasks for this exercise are as follows:

1. Create a trial Office 365 E5 subscription.

2. Verify the Microsoft Entra tenant.

>**Note:**  Do not use the online lab environment to initially create your Microsoft Entra tenant. Perform Exercise 1 from your personal host computer.

### Task 1: Create a trial Office 365 E5 subscription

1.  From your host computer, open a new InPrivate window in **Microsoft Edge**.

2.  In the address bar, enter the following URL and the press Enter: **`https://products.office.com/en-us/business/office-365-enterprise-e5-business-software`**

3.  Select the **Try for Free** link.

4.  On the **Let's get you started** page, in the **Email** text box, enter an email address in the form of **mmddyyyourinitials@outlook.com**, and then select **Next**. (Where mmddyy represents the month, day, and year in two digits.)

>**Note:**  You'll be directed to create a new account.

5.  On the **Let's get you started** page, select **Set up account**.

6.  On the **Tell us about yourself** page, fill in the form as follows, and then select **Next**:

   - First name: Your choice
   - Last name: Your choice
   - Business phone number: Your cell phone number
   - Company name: Contoso
   - Company size: 10-24 people
   - Country or Region: Select your country of residence

7.  On the **Security check** page, select **Text me**, in the **Phone number** text box, enter your cell phone number, and then select **Send verification code**.

8.  Retrieve the verification code from your phone, and in the **Enter your verification code** text box, enter the provided code, and then select **Verify**.

9.  On the **How you'll sign in** page, enter the following details, and then select **Next**:

   - Username: Your choice
   - Domain name: **mmddyyyourinitialsContoso.onmicrosoft.com** and click **Save**.
   - Password and Confirm password: **`Pa55w.rd1234`**

10.  On the **Quantity and payment** page, verify that the license quantity to **1**. 

>**Note:** Be sure that you note the trial expiration date in the lower right corner of the window. You will not be charged during the trial period. Ensure that you follow all steps in this task to disable recurring billing on your subscription before the trial expires.

11.  Select **Add payment method**.

12.  On the **Add payment method** page, fill in your personal details and your credit card number. Your credit card will not be charged at this moment. It  is used for verification purposes. Select **Save** when you are done.

13.  On the **Review and confirm** page, review your details, ensure that you note the date when your trial expires, and select **Start trial**. 

14.  On the **Add extra security to your account** page, select **Next**.

15.  On the **Action Required** page, select **Next**.

16.  On the **Keep your account secure** page, select **I want to set up a different method**, and then select **Phone**.

17.  On the **Phone** page, enter your mobile phone number and then select **Next**.

18.  On the **Phone** page, enter the code, select **Next**, on the verification complete page, select **Next**, and then select **Done**.

19.  On the **Start using your new product** page, ensure that you note your username and then select **Start using Office 365 E5 (no Teams) - Trial**.

>**Note:** The Microsoft 365 admin center opens.

20.  In the Microsoft 365 admin center, use the left navigation pane to expand **Billing** and then select **Your products**.

21.  Select the **Office 365 E5 (no Teams)** item.

22.  On the **Office 365 E5 (no Teams)** page, select **Edit recurring billing**. 

23.  On the **Edit recurring billing** page, select **Off** and then click **Save** and then select **Yes**.

>**Note:** With disabling recurring billing you ensure that your subscription will not automatically renew once the trial expires.

### Task 2: Verify the Microsoft Entra tenant

1.  In the lab environment, sign in to **LON-CL1** as **Contoso\\Administrator**, with the password of **Pa55w.rd**.

2.  On **LON-CL1**, open **Microsoft Edge**. 

3.  In the **Microsoft Edge** window, open a new tab, and then browse to **`https://entra.microsoft.com`**.

4.  Expand **Users** and select **All users**. Ensure that you see your user account.

5.  In the navigation pane, select **Show more**, expand **Settings** and then select **Domain names**.

6.  Verify your **mmddyyyourinitialsContoso.onmicrosoft.com** domain that you created in the previous task.

7.  Close the Microsoft Edge InPrivate window.

>**Note:** Complete all further exercises from within the online lab environment.

**Results:** After completing this exercise, you'll have verified the Microsoft Entra tenant.

## Exercise 2: Configure directory synchronization

### Scenario

Now that the environment is prepared with a new tenant, the next step is to configure directory synchronization.

The main tasks for this exercise are as follows:

1. Configure a synchronization account.

2. Configure Microsoft Entra Cloud Sync.

3. Monitor and Verify the initial synchronization.

4. Install and configure Microsoft Entra Connect.

5. Verify the synchronization, and manage the settings.

### Task 1: Configure a synchronization account

1.  Switch to **LON-SVR1**, and then sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

2.  From the task bar, select **Microsoft Edge** and then browse to **`http:\\entra.microsoft.com`**.

3.  Sign in as **User@mmddyyyourinitialsContoso.onmicrosoft.com** with the password of **`Pa55w.rd1234`**. Where **User** is the Username you provided in the previous exercise.

4.  In the Microsoft Entra admin center, in the navigation pane, expand **Users**, and then select **All users**.

5.  Select **New user**, and then select **Create new user**.

6.  In the **Identity** section enter the following information:

   - User principal name: **`Sync`**

   - Display name: **`Sync`**

7.  In the **Password** section enter the following information:

   - Auto-generate password: **not selected**

   - Password: **`Pa55w.rd1234`**

8.  Select **Next:Properties**.

9.  In the **First name** field, enter **`Sync`**.

10.  In the **Last name** field, enter **`User`**. Ensure that the **User type** is set to **Member**.

11.  Select **Next:Assignments**. 

12.  Select **Add role**.

13.  In the **Directory roles** list, select **Global Administrator** and then click **Select**.

14.  Select **Review + create** and then select **Create**.

15.  Right-click or access the context menu for the **Microsoft Edge** icon on the taskbar, and then select **New InPrivate Window**.

16.  In the inPrivate window, browse to **`https://portal.azure.com`**.

17.  Sign in as **sync@mmddyyyourinitialsContoso.onmicrosoft.com** with the password of **`Pa55w.rd1234`**.

18.  On the **Update your password** page, enter **`Pa55w.rd1234`** in the **Current password** text box, and then enter **`Pa55w.rd1234!`** in the **New password** and **Confirm password** text boxes. Select **Sign in**.

>**Note:**  If the **Action Required** dialog box displays, select **Ask later**.  

19.  Select **No** at the **Stay signed in** message.

>**Note:**  Verify that the Azure portal opens. 

20.  Close the in-private **Microsoft Edge** window.

>**Note:**  Keep the **Microsoft Entra admin center** window open. 

### Task 2: Configure Microsoft Entra Cloud Sync

>**Note:**  For this configuration, you will scope Cloud Sync to only include objects that are located in the IT organizational Unit of Contoso.com. 

1.  In the Microsoft Entra admin center, in the navigation pane, expand **Identity** and then expand **Hybrid management**.

>**Note:**  You may need to select **Show more** to display the entire navigation pane. 

2.  In the navigation pane, select **Microsoft Entra Connect**.

3.  On the **Microsoft Entra Connect** page, select **Cloud Sync**.

4.  On the **Cloud sync|Configurations** page, select **Agents**.

5.  On the **Cloud sync|Agents** page, select **Download on-premises agent**. 

6.  On the **Microsoft Entra Provisioning** page, select **Accept terms & download**. 

7.  At the **Downloads** notification, select **Open file**.

>**Note:**  The **Microsot Entra Provisiong Agent Package Setup** starts.

8.  In the **Microsot Entra Provisiong Agent Package Setup** box, select **I agree to the license terms and conditions**, and then select **Install**. 

>**Note:**  The **Microsoft Entra Provisioning Agent Configuration Wizard** starts.

9.  On the **Welcome** page, select **Next**. 

10.  On the **Select Extension** page, select **HR-driven provisioning**, and then select **Next**.

11.  At the **Sign in to your account** page, enter **Sync@mmddyyyourinitialsContoso.onmicrosoft.com**, and then select **Next**.

12.  At the **Enter password** page, enter **`Pa55w.rd1234!`**, and then select **Sign in**. 

13.  On the **Configure Service Account** page, select **Create gMSA**, and provide the domain credentials **`Contoso\Administrator`** with the the password of **`Pa55w.rd`**. Select **Next**.

14.  On the **Connect Active Directory** page, ensure that Contoso.com is listed as the Domain and then select **Next**.

15.  On the **Confirm** page, review the settings and then select **Confirm**.

>**Note:**  The **Microsoft Entra Provisioning Agent** installs. It may take several minutes to complete.

16.  On the **Confirm** page, select **Exit** and then close **Microsoft Entra Provisioning Agent Package Setup**.

17.  On the **Cloud sync|Agents** page, select **Configurations**.

18.  On the **Cloud sync|Configurations** page, select **New configuration**, and then select **AD to Microsoft Entra ID sync**.

19.  On the **New cloud sync configuration** page, under For a list of active agents, verify that **Contoso.com** is listed , and then select **Create**.

>**Note:**  The **New coud sync configuration** is configured. It may take a couple of minutes to complete.

20.  On the **Contoso.com|Overview** page, select **Scoping filters**.

21.  On the **Contoso.com|Scoping filters** page, select **Selected organizational units** and then at the **Scoping type change**, selet **OK**.

22.  On the **Contoso.com|Scoping filters** page, enter **`OU=IT,DC=Contoso,DC=com`**, select **Add**, and then select **Save**. 

23.  On the **Contoso.com|Scoping filters** page, select **Overview**.

24.  On the **Contoso.com|Overview** page, select **Review and enable**. 

25.  On the **Review and enable configuration** page, select **Enable configuration**.

### Task 3: Monitor and Verify the initial synchronization

1.  On the **Cloud sync|Configurations** page, verify that the Status for **Contoso.com** is **Healthy** and then select **Audit logs**.

>**Note:**  Review the activity by selecting **Refresh** every couple of minutes. It may take 10 to 15 minutes to complete.

2.  On the **Cloud sync|Audit logs** page, select **Provisioning logs**.

>**Note:**  Review and validate the actions by selecting **Refresh** every couple of minutes. It may take 10 to 15 minutes to complete.

3.  In the Microsoft Entra admin center, in the navigation pane, expand **Identity**, expand **Users**, and then select **All users**.

>**Note:** Notice the users synchronized from Contoso.com. For each synchronized user, the **On-premises sync enabled** attribute should display **Yes**. These are only users that are a member of the IT organizational unit.

### Task 4: Install and configure Microsoft Entra Connect

>**Note:**  For this configuration, you will scope Microsoft Entra Connect sync to include objects that are located in all organizational units **except** the IT organizational Unit that has already been synchronized. 

1.  Open a new tab in **Microsoft Edge** and then browse to **`https://www.microsoft.com/en-ie/download/details.aspx?id=47594&msockid=2584d9c663aa6b333bb4c84d62006aba`**

2.  On the **Microsoft Entra Connect** page, select **Download**.

3.  On the Downloads prompt, under **AzureADConnect.msi**, select **Open file**.

> Microsoft Entra Connect Sync is installed and then starts the installation wizard .

4.  In the **Microsoft Entra Connect Sync** wizard, on the **Welcome to Microsoft Entra Connect Sync** page, select **I agree to the license terms and privacy notice**, and then select **Continue**. 

5.  On the **Express Settings** page, select **Use express settings**. 

6.  On the **Connect to Microsoft Entra ID** page, in the **USERNAME** text box, enter **sync@mmddyyyourinitialsContoso.onmicrosoft.com**. 

7.  In the **Enter password** text box, enter **`Pa55w.rd1234!`**, and then select **Sign in**. 

>**Note:**  If a prompt displays with **Action Required**, select **Ask later**. 

8.  On the **Connect to AD DS** page, in the **USERNAME** text box, enter **`Contoso\Administrator`**. 

9.  In the **PASSWORD** box, enter **`Pa55w.rd`**, and then select **Next**.

10.  On the **Microsoft Entra sign-in configuration** page, select **Continue without matching all UPN suffixes to verified domains**, and then select **Next**.

11.  On the **Ready to configure** page, remove the check mark next to **Start the syncronization process when configuration completes**. 

12.  Select **Install**, and when the configuration is complete, select **Exit**.

13.  On **LON-SVR1**, minimize the **Microsoft Edge** window. 

14.  On **LON-SVR1**, on the desktop, open **Azure AD Connect** (The name branding may change to Microsoft Entra Connect in later versions of the software).

15.  On the **Welcome to Microsoft Entra Connect Sync** page, select **Configure**.

16.  On the **Additional tasks** page, select **Customize synchronization options**, and then select **Next**.

17.  On the **Connect to Microsoft Entra ID** page, in the **USERNAME** text box, enter **sync@mmddyyyourinitialsContoso.onmicrosoft.com** and select **Next**.

18.  Select the sync account, and then in the **Enter password** text box, enter **`Pa55w.rd1234!`**, and then select **Sign in**. 

19.  On the **Connect your directories** page, select **Next**.

20.  On the **Domain and OU filtering** page, select **Sync selected domains and OUs**.

21.  Expand **Contoso.com**, and then remove the check mark next to **Contoso.com**.

>**Note:**  All objects under Contoso.com will no longer be selected.

22.  Select the following organizations units: **Development**, **Infrastructure**, **Managers**, **Marketing**, **Research**, **Sales**. Select **Next**.

23.  On the **Optional features** page, select **Next**.

24.  On the **Ready to configure** page, select the check mark next to **Start the syncronization process when configuration completes**.

25.  Select **Configure**, and when the configuration is complete, select **Exit**.

>**Note:**  The synchronization of objects from your local AD DS and Microsoft Entra ID begins. Wait approximately 5-10 minutes for this process to complete. 

### Task 5: Verify the synchronization, and manage the settings

1.  Restore the **Microsoft Edge** window.

>**Note:**  Microsoft Edge should still be open with the Microsoft Entra admin center.

2.  In Microsoft Entra admin center, expand **Users**, and then select **All users.**

>**Note:**  Verify that the user accounts from AD DS are listed. Users that have been syncronized will have the **On-premises sync enabled** column set to **Yes**.

3.  On **LON-SVR1**, select **Start**, expand **Micrsosoft Entra Connect** (or **Azure AD Connect**), and then select **Synchronization Service**.

4.  In the **Synchronization Service Manager on LON-SVR1** window, select the **Operations** tab.

5.  Ensure that you observe the **Export, Full Synchronization**, and **Full Import** tasks. 

6.  Ensure that all the tasks have a current time and date in the **Start Time** and **End Time** columns. Also, ensure that all tasks indicate **success** in the **Status** column. 

> **Note:** It's normal for some tasks to have the **completed-no-objects** status.

7.  Close the **Synchronization Service Manager** window.

8.  On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

9.  In the Windows PowerShell ISE command prompt window, enter the following command, and then select Enter.

    ```
Get-ADSyncScheduler
    ```

10.  Review the results. Ensure that the **AllowedSyncCycleInterval** and **CurrentlyEffectiveSyncCycleInterval** values are set to **30 minutes**.

11.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

    ```
Set-ADSyncScheduler –CustomizedSyncCycleInterval 01:00:00
    ```

12.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

    ```
    Start-ADSyncSyncCycle –Policytype Delta
    ```

> Wait for approximately 2 minutes.

13.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

    ```
    Get-ADSyncScheduler
    ```
14.  Ensure that the new value is applied for the **CurrentlyEffectiveSyncCycleInterval** variable.

15.  Close the **Windows PowerShell ISE** window.

**Results**: After completing this exercise, you should have installed Microsoft Entra Connect with the customized settings, completed directory synchronization to Microsoft Entra ID, and verified that the synchronization was successful.

## Exercise 3: Manage Active Directory users and groups, and validate directory synchronization

### Scenario

Now that directory synchronization is in place and working, you need to identify how managing user and group accounts has changed with directory synchronization. 

The main tasks for this exercise are as follows:

1. Add new objects in AD DS.
2. Verify the synchronization of the new user objects.


### Task 1: Add new objects in AD DS

1.  Switch to **LON-DC1**.

2.  Sign in to **LON-DC1** as **`Contoso\\Administrator`** with the password of **`Pa55w.rd`**.

3.  From **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

4.  In the navigation pane, expand **Contoso.com**, right-click or access the context menu for **Sales**, select **New**, and then select **User**.

5.  In the **New Object – User** dialog box, in the **Full name** text box, enter your name.

6.  In the **User logon name** text box, enter *your* *first name*, and then select **Next**.

7.  In the **Password** and **Confirm** **password** boxes, enter **`Pa55w.rd`**, and then clear **User must change password at next logon**. 

8.  Select **Next**, select **Finish**, and then select **Sales**.

9.  Right-click or access the context menu for your user account, and then select **Add to a group**. 

10.  In the **Select Groups** dialog box, in the **Enter the object names to select (examples)** text box, enter **`Sales`**, and then select **OK**.

11.  In the **Active Directory Domain Services** dialog box, select **OK**.

### Task 2: Verify the synchronization of the new user objects

1.  Switch to **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

   ```
   Start-ADSyncSyncCycle –Policytype Delta
   ```

>**Note:** Wait for approximately 4 minutes. Don't close the **Administrator: Windows PowerShell ISE** window. However, you can minimize it.

4.  Restore Microsoft Edge to access the Microsoft Entra admin center. 

5.  Refresh the page, select **All users**, and verify that the user account you just added is present.

6.  In Microsoft Entra admin center, browse to **Groups|All groups**, select **Sales**, and then select **Members**.

>**Note:**  Verify that your account was also added to the **Sales** group.

**Results**: After completing this exercise, you'll have identified how managing user and group accounts has changed with directory synchronization.
