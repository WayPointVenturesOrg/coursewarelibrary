# Lab B: Troubleshoot Group Policy infrastructure

## Lab scenario

After configuring GPO settings for the Research department and kiosk computers in the conference room, you need to ensure that all settings apply as intended. You'll do this by creating Resultant Set of Policy (RSoP) reports from both **Group Policy Management Console** and a Windows client. You don't have access to a kiosk in the conference room, so you have to simulate how settings will apply by using Group Policy modeling analyses. You'll also identify the Group Policy-related events stored in Event Viewer to assist with troubleshooting.

You also receive a help-desk ticket that a user has opened. The issue is that the applied screen-saver configuration isn't the correct settings for the user. You have to investigate the issue and make sure that the correct settings apply to the user.

## Exercise 1: Verify GPO application

### Scenario

After configuring GPO settings for the Research department and computers in the conference rooms, to make sure that all settings apply as intended, you need to create RSoP reports from both **Group Policy Management Console** and a Windows client. You don't have access to a kiosk in the conference room, so you have to simulate how settings will apply by using Group Policy modeling analyses. You'll also identify the Group Policy-related events stored in Event Viewer to assist with troubleshooting.

The main tasks for this exercise are as follows:

1. Perform RSoP analysis.

2. Analyze RSoP with GPResult.

3. Evaluate GPO results by using Group Policy Modeling Wizard.

4. Review policy events.

### Task 1: Perform RSoP analysis

1.  Switch to **LON-CL1**, and sign in as **`Contoso\Susan`** with the password of **`Pa55w.rd`**.

2.  Select **Start**, enter **cmd**, and then select Enter.

    >Note: The command prompt opens.

3.  At the command prompt, enter the following command, and then select Enter:

   ```
gpupdate /force
   ```

4.  Wait for the command to complete. Make a note of the current system time, which you'll need to know for a task later in this lab. To record the system time, enter the following command, and then select Enter twice:

   ```
Time
   ```

5.  Restart **LON-CL1**. 

>Note: Wait for **LON-CL1** to restart before proceeding with the next task. Don't sign in to **LON-CL1**.

6.  Switch to **LON-DC1**.

7.  Sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**. 

8.  From Server Manager, open the **Group Policy Management** console.

9.  In **Group Policy Management**, in the navigation pane, expand **Forest: Contoso.com**, and then select **Group Policy Results**.

10.  Right-click or access the context menu for **Group Policy Results**, and then select **Group Policy Results Wizard**.

11.  On the **Welcome to the Group Policy Results Wizard** page, select **Next**.

12.  On the **Computer Selection** page, select the **Another computer** option, enter **`LON-CL1`**, and then select **Next**.

13.  On the **User Selection** page, Select **Contoso\Susan**, and then select **Next**.

14.  On the **Summary of Selections** page, review your settings, and then select **Next**.

15.  Select **Finish**. 

    >Note: The RSoP report appears in the details pane of **Group Policy Management Console**.

16.  Review the summary results. For both the user and the computer configuration, identify the time of the last policy refresh and the list of allowed and denied GPOs. Identify the components that were used to process policy settings.

17.  Select the **Details** tab. Review the settings that were applied during user and computer policy application, and then identify the GPO from which the settings were obtained.

18.  Select the **Policy Events** tab, and then locate the event that logs the policy refresh that you triggered with the **gpupdate** command.

19.  Select the **Summary** tab, right-click or access the context menu for an empty space on the page, and then select **Save Report**. 

20.  In the navigation pane, select **Desktop**, and then select **Save**.

21.  On the LON-DC1 desktop, right-click or access the context menu for **Susan on LON-CL1.htm**, and then select **Open**.

22.  When you have examined the report, close **Microsoft Edge**.

### Task 2: Analyze RSoP with GPResult

1.  Switch to **LON-CL1**.

2.  Sign in to **LON-CL1** as **`Contoso\Susan`** with the password of **`Pa55w.rd`**.

3.  Select **Start**, enter **cmd**, and then select **Command Prompt**.

4.  At the command prompt, enter the following command, and then select Enter:

   ```
   gpresult /r 
   ```

>Note: RSoP summary results are displayed. Notice that the information is very similar to the **Summary** tab of the RSoP report that was produced by **Group Policy Results Wizard**.

5.  At the command prompt, enter the following command, and then select Enter:

   ```
gpresult /v | more
   ```

6.  Select the spacebar to proceed through the report. 

