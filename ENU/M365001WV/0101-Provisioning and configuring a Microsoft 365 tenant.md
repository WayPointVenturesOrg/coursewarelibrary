# Lab: Provisioning and configuring a Microsoft 365 tenant

## Lab scenario

As part of the proof-of-concept phase, you plan to provision and configure a Microsoft 365 tenant. Your goal for this lab is to provision a new tenant, add additional service subscriptions, and configure organizational settings. You'll also test out the process for installing and configuring integrated apps and Microsoft 365 apps for users.

>**NOTE:** This lab requires students to provision an Office 365 trial tenant. Microsoft requires credit card verification during the trial tenant provisioning. No charges will be applied if recurring billing is disabled and the payment method is removed, as instructed in the lab steps. Students who don't have a credit card can use the Microsoft 365 Developer program to apply for a trial. More details are available at [Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program).

## Exercise 1: Provisioning a Microsoft 365 trial tenant 

### Scenario

To begin the proof-of concept, you must create and prepare your Microsoft 365 tenant. In this exercise, you'll subscribe to and provision an Office 365 E5 trial subscription.

The main task for this exercise is as follows:

- Create a trial Office 365 E5 subscription.

### Task 1: Create a trial Office 365 E5 subscription

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter the following URL and the select Enter: **`https://products.office.com/business/office-365-enterprise-e5-business-software`**

4.  Select the **Try for free** link.

5.  On the **Let's get you started** page, in the **Email** text box, enter an email address in the form of **`mmddyyyourinitials@outlook.com`** (where mmddyy represents the month, day, and year in two digits), and then select **Next**. 

   >**Note:** You'll be directed to create a new account.

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

10.  On the **Quantity and payment** page, verify that the license quantity is set to **1**. 

   >**Note:** Be sure that you note the trial expiration date at the end of the page. You'll not be charged during the trial period. 

12. Select **Add payment method**.

13. On the **Add payment method** page, fill in your personal details and your credit card number. Your credit card will not be charged at this moment. It is used for verification purposes. Select **Save** when you're done.

14. On the **Review and confirm** page, review your details, ensure that you note the date when your trial expires, and then select **Start trial**. 

15. On the **Thanks for choosing Office 365 E5 Trial** page, ensure that you note your username, and then select **Start using Office 365 E5 Trial**.

16. On the **Install Microsoft 365** page, select **Exit setup**. Provide a reason for exiting setup, and then select **Send and exit**.

   >**Note:** The Microsoft 365 admin center opens.

17. In the navigation menu, select **Show all**.

   > **Note:** All options are now displayed on the navigation menu.

18. In the navigation menu, select **Setup**.

   > **Note:** Review the **Setup** page. Notice that it provides a list of recommended tasks to assist with securing sign-in, apps, and email. 

19. In the navigation menu, select **Home** to view the **Home** page.

**Results:** After completing this exercise, you'll have provisioned a Microsoft 365 tenant by using the Office 365 trial subscription.

> **Important:** Be sure to complete **Exercise 2: Task 2: Remove payment method from the Office 365 trial subscription**. Ensure that you follow all steps to disable recurring billing on your subscription and remove your credit card details before the trial expires. Although you'll not be charged until the trial expires, it is recommended that you remove your payment details when performing the lab steps.

## Exercise 2: Adding products and licenses to a Microsoft 365 tenant

### Scenario

Now that you've provisioned a Microsoft 365 tenant, your next step is adding additional licenses and products for additional features and cloud services. For this exercise, you'll add the **Microsoft Entra ID P2** subscription to enable additional management and security services to the tenant.

The main tasks for this exercise are as follows:

1. Add additional cloud services to the tenant.
2. Remove a payment method from the Office 365 trial subscription.


### Task 1: Add additional cloud services to the tenant

1. In the Microsoft 365 admin center, on the navigation menu, expand **Billing**, and then select **Licenses**.

   > **Home:** The **Licenses** page displays the current subscriptions and available licenses for the tenant.

