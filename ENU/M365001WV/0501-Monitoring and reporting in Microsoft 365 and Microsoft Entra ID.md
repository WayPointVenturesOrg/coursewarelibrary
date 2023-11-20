# Lab: Monitoring and reporting in Microsoft 365 and Microsoft Entra ID

## Lab scenario

To assist in monitoring and maintaining your Microsoft 365 tenant, you have several options available within the Microsoft 365 admin center and the Microsoft Entra admin center. This lab introduces you to the tools that you can use to review user adoption to Microsoft 365 services, review the health of online services, and logs that can be used to monitor and troubleshoot activity within your tenant.

>**Note:** This lab requires students to first complete the following:
>
>- Module 1 lab: **Provisioning and configuring a Microsoft 365 tenant** 
>- Module 2 lab: **Managing user, resource, and group objects in Microsoft 365**. 
>
>To assist with your sign-in process, enter your Microsoft 365 sign-in username and password as follows:
>
>- **Microsoft 365 Username:**    __________________________________________________________________
>
>- **Password:** **`Pa55w.rd1234`**

## Exercise 1: Reviewing usage reports and health by using the Microsoft 365 admin portal

### Scenario

You need to provide information that displays the number of users and experiences related to the Microsoft 365 services used in the tenant. You also need to validate the health of Microsoft 365 services and identify if there are any current advisories in place by Microsoft that may impact user productivity.

The main tasks for this exercise are as follows:

1. Review the Microsoft 365 Adoption Score.
2. Review Usage Reports.
3. Review Microsoft 365 Health.
4. Review Help and Support options.

### Task 1: Review the Microsoft 365 Adoption Score

   > **Note:** Depending on when the tenant was created, you may not yet have data for the Adoption Score and Usage Reports. If that is the case, proceed to Task 3.

1. Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2. From the taskbar, select **Microsoft Edge**.

3. In the address bar, enter the following URL and then select Enter: **`https://admin.microsoft.com`**.