>Note: Notice that many of the Group Policy settings that were applied by the client are listed in this report. 

7.  At the command prompt, enter the following command, and then select Enter:

   ```
gpresult /z | more
   ```

8.  Select the spacebar to proceed through the report. 

>Note: This is the most detailed RSoP report.

9.  At the command prompt, enter the following command, and then select Enter:

   ```
   gpresult /h %userprofile%\Desktop\RSOP.html
   ```

>Note: An RSoP report is saved as an HTML file to your desktop. 

10.  Open the saved RSoP report from your desktop. 

>Note: Compare the report, its information, and its formatting with the RSoP report that you saved in the previous task.

11.  Sign out of **LON-CL1**.

### Task 3: Evaluate GPO results by using Group Policy Modeling Wizard

1.  Switch to **LON-DC1**.

2.  On **LON-DC1**, in **Group Policy Management** console, in the navigation pane, select **Group Policy Modeling**.

3.  Right-click or access the context menu for **Group Policy Modeling**, and then select **Group Policy Modeling Wizard**.

4.  In the **Group Policy Modeling Wizard**, select **Next**.

5.  On the **Domain Controller Selection** page, select **Next**.

6.  On the **User and Computer Selection** page, in the **User information** section, select the **User** option, and then select **Browse**. In the **Select User** dialog box enter **`Susan`**, and then select Enter.

7.  In the **Computer information** section, select the **Computer** option, and then select **Browse**. In the **Select Computer** dialog box, enter **`LON-CL1`**, and then select Enter.

8.  In the **Group Policy Modeling Wizard**, select **Next**.

9.  On the **Advanced Simulation Options** page, select the **Loopback Processing** check box, and then select the **Merge** option. 

>Note: Even though the **Conference Room Settings** GPO specifies loopback processing, you must instruct **Group Policy Modeling Wizard** to consider loopback processing in its simulation. 

10.  Select **Next**.

11.  On the **Alternate Active Directory Paths** page, next to **Computer location**, Select **Browse**.

12.  In the **Choose Computer Container** dialog box, expand **Contoso**, expand **Kiosks**, and then select **Conference Room**. You are simulating the effect of **LON-CL1** as a conference room kiosk computer. Select **OK**, and then select **Next**.

13.  On the **User Security Groups** page, select **Next**.

14.  On the **Computer Security Groups** page, select **Next**.

15.  On the **WMI Filters for Users** page, select **Next**.

16.  On the **WMI Filters for Computers** page, select **Next**.

17.  Review your settings on the **Summary of Selections** page, select **Next**, and then select **Finish**.

18.  In the details pane, select the **Details** tab, if necessary expand **User Details**, expand **Group Policy Objects**, and then expand **Applied GPOs**.

19.  Verify if the **Conference Room Settings** GPO applies to Susan as a User policy when she signs in to **LON-CL1**, if **LON-CL1** is in the **Conference Rooms** OU.

20.  Scroll to, and if necessary expand, **User Details**, expand **Settings**, expand **Policies**, expand **Administrative Templates**, and then expand **Control Panel/Personalization**.

>Note: Confirm that the screen-saver timeout is 7,200 seconds (2 hours), which is the setting configured by the **Conference Room Settings** GPO that overrides the 10-minute standard configured by the **Contoso Standards** GPO.

21.  Close all open windows on **LON-DC1**.

### Task 4: Review policy events

1.  Switch to **LON-CL1**. 

2.  Sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

3.  Right-click or access the context menu for **Start**, and then select **Event Viewer**. 

4.  In the navigation pane, expand **Windows Logs**, and then select the **System** log.

5.  Select the **Source** column header to sort the **System** log by source.

6.  Locate event **1502** or **1503** with **Group Policy** as the source. 

>Note: Review the information that is associated with Group Policy events.

7.  In the navigation pane, expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand **Group Policy**, and then select **Operational**. 

8.  Locate the first event related to the Group Policy refresh that you initiated in the first exercise with the **gpupdate** command. Review that event and the events that followed it.

9.  Sign out of **LON-CL1**.

**Results:** After completing this exercise, you'll have used the RSoP tools successfully to verify the correct application of your GPOs, examined Group Policy events, and verified the health of the Group Policy infrastructure.

## Exercise 2: Troubleshooting GPOs

### Scenario

A user has opened a helpdesk ticket because the screen saver settings don't apply as intended. You have to investigate the issue and make sure that the correct settings apply to the user.

