# Lab 7B: Message lifecycle management using archiving and retention

## Lab scenario

You plan to implement two features to assist with your messaging lifecycle management goals. You decide to implement an In-place archive mailbox for users, to minimize the size of each user's primary mailbox and  ensure that emails older than two years will automatically move to the Archive mailbox. You also decide to implement Microsoft 365 retention labels and publish the labels to Exchange mailboxes. These labels will enable users to set retention settings for specific email messages as needed.

>**Note:** This lab requires students to first complete the **Module 1 lab: Exploring Microsoft 365 and Exchange Online administration portals**, and **Module 2, lab A: Creating and managing Exchange Online recipients**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234
## Exercise 1: Enabling In-place archive for user mailboxes

### Scenario

You are considering enabling In-place archive for user mailboxes in your organization. To test out the feature, you will first enable in-place archive for Adele Vance. You will also validate the default MRM retention policy settings to ensure that email messages are automatically moved to the archive mailbox after a specific amount of time.

The main tasks for this exercise are as follows:

1. Validate default MRM retention policy settings.
2. Enable In-Place archive.
3. Validate In-place archive and MRM retention settings.

### Task 1: Validate default MRM retention policy settings

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://purview.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Purview portal opens.

6.  Complete and close any notification prompts that might display.

7.  In the navigation pane, select **Solutions**, select **Data lifecycle Management**.

8.  Expand **Exchange (legacy)**, and then select **MRM Retention tags**.

>**Note:** Take note of the default MRM Retention tags. Notice the **Default 2 year move to archive** tag. This is a Default tag that's assigned to every user's mailbox. If the user has an in-place archive mailbox, this tag takes effect. By default, users are not enabled for in-place archive, and will not have items automatically archived until the setting is enabled.

9.  Expand **Exchange (legacy)**, and then select **MRM Retention policies**.

>**Note:** The **Default MRM Policy** contains all of the MRM Retention tags, and is by default, published to all users in the tenant.

### Task 2: Enable In-Place archive

1.  In the Microsoft Edge address bar, open a new tab, and then in the address bar, enter **`https://admin.exchange.microsoft.com`**.

>**Note:** The **Exchange admin center** opens.

2.  Complete and close any notification prompts that might display.

3.  In the navigation pane, expand **Recipients**, and then select **Mailboxes**.

4.  On the **Manage mailboxes** page, select **Adele Vance**.

5.  In the **Adele Vance User mailbox** panel, select the **Others** tab.

6.  In the **Mailbox archive** section, select **Manage mailbox archive**.

7.  On the **Manage mailbox archive** panel, enable the **Mailbox archive status** toggle, and then select **Save**.

8.  Select the **Back** button to return to the **Adele Vance User mailbox** panel.

9.  Select the **Mailbox** tab.

>**Note:** Take note of the assigned **Retention policy**. By default, the **Default MRM Policy** is assigned to all users. Among other settings, the default policy is set, by default, to move items to the Archive after two years if the user has an Archive mailbox.

10.  Close the **Adele Vance User mailbox** panel.

11.  On the **Manage mailboxes** page, select **Refresh**.

>**Note:** Notice the Archive status column for Adele Vance is set to **Active**.

12.  Close Microsoft Edge.

### Task 3: Validate In-place archive and MRM retention settings

1.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`** and then select Enter.

3.  Sign in as **`Adele@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

5.  In the Outlook Inbox navigation pane, notice the **In-Place Archive - Adele Vance** archive mailbox.

>**Note:** You might notice the **Archive** folder in the **Folders** section, and the **In-Place Archive** that was just created. The **Archive** folder is just a standard folder that resides in the user's primary mailbox. Moving email messages to the **Archive** folder doesn't reduce the size of the primary mailbox. However, moving email messages to the **In-Place Archive** will reduce the size of the primary mailbox because the **In-Place Archive** is a secondary mailbox for the user.

6.  Right-click the **In-Place Archive - Adele Vance** archive mailbox, select **Create new folder**, enter **`Archive Inbox`** and then select **Save**.

7.  In Outlook, select **Settings**.

8.  On the **Settings** page, ensure that **Mail** is selected, and then select **Retention policies**.

9.  On the **Retention policies** page, select **Add new policy**, select the checkbox for all policies, and then select **Save**.

10.  Close the **Settings** page.

11.  In the navigation menu, under **Folders**, select **Inbox**, and then select an email message.

12.  In the menu bar, select **Assign policy**.

>**Note:** Notice the Archive policies and the Retention label policies listed. These are the MRM retention policies selected in the previous task.

13.  Select the **Personal 1 year move to archive** policy.

>**Note:** The email message is now labeled with the archive policy and will be moved to the in-place archive after 1 year.

14.  To manually move an email message to the in-place archive, right-click or select the context menu for an email message, point to **Move**, and then select **In-Place Archive - Adele Vance**.

15.  In the **Move** menu, select **Archive Inbox**.

