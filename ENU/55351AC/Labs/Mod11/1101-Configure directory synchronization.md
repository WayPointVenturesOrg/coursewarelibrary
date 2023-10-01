# Lab: Configure directory synchronization

## Lab scenario

As part of the proof-of-concept phase, your team must configure and test synchronization between on-premises Active Directory Domain Services (AD DS) and Microsoft Entra ID. You must prepare AD DS for directory synchronization, install and run the Microsoft Entra Connect tool (previously known as Azure AD Connect), and then verify directory synchronization.

>**NOTE:** This lab requires that students provision an Office 365 trial tenant. Microsoft requires credit card verification during the trial tenant provisioning. No charges will be applied if recurring billing is disabled and the payment method is removed, as instructed in the lab steps. Students who don't have a credit card, can use the Microsoft 365 Developer program to apply for trial. More details are available at: [Developer Program | Microsoft 365 Dev Center](https://developer.microsoft.com/en-us/microsoft-365/dev-program)
## Exercise 1: Prepare for directory synchronization

### Scenario

Before you configure directory synchronization, you must create and prepare your Microsoft Entra tenant. In this exercise, you'll create the required accounts and create a new Microsoft Entra tenant by provisioning the Office 365 E5 trial subscription.

The main tasks for this exercise are as follows:

1. Create a trial Office 365 E5 subscription.

2. Verify the Microsoft Entra tenant, and (optionally) add a domain.

### Task 1: Create a trial Office 365 E5 subscription

1.  Sign in to **LON-CL1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

2.  From the taskbar, select to open **Microsoft Edge**.

3.  In the address bar, enter the following URL and the press Enter: **`https://products.office.com/en-us/business/office-365-enterprise-e5-business-software`**

4.  Select the **Free trial** link.

4.  On the **Let's get you started** page, in the **Email** text box, enter an email address in the form of **`mmddyyyourinitials@outlook.com`**, and then select **Next**. (Where mmddyy represents the month, day, and year in two digits.)

>Note: You'll be directed to create a new account.

5.  On the **Let's get you started** page, select **Set up account**.

6.  On the **Tell us about yourself** page, fill in the form as follows, and then select **Next**:

   - First name: Your choice
   - Last name: Your choice
   - Business phone number: Your cell phone number
   - Company name: Contoso
   - Company size: 10-24 people
   - Country or Region: Select your country of residence

7.  On the **Tell us about yourself** page, select **Text me**, in the **Phone number** text box, enter your cell phone number, and then select **Send verification code**.

8.  Retrieve the verification code from your phone, and in the **Enter your verification code** text box, enter the provided code, and then select **Verify**.

9.  On the **How you'll sign in** page, enter the following details, and then select **Next**:

   - Username: Your choice
   - Domain name: **mmddyyyourinitialsContoso.onmicrosoft.com** and click **Save**.
   - Password and Confirm password: **`Pa55w.rd1234`**

10.  On the **Quantity and payment** page, set the license quantity to **10** and then select **Update**. 

>Note: Be sure that you note the trial expiration date in the lower right corner of the window. You will not be charged during the trial period. Ensure that you follow all steps in this task to disable recurring billing on your subscription and remove credit card details before the trial expires. Although you will not be charged until trial expires, it is recommended that you remove your payment details when instructed by lab steps.

11.  Select **Add payment method**.

12.  On the **Add payment method** page, fill in your personal details and your credit card number. Your credit card will not be charged at this moment. It is used for verification purposes. Select **Save** when you are done.

13.  On the **Review and confirm** page, review your details, ensure that you note the date when your trial expires, and select **Start trial**. 

14.  On the **Thanks for choosing Office 365 E5 Trial** page, ensure that you note your username and select **Start using Office 365 E5 Trial**.

15.  On the **Install Microsoft 365** page, at the bottom-right corner, select **Exit setup**. Provide a reason for exiting setup, and then select **Send and exit**.

>Note: The Microsoft 365 admin center opens.

16.  In the Microsoft 365 admin center, use the left navigation pane to expand **Billing** and then select **Your products**.

17.  Select the **Office 365 E5 Trial** item.

18.  On the **Office 365 E5 Trial** page, select **Edit recurring billing**. 

19.  On the **Edit recurring billing** page, select **Off** and then click **Save**.