You must resolve the reported GPO application problem that Tier 1 helpdesk staff couldn't resolve.

| **Incident Record**                                          |
| ------------------------------------------------------------ |
| **Incident Reference Number:** 604531                        |
| **Date of Call:** July 15                                    |
| **User:** Susan Kemp                                         |
| **Incident Details**:  A user reports that the Research configuration doesn't apply anymore. |
| **Additional  Information:**  A user reports that suddenly she has a fixed time of 10 minutes before her screen saver activates. Because of an application that the Research department uses, she is unable to complete her work. |
| **Plan  of Action:**                                         |
| **Resolution:**                                              |

The main tasks for this exercise are as follows:

1. Read the help desk Incident Record and simulate the problem.

2. Determine the Plan of Action.

3. Troubleshoot and resolve the problem.

### Task 1: Read the helpdesk Incident Record and simulate the problem

1.  Read helpdesk **Incident Record 604531** in the exercise scenario.

2.  On **LON-DC1**, on the taskbar, select **File Explorer**.

3.  In File Explorer, in the navigation pane, expand **Allfiles (E:)**, expand **Labfiles**, and then select **Mod05**.

4.  In the details pane, right-click or access the context menu for **Mod05-1.ps1**, and then select **Run with PowerShell**. If prompted, select **Y**, and then select Enter.

### Task 2: Determine Plan of Action

1.  Read the **Additional Information** section of the **Incident Record**.

2.  Discuss your **Plan of Action** with other students and the instructor, and provide your recommendations:

   - Verify the configuration for **Susan Kemp**.

   - RSoP from **Group Policy Results Wizard** will provide the configuration information for **Susan Kemp**.

   - The **Research Application Override** GPO should provide the correct configuration. Investigate the configuration of the GPO.

### Task 3: Troubleshoot and resolve the problem

1.  On **LON-CL1**, sign in as **`Contoso\Susan`** with the password of **`Pa55w.rd`**.

2.  Select **Start**, and then enter **screen saver**.

3.  In the search results, select **Change Screen Saver**.

>Note: Verify that **Wait** is dimmed and has a value of **10 minutes**.

4.  Sign out of **LON-CL1**.

5.  Switch to **LON-DC1**.

6.  Open **Server Manager**, and then open **Group Policy Management**.

7.  In the **Group Policy Management** window, in the navigation pane, select **Group Policy Results**.

8.  Right-click or access the context menu for **Group Policy Results**, and then select **Group Policy Results Wizard**.

9.  On the **Welcome to the Group Policy Results Wizard** page, select **Next**.

10.  On the **Computer Selection** page, select the **Another computer** option, enter **`LON-CL1`**, and then select **Next**.

11.  On the **User Selection** page, Select **Contoso\\Susan**, and then select **Next**.

12.  On the **Summary of Selections** page, review your settings, and then select **Next**.

13.  Select **Finish**.

14.  Select the **Details** tab, and then select **Show all**.

15.  On the **Susan on LON-CL1** results page, in the **User Details** section, locate the **Settings** section, and then in **Control Panel/Personalization**, verify that the screen-saver timeout is **600** seconds and the winning GPO is **Contoso Standards**.

16.  In the **User Details** section, locate the denied GPOs, and then verify that the **Research Application Override** GPO is in the list of denied GPOs with a reason of **Disabled Link**. In this case, it appears that the GPO link for the Research OU is disabled.

17.  In the navigation pane, select the **Research** OU, right-click or access the context menu for the **Research** OU, and then select **Refresh**.

18.  Expand the **Research** OU.

19.  Notice that the link for the **Research Application Override** GPO is disabled. In the navigation pane, right-click or access the context menu for the **Research Application Override** GPO, and then select **Link Enabled**.

20.  Switch to **LON-CL1**.

21.  On **LON-CL1**, sign in as **`Contoso\Susan`** with the password of **`Pa55w.rd`**.

22.  Select **Start**, and then enter **screen saver**.

23.  In the search results, select **Change screen saver**.

24.  Verify that **Wait** is no longer dimmed and has a value of **10 minutes**.

>Note: If **Wait** is still dimmed, perform the following steps:
- Right-click or access the context menu for **Start**, select **Shut down or sign out**, and then select **Restart**.
- Sign in as **Contoso\Susan** with the password **Pa55w.rd**.
- Perform steps 22-24.

25.  Sign out of **LON-CL1**.

**Results**: After completing this exercise, you'll have resolved the GPO application problem.
