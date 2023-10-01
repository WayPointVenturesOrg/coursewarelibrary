---
lab:
    title: 'Lab: Implement WSUS and deploy updates'
    module: 'Module 11: Maintain and monitor Windows Server installations'
---

# Lab: Implement WSUS, and deploy updates

## Scenario

Contoso Ltd. has a head office in London and a branch office in Toronto. The branch office contains a research department for the organization.

The Toronto location contains several Windows Server 2022 servers. Each server is individually configured to contact Windows update services and perform quality updates as needed. This has made it difficult to ensure that all servers are updated within the same timeframe. You plan to streamline the update process by implementing Windows Server Update Services (WSUS). You intend to use WSUS to manage quality, feature, and Office 365 updates for the entire organization for both Windows Server and Windows 11 devices. 

## Objectives

After completing this lab, you'll be able to:

- Implement the WSUS server role.
- Configure update settings.
- Approve and deploy an update by using WSUS.

## Estimated time: 60 minutes
## Exercise 1: Implement the WSUS server role

### Scenario

Contoso Ltd. has a WSUS implementation that covers its head office location. The WSUS server role is installed on a server named **LON-SVR2**. 

You need to configure WSUS to manage updates for the remote location in Toronto. You plan to install the WSUS server role on a server named **LON-SVR4**, which is located in Toronto. To minimize the number of servers needing access to the Windows update service, you'll configure **LON-SVR4** to use **LON-SVR2** as the source for Windows Update downloads. 

The main tasks for this exercise are:

1. Install the WSUS server role.
2. Configure WSUS to synchronize with an upstream WSUS server.

### Task 1: Install the WSUS server role

1.  Sign in to **LON-SVR4** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2.  On **LON-SVR4**, open **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

3.  In the **Add Roles and Features Wizard**, select **Next**.

4.  On the **Select installation type** page, ensure that **Role-based** **or** **feature-based** **installation** is selected, and then select **Next**.

5.  On the **Select destination server** page, select **Next**.

6.  On the **Select server roles** page, select the **Windows Server Update Services** checkbox. In the **Add Roles and Features Wizard** window, select **Add Features**.

7.  On the **Select server roles** page, select **Next**.

8.  On the **Select features** page, select **Next**.

9.  On the **Windows Server Update Services** page, select **Next**.

10.  On the **Select role services** page, confirm that both **WID Connectivity** and **WSUS Services** are selected, and then select **Next**.

11.  On the **Content location selection** page, in the text box, enter **`C:\WSUSUpdates`**, and then select **Next**.

12.  On the **Confirm installation selections** page, select **Install**.

>It'll take several minutes for the installation to complete.

>The Installation progress will complete with a message that states **Configuration required**. You will peform this configuration during the next couple of steps.

13.  When the installation completes, select **Close**.

14.  In Server Manager, select **Tools**, and then select **Windows Server Update Services**.

15.  In the **Complete WSUS Installation** dialog box, select **Run**, wait for the post-installation task to complete, and then select **Close**.

>The **Windows Server Update Services Configuration Wizard** starts.

### Task 2: Configure WSUS to synchronize with an upstream WSUS server

1.  In the **Windows Server Update Services Configuration Wizard: LON-SVR4** window, select **Next** twice.

2.  On the **Choose Upstream Server** page, select **Synchronize from another Windows Server Update Services server**, and in the **Server name** text box, enter **`LON-SVR2.Contoso.com`**, and then select **Next**.

3.  On the **Specify Proxy Server** page, select **Next**.

4.  On the **Connect to Upstream Server** page, select **Start Connecting**. Wait for the upstream server settings to be applied, and then select **Next**.

5.  On the **Choose Languages** page, select **Next**.

6.  On the **Set Sync Schedule** page, select **Next**.

7.  On the **Finished** page, select the **Begin initial synchronization** checkbox, and then select **Finish**.

8.  In the **Update Services** console, in the **navigation** pane, select and expand **LON-SVR4**, and then select **Synchronizations**.

>Wait until synchronization status for the most recent synchronization indicates that it's 100% complete. It'll take several minutes to complete.

9.  In the **navigation** pane, select **Options**.

10.  In the **Options** pane, select **Computers**. 

11.  In the **Computers** dialog box, select **Use Group Policy or registry settings on computers**, and then select **OK**. 

### Results

After completing this exercise, you'll have implemented the WSUS server role.

## Exercise 2: Configure update settings

### Scenario

You need to configure the Group Policy settings to deploy WSUS settings to client computers. With the WSUS role configured on **LON-SVR4**, you must ensure that the Research Department in Toronto has its own computer group in WSUS on **LON-SVR4**. You must also configure client computers in the Research organizational unit (OU) to use **LON-SVR4** as their source for updates.

The main tasks for this exercise are:

1. Configure WSUS groups.
2. Configure Group Policy to deploy WSUS settings.
3. Verify the application of Group Policy settings.
4. Initialize Windows Update.

### Task 1: Configure WSUS groups

1.  On **LON-SVR4**, in the **Update Services** console, in the **navigation** pane, expand **Computers**.

2.  Select **All Computers**, and then in the **Actions** pane, select **Add Computer Group**.

3.  In the **Add Computer Group** dialog box, in the **Name** text box, enter **`Research`**, and then select **Add**.


### Task 2: Configure Group Policy to deploy WSUS settings

1.  Switch to **LON-DC1**, and then sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

>Server Manager starts automatically.

2.  In Server Manager, select **Tools**, and then select **Group Policy Management**.

3.  In the **Group Policy Management** console, expand **Forest: Contoso.com**, expand **Domains**, and then expand **Contoso.com**.

