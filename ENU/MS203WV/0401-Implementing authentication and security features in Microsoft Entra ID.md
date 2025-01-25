# Lab: Implementing authentication and security features in Microsoft Entra ID

## Lab scenario

You need to implement authentication and security features for the tenant. You'll begin by using the Microsoft Entra admin center to create a new user and group for the Human Resources department. This user and group will be used to validate self-service password reset (SSRS) and multifactor authentication (MFA). MFA will be deployed by using a conditional access policy that takes effect whenever a member of the Human Resources department signs in to a Microsoft Office 365 app such as Microsoft Outlook.

>**Note:** This lab requires students to have first completed the **Module 1 lab: Exploring Microsoft 365 and Exchange Online administration portals**, and **Module 2: Lab A:Creating and managing Exchange Online recipients**.
>
>**Note:** This lab requires a valid phone number for approving MFA requests.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234
## Exercise 1: Managing objects and reviewing authentication methods in Microsoft Entra ID

### Scenario

Before implementing SSRS and MFA, you need to create a new user account and group. The group will also automatically assign licenses to members. You'll also review the authentication methods that you can enable for the tenant, and modify the default password protection settings. Finally, you'll verify that Security Defaults have been disabled so that you can implement conditional access policies for the tenant.

The main tasks for this exercise are as follows:

1. Create a new user by using the Microsoft Entra admin center.
2. Create a new group by using the Microsoft Entra admin center.
3. Assign a license to a group.
4. Review and configure authentication methods and password protection.
5. Review Security Defaults.

### Task 1: Create a new user by using the Microsoft Entra admin center

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://entra.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Entra admin center opens.

6.  In the **Microsoft Entra admin center** navigation pane, expand **Users**, and then select **All Users**.

>**Note:** Notice that the same user accounts display in the Microsoft 365 admin center.

7.  On the **All Users** page, select **New user**, and then select **Create new user**.

8.  On the **Basics** page, enter the following details, and then select **Next: Properties**:

   - **User principal name:** `Patti`@ddmmyyyourinitialsContoso.onmicrosoft.com
   - **Display name:** `Patti Fernandez`
   - **Auto-generate password:** Not selected
   - **Password:** `Pa55w.rd1234`
   - **Account enabled:** Selected

9.  On the **Properties** page, enter the following details:

   - **Job title:** `HR Manager`
   - **Department:** `HR`

10.  Select **Review + create**, and then select **Create**.

11.  On the **Review and finish** page, review your settings, select **Finish adding**, and then select **Close** on the confirmation page.

>**Note:** **Patti Fernandez** should now display on the **Users** page. However, you might first need to refresh the page.

### Task 2: Create a new group by using the Microsoft Entra admin center

1.  In the **Microsoft Entra admin center** navigation pane,, expand **Groups**, and then select **All groups**.

2.  On the **All groups** page, select **New group**.

3.  On the **New Group** page, enter the following details:

   - **Group type:** Security
   - **Group name:** `Human Resources`
   - **Membership type:** Assigned

4.  On the **New Group** page, in the **Members** section, select **No members selected**.

5.  On the **Add members** page, select **Patti Fernandez**, and then choose **Select**.

6.  On the **New Group** page, select **Create**.

>**Note:** The **Human Resources** group should now display. However, you might need to refresh the page.

### Task 3: Assign a license to a group

1.  In **Microsoft Edge** open a new tab.

2.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter..

3.  On the navigation menu, expand **Billing** and then select **Licenses**.

4.  On the **Licenses** page, select **Microsoft 365 E5 (no Teams)**.

5.  On the **Microsoft 365 E5 (no Teams)** page, select the **Groups** tab, and then select **Assign licenses**.

6.  On the **Assign licenses to groups** page, select **Human Resources**, and then select **Assign**.

7.  Close the **You assigned licenses to Human Resources** page. Refresh the page to confirm the results.

>**Note:** You have configured the **Human Resources** security group with a license assignment. Any member of the Human Resources security group will automatically be assigned a Microsoft 365 E5 license.

### Task 4: Review and configure authentication methods and password protection

1.  Switch to the **Microsoft Entra admin center** navigation pane, expand **Protection**, and then select **Authentication methods**.

>**Note:** The **Policies** page is selected by default.

2.  On the **Policies** page, review the authentication methods that can be enabled for the tenant.