3. On the navigation menu, under **Billing**, select **Purchase services**.

   > **Note:** The **Purchase services** page is where you'll review the products and services that you can add on to your subscription.

4. On the **Purchase services** page, under **view by category**, select **Security and identity**.

5. Under **Microsoft Entra ID P2** , select **Details**.

6. On the **Microsoft Entra ID P2**  page, select **Start free trial**.

7. On the **Check out** page, select **Try now**.

8. On the **order receipt** page, select **Continue**.

   > **Note:** You return to the Microsoft 365 admin center home page.

### Task 2: Remove a payment method from the Office 365 trial subscription

> **Important:** Ensure that you follow all the steps listed in this task to disable recurring billing on your subscription and remove credit card details before the trial expires.

1. In the Microsoft 365 admin center, use the navigation pane to expand **Billing**, and then select **Your products**.

   > **Note:** Both the **Office 365 E5 Trial** and the **Microsoft Entra ID P2**  subscriptions are displayed.

2. Select the **Office 365 E5 Trial** item.

3. On the **Office 365 E5 Trial** page, select **Edit recurring billing**. 

4. On the **Edit recurring billing** page, select **Off**, and then select **Save**.

   >**Note:** By disabling recurring billing, you ensure that your subscription will not automatically renew once the trial expires.

5. In the left navigation pane, select **Payment methods**, and then select your credit card.

6. On the credit card window, select **Delete**.

7. On the **Delete a payment method** page, select **Next**.

8. On the **Review details and delete** page, select **Delete**, and then select **Close**.

   >**Note:** Ensure that your credit card is removed from the **Payment methods** page. This is very important to avoid unwanted charges.

9. Close Microsoft Edge.

**Results**: After completing this exercise, you should have added additional services to the tenant by adding the Microsoft Entra ID P2  Trial subscription.

## Exercise 3: Configuring Org Settings for the Microsoft 365 tenant

### Scenario

You need to customize specific organization profile, security and privacy, and Services Org settings for the tenant. You'll modify the default theme and release preferences for the tenant. You also need to customize the amount of detail that is shared when users share their calendar with people outside of the organization, and remove the ability for users from starting trial subscriptions on behalf of the organization. Finally, you'll configure Customer lockbox, idle session timeout, and Privacy profile settings.

The main tasks for this exercise are as follows:

1. Customize Organization profile settings.
2. Customize Microsoft 365 services.
3. Customize Security & privacy settings.
4. Customize Security Defaults.


### Task 1: Customize Organization profile settings

1. On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2. In the address bar, enter the following URL and then select Enter: **`https://admin.microsoft.com`**.