4.  Right-click or access the context menu for the **Research** organizational unit (OU), and then select **Create a GPO in this domain, and Link it here**.

5.  In the **New GPO** dialog box, in the **Name** text box, enter **`WSUS Research`**, and then select **OK**.

6.  Expand the **Research** OU, right-click or access the context menu for **WSUS Research**, and then select **Edit**.

7.  In the **Group Policy Management Editor**, expand **Computer Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Windows Components**, and then select **Windows Update**.

8.  In the **Settings** pane, right-click or access the context menu for **Configure Automatic Updates**, and then select **Edit**. 

9.  In the **Configure Automatic Updates** window, select the **Enabled** option.

10.  In the **Configure automatic updating** section, select **4 – Auto download and schedule the install**, and then select **OK**.

11.  In the **Settings** pane, open the **Specify intranet Microsoft update service location** policy, and then select the **Enabled** option.

12.  In the **Set the intranet update service for detecting updates** and the **Set the intranet statistics server** text boxes, enter **`http://LON-SVR4.Contoso.com:8530`**, and then select **OK**.

13.  In the **Settings** pane, open the **Enable client-side targeting** policy.

14.  In the **Enable client-side targeting** dialog box, select the **Enabled** option, and in the **Target group name for this computer** text box, enter **`Research`**, and then select **OK**.

15.  Close the **Group Policy Management Editor** and the **Group Policy Management** console.

16.  In **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

17.  In **Active Directory Users and Computers**, expand **Contoso.com**, select **Computers**, right-click or access the context menu for **LON-CL1**, and then select **Move**.

18.  In the **Move** dialog box, select the **Research** OU, and then select **OK**.

19.  Close **Active Directory Users and Computers**.

### Task 3: Verify the application of Group Policy settings

1.  Restart **LON-CL1**, and then sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2.  On **LON-CL1**, select **Start**, enter **Updates**, and then select **Windows Update settings**.

3.  Select **Advanced** **options**, and then under **Additional options**, select **Configured update policies**. 

>Notice that the Group Policy settings configured in the previous task display. This confirms that they were applied.

4.  Close the **Settings** window.

5.  Select **Start**, enter **cmd**, and then select Enter.

6.  At the command prompt, enter the following command, and then select Enter:

   ```
Gpresult /r
   ```

7.  In the output of the command, confirm that, under **Computer Settings**, the **WSUS Research** GPO is listed under **Applied Group Policy Objects**.


### Task 4: Initialize Windows Update

1.  On **LON-CL1**, at the command prompt, enter the following command, and then select Enter:

   ```
Wuauclt.exe /detectnow /reportnow
   ```

2.  Switch to **LON-SVR4**.

3.  In the **Update Services** console, expand **Computers**, expand **All Computers**, and then select **Research**.

4.  In the **Status** drop-down list, select **Any**, and then select **Refresh**.

5.  Verify that **LON-CL1.contoso.com** appears in the **Research** group. If it doesn't, then repeat steps 1 through 3, and then select **Refresh**. 

>It might take several minutes for **LON-CL1** to display.

6.  Verify that update status has reported for **LON-CL1**. 

>You can verify the update status by reviewing the information message that the **details** pane displays. If the status hasn't reported, repeat step 1 to force detection and reporting. It might take 10 to 15 minutes for updates to register. Select **Refresh** every few minutes as you wait. LON-CL1 should report approximately 17 updates needed.

### Results

After completing this exercise, you'll have configured update settings for client computers.

## Exercise 3: Approve and deploy an update by using WSUS

### Scenario

After you configure the Windows Update settings, you can review, approve, and then deploy required updates. You want to use **LON-CL1** as a test case for the Research Department, and you'll approve, deploy, and verify an update on **LON-CL1** to confirm the proper configuration of the WSUS environment.

The main tasks for this exercise are:

1. Approve WSUS updates for the Research computer group.
2. Deploy updates to LON-CL1.
3. Verify update deployment to LON-CL1.

### Task 1: Approve WSUS updates for the Research computer group

1.  On **LON-SVR4**, in the **Update Services** console, expand **Updates**, and then select **All Updates**.

2.  In the **Status** drop-down list, select **Needed**, and then select **Refresh**.

3.  Review the list of updates, right-click or access the context menu for **2022-09 Cumulative Update for .NET Framework 3.5, 4.8, and 4.8.1 for Windows 11 for x64 (KB50117497)**, and then select **Approve**.

4.  In the **Approve Updates** window, in the **Research** drop-down list box, select **Approved for Install**.

5.  Select **OK**, and then select **Close**.

### Task 2: Deploy updates to LON-CL1

1.  On **LON-CL1**, at the command prompt, enter the following command, and then select Enter:

   ```
Wuauclt.exe /detectnow /reportnow
   ```

2.  Select **Start**, and then enter **Windows Update**.

3.  In the results list, select **Check for updates**.

4.  Select **Check for updates**.

>The update begins to download and install. This may take 5 -10 minutes to complete.

>If the **Update status** feature reports that the device is up to date, wait 5 minutes, and then check for updates again. The update won't be available to **LON-CL1** until **LON-SVR4** has downloaded the update from **LON-SVR2**.

5.  After the update has been downloaded and installed, select **Restart now**.

6.  After **LON-CL1** restarts, sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**. 

### Task 3: Verify update deployment to LON-CL1

1.  On **LON-CL1**, select **Start**, enter **Event Viewer**, and then select **Event Viewer**.

2.  In Event Viewer, expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand **WindowsUpdateClient**, and then select **Operational** to review events.

>Confirm that events are logged that pertain to the update. 

3.  Close all windows and sign out of **LON-CL1**.

### Results

After completing this exercise, you'll have approved and deployed an update by using WSUS.