>**Note:** After September 30th, 2025, this is where you will need to enable and manage authentication methods for MFA and SSRS.  

3.  On the **Authentication methods** page, select **Password protection**.

4.  On the **Password protection** page, enter the following details, and then select **Save**:

   - **Lockout threshold:** `15`
   - **Enforce custom list:** Yes
   - **Custom banned password list**: Enter `Contoso`, and then select Enter. Then enter `Seattle` on a separate line

### Task 5: Review Security Defaults

1.  In the **Microsoft Entra admin center** navigation pane, expand **Identity**, and then select **Overview**.

2.  On the **Contoso** page, select **Properties**.

3.  Scroll to the end of the page, and then select **Manage security defaults**.

4.  On the **Security defaults** page, verify that the defaults are **Disabled**.

>**Note:** You disabled the Security defaults in Lab 1: **Exploring Microsoft 365 and Exchange Online administration portals**. Security Defaults are enabled by default. In a production environment, you would only disable this setting if you plan to use Conditional Access policies, which you plan to do later in this lab. 

**Results:** After completing this exercise, you'll have created objects and reviewed and modified authentication methods by using Microsoft Entra admin center.

## Exercise 2: Configuring SSPR

### Scenario

To help minimize helpdesk calls, you need to allow users to reset their own sign-in account passwords. In this exercise, you'll validate SSPR by enabling the feature for Patti Fernandez.

The main tasks for this exercise are as follows:

1. Configure password reset.
2. Register authentication methods.
3. Perform a password reset.
4. Reset a forgotten password.


### Task 1: Configure password reset

1.  In the **Microsoft Entra admin center** navigation pane, expand **Protection**, and then select **Password reset**. 

2.  On the **Password reset** page, select **Registration**.

3.  On the **Password reset|Registration** page, configure the following setting, and then select **Save**:

   - **Require users to register when signing in**: Yes

>**Note:** This setting ensures that users enabled for password reset register authentication methods when they sign in. The setting might already be enabled by default.

4.  On the **Password reset** page, select **Authentication methods**.

5.  On the **Password reset|Authentication methods** page, configure the following settings:

   - **Number of methods required to reset**: 2
   - **Methods available to users**: 
     - Email
     - Mobile phone (SMS only)
     - Security questions
   - **Number of questions required to register**: 3
   - **Number of questions required to reset**: 3

6.  For **Select security questions**, select **No security questions configured**.

7.  On the **Select security questions** page, select **Predefined**.

8.  On the **Add predefined security questions** page, select the checkboxes for the following predefined questions, and then select **OK**. Note that you might need to collapse the navigation menu to review the checkboxes:

   - **In what city was your first job?**
   - **What is your favorite food?**
   - **What was the name of your first pet?**
   - **What was your first job?**

9.  On the **Select security questions** page, select **OK**.

>**Note:** You should receive a message that states that four security questions are selected.

10.  On the **Password reset|Authentication methods** page, select **Save**.

11.  On the **Password reset** page, select **Properties**.

12.  On the **Password reset|Properties** page, configure the following setting, and then select **Save**:

    - **Self service password reset enabled**: Selected
    - **Select group**: Human Resources

13.  On the **Password reset** page, select **Administrator Policy**.

>**Note:** Review the preconfigured settings for administrators. Notice that SSPR is enabled by default and is not affected by the authentication methods and properties configured in the previous steps.

14.  Close Microsoft Edge.

### Task 2: Register authentication methods

