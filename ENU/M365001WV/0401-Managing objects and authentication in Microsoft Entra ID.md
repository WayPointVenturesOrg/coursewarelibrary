# Lab: Managing objects and authentication in Microsoft Entra ID

## Lab scenario

Now that you have a basic understanding of the Microsoft 365 admin center, your next task is to review the features from the perspective of Microsoft Entra ID. You need to identify the process for creating and managing users, groups, and device objects by using the Microsoft Entra admin center. You'll also configure authentication and password requirements, and enable self-service password reset and multifactor authentication (MFA).

>**Note:** This lab requires students to first complete the following:
>
>- Module 1 lab: **Provisioning and configuring a Microsoft 365 tenant** 
>- Module 2 lab: **Managing user, resource, and group objects in Microsoft 365**
>
>You'll also need a mobile phone to respond to authentication prompts for some of the lab tasks.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):**    
>- **Password:** Pa55w.rd1234
## Exercise 1: Managing user, group, and device objects in Microsoft Entra ID 

### Scenario

You need to validate how Microsoft Entra admin center can be used to manage users, groups, and device objects. You plan to create a new user and a new group by using Microsoft Entra admin center. You'll then perform a Microsoft Entra join with LON-CL1 and validate that a Microsoft Entra user can sign in to a Microsoft Entra-joined device.

The main tasks for this exercise are as follows:

1. Create users by using Microsoft Entra admin center.
2. Create and configure groups by using Microsoft Entra admin center.
3. Manage Microsoft Entra join.
4. Validate Microsoft Entra Join.
5. Sign in to a Windows 11 device as a Microsoft Entra User.

### Task 1: Create users by using Microsoft Entra admin center

1.  Sign in to **LON-CL1** as **Admin** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter the following URL and then select Enter: **`https://admin.microsoft.com`**.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The **Microsoft 365 admin center** opens.

6.  Complete and close any notification prompts that might be displayed.

7.  In the navigation menu, select **Show all**.

8.  In the navigation menu, under **Admin centers**, select **Identity**.

>**Note:** A new web browser page opens and the **Microsoft Entra admin center** opens.

9.  On the navigation menu, expand **Identity** and then select **Overview**.

>**Note:** Review the basic information for the tenant including Contoso as the name of the tenant and Microsoft Entra ID P2 as the License level.

10.  In the navigation menu, expand **Users**, and then select **User settings**.

>**Note:** Review the various settings that can be configured for user objects.  

11.  On the **User settings** page, under **Default user role permissions**, modify the following options, and then select **Save**:

    - **Users can register applications**: No
    - **Restrict non-admin users from creating tenants:** Yes

12.  In the navigation menu, select **All users**.

>**Note:** All users and resource accounts created in previous labs should be displayed.

13.  On the **Users** page, select **New user**, and then select **Create new user**.

14.  On the **Create new user** page, on the **Basics** tab, configure the following settings, and then select **Next: Properties**:

    - **User principal name**: **`User6`**@ddmmyyyourinitialsContoso.onmicrosoft.com
    - **Display name**: `User6`
    - **Auto-generate password**: Not selected
    - **Password**: `Pa55w.rd1234`

15.  On the **Create new user** page, on the **Properties** tab, configure the following settings, and then select **Next: Assignments**:

    - **First name**: `User`
    - **Last name**: `6`
    - **Department**: `Research`
    - **Usage location**: Select the user location you used when you signed up for the Microsoft 365 tenant.

16.  On the **Create new user** page, on the **Assignments** tab, configure the following settings, and then select **Next: Review + create**:

    - **Add group**: Research

17.  Review the settings and then select **Create**. 

>**Note:** Review the user list. You may need to select the **Refresh** button for User 6 to display in the list.

18.  Select **User6** to open the **User6** properties page.

19.  On the **User6** page, select **Licenses**.

>**Note:** Take note of the message that states adding or removing license assignements can only be performed from the Microsoft 365 admin center.  

20.  Switch to the **Microsoft 365 admin center** tab.

21.  In the Navigation pane, expand **Users**, and then select **Active users**.

22.  On the **Active users** page, select **User6** to open the User6 details page.

23.  On the User6 page, select **Licenses and apps**.

24.  On the **Licenses and apps** page, select the following options, and then select **Save changes**:

    - **Microsoft Entra ID P2**: Selected
    - **Office 365 E5 (no Teams)**: Selected

### Task 2: Create and configure groups by using Microsoft Entra admin center