>Note: With disabling recurring billing you ensure that your subscription will not automatically renew once the trial expires.

20.  In the left navigation pane, select **Payment methods**, and then select your credit card.

21.  On the credit card window, select **Delete**.

22.  On the **Delete a payment method** page, select **Next**.

23.  On the **Review details and delete** page, select **Delete** and then select **Close**.

>Note: Ensure that your credit card is removed from the **Payment methods** page. This is very important to avoid unwanted charges.

### Task 2: Verify the Microsoft Entra tenant and add a custom domain

1.  On **LON-CL1**, in the **Microsoft Edge** window, open a new tab, and then browse to **`https://entra.microsoft.com`**.

2.  Expand **Users** and select **All users**. Ensure that you see your user account.

3.  Expand **Settings** and then select **Domain names**.

>Note: You may need to select the **Show more** button first.

4.  Verify your **mmddyyyourinitialsContoso.onmicrosoft.com** domain that you created in the previous task.

**Results:** After completing this exercise, you'll have verified the Microsoft Entra tenant.

## Exercise 2: Configure directory synchronization

### Scenario

Now that the environment is prepared for directory synchronization, the next step is to install and configure the Microsoft Entra Connect tool and configure initial synchronization.

The main tasks for this exercise are as follows:

1. Configure a synchronization account.

2. Install and configure Microsoft Entra Connect.

3. Verify the initial synchronization, and manage the settings.


### Task 1: Configure a synchronization account

1.  On **LON-CL1**, in the Microsoft Entra admin center, in the navigation pane, expand **Users**, and then select **All users**.

2.  Select **New user**, and then select **Create new user**.

3.  In the **Identity** section enter the following information:

   - User principal name: **`Sync`**

   - Display name: **`Sync`**

4.  In the **Password** section enter the following information:

   - Auto-generate password: **not selected**

   - Password: **`Pa55w.rd1234`**

5.  Select **Next:Properties**.

6.  In the **First name** field, enter **`Sync`**.

7.  In the **Last name** field, enter **`User`**. Ensure that the **User type** is set to **Member**.

8.  Select **Next:Assignments**. 

9.  Select **Add role**.

10.  In the **Directory roles** list, select **Global Administrator** and then click **Select**.

11.  Select **Review + create** and then select **Create**.

12.  Right-click or access the context menu for the **Microsoft Edge** icon on the taskbar, and then select **New InPrivate Window**.

13.  In the inPrivate window, browse to **`https://portal.azure.com`**.

14.  Sign in as **sync@mmddyyyourinitialsContoso.onmicrosoft.com** with the password of **`Pa55w.rd1234`**.

15.  On the **Update your password** page, enter **`Pa55w.rd1234`** in the **Current password** text box, and then enter **`Pa55w.rd1234!`** in the **New password** and **Confirm password** text boxes. 

16.  Select **Sign in** and then select **No** at the **Stay signed in** message.

>Note: Verify that the Azure portal opens. 

16.  Close the in-private **Microsoft Edge** window. Keep Microsoft Edge, where you're signed in with your account, open.

### Task 2: Install and configure Microsoft Entra Connect

1.  On **LON-SVR1**, sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

2.  Open **Microsoft Edge** from the taskbar, and then browse to **`https://entra.microsoft.com`**.

3.  When prompted, sign in with the global administrative credentials that you created in Exercise 1, Task 1.

4.  In the Microsoft Entra admin center, in the navigation pane, expand **Identity** and then expand **Hybrid management**.

5.  In the navigation pane, select **Microsoft Entra Connect**.

>Note: Some tenants might still show **Azure AD Connect** because of branding change. You can safely select Azure AD Connect, if that's the case.

6.  On the **Microsoft Entra Connect** page, select **Connect Sync** and then select **Download Microsoft Entra Connect** (or Download Azure AD Connect).

>Note: A new tab will open in Microsoft Edge.

7.  On the **Azure AD Connect V2** web page, select **Download**.

>Note: The exact name and branding may change to Microsoft Entra Connect.

8.  After the file is downloaded, select **Open file**. Minimize the **Microsoft Edge** window.

9.  In the **Microsoft Azure Active Directory Connect** wizard, on the **Welcome to Azure AD Connect** page, select **I agree to the license terms and privacy notice**, and then select **Continue**. 