1.  From the taskbar, select **Microsoft Edge**.
2.  In the address bar, enter **`https://myaccount.microsoft.com`**, and then select Enter.
3.  Sign in as **`Patti@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 
4.  At the **Update your password** prompt, enter the following settings, and then select **Sign in**:
   - **Current password**: `Pa55w.rd1234`
   - **New password**: `Pa55w.rd123456`
   - **Confirm password**: `Pa55w.rd123456`

>**Note:** You need to update the password because this is the first time signing in with Patti.

5.  On the **More information required** page, select **Next**.

>**Note:** If you do not get the **More information required** prompt. Close the browser and restart this task by re-signing in as Patti.

6.  On the **Keep your account secure** page, select **I want to set up a different method**.

7.  For the **Choose a different method** prompt, select **Security questions**.

8.  On the **Security questions** page, select and provide an answer for three security questions, and then select **Done**.

9.  On the **Keep your account secure** page, in the **Enter email** box, enter your email address and then select **Next**. Ensure that you have access to this email address from your mobile phone. 

10.  Enter the code that has been sent to your email address, and then select **Next**.

11.  On the Success page, select **Done**.

12.  At the **Stay signed in** prompt, select **No**.

>**Note:** The **My Account** page opens for Patti Fernandez.

### Task 3: Perform a password reset

1.  On the **My Account** page, in the navigation pane, select **Password**.

2.  On the **Change password** page, enter the following information, and then select **Submit**:
   - Current password: **`Pa55w.rd123456`**
   - New password: **`Pa55w.rd1234`**
   - Confirm new password: **`Pa55w.rd1234`**

3.  Close Microsoft Edge.

### Task 4: Reset a forgotten password

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://myaccount.microsoft.com`**, and then select Enter.

3.  On the **Sign in** page, enter **`Patti@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

4.  On the **Enter password** page, select **Forgot my password**.

5.  On the **Get back to your account** page, verify that **`Patti@ddmmyyyourinitialsContoso.onmicrosoft.com`** is listed as the the email or username.

6.  Enter the characters in the picture, and then select **Next**.

7.  On the **verification step 1** page, select **Email my alternate email**, and then select **Email**. 

8.  Enter the code sent to your email address, and then select **Next**.

9.  On the **Answer my security questions** page, answer each security question, and then select **Next**.

10.  On the **Choose a new password page**, enter **`Pa55w.rd1234`** for both the **Enter new password** and **Confirm new password** textboxes, and then select **Finish**.

11.  At the **To sign in with your new password** message, select **click here**.

12.  On the **Sign in** page, enter **`Patti@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

13.  On the **Enter password** page, enter **`Pa55w.rd1234`**, and then select **Sign in**.

14.  On the **Stay signed in** page, select **No**. 

>**Note:** The **My Account** page opens. 

16.  Close Microsoft Edge.

**Results**: After completing this exercise, you should have configured and validated password reset functionality.

## Exercise 3: Enforcing multifactor authentication by using a conditional access policy 

### Scenario

You need to implement MFA for the Human Resources department. You decide to use a conditional access policy to manage MFA.

The main tasks for this exercise are as follows:

1. Configure MFA by using a conditional access policy.
2. Validate MFA.

### Task 1: Configure MFA by using a conditional access policy

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://entra.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  In the navigation menu, expand **Protection**, and then select **Conditional Access**. 

5.  On the **Conditional Access** page, select **Create new policy**.

6.  On the **New Conditional access policy** page, in the **Name** box, enter **`MFA Policy for Office 365 Apps`**.

7.  Under **Assignments**, in the **Users** section, select **0 users and groups selected**.

8.  In the details pane, on the **Include** tab, select the **Select users and groups** option, and then select the **Users and groups** checkbox.

9.  On the **Select users and groups** page, select the **Human Resources** checkbox, and then choose **Select**.

10.  Under **Target resources**, select **No target resources selected**.

11.  Select the **Include** tab, and then choose **Select resources**.

12.  In the **Select** section, select **None**.

13.  In the list of cloud apps, select the **Office 365** checkbox, and then choose **Select**.

14.  Under **Access controls**, in the **Grant** section, select **0 controls selected**.

15.  On the **Grant** page, select **Grant access**, select the **Require multifactor authentication** checkbox, and then choose **Select**.

16.  Under **Enable policy**, select **On**.

17.  Select **Create** to create the MFA Policy. 

>**Note:** The policy is listed with a State of **On**.

18.  Close Microsoft Edge.

### Task 2: Validate MFA

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

3.  On the **Sign in** page, enter **`Patti@ddmmyyyourinitialsContoso.onmicrosoft.com`**.

4.  On the **Enter password** page, enter **`Pa55w.rd1234`**, and then select **Sign in**.

5.  On the **More information required** page, select **Next**.

6.  Continue configuring Microsoft Authenticator on your phone. 

>**Note:** If you do not want to install Microsoft Authenticator, you may end the lab at this point. MFA is now configured for Patti.

7.  Close Microsoft Edge.

**Results**: After completing this exercise, you'll have successfully configured MFA to be enforced for the Human Resources department by using conditional access. 