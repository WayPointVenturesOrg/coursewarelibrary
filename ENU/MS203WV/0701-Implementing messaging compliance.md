# Lab 7A: Implementing Messaging Compliance

## Lab scenario

To improve message compliance in your organization, you plan to implement message classification and protection by using Sensitivity Labels. You also need to ensure that any emails that contain a Contoso product code is protected and reviewed as per your data loss prevention standards. Finally, you have been asked to perform an eDiscovery hold and search on a user mailbox.

>**Note:** This lab requires students  to first complete the following labs:
>
>- **Module 1 Lab: Exploring Microsoft 365 and Exchange Online administration portals**
>- **Module 2, Lab A: Creating and managing Exchange Online recipients**
>- **Module 5 lab A: Managing mail flow for Exchange Online**
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
- **Password:** Pa55w.rd1234
## Exercise 1: Protecting and Classifying Exchange Messages by using Sensitivity Labels

### Scenario

You need to create a custom Sensitivity label for the Project X team members to use. The label will be assigned a label policy and used for files, email, and documents. The label must add a watermark that states **Project X Draft**, and a footer that states **Project X Confidential**.

The main tasks for this exercise are as follows:

1. Create a Sensitivity label.
2. Publish sensitivity labels with a Label policy.

### Task 1: Create a Sensitivity label

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

6.  Complete and close any notification prompts that might display.

7.  In the navigation menu, select **Show all**.

>**Note:** All options now display in the navigation menu.

8.  In the navigation menu, under **Admin centers**, select **Compliance**.

>**Note:** The Microsoft Purview portal opens in a new browser tab. If prompted, switch to the new portal or wait to be automatically directed to the new portal.

9.  At the **Welcome to the new Microsoft Purview portal**, select the check box next to **I agree to the terms of data flow  disclosure, and Privacy Statements**, and then select **Get Started**.

10.  In the navigation pane, select **Solutions**, select **Information protection**, and then select **Sensitivity labels**.

11.  On the **Sensitivity labels** page, select  **Create a label**.

12.  In the **New sensitivity label** wizard, on the **Label details** page, enter the following details, and then select **Next**:

   - **Name:** `Contoso Project X Label`
   - **Display name:** `Contoso Project X` 
   - **Description for users:** `Apply this label to assign a watermark with Project X Draft, and a footer with Project X Confidential.`
   - **Label color:** Select a color of your choice.

13.  On the **Scope** page, verify that **Files and other data assets** and **Emails** are both selected. Remove the check mark next to **Meetings**, and then select **Next**.

14.  On the **Items** page, select **Apply content marking**, and then select **Next**.

15.  On the **Content marking** page, enable the **Content marking** toggle switch.

16.  Select the **Add a watermark** checkbox, and then select **Customize text**.

17.  In the **Customize watermark text** panel, in the **Watermark text** field, enter **`Project X Draft`**, and then select **Save**.

18.  Verify that the **Add a footer** checkbox is selected, and then after **Add a footer**, select **Customize text**.

19.  In the **Customize footer text** panel, in the **Footer text** field, enter **`Project X Confidential`**, and then select **Save**.

20.  On the **Content marking** page, select **Next**.

21.  On the **Auto-labeling for files and emails** page, select **Next**. 

22.  On the **Groups & sites** page, select **Next**.

23.  On the **Finish** page, review the details, and then select **Create label**.

24.  On the **Your sensitivity label was created** page, select **Don't create a policy yet,** and then select **Done**.

>**Note:** When you are returned to the **Labels** page, notice that the **Contoso Project X** label is displayed. In the next task, you will create a label policy to deploy the label.

### Task 2: Publish sensitivity labels with a label policy

1.  In the Microsoft Purview portal, in the **Information Protection** navigation pane, expand **Policies**, and then select **Publishing policies**.

2.  On the **Label policies** page, select **Publish label**.

3.  In the **Create policy** wizard, on the **Labels to publish** page, select **Choose sensitivity labels to publish**.

4.  In the **Sensitivity labels to publish** panel, select the **Contoso Project X** checkbox, select **Add**, and then select **Next**.

5.  On the **Admin units** page, select **Next**.

6.  On the **Users and groups** page, verify that **All users & groups** is selected, and then select **Next**.

7.  On the **Settings** page, leave the default settings, and then select **Next**.

8.  On the **Documents** page, select **Next**.

9.  On the **Emails** page, select **Next**.

10.  On the **Meetings** page, select **Next**.

11.  On the **Fabric and Power BI** page, select **Next**.

12.  On the **Name** page, enter the following setting, and then select **Next**:

    - **Name:** `Contoso Project X Label Policy`

13.  On the **Finish** page, review the details, and then select **Submit**.

14.  On the **New policy created** page, select **Done**.

>**Note:** It can take up to 24 hours to publish the label to user's apps.

15.  Close Microsoft Edge.

