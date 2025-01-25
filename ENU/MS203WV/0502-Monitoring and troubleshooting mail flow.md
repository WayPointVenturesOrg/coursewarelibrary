# Lab 5B: Monitoring and troubleshooting Mail flow

## Lab scenario

A vital part of a Messaging Administrator's role is to monitor the Microsoft 365 and Microsoft Exchange Online environments to proactively address service issues. You need to be able to monitor Exchange Online health and identify usage statistics to ensure a healthy and functional email system. Reports and alerts will also help you identify mail flow issues, and provide statistics necessary for managers to make decisions related to additional features and forecasting costs. You also need to understand the tools available to you such as the **Microsoft Remote Connectivity Analyzer** and **Message Trace** for troubleshooting user configuration and mail flow issues.

>**Note:** This lab requires students to have first completed the following labs:
>
>- **Module 1 Lab: Exploring Microsoft 365 and Exchange Online administration portals** 
>
>- **Module 2 Lab A: Creating and managing Exchange Online recipients**.
>
>- **Module 5 Lab A: Managing mail flow for Exchange Online**
>

>**Note:** In order to review report results, it is recommended to perform this lab at least **1 hour** after you complete **Module 5 Lab A: Managing mail flow for Exchange Online**.

>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234
## Exercise 1: Monitoring Exchange Health and Mail Flow

### Scenario

Both the Microsoft 365 admin center and the Exchange admin center provide extensive monitoring and reports for validating Microsoft Exchange health and details about mail flow. In this exercise you will review features used to monitor the health and mail flow for Exchange Online. You will also create an alert policy that will generate an alert when new users forward email messages outside of the organization.

The main tasks for this exercise are as follows:

1. Monitor Exchange Online Health and Usage.
2. Review Mail flow reports from the Exchange admin center.
3. Create Alert policies for email-related events.

### Task 1: Monitor Exchange Online Health and Usage

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

6.  In the Microsoft 365 admin center navigation pane, select **Show all**, and then select **Home**.

7.  At the beginning of the details pane, select the **Dashboard view** drop-down, and then select **Health**.

8.  Review the current service health and usage statistics.

9.  In the navigation pane, expand **Health**, and then select **Service health**.

>**Note:** The **Service health** page details current related issues for all Microsoft 365 services. If there are any advisories for Exchange Online, select their status and review the details. You can also select **Issue history** to review a history of incidents that have been resolved.

10.  In the navigation pane, under **Health**, select **Message center**.

>**Note:** Message center provides details of planned changes for each type of Microsoft 365 service. Review any messages that relate to Exchange Online.

11.  In the navigation pane, expand **Reports**, and then select **Usage**.

12.  On the **Usage** page, select **Exchange**, and then review the details on the **Email activity** page.

>**Note:** There may be no data displayed due to the lab environment and the lack of email activity. However, this is where you can review email activity, app usage, and mailbox usage.

13.  On the **Usage** page, select **Email app usage**, and then review the details on the **Email app usage** page.

14.  On the **Usage** page, select **Mailbox usage**, review the details related to a number of mailboxes, storage, and quota status.

>**Note:** Note that the username is concealed for privacy. You can change this setting to display on the **Org settings** page. To do this, from the **Services** tab, select **Reports**, and then clear the **Display concealed user, group, and site named in all reports** checkbox.

### Task 2: Review Mail flow reports from the Exchange admin center

1.  From the Microsoft 365 admin center navigation pane, under **Admin centers**, select **Exchange**.

2.  In the Exchange admin center, in the navigation pane, select **Home**.

3.  At the beginning of the details pane, select **Add card**.

>**Note:** You can add cards to the Exchange admin center that provide monitoring-related to various aspects of mail flow, such as non-delivery reports, mail-flow issues, and Outbound messages details.

4.  Select the **Non-delivery report,** **Outbound messages details**, and **Mail flow** cards.

5.  Close the **Add cards to your home page** pane.

>**Note:** The cards might not have any details yet as it takes time for the details to display.

6.  On the navigation pane, expand **Reports**, and then select **Mail flow**.

>**Note:** A list of mail flow reports display in the **Mail flow reports** details pane.

7.  From the Mail flow reports page, review the following reports:

   - **Inbound messages report** - Used to monitor inbound messages.
   - **Mail flow map report** - Used to determine mail flow patterns in your organization.
   - **Non-delivery details report** - Used to monitor messages that are not delivered to intended recipients.
   - **Exchange Transport Rule report** - Used to display matches for mail flow rules configured in the organization.

>**Note:** Some reports might not have any details yet, as it takes some time before details are summarized and available in the reports.

### Task 3: Create Alert policies for email-related events

1.  From the Exchange admin center navigation pane, expand **Mail flow**, and then select **Alert policies**.

>**Note:** Notice the default Alert polices that are configured to alert administrators regarding reply-all email storms, messages that have been delayed, and mail flow issues related to priority accounts.

2.  On the **Alert policies** page, select **New alert policy**.

3.  In the **New alert policy** panel, on the **Name your policy** page, enter the following details, and then select **Next**.

   - **Name:** `New user forwarding alert`
   - **Description:** `Alert to identify new users that are forwarding email messages outside of the organization`

4.  On the **Edit settings** page, configure the following details, and then select **Next**:

   - **Severity:** High
   - **Trigger an alert when following insight is generated:** New users forwarding

5.  On the **Recipients** page, configure the following details, and then select **Next**:

   - **Send email notification:** Selected
   - **Email recipients:** `Alex Wilber`
   - **Daily notification limit:** 10

