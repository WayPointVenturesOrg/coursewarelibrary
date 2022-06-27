# Lab: Configure directory synchronization

## Lab scenario

As part of the proof-of-concept phase, your team must configure and test synchronization between on-premises Active Directory Domain Services (AD DS) and Azure Active Directory (Azure AD). You must prepare AD DS for directory synchronization, install and run the Azure AD Connect tool, and then verify that the directories synchronize.

## Exercise 1: Prepare for directory synchronization

### Scenario

Before you configure directory synchronization, you must create and prepare your Azure AD tenant. In this exercise, you will create the required accounts and create a new Azure AD tenant by provisioning the Office 365 trial subscription.

The main tasks for this exercise are as follows:

1. Create a trial Office 365 E5 subscription.

2. Verify the Azure AD tenant and add a domain.


### Task 1: Create a trial Office 365 E5 subscription

1. Sign in to **LON-CL1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. From the taskbar, select to open the **Microsoft Edge**.

3. Open the **`https://products.office.com/en-us/business/office-365-enterprise-e5-business-software`** URL, and then select the **Free trial** link.

4. On the **Let's get you started** page, in the **Email** text box, enter an email address in the form of **`mmddyy<yourinitials.@outlook.com`** and then select **Next**. (Where mmddyy represents the month, day, and year in two digits.)

   > You will be directed to create a new account.

5. On the **Let's get you started** page, select **Set up account**.

6. On the **Tell us about yourself** page, fill in the form as follows and then select **Next**:

   - First name: Your choice
   - Last name: Your choice
   - Business phone number: Your cell phone number
   - Company name: Contoso
   - Company size: 2-4 people
   - Country or Region: United States

7. On the **Tell us about yourself** page, select **Text me**, in the **Phone number** text box, enter your cell phone number, and then select **Send verification code**.

8. Retrieve the verification code from your phone, and in the **Enter your verification code** text box, enter the provided code and then select **Verify**.

9. On the **How you'll sign in** page, fill in the following details and then select **Next**:

   - Username: Your choice
   - Domain name: **`mmddyy<yourinitials>Contoso.onmicrosoft.com`**
   - Password and Confirm password: **Pa55w.rd1234**

10. On the Confirmation details page, review your username information and then select **Get Started**.

    > Be sure to write down your username and password so that you can use it later.

11. On the **Install Office** page, at the bottom right corner, select **Exit setup**. Provide a reason for exiting setup and complete the task.

    > The Microsoft 365 admin center opens.

12. Leave the Microsoft Edge browser window open.


### Task 2: Verify the Azure AD tenant and add a domain

1. On **LON-CL1**, in the **Microsoft Edge** window, open a new tab, and then browse to **`https://portal.azure.com`**.

2. In the Azure portal, if necessary, select the **Show portal menu** button.

3. In the left navigation pane, select **Azure Active Directory**.

4. In the **Manage** options list, select **Custom** **Domain names**.

5. Verify your **`mmddyy<initials>.Contoso.onmicrosoft.com`** domain that you created in the previous task.

6. Select **Add custom domain**.

7. In the **Custom domain name** pane, enter **Contoso.com**, and then select **Add domain**.

8. On the Contoso.com page, review the content, and then close the **Contoso.com** window.

   > Notice that you need to create a TXT record on your DNS server to verify the custom domain.

9. Leave the Microsoft Azure portal open.

**Results:** After completing this exercise, you will have created the Azure AD tenant.

## Exercise 2: Configure directory synchronization

### Scenario

Now that the environment is prepared for directory synchronization, the next step is to install and configure the Azure AD Connect tool and configure initial synchronization.

The main tasks for this exercise are as follows:

1. Configure a synchronization account.

2. Install and configure Azure AD Connect.

3. Verify the initial synchronization and manage the settings.


### Task 1: Configure a synchronization account

1. On **LON-CL1**, in the Azure portal, in the navigation pane, select **Users**.

2. Select **All users**.

3. Select **New user** and then select **Create new user**.

4. In the **New user** blade, next to **Select template**, select **Create user**.

5. In the **Identity** section enter the following information:

   - User name: **Sync**

   - Name: **Sync**

6. In the **Password** section enter the following information:

   - Let me create the password: **Selected**

   - Initial password: **Pa55w.rd1234**

7. In the **Groups and roles** section enter the following information:

   - Roles: **Global administrator**

8. In the **Settings** section enter the following information:

   - Usage location: **United States**

9. Select **Create**.

10. Right-click or access the context menu for the **Microsoft Edge** icon on the taskbar, and then select **New InPrivate Window**.

11. In the new browser window, browse to **`https://portal.azure.com`**.

12. Sign in as **`sync@mmddyy<initials>Contoso.onmicrosoft.com`** with the password **Pa55w.rd1234**.

13. On the **Update your password** page, enter **Pa55w.rd1234** in the **Current password** text box, and then enter a new password in the **New password** and **Confirm password** text boxes. Select **Sign in**. Document the password for the SYNC account.

    > Verify that the Azure portal opens. 

14. Close the in-private **Microsoft Edge** window. Keep Microsoft Edge, where you are signed in with your account, open.


### Task 2: Install and configure Azure AD Connect

1. On **LON-SVR1**, sign in as **Contoso\\Administrator**.

2. Open **Microsoft Edge** from the taskbar, and then browse to **`https://portal.azure.com`**.

3. On the **Microsoft Azure** page, sign in with the global administrative credentials that you created in Exercise 1, Task 1.

4. In the Microsoft Azure portal, select **Azure Active Directory** in the left navigation pane.

5. In the navigation pane, select **Azure AD Connect.**

6. On the **Contoso|Azure AD Connect** page, select **Download Azure AD Connect**. 

   > A new tab will open in Microsoft Edge.