3. Sign in as **`Username@mmddyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

   > **Note:** Use the credentials that you created in Exercise 1.

4. At the **Stay signed in** prompt, select **No**.

   > **Note:** The Microsoft 365 admin center opens.

5. Complete and close any notification prompts that might be displayed.

6. In the navigation menu, select **Show all**.

   > **Note:** All options are now displayed on the navigation menu.

7. In the navigation menu, expand **Settings**, and then select **Org settings**.

8. On the **Org settings** page, select **Organization profile**.

9. On the **Organization profile** page, select **Custom themes**.

   > **Note:** The **Customize Microsoft 365 for your organization** page displays.

10. Select **Add theme**.

11. On the default theme page, select **Colors**.

12. Next to the navigation bar color, select the colored box and then choose a different color for the navigation bar. When you have selected a color, select **Save**.

13. On the default theme page, select the check box next to **Show the user's display name**, and then select **Save**.

14. Refresh the browser window to display the new color for the navigation bar.

15. On the **Organization profile** page, select **Data location**.

    > **Note:** Take note of each Microsoft 365 service, and where the data is located for each service.

16. Close the **Data location** page.

17. On the **Organization profile** page, select **Organization information**.

    > **Note:** Take note of the organization information. 

18. Close the **Organization information** page.

19. On the **Organization profile** page, select **Release preferences**.

    > **Note:** Release preferences allow you to select who in your organization will get new features and service updates for Microsoft 365. By default, the entire organization will only get updates when Microsoft releases the update to the general public. You can choose to receive early preview updates by selecting  either one of the targeted release options.

20. Select **Targeted release for select users**, and then select **Save**.

21. On the **Release preferences** page, select the **Select users** link.

22. Under **Who should receive targeted releases**, select the text box, and then select your user account. Select **Save**.

23. Close the **Release preferences** page.

### Task 2: Customize Microsoft 365 services

1. On the **Org settings** page, select **Services**.

2. On the **Services** page, select **Calendar**.

   > **Note:** The **Calendar** page opens.

3. On the **Calendar** page, under **External sharing**, select the **Show calendar free/busy information with time only** option, and then select **Save**.

4. Close the **Calendar** page.

5. On the **Services** page, select **Microsoft communication to users**.

   > **Note:** The **Microsoft communication to users** page opens.

6. Remove the check mark next to **Let people in my organization receive emails from Microsoft about how to use Microsoft 365 products**, select **Save**, and then close the **Microsoft communication to users** page.

7. On the **Services** page, select **User owned apps and services**.

   > **Note:** The **User owned apps and services** page opens.

8. Remove the check mark next to **Let users start trials on behalf of your organization**, select **Save**, and then close the **User owned apps and services** page.

### Task 3: Customize Security & privacy settings

1. On the **Org settings** page, select **Security & privacy**.

2. On the **Security & privacy** page, select **Customer lockbox**.

   > **Note:** The **Customer lockbox** page opens.

3. Select the **Require approval for all data requests** option, and then select **Save**.

4. Close the **Customer lockbox** page.

5. On the **Security & privacy** page, select **Idle session timeout**.

   > **Note:** The **Idle session timeout** page opens.

6. Select the **Turn on to set the period of inactivity for users to be signed off of Microsoft 365 web apps** option.

7. Under **When do you want users signed out**, select **6 hours**, and then select **Save**.

8. Close the **Idle session timeout** page.

9. On the **Security & privacy** page, select **Password expiration policy**.

   > **Note:** The **Password expiration policy** page opens. Notice that, by default, **Set passwords to never expire** is selected and is recommended. 

10. Close the **Password expiration policy** page.

11. On the **Security & privacy** page, select **Privacy profile**.

    > **Note:** The **Privacy profile** page opens.

12. On the **Privacy profile** page, configure the following settings, and then select **Save**:

    - **Organization privacy statement**: `https://www.contoso.com/privacy`

    - **Organization privacy contact**: `SecOps@mmddyyyourinitialsContoso.onmicrosoft.com`

13. Close the **Privacy profile** page.

### Task 4: Customize security defaults

1. In the Microsoft 365 admin center, on the navigation menu, select **Show all**.

2. In the navigation menu, under **Admin centers**, select **Identity**.

3. If necessary, at the **Action Required** prompt, select **Ask later**.

   > **Note:** Microsoft Entra admin center opens.

4. On the navigation pane, expand **Identity**, and then select **Overview**.

5. On the **Contoso** page, select **Properties**.

6. Scroll down to the end of the page and select **Manage security defaults**.

7. On the **Security defaults** page, select the drop-down menu, and then select **Disabled**.

8. On the **Reason for disabling** list, select **My organization is using Conditional Access**, and then select **Save**.

9. Select **Disable** to close the **Security defaults** window.

10. Close the Microsoft Entra admin center tab.

    > **Note:** Security Defaults are enabled by default to provide extra security such as multifactor authentication for the tenant. In a production environment, you would only disable this setting if you plan to use Conditional Access policies. 

**Results**: After completing this exercise, you'll have customized Organization profile, Security & privacy, and Services Org settings.

## Exercise 4: Configuring integrated apps and Microsoft 365 app installation options

### Scenario

Microsoft 365 provides options for discovering, purchasing, managing, and deploying apps developed by partners. You can also manage the deployment of Microsoft 365 apps to users. In this exercise, you'll configure integrated apps and Microsoft 365 app installation options.

The main tasks for this exercise are as follows:

1. Configure and deploy Integrated apps.
2. Configure Microsoft 365 apps.
3. Reviewing the Microsoft 365 portal.