10.  On the **Express Settings** page, select **Use express settings**. 

11.  On the **Connect to Entra ID** page, in the **USERNAME** text box, enter **sync@mmddyyyourinitialsContoso.onmicrosoft.com**. 

12.  In the **PASSWORD** text box, enter **`Pa55w.rd1234!`**, and then select **Next**. 

13.  On the **Connect to AD DS** page, in the **USERNAME** text box, enter **`Contoso\Administrator`**. 

14.  In the **PASSWORD** box, enter **`Pa55w.rd`**, and then select **Next**.

15.  On the **Entra ID sign-in configuration** page, select **Continue without matching all UPN suffixes to verified domains**, and then select **Next**.

16.  On the **Ready to configure** page, select **Install**, and when the configuration is complete, select **Exit**.

>Note: The synchronization of objects from your local AD DS and Microsoft Entra ID begins. Wait approximately 5-10 minutes for this process to complete. 

17.  On **LON-SVR1**, close the **Microsoft Edge** window.

### Task 3: Verify the initial synchronization, and manage the settings

1.  Switch to **LON-CL1**.

>Note: Microsoft Edge should still be open with the Microsoft Entra admin center.

2.  If necessary, expand **Users**, and then select **All users.**

>Note: Verify that the user accounts from AD DS are listed. Users that have been syncronized will have the **On-premises sync enabled** column set to **Yes**.

3.  Switch to **LON-SVR1**.

4.  On **LON-SVR1**, select **Start**, expand **Micrsosoft Entra Connect** (or **Azure AD Connect**), and then select **Synchronization Service**.

5.  In the **Synchronization Service Manager on LON-SVR1** window, select the **Operations** tab.

6.  Ensure that you observe the **Export, Full Synchronization**, and **Full Import** tasks. 

7.  Ensure that all the tasks have a current time and date in the **Start Time** and **End Time** columns. Also, ensure that all tasks indicate **success** in the **Status** column. 

>Note: It's normal for some tasks to have the **completed-no-objects** status.

8.  Close the **Synchronization Service Manager** window.

9.  On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

10.  In the Windows PowerShell ISE command prompt window, enter the following command, and then select Enter.

    ```
Get-ADSyncScheduler
    ```

11.  Review the results. Ensure that the **AllowedSyncCycleInterval** and **CurrentlyEffectiveSyncCycleInterval** values are set to **30 minutes**.

12.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

    ```
Set-ADSyncScheduler –CustomizedSyncCycleInterval 01:00:00
    ```

13.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

    ```
    Start-ADSyncSyncCycle –Policytype Delta
    ```

>Note: Wait for approximately 2 minutes.

14.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

    ```
    Get-ADSyncScheduler
    ```
15.  Ensure that the new value is applied for the **CurrentlyEffectiveSyncCycleInterval** variable.

16.  Close the **Windows PowerShell ISE** window.

**Results**: After completing this exercise, you should have installed Microsoft Entra Connect with the customized settings, completed directory synchronization to Microsoft Entra ID, and verified that the synchronization was successful.

## Exercise 3: Manage Active Directory users and groups, and validate directory synchronization

### Scenario

Now that directory synchronization is in place and working, you need to identify how managing user and group accounts has changed with directory synchronization. 

The main tasks for this exercise are as follows:

1. Add new objects in AD DS.
2. Verify the synchronization of the new user objects.


### Task 1: Add new objects in AD DS

1.  Switch to **LON-DC1**.

2.  Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

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

1.  On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter.

   ```
   Start-ADSyncSyncCycle –Policytype Delta
   ```

>Note: Wait for approximately 4 minutes. Don't close the **Administrator: Windows PowerShell ISE** window. However, you can minimize it.

4.  Switch to Microsoft Edge on **LON-CL1**, where you have the Microsoft Entra admin center open. 

5.  Refresh the page, select **All users**, and verify that the user account you just added is present.

6.  In Microsoft Entra admin center, browse to **Groups|All groups**, select **Sales**, and then select **Members**.

>Note: Verify that your account was also added to the **Sales** group.

**Results**: After completing this exercise, you'll have identified how managing user and group accounts has changed with directory synchronization.