1.  Switch to the **Microsoft Entra admin center** tab, and then on the navigation menu, expand **Groups** and then select **All groups**.
2.  On the **Groups|All groups** page, select **New group**.
3.  On the **New Group** page, configure the following settings, and then select **Create**:
   - **Group type**: Microsoft 365
   - **Group name**: `Project X`
   - **Group email address**: `ProjectX`@ddmmyyyourinitialsContoso.onmicrosoft.com
   - **Membership type**: Assigned
   - **Owners:** User4
   - **Members:** User5, User6
4.  On the **Groups|All groups** page, select **Expiration**.
5.  On the **Groups|Expiration** page, configure the following settings, and then select **Save**.
   - **Group lifetime**: 365
   - **Email contact for groups with no owners**: **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`**
   - **Enable expiration for these Microsoft 365 groups**: 
     - **Selected**:
     - Project X (Select **Add** and then select **Project X**)

### Task 3: Manage Microsoft Entra join

1.  In the Microsoft Entra admin center, on the navigation menu, expand **Devices**, and then select **Overview**.

2.  On the **Devices|Overview** page, select **Device settings**.

>**Note:** The **Device settings** page contains options used to control Microsoft Entra join and registration for devices. Notice that, by default, all users are able to join devices to Microsoft Entra. Each user is allowed, by default. to join a maximum of 50 devices.

3.  On the navigation menu, select **All devices**.

>**Note:** There are currently no devices joined or registered in Microsoft Entra ID. Note that LON-CL1 may show as **Microsoft Entra registered** if you opened a Microsoft Office application and registered the device in Lab 1.

4.  Close Microsoft Edge.

5.  On **LON-CL1**, on the taskbar, select **Start**, and then select **Settings**.

6.  In the **Settings** window, select **Accounts**.

7.  On the **Accounts** page, select **Access work or school**.

8.  In the **Access work or school** page, next to **Add a work or school account**, select **Connect**.

9.  In the **Microsoft account** window, select **Join this device to Microsoft Entra ID**.

10.  On the **Sign in** page, enter **`User1@ddmmyyyourinitialsContoso.onmicrosoft.com`**, and then select **Next**.

11.  On the **Enter password** page, enter **`Pa55w.rd1234`**, and then select **Sign in**.

12.  On the **Make sure this is your organization** dialog box, select **Join**.

13.  On the **You're all set!** page, select **Done**.

14.  On the **Access work or school** page, verify that **Connected to Contoso's Azure AD** is displayed.

15.  Close the **Settings** page.

### Task 4: Validate Microsoft Entra Join

1.  From the taskbar, select to open **Microsoft Edge**.

2.  In the address bar, enter the following URL and then select Enter: **`https://entra.microsoft.com`**.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**.

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The **Microsoft Entra admin center** opens.

5.  On the navigation menu, expand **Devices**, and then select **All devices**.

>**Note:** **LON-CL1** is listed. Also take note of the **Join type** column which shows that LON-CL1 is Microsoft Entra joined with User1 as the owner.

6.  Close Microsoft Edge.

### Task 5: Sign in to a Windows 11 device as a Microsoft Entra User

1.  Restart **LON-CL1**.

2.  After **LON-CL1** restarts, on the sign-in page, select **Other user**.

3.  In the **Email address** field, enter **`User1@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

4.  In the **Password** field, enter **`Pa55w.rd1234`**, and then select **Submit**.

>**Note:** A local profile is created on LON-CL1 for User1.

5.  At the **Use Windows Hello with your account** page, select **OK**.

6.  On the **More information required** page, select **Next**.

7.  On the **Keep your account secure** page, read the information about Microsoft Authenticator.

>**Note:** If you do not have Microsoft Authenticator on your phone, download and install the app as directed. After you have installed Microsoft Authenticator, select **Next**.

8.  As prompted, select **Work or school account** in Microsoft Authenticator, and then on the Keep your account secure page, select **Next**.

9.  Scan the QR code as indicated and then select **Next**.

10.  Validate authentication by entering the code as indicated.

11.  On the Notification approved page select **Next**.

12.  On the **Success!** page, select **Done**.

13.  On the **Set up a PIN** page, enter **`135246`** in the **New PIN** and **Confirm PIN** fields and then select **OK**. On the **All set!** page, select **OK**.

14.  On the task bar, select **Microsoft Edge**.

15.  In Microsoft Edge, select **Start without your data**, and then select **Confirm and continue**.

16.  Select **Continue without this data**, and then select **Confirm and start browsing**.

17.  Close and then reopen Microsoft Edge to display a clean browser window.

18.  In the address bar, enter **`https://portal.office.com`**, and then select Enter.

>**Note:** User1 signs in to the portal using single sign-on.

19.  Close **Microsoft Edge** and then sign out of **LON-CL1**.

**Results:** After completing this exercise, you'll have used the Microsoft Entra admin center to create a new user and a new group. You'll also have joined LON-CL1 to Microsoft Entra ID and verified that a Microsoft Entra user can sign in using the device.