4. Sign in as **`Username@mmddyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

   > **Note:** Use the credentials that you provided at the start of this lab.

5. At the **Stay signed in** prompt, select **No**.

   > **Note:** The **Microsoft 365 admin center** opens.

6. Complete and close any notification prompts that might be displayed.

7. In the navigation menu, select **Show all**.

8. In the navigation menu, expand **Reports**, and then select **Adoption Score**.

9. Review the details listed on the **Overview** page of the **Adoption Score**.

   > **Note:** The **Adoption Score** overview page provides statistics related to various workloads such as Microsoft Teams and Microsoft SharePoint. In the lab environment, the adoption score is quite low.

10. In the **Group-level analytics** section, select **Manage in Settings**.

    > **Note:** The focus changes to **Org settings** with the **Adoption Score** settings displayed. Notice that, by default, all users are considered for calculating the **Adoption Score** insights. If required, you could change this to specific users or turn off the calculation.

11. In the **Group data filtering** section, select the check box next to **Turn on group-level insights**, and then select **Save**.

    > **Note:** This will enable you to review insights based upon groups such as departments or locations.

12. In the **Group data filtering** section, select **Manage group-level filtering**.

13. In the **Manage group-level filtering** page, select **Turn on selected filters**.

14. Close the **Manage group-level filtering** page.

15. Close the **Adoption Score** settings page, and then in the navigation menu, under **Reports**, select **Adoption Score**.

16. On the **Adoption Score** page, select the **Actions** tab.

    > **Note:** Review the recommended actions that can be addressed to increase your adoption score.

### Task 2: Review Usage Reports

1. In the Microsoft 365 admin center, on the navigation menu, expand **Reports**, and then select **Usage**.

   > **Note:** The **Usage** page opens to display product reports for various Microsoft 365 services.

2. On the **Usage** page, select **Overview**.

3. Review the details on the **Overview** page.

   > **Note:** The **Overview** page provides insight into active users and activity related to various Microsoft 365 services such as Teams, OneDrive, and SharePoint.

4. Scroll down to the bottom of the **Overview** page, and then in the **Microsoft 365 usage analytics** section, select **Get started**.

5. On the **Reports** page, select the check box next to **Make organizational usage data available to Microsoft 365 usage analytics for Power BI**, and then select **Save**.

6. Refresh the browser window and then return to the bottom of the **Usage** **Overview** page.

   > **Note:** It may take 48 hours to collect usage data for Power BI.

7. On the **Usage** page, under **Product Reports**, select **Exchange**.

8. Review the details for Exchange.

   > **Note:** You can review details related to email activity, email app usage, and mailbox usage.

9. On the **Usage** page, under **Product Reports**, select **Microsoft 365 apps**.

10. Review the details for Microsoft 365 apps.

    > **Note:** You can review details related to activations, usage, and active users.

### Task 3: Review Microsoft 365 Health

1. In the Microsoft 365 admin center, on the navigation menu, expand **Health**, and then select **Dashboard**.

   > **Note:** The Dashboard provides a summary of critical alerts and service health for all primary Microsoft 365 services. Take note of the **Health** column. Services may display as **Healthy** or might display advisories. You can also review a percentage of users that are using a specific service.

2. If there are any advisories reported in the **Health** column, select the advisories link to display additional details on the advisory.

3. On the navigation menu, under **Health**, select **Service heath**.

4. Review the details on the **Service health** page.

   > **Note:** In addition to current service health status, you can review issue history and reported issues by people in your organization within the last 30 days.

5. On the navigation menu, under **Health**, select **Message center**.

6. Review the details on the **Message center** page.

   > **Note:** The message center provides details on planned changes to Microsoft 365 services.

7. On the **Message center** page, select **Preferences**.

8. On the **Preferences** page, select the **Email** tab.

9. Review the details on the **Email** tab and then close the **Preferences** tab.

   > **Note:** By default, the first tenant Global Administrator is listed. You can add additional email addresses as needed for other users to receive weekly email messages related to upcoming changes to the service.

### Task 4: Review Help and Support options

1. In the Microsoft 365 admin center, on the navigation menu, expand **Support**, and then select **Help & support**.

   > **Note:** The **How can we help?** page opens.

2. In the **Example** text box, enter **`How can I add a new user`**, and then select **Search**.

3. In the **View insights** section, review the information, and then clear the search text.

4. In the **Example** text box, enter **`diag: outlook user connectivity`**, and then select **Search**.

   > **Note:** The **diag:** prefix provides additional diagnostic capabilities to run specific tests based upon the problem.

5. In the **Run diagnostics** section, in the **What's the email address of the affected user** box, enter **`User1@mmddyyyourinitialsContoso.onmicrosoft.com`**, and then select **Run Tests**.

   > **Note:** The diagnostic test runs. It may take several minutes to complete.

6. Review the **Results and recommended solution** information.

7. Close the **How can we help** page.

**Results:** After completing this exercise, you'll have reviewed the Microsoft 365 Adoption Score, Usage, Service health, and Help and Support options.

## Exercise 2: Reviewing logs by using the Microsoft Entra admin center

### Scenario

The Microsoft Entra admin center provides additional report and log details related to the activities for all cloud services. In this exercise, you'll review sign-in activity and tasks by using the Sign-in and Audit log information.

The main tasks for this exercise are as follows:

1. Review Sign-in Logs.
2. Review Audit logs.

### Task 1: Review Sign-in Logs

1. In the **Microsoft 365 admin center**, on the navigation menu, under **Admin centers**, select **Identity**. 

   > **Note:** A new tab opens in Microsoft Edge, and displays the **Microsoft Entra admin center**.

2. In the **Microsoft Entra admin center**, expand **Identity**, and then select **Show more**.

3. In the **Identity** section, expand **Monitoring & health**.

4. Under **Monitoring & health**, select **Sign-in logs**.

5. Review the **Sign-in events** details.

   > **Note:** Sign-in events are displayed, by default, for the last 24 hours.

6. Select the **Date: Last 24 hours** filter, and then in the drop-down menu, select **Last 7 days**, and then select **Apply**.

   > **Note:** Sign-in events are shown for the last 7 days. Details may include your sign-in account as well as any user accounts that have signed into your tenant throughout previous labs. Take note that the details include which service portal was signed in, the user's IP address, and whether the sign-in was successful.

7. Select various sign-ins and review the details of the sign-in.

   > **Note:** Review whether the sign-in was a success, and which type of authentication requirement was used. If you chose to select another type of sign-in event (such as Interrupted), review why it was not successful. You can also review the **Location**, **Device info**, and **Authentication Details**.

### Task 2: Review Audit logs

1. In the **Microsoft Entra admin center**, in the **Identity** section, expand **Monitoring & health**.

2. Under **Monitoring & health**, select **Audit logs**.

3. Review the details listed on the **Audit Logs** page.

   > **Note:** Audit logs are shown, by default, for the last 24 hours and relate to all services.

6. Select the **Date range: Last 24 hours** filter, in the drop-down menu, select **Last 7 days**, and then select **Apply**.

   > **Note:** Scroll through the audit log and review the **Service** and **Activity** columns. These should reflect activities that have been performed throughout the duration of the course.

7. Select various audit log entries and review the details of the activity.
8. Close Microsoft Edge.

**Results**: After completing this exercise, you'll have successfully used the Microsoft Entra admin center to review sign-in and audit log details.