6.  On the **Review and finish** page, select **Create**, and then select **Done**.

7.  On the **Alert policies** page, select the **Refresh** button to display the **New user forwarding alert** policy.

>**Note:** In addition to an email notification, you can use the **Alerts** page in the Exchange admin center to review the recent alerts that have been triggered in your organization.

**Results:** After completing this exercise, you'll have used monitoring and reports to review Exchange Online health and mail flow details and have created an Alert policy.

## Exercise 2: Troubleshooting Exchange Online Mail Flow

### Scenario

You need to identify messages that have remained in the outgoing message queue for an extended amount of time. You also need to use the **Microsoft Remote Connectivity Analyzer** to validate that Alex Wilber has an Exchange Online mailbox and can connect to the mailbox by using Microsoft Outlook. Finally, you will use Message Trace to review messages sent by Alex.

The main tasks for this exercise are as follows:

1. Review Queued messages.
2. Troubleshoot Exchange Online by using the Microsoft Remote Connectivity Analyzer.
3. Monitor and troubleshoot mail flow by using Message Trace.

### Task 1: Review Queued messages

1.  In the Exchange admin center, from the navigation pane, expand **Reports**, and then select **Mail flow**.

2.  On the **Mail flow reports** page, select **Queued messages report**.

>**Note:** The Queued messages report displays messages that have been queued for more than 1 hour. This can provide insight into why specific messages are not being delivered.

3.  Review the details presented on the **Messages queued** panel.

4.  Under **Number of messages queued**, select the link that indicates the number of messages queued.

>**Note:** The link will display how many messages have been queued in the past hour. For example, your link might state **3 messages**. If there are no messages queued, you can continue with the next task.

5.  On the **Message trace search results** page, review all of the **Pending** messages, and then select the first pending message.

6.  When the details pane opens displaying details about the message, review the **Message events** and **More information** drop-down sections.

7.  Close the **Message details** pane.

### Task 2: Troubleshoot Exchange Online by using the Microsoft Remote Connectivity Analyzer

1.  In Microsoft Edge, open a new browser tab.

2.  In the address bar, enter **`http://testconnectivity.microsoft.com`**, and then select Enter.

>**Note:** When the **Microsoft Remote Connectivity Analyzer** page opens, take note of the various connectivity tests available in the navigation area.

3.  Under **Connectivity Tests**, ensure that **Exchange Online** is selected, and then select **Mailbox Provisioning Test**.

4.  On the **Mailbox Provisioning Test** page, enter the following information:

   - **Email address:** **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`**
   - **Source Mailbox Credentials:** Sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 
   - **Enter the characters displayed:** Enter the characters from the verification code, and then select **Verify**.

5.  On the **Mailbox Provisioning Test** page, select the **Notice message** checkbox, and then select **Perform Test**.

>**Note:** The Mailbox Provision Test proceeds. However, it might take a few moments to complete.

6.  On the **Connectivity Test Successful** page, review the **Test Details**.

7.  Expand **Test Steps**, and then review each test step. Expand additional details as needed.

8.  Under **Connectivity Tests**, select **Exchange Online**, and then select **Outlook Connectivity**.

9.  On the **Outlook Connectivity** page, enter the following information:

   - **Email address:** **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`**
   - **Authentication type:** Modern authentication (OAuth)
   - **Modern Authentication (OAuth) Credentials:** Sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 
   - **Autodiscover selection:** Use Autodiscover to detect server settings
   - **Service Selection:** Microsoft 365 (Default)

10.  On the **Outlook Connectivity** page, select the **Notice message** checkbox, and then select **Perform Test**.

>**Note:** The **Outlook Connectivity** test might take a few moments to complete.

11.  On the **Connectivity Test Successful** page, review the **Test Details**.

12.  In the Test Details, Expand **Test Steps**, and then review each test step. Expand additional details as needed.

13.  Close the **Microsoft Remote Connectivity Analyzer** tab.

### Task 3: Monitor and troubleshoot mail flow by using Message Trace

1.  In the Exchange admin center, from the navigation pane, expand **Mail flow**, and then select **Message trace**.

>**Note:** Take note of the default message traces that are pre-configured. 

2.  On the **Message trace** page, select **Start a trace**.

3.  In the **New message trace** panel, in the **New Message trace** pane, enter the following details, and then select **Search**:

   - **Senders:** `Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`

   - **Time range:** Last 7 days

   - **Report type:** Summary report

>**Note:** If you set the Time range to anything over 10 days, an instant online Summary report is not available. Any time range of more than 10 days can only be downloaded as an Enhanced summary report CSV file, or an Extended report CSV file.

4.  On the **Message trace search results** page, review the messages sent by Alex. 

5.  Select a message that has a status of **Pending** or **Failed**.

6.  Review the details of the message, including the **Message events** and **More information** sections, and then close the message panel.

7.  Select a message that has a status of **Delivered**.

8.  Review the details of the message including the Message events and More information sections, and then close the message panel.

9.  Select a message that has a status of **Delivered**, and then select **View message in Explorer**.

>**Note:** The Microsoft Defender portal opens. The **Explorer** page provides additional details about the message.

10.  At the bottom of the page, in the **Subject** column, select the subject of the email message.

11.  In the **Details** pane, review the details of the message, and then close the **Explorer-Microsoft Defender** browser tab.

12.  Close Microsoft Edge.

**Results**: After completing this exercise, you will have performed tasks such as reviewing the message queue, using the Microsoft Remote Connectivity Analyzer, and monitoring and troubleshooting mail flow by using Message Trace.