## Exercise 2: Configuring self-service password reset

### Scenario

To help minimize helpdesk calls, you need to allow users to reset their own passwords. In this exercise, you'll configure authentication methods that can be used to validate password reset. You'll then configure the password reset feature and validate that it works.

The main tasks for this exercise are as follows:

1. Review authentication methods.
2. Configure password reset.
3. Register authentication methods.
4. Perform password reset.
5. Reset a forgotten password.

### Task 1: Review authentication methods

1.  On LON-CL1, on the sign-in page, select **Other user**.

2.  In the **Email address** field, enter **`.\Admin`**.

3.  In the **Password** field, enter **`Pa55w.rd`**, and then select **Submit**.

4.  From the taskbar, select **Microsoft Edge**.

5.  In the address bar, enter the following URL, and then select Enter: **`https://entra.microsoft.com`**.

6.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

7.  At the **Stay signed in** prompt, select **No**.

>**Note:** The **Microsoft Entra admin center** opens.

8.  In the navigation menu, expand **Protection**, and then select **Authentication methods**. 

>**Note:** Take note of the various authentication methods that can be used. This is where you can enable and disable specific methods.


### Task 2: Configure password reset

1.  In the navigation menu, expand **Protection**, and then select **Password reset**. 

2.  On the **Password reset** page, select **Propeties**.

3.  Under **Self service password reset enabled**, select **All** and then select **Save**.

4.  On the **Password reset** page, select **Registration**.

5.  On the **Password reset|Registration** page, set **Require users to register when signing in** to **No** and then select **Save**.

6.  On the **Password reset** page, select **Authentication methods**.

7.  On the **Password reset|Authentication methods** page, configure the following settings:

   - **Number of methods required to reset**: 2
   - **Methods available to users**: 
     - Email
     - Mobile phone (SMS only)
     - Security questions
   - **Number of questions required to register**: 3
   - **Number of questions required to reset**: 3

8.  Under **Select security questions**, select **No security questions configured**.

>**Note:** The **Select security questions** page opens.

9.  On the **Select security questions** page, select **Predefined**.

10.  On the **Add predefined security questions** page, select the check box next to the following predefined questions and then select **OK**. Note that you may need to collapse the navigation menu to review the check boxes:

   - In what city was your first job?
   - What is your favorite food?
   - What was the name of your first pet?
   - What was your first job?

11.  On the **Select security questions** page, select **OK**.

>**Note:** You should have a message that states that four security questions are selected.

12.  On the **Password reset|Authentication methods** page, select **Save**.

13.  On the **Password reset** page, select **Administrator Policy**.

>**Note:** Review the preconfigured settings for administrators. Notice that self-service password reset is enabled by default and is not affected by the authentication methods and properties configured in the previous steps.

14.  Close Microsoft Edge.

### Task 3: Register authentication methods

1.  From the taskbar, right-click or access the context menu for **Microsoft Edge**, and then select **New InPrivate window**.
2.  In the address bar, enter the following URL, and then select Enter: **`https://myaccount.microsoft.com`**.
3.  On the **Sign in** page, enter **`User2@ddmmyyyourinitialsContoso.onmicrosoft.com`** and then on the **Enter password** page, enter **`Pa55w.rd1234`**.
4.  At the **Update your password** prompt, enter the following and then select **Sign in**:
    - **Current password**: `Pa55w.rd1234`
    - **New password**: `Pa55w.rd123456`
    - **Confirm password**: `Pa55w.rd123456`

>**Note:** You need to update the password since this is the first time signing in with User2.

5.  On the **Stay signed in** page, select **No**.
6.  On the **My Account** page, select **Security info**.
7.  On the **Security info** page, select **Add sign-in method**.
8.  On the **Add a method** prompt, select **Email**, enter a valid email address, and then select **Next**.
9.  On the **Email** code page, enter your verification code and then select **Next**.
10.  On the **Security info** page, select **Add sign-in method**.
11.  On the **Add a method** prompt, and then select **Security questions**.
12.  On the **Security questions** prompt, select and provide an answer for three security questions, and then select **Done**.

### Task 4: Perform password reset

1.  On the **My Account** page, in the navigation pane, select **Password**.

2.  On the **Change password** page, enter the following information, and then select **Submit**:
   - **Old password**: `Pa55w.rd123456`
   - **Create new password**: `Pa55w.rd1234`
   - **Confirm new password**: `Pa55w.rd1234`

3.  Close the Microsoft Edge InPrivate window.

### Task 5: Reset a forgotten password

1.  From the taskbar, right-click or access the context menu for **Microsoft Edge**, and then select **New InPrivate window**.