**Results:** After completing this exercise, you'll have created Sensitivity label and published the label using a Label policy.

## Exercise 2: Configuring Data Loss Prevention Policies

### Scenario

You have been made aware that many users are sending external recipients email messages containing confidential product codes. You need to ensure that when an email message containing a product code in the form of *ProdCodexxxx* (where *x* is any digit) is sent to an external recipient, the message gets forwarded to Lee Wu for approval. 

You decide to use Microsoft Purview and create a sensitive info type to detect the product code. You will then use the sensitive info type in a Data Loss Prevention policy to address the requirements.

The main tasks for this exercise are as follows:

1. Create a Sensitive info type.
2. Create a Microsoft Purview Data Loss Prevention (DLP) Policy.

### Task 1: Create a Sensitive info type

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://purview.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Purview portal opens.

5.  Complete and close any notification prompts that might display.

6.  In the Microsoft Purview portal, in the navigation pane, select **Solutions**, select **Communication Compliance**.

7.  Expand **Classifiers**, and then select **Sensitive info types**.

8.  On the **Sensitive info types** page, select **Create sensitive info type**.

9.  In the **Create sensitive info type** wizard, on the **Name** page, enter the following details, and then select **Next**:

   - **Name:** `Contoso Product Code`
   - **Description:** `Sensitive info type used to detect Contoso product codes.`

10.  On the **Patterns** page, select **Create pattern**.

11.  In the **New pattern** panel, in the **Confidence level** section, verify that **High confidence** is selected.

12.  In the **Primary element** section, select **Add primary element**, and then select **Regular expression**.

13.  In the **Add a regular expression** panel, in the **ID** field, enter **`Product Code`**.

14.  In the **Regular expression** field, enter **`/ContID\d\d\d\d/gm`**, and ensure that **String match** is selected.

15.  On the **Add a regular expression** panel, select **Done**.

>**Note:** You return to the **New pattern** panel. 

16.  In the **New pattern** panel, in the **Character proximity** section, select the **Anywhere in the document** checkbox, and then select **Create**.

17.  On the **Patterns** page, select **Next**.

18.  On the **Recommended confidence level** page, ensure that **High confidence level** is selected, and then select **Next**.

19.  On the **Finish** page, select **Create**, and then select **Done**.

>**Note:** The **Contoso Product Code** sensitive info type is now included in the list.

### Task 2: Create a Microsoft Purview Data Loss Prevention (DLP) Policy

1.  In the Microsoft Purview portal, in the navigation pane, select **Solutions**, select **Data Loss Prevention**, and then select **Policies**.

2.  On the **Policies** page, select **Create policy**.

3.  In the **Create policy** wizard, on the **Template or custom policy** page, under **Categories**, select **Custom**.

4.  Under **Regulations**, select **Custom policy**, and then select **Next**.

5.  On the **Name** page, enter the following details, and then select **Next**:

   - **Name:** `Contoso Product Code Detection policy`
   - **Description:** `Policy used to detect Contoso product codes.`

6.  On the **Admin units** page, select **Next**.

7.  On the **Locations** page, clear the checkbox for each location except for **Exchange email**, and then select **Next**.

>**Note:** Make sure that only **Exchange email** is selected. All other locations should be cleared.

8.  On the **Policy settings** page, ensure that **Create or customize advanced DLP rules** is selected, and then select **Next**.

9.  On the **Advanced DLP rules** page, select **Create rule**.

10.  On the **Create rule** page, enter the following details:

       - **Name:** `Contoso product rule`

       - **Description:** `Rule used to detect Contoso product codes.`

11.  On the **Create rule** page, under **Conditions**, select **Add condition**, and then select **Content contains**.

12.  In the **Content contains** section, select **Add**, and then select **Sensitive info types**.

13.  In the **Sensitive info types** panel, select the **Contoso Product Code** checkbox, and then select **Add**.

14.  Under **Conditions**, select **Add condition**, and then select **Content is shared from Microsoft 365**.

15.  In the **Content is shared from Microsoft 365** section, select the drop-down menu, and then select **with people outside of my organization**.

16.  On the **Create rule** page, under **Actions**, select **Add an action**, and then select **Forward the message for approval to specific approvers**.

17.  In the **Forward the message for approval to specific approvers** section, select **Add or remove people**.

18.  In the **Add or remove people** panel, select **Lee Gu**, and then select **Add**.

19.  Review the remainder of the **Create rule** default settings, and then select **Save**.

>**Note:** The **Contoso Product rule** is listed on the Advanced DLP rules page.

20.  On the **Advanced DLP rules** page, select **Next**.

21.  On the **Policy mode** page, select **Turn the policy on immediately**, and then select **Next**.

22.  On the **Finish** page, review the settings, select **Submit**, and then select **Done**.

**Results**: After completing this exercise, you will have configured a sensitive info type, and then configure a DLP policy that references the sensitive info type.

## Exercise 3: Creating and managing an eDiscovery case