### Task 1: Configure and deploy integrated apps

1. In the Microsoft 365 admin center, on the navigation menu, expand **Settings**, and then select **Integrated apps**.

2. On the **Integrated apps** page, select **Available apps**.

   > **Note:** The **Available apps** tab provides a list of apps, which host products relate to each app, and who can install each app.

3. In the **Search** box, enter **Power BI**.

   > **Note:** The list is filtered to only display apps that contain the name **Power BI**.

4. Select **Power BI for Microsoft Teams, Microsoft Outlook and Microsoft Office**.

5. On the **Power BI for Microsoft Teams, Microsoft Outlook and Microsoft Office** page, review the **Overview** page. 

6. On the **Overview** page, under **Actions**, select **Deploy app**.

   > **Note:** The **Deploy New App** dialog box opens.

7. On the **Apps to deploy** page, verify that **Power BI for Microsoft Teams, Microsoft Outlook and Microsoft Office** is listed, and then select **Next**.

8. On the **Add users** page, select **Entire organization**, and then select **Next**.

9. On the **Accept permissions requests** page, select **Accept permissions**. Provide your user credentials, and then select **Next**.

10. On the **Review and finish deployment** page, select **Finish deployment**.

11. On the **Deployment completed** page, select **Done**.

    > **Note:** You return to the **Integrated apps** page, with the **Deployed apps** tab selected. Notice that the Power BI app is now listed as a deployed app.

### Task 2: Configure Microsoft 365 apps

1. In the navigation menu, expand **Settings**, and then select **Org settings**.

2. On the **Org settings** page, on the **Services** tab, select **Microsoft 365 installation options**.

3. On the **Microsoft 365 installation options** page, select the **Feature updates** tab.

   > **Note:** You can select how often users receive updates to Microsoft 365 apps.

4. On the **Feature updates** tab, select **Once a month (Monthly Enterprise Channel)**.

5. Select the **Installation** tab.

6. On the **Installation** page, remove the check boxes next to the following options:

   - **Skype for Business (Standalone)**
   - **Under Apps for Mac: Office**
   - **User Apps for Mac: Skype for Business (X EI Capitan 10.11 or higher)**

   > **Note:** Make sure that under **Apps for Windows and mobile devices**, the only item selected is **Office (includes Skype for Business)**.

7. Select **Save**, and then close the **Microsoft 365 app installation options** page.

8. Close Microsoft Edge.

### Task 3: Reviewing the Microsoft 365 portal

1. On **LON-CL1**, from the taskbar, select to open **Microsoft Edge**.

2. In the address bar, enter the following URL and them select Enter: **`https://portal.office.com`**.

3. Sign in as **`Username@mmddyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

   > **Note:** Use the credentials that you created in Exercise 1.

4. Go through all the Welcome prompts as needed.

5. Complete and close any notification prompts that might be displayed.

6. On the navigation pane, select **Apps**.

   > **Note:** You may get a prompt that a newly added app is added by your admin. The app listed should be Power BI. If you receive this message, select **Got it**.

7. On the navigation pane, select **Home**.

8. Select **Install apps**, and then select **Other install options.**

   > **Note:** The **My account** portal opens. Review each of the options in the navigation list.

9. Select **Apps & devices**.

   > **Note:** Office is available for the user to install. Skype for Business has been turned off. Also notice that there are no options for Mac.

10. On the **Apps & devices** page, select **Install Office**.

11. On the **Downloads** prompt, under **OfficeSetup.exe**, select **Open file**.

12. At the **User Account Control** prompt, select **Yes**.

    > **Note:** Microsoft Office Apps begin to install on LON-CL1. It will take 4-5 minutes to complete.

13. On the **You're all set** page, select **Close**.

14. On **LON-CL1**, select **Start**, and then select **All apps**.  

    > **Note:** Microsoft apps have been installed, including Word, PowerPoint, and Outlook.

15. Close Microsoft Edge.

**Results**: After completing this exercise, you'll have configured Integrated apps and Microsoft 365 app installation options.