2.  In the address bar, enter the following URL and then select Enter: **`https://myaccount.microsoft.com`**.

3.  On the **Sign in** page, enter **`User2@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

4.  On the **Enter password** page, select **Forgot my password**.

5.  On the **Get back to your account** page, verify that **`User2@ddmmyyyourinitialsContoso.onmicrosoft.com`** is listed as the email or username.

6.  Enter the characters in the picture, and then select **Next**.

7.  On the **verification step 1** page, on **Email my alternate email**, select **Email**. 

8.  In the **Enter your verification code** field, enter your verification code, and then select **Next**.

9.  On the **Answer my security questions** page, answer each security question, and then select **Next**.

10.  On the **Choose a new password page**, enter **`Pa55w.rd1234`** for both the **Enter new password** and **Confirm new password** boxes, and then select **Finish**.

11.  At the **To sign in with your new password** message, select **click here**.

12.  On the **Sign in** page, enter **`User2@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

13.  On the **Enter password** page, enter **`Pa55w.rd1234`**, and then select **Sign in**.

14.  On the **Stay signed in** page, select **No**. 

>**Note:** The User 2 My Account page opens. 

15.  Close the Microsoft Edge InPrivate window.

**Results**: After completing this exercise, you should have configured authentication methods and configured and validated password reset functionality for the tenant.

## Exercise 3: Enforcing multifactor authentication by using conditional access policy 

### Scenario

You need to implement multifactor authentication (MFA) for the Sales department. You decide to use conditional access policy to manage MFA.

The main tasks for this exercise are as follows:

1. Validate sign-in before enabling MFA.
2. Configure conditional access with MFA.
3. Validate MFA.

### Task 1: Validate sign-in before enabling MFA

1.  From the taskbar, right-click or access the context menu for **Microsoft Edge**, and then select **New InPrivate window**.

2.  In the address bar, enter the following URL and then select Enter: **`https://outlook.office.com`**.

3.  On the **Sign in** page, enter **`User2@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

4.  On the **Enter password** page, enter **`Pa55w.rd1234`**, and then select **Sign in**.

5.  On the **Stay signed in** page, select **No**. 

>**Note:** Outlook opens to User 2's inbox. Note that only the password was required to sign in to Outlook on the Web.

6.  Close the Microsoft Edge InPrivate window.

### Task 2: Configure conditional access with MFA

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter the following URL, and then select Enter: **`https://entra.microsoft.com`**.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The **Microsoft Entra admin center** opens.

5.  In the navigation menu, expand **Protection**, and then select **Conditional Access**. 

6.  On the **Conditional Access** page, select **Policies**, and then select **New policy**.

7.  On the **New Conditional access policy** page, in the **Name** box, enter **`MFA Policy`**.

8.  Under **Assignments**, in the **Users** section, select **0 users and groups selected**.

9.  In the details pane, on the **Include** tab, select the **Select users and groups** option and then select the check box next to **Users and groups**.

10.  On the **Select users and groups** page, select the check box next to **Sales**, and then choose **Select**.

11.  Under **Target resources**, select **No target resources selected** and then, on the **Include** tab, select **Select resources**.

12.  In the **Select** section, under **Select**, select **None**, and then in the list of cloud apps, select the check box next to **Office 365** and choose **Select**.

13.  Under **Access controls**, in the **Grant** section, select **0 controls selected**.

14.  On the **Grant** page, select **Grant access**, select the check box next to **Require multifactor authentication**, and then choose **Select**.

15.  Under **Enable policy**, select **On**.

16.  Select **Create** to create the MFA Policy. 

>**Note:** The policy is listed with a State of **On**.

17.  Close Microsoft Edge.

### Task 3: Validate MFA

1.  From the taskbar, right-click or access the context menu for **Microsoft Edge**, and then select **New InPrivate window**.

2.  In the address bar, enter the following URL and then select Enter: **`https://outlook.office.com`**.

3.  On the **Sign in** page, enter **`User2@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

4.  On the **Enter password** page, enter **`Pa55w.rd1234`**, and then select **Sign in**.

5.  On the **Stay signed in** page, select **No**. 

6.  On the **More information required** page, select **Next**.

7.  On the **Microsoft Authenticator** page, follow the instructions to scan the QR code for User2 using your downloaded Microsoft Authenticator app. 

>**Note:** The Authenticator should have been downloaded earlier in the lab.

>**Note:** Outlook opens to User 2's inbox.

>**Note:** User 2 had already registered authentication methods in Exercise 2. If the user had not yet registered, they would have to first register authentication methods to support MFA.

8.  Close the Microsoft Edge InPrivate window.

**Results**: After completing this exercise, you'll have successfully configured MFA to be enforced for the Sales department by using conditional access. 