### Scenario

You have been asked to create an eDiscovery case and place a hold on Alex Wilber's Microsoft Exchange mailbox. Joni Sherman will also need permission to create eDiscovery cases for investigation. You need to assign eDiscovery permissions to ensure that Joni can create and manage only their own eDiscovery cases. You also need to ensure that you have access to and can manage all eDiscovery cases created in the tenant.

You will then place an eDiscovery hold, and perform a search on Alex Wilber's Exchange mailbox for any content related to the words *Project Status*.

The main tasks for this exercise are as follows:

1. Assign eDiscovery permissions.
2. Perform an eDiscovery Hold.
3. Perform an eDiscovery Search.

### Task 1: Assign eDiscovery permissions

1.  In the Microsoft Purview portal, in the navigation pane, select **Settings**, expand **Roles and scopes**, and then select **Role groups**.

2.  On the **Role groups for Microsoft Purview solutions** page, select **eDiscovery Manager**.

3.  In the **eDiscovery Manager** panel, select **Edit**.

4.  On the **Manage eDiscovery Manager** page, select **Choose users**.

5.  On the **Choose users** page, select the **Joni Sherman** checkbox, select **Select**, and then select **Next**.

6.  On the **Manage eDiscovery Administrator** page, select **Choose users**.

7.  On the **Choose users** page, select the check box next to your username, choose **Select**, and then select **Next**.

>**Note:** Joni can only access and manage the cases she creates. She can't access or manage cases created by other eDiscovery Managers. You have permission for all eDiscovery cases created by any eDiscovery Manager.

8.  On the **Review and finish** page, select **Save**, and then select **Done**.

9.  Close Microsoft Edge.

>**Note:** You will re-sign in to the Microsoft Purview portal to ensure you have updated eDiscovery permissions.

### Task 2: Perform an eDiscovery Hold

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://purview.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Purview portal opens.

5.  Complete and close any notification prompts that might display.

6.  In the Microsoft Purview portal, in the navigation pane, select **Solutions**, select **eDiscovery**, and then select **Standard Cases**.

7.  On the **eDiscovery (Standard)** page, select **Create a case**.

8.  On the **New case** panel, enter the following details, and then select **Save**:

   - **Name:** `Alex Wilber eDiscovery`
   - **Description:** `eDiscovery and hold for Alex Wilber`

9.  On the **eDiscovery (Standard)** page, select **Alex Wilber eDiscovery**.

10.  On the **Alex Wilber eDiscovery** page, select the **Hold** tab.

11.  On the **Hold** tab, select **Create**.

12.  In the **New Hold** wizard, on the **Name your hold** page, enter the following details, and then select **Next**:

   - **Name:** `Alex Wilber Hold`
   - **Description:** `Hold for Alex Wilber`

13.  On the **Choose locations** page, enable the toggle for **Exchange mailboxes**.

14.  Next to **Exchange mailboxes**, select **Choose users, groups, or teams**.

15.  On the **Exchange mailboxes** panel, select **Alex Wilber**, and then select **Done**.

16.  On the **Choose locations** page, select **Next**.

17.  On the **Query** page, select **Next**.

18.  On the **Review your settings** page, select **Submit**, and then select **Done**.

### Task 3: Perform an eDiscovery Search

1.  In the Microsoft Purview portal, on the **Alex Wilber eDiscovery** page, select the **Searches** tab.

2.  On the **Searches** tab, select **New search**.

3.  In the **New search** wizard, on the **Name and description** page, enter the following details, and then select **Next**:

   - **Name:** `Alex Wilber Search`
   - **Description:** `Search for Alex Wilber`

4.  On the **Locations** page, enable the toggle switch for **Exchange mailboxes**.

5.  Next to **Exchange mailboxes**, select **Choose users, groups, or teams**.

6.  On the **Exchange mailboxes** panel, select **Alex Wilber**, and then select **Done**.

7.  On the **Locations** page, clear the **Add App Content for On-Premises Users** checkbox, and then select **Next**.

8.  On the **Conditions** page, ensure that **Query builder** is selected. In the **Keywords** field, enter **`Project Status`**, and then select **Next**.

9.  On the **Review your search** page, select **Submit**, and then select **Done**.

    >**Note:** Take note of the **Status** column, which initially indicates **Starting**. Refresh the page until the Status is listed as **Completed**.

10.  Select the **Alex Wilber** search, and then review **Summary** and **Search statistics**.

11.  Select **Review sample** and then review the contents for the **Project Status** email message.

    >**Note:** It might take a few minutes for the sample to display.

12.  On the **Alex Wilber Search samples** page, select the **Back** button.

13.  Select the **Actions** button, and then review the actions that can be performed. 

14.  Select **Close**, and then close Microsoft Edge.

**Results**: After completing this exercise, you will have managed eDiscovery by modifying permissions, creating a hold, and creating an eDiscovery search.