7. On the **Microsoft Azure Active Directory Connect** webpage, select **Download**.

8. After the file is downloaded, select **Open file**. Minimize the **Microsoft Edge** window.

9. In the **Microsoft Azure Active Directory Connect** wizard, on the **Welcome to Azure AD Connect** page, select **I agree to the license terms and privacy notice**, and then select **Continue**. 

10. On the **Express Settings** page, select **Use express settings**. 

11. On the **Connect to Azure AD** page, in the **USERNAME** text box, enter **`sync@mmddyy<initials>Contoso.onmicrosoft.com`**. 

12. In the **PASSWORD** text box, enter the password that you assigned to the SYNC account, and then select **Next**. 

13. On the **Connect to AD DS** page, in the **USERNAME** text box, enter **Contoso\\Administrator**. 

14. In the **PASSWORD** box, enter **Pa55w.rd**, and then select **Next**.

15. On the **Azure AD sign-in configuration** page, select **Continue without matching all UPN suffixes to verified domains**, and then select **Next**.

16. On the **Ready to configure** page, select **Install**, and when the configuration is complete, select **Exit**.

    > The synchronization of objects from your local Active Directory Domain Services (AD DS) and Azure Active Directory (Azure AD) begins. Wait approximately 5-10 minutes for this process to complete. 

17. On **LON-SVR1**, close the **Microsoft Edge** window.


### Task 3: Verify the initial synchronization and manage the settings

1. Switch to **LON-CL1**.

   > Microsoft Edge should still be open with the Microsoft Azure portal.

2. If necessary, under the **Manage** options list, select **Users** and then select **All users.**

   > Verify that you can see the user accounts from your local AD DS. You should be able to see all users from your local Contoso.com domain.

3. Switch to **LON-SVR1**.

4. On **LON-SVR1**, select **Start**, expand **Azure AD Connect**, and then select **Synchronization Service**.

5. In the **Synchronization Service Manager on LON-SVR1** window, select the **Operations** tab.

6. Ensure that you can see the **Export, Full Synchronization**, and **Full Import** tasks. 

7. Ensure that all the tasks have a current time and date in the **Start Time** and **End Time** columns. Also, ensure that all tasks show **success** in the **Status** column. 

   > **Note:** It is normal for some tasks to have the **completed-no-objects** status.

8. Close the **Synchronization Service Manager** window.

9. On **LON-SVR1**, select **Start**, and then open **Windows PowerShell**.

10. In the **Administrator: Windows PowerShell** window, enter the following command, and then press Enter.

    ```
    Get-ADSyncScheduler
    ```

11. Review the results. Ensure that the **`AllowedSyncCycleInterval`** value and the **`CurrentlyEffectiveSyncCycleInterval`** value are set to **30 minutes**.

12. In the **Administrator: Windows PowerShell** window, enter the following command, and then press Enter.

    ```
    Set-ADSyncScheduler –CustomizedSyncCycleInterval 01:00:00
    ```

13. In the **Administrator: Windows PowerShell** window, enter the following command, and then press Enter.

    ```
    Start-ADSyncSyncCycle –Policytype Delta
    ```

    > Wait for approximately two minutes.
    >

14. In the **Administrator: Windows PowerShell** window, enter the following command, and then press Enter.

    ```
    Get-ADSyncScheduler
    ```

15. Ensure that the new value is applied for the **`CurrentlyEffectiveSyncCycleInterval`** variable.

16. Close the **Windows PowerShell** window.


**Results**: After completing this exercise, you should have installed Azure AD Connect with the customized settings, completed directory synchronization to Azure AD, and verified that the synchronization was successful.

## Exercise 3: Manage Active Directory users and groups and validate directory synchronization

### Scenario

Now that directory synchronization is in place and working, you need to identify how managing user and group accounts has changed with directory synchronization. 

The main tasks for this exercise are as follows:

1. Add new objects in AD DS.
2. Verify the synchronization of the new user objects.


### Task 1: Add new objects in AD DS

1. Switch to **LON-DC1**.

2. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. From **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

4. In the navigation pane, expand **Contoso.com**, right-click or access the context menu for **Sales**, select **New**, and then select **User**.

5. In the **New Object – User** dialog box, in the **Full name** text box, enter your name.

6. In the **User logon name** text box, enter *your* *first name*, and then select **Next**.

7. In the **Password** and **Confirm** **password** boxes, enter **Pa55w.rd**, and then clear **User must change password at next logon**. 

8. Select **Next**, select **Finish**, and then select **Sales**.

9. Right-click or access the context menu for your user account, and then select **Add to a group**. 

10. In the **Select Groups** dialog box, in the **Enter the object names to select (examples)** text box, enter **Sales**, and then select **OK**.

11. In the **Active Directory Domain Services** dialog box, select **OK**.


### Task 2: Verify the synchronization of the new user objects

1. On **LON-SVR1**, right-click or access the context menu for **Start**, and then select **Windows PowerShell (Admin)**.

2. In the **Administrator: Windows PowerShell** window, enter the following command, and then press Enter.

   ```
   Start-ADSyncSyncCycle –Policytype Delta
   ```

3. Wait for approximately four minutes. Do not close the **Administrator: Windows PowerShell** window. However, you can minimize it.

4. Switch to Microsoft Edge on **LON-CL1**, where you have the Azure portal open. 

5. Refresh the page, select **All users**, and verify that the user account you just added is present.

6. In Azure Active Directory, browse to **Groups|All groups**, and then select **Sales** and then select **Members**.

   > Verify that your account was also added to the **Sales** group. Leave the browser window open.

**Results**: After completing this exercise, you will have identified how managing user and group accounts has changed with directory synchronization.