>**Note:** The email message is moved to the **In-Place Archive - Adele Vance** archive inbox.

16.  Close Microsoft Edge.

**Results:** After completing this exercise, you'll have enabled and validated In-place archive and retention for user mailboxes.

## Exercise 2: Configuring and publishing Microsoft 365 Retention labels

### Scenario

To improve data lifecycle management in your organization, you decide to implement Microsoft 365 retention. You need to ensure that users have the ability to label email messages with one of three retention labels. The first retention label will be configured to retain items for 1 year and then delete. The second retention label will be configured to retain items for 5 years and then delete. You will also configure a label to never delete an item automatically. After creating the retention labels, you will then publish the labels to the Exchange mailboxes by using a Label policy.

The main tasks for this exercise are as follows:

1. Create Microsoft 365 retention labels.
2. Publish Microsoft 365 retention labels.

### Task 1: Create Microsoft 365 retention labels

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://purview.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Purview portal opens.

5.  Complete and close any notification prompts that might display.

6.  In the Microsoft Purview portal, in the navigation pane, select **Solutions**, select **Data lifecycle management**, and then select **Retention labels**.

7.  On the **Labels** page, select **Create a label**.

8.  In the **Create retention label** wizard, on the **Name** page, enter the following details, and then select **Next**:

    - **Name:** `1 year then delete`
    - **Description for users:** `Retains an item for 1 year from creation and then automatically deletes.`
    - **Description for admins:** `Retains an item for 1 year from creation and then automatically deletes.`

9.  On the **Label settings** page, select **Enforce actions after a specific period**, and then select **Next**.

10.  On the **Period** page, enter the following details, and then select **Next**:

     - **How long is the period:** Custom 
       - Configure for 1 year
     - **When should the period begin:** When items were created

11.  On the **Setting after period** page, select **Delete items automatically**, and then select **Next**.

12.  On the **Finish** page, select **Create label**.

13.  On the **Your retention label is created** page, select **Do Nothing**, and then select **Done**.

>**Note:** You will create a policy in a later step to publish the label to users.

14.  On the **Labels** tab, select **Create a label**.

15.  In the **Create retention label** wizard, on the **Name** page, enter the following details, and then select **Next**:

     - **Name:** `5 years then delete`
     - **Description for users:** `Retains an item for 5 years from creation and then automatically deletes.`
     - **Description for admins:** `Retains an item for 5 years from creation and then automatically deletes.`

16.  On the **Label settings** page, select **Enforce actions after a specific period**, and then select **Next**.

17.  On the **Period** page, enter the following details, and then select **Next**:

     - **How long is the period:** 5 years
     - **When should the period begin:** When items were created

18.  On the **Setting after period** page, select **Delete items automatically** and then select **Next**.

19.  On the **Finish** page, select **Create label**.

20.  On the **Your retention label is created** page, select **Do Nothing**, and then select **Done**.

>**Note:** You will create a policy in a later step to apply publish the label to users.

21.  On the **Labels** tab, select **Create a label**.

22.  In the **Create retention label** wizard, on the **Name** page, enter the following details, and then select **Next**:

     - **Name:** `Never delete`
     - **Description for users:** `Tag an item to never automatically delete`
     - **Description for admins:** `Tag an item to never automatically delete`

23.  On the **Label settings** page, select **Retain items forever or for a specific period**, and then select **Next**.

24.  On the **Period** page, enter the following setting, and then select **Next**:

     - **Retain item for:** Forever

25.  On the **Finish** page, select **Create label**.

26.  On the **Your retention label is created** page, select **Do Nothing**, and then select **Done**.

>**Note:** You will create a policy in a later step to apply publish the label to users.

### Task 2: Publish Microsoft 365 retention labels

1.  On the **Data lifecycle management** page, expand **Policies**, and then select **Label policies**.

2.  On the **Label policies** page, select **Publish labels**.

3.  On the **Choose labels to publish** page, select **Choose labels to publish**.

4.  On the **Choose labels to publish** panel, select the checkboxes for the following retention labels, and then select **Add**:

    - 1 year then delete

    - 5 years then delete

    - Never delete

5.  On the **Choose labels to publish** page, select **Next**.

6.  On the **Administrative Units** page, select **Next**.

7.  On the **Scope** page, select **Static**, and then select **Next**.

8.  On the **Publish to users and groups** page, select **Let me choose specific locations**.

9.  On the **Publish to users and groups** page, disable all toggle switches except for **Exchange mailboxes**, and then select **Next**.

10.  On the **Name your policy** page, enter the following details, and then select **Next**:

       - **Name:** `Contoso retention policy`

       - **Description:** `User Retention Policies`

11.  On the **Finish** page, review the settings, select **Submit**, and then select **Done**.

>**Note:** Take note of the message that states that labels will become active within a week and that labels will display only for mailboxes that have at least 10 megabytes (MB) of data.

12.  Close Microsoft Edge.

**Results**: After completing this exercise, you will have configured and published Microsoft 365 retention labels.