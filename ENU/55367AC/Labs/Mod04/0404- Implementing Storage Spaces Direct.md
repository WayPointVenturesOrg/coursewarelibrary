---
lab:
    title: 'Lab: Implement Storage Spaces Direct'
    module: 'Module 4: File servers and storage management in Windows Server'
---

# Lab: Implement Storage Spaces Direct

## Scenario

You want to test whether using local storage as highly available storage is a viable solution, as your organization previously has used storage area networks (SANs) for storing virtual machines (VMs). The features in Windows Server 2022 enable using only local storage, so you want to implement Storage Spaces Direct as a test implementation.

## Objectives

After completing this lab, you'll be able to:

- Implement the **Storage Spaces Direct** feature.

## Estimated time: 30 minutes

## Exercise 1: Implement Storage Spaces Direct

### Scenario

You need to test the feasibility of using highly available storage, specifically the **Storage Spaces Direct** feature.

The main tasks for this exercise are:

1. Install the **Storage Spaces Direct Failover Clustering** features.
2. Create and validate the failover cluster.
3. Enable **Storage Spaces Direct**.
4. Create the storage pool, a virtual disk, and a share.
5. Verify that **Storage Spaces Direct** functions properly.

### Task 1: Install the Storage Spaces Direct Failover Clustering features

1. Sign in to **LON-ADM1** as **Contoso\\Administrator** with the password **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**.

3. In Server Manager, in the console tree, select **All Servers**, and verify that **LON-SVR1**, **LON-SVR2**, and **LON-SVR3** have a **Manageability** of **Online – Performance counters not started** before continuing.

4. In Server Manager, in the **navigation** pane, select **File and Storage Services**, and then select **Disks**.

5. In the **Disks** pane, scroll until you find **LON-SVR3** disks 1 through 4, and verify that they are **Offline** and set to **Unknown**.

6. Right-click or access the context menu for each offline disk for **LON-SVR3**, select **Bring Online**, and then in the **Bring Disk Online** window, select **Yes**.

7. Verify that all disks are online for **LON-SVR1** and **LON-SVR2**.

8. Select **Start**, and in the **Start** menu, select **Windows PowerShell ISE**.

9. When **Windows PowerShell ISE** completes loading, select **File**, select **Open**, and then navigate to **C:\Labfiles\Mod04**.

10. Select **Implement-StorageSpacesDirect.ps1**, and then select **Open**.

    > **Note:** The script is divided into eight numbered steps, and each step has several commands. Run the commands by highlighting each command and selecting **F8**, one after the other, in accordance with the following instructions. Ensure each step finishes, meaning its status changes from **Stop operation** (a red square) to a **Run selection** (green arrow) in the menu bar *before* you begin the next step.

11. Select line 14 in Step 1 by highlighting the whole line, starting with the first **Invoke-Command**, and then select **F8**.

12. Wait until the installation finishes, and then verify that the command's output includes three lines (one for each server) with the **Success** listed as **True** for each.

13. Select line 15 in Step 1, starting with _second_ **Invoke-Command**, and then select **F8**.

       > **Note:** When you start the second command to restart the servers, you can run the third command to install the console without waiting for the second command's restarts to finish.

14. Select line 16 in Step 1, starting with **Install**, and then select **F8**.

       > Wait a few minutes while the servers restart and the **Failover Cluster Manager** tool is added to **LON-ADM1**.  

15. Leave the **Windows PowerShell ISE** console open for the remainder of the exercise.

### Task 2: Create and validate a cluster

1. On **LON-ADM1**, switch to **Server Manager**.

2. In Server Manager, select **Tools**, and then select **Failover Cluster Manager**, to confirm it's installed. Leave the Server Manager console open.

3. In the **Administrator: Windows PowerShell ISE** window, select line 20 in Step 2 starting with **Test-Cluster**, and then select **F8**.

   > Wait until the test finishes, which takes about 5 minutes.

4. Verify that the command's output only includes warnings and that the last line is a validation report in HTML format.

5. In the **Administrator: Windows PowerShell ISE** window, select line 25 in Step 3 starting with **New-Cluster**, and then select **F8**.

   > Wait until the installation finishes.

6. Verify that the command's output only includes warnings and that the last line has a **Name** column with the value **S2DCluster**.

7. Switch to the **Failover Cluster Manager** window, and in the **Management** pane, select **Connect to Cluster**, enter **```S2DCluster.Contoso.com```**, and then select **OK**.

### Task 3: Enable Storage Spaces Direct

1. In the **Administrator: Windows PowerShell ISE** window, select line 30 in Step 4 starting with **Invoke-Command**, and then select **F8**.

   > Wait until the installation finishes.

2. In the **Administrator: Windows PowerShell ISE** window, select line 35 in Step 5 starting with **Invoke-Command**, and then select **F8**.

   > Wait until the installation finishes.

3. In the output of the command, verify that the **FriendlyName** attribute has a value of **S2DStoragePool**.

4. In the **Failover Cluster Manager** window, expand **```S2DCluster.Contoso.com```**, expand **Storage**, and then select **Pools**.

5. Verify the existence of **Cluster Pool 1**.

6. In the **Administrator: Windows PowerShell ISE** window, select line 40 in step 6 starting with **Invoke-Command**, and then select **F8**.

   > Wait until the installation finishes.

7. Verify that in the command's output, the attribute **FileSystemLabel** appears and has a value of **CSV**.

8. In the **Failover Cluster Manager** window, select **Disks**.

9. Verify the existence of **Cluster Virtual Disk (CSV)**.

### Task 4: Create a storage pool, a virtual disk, and a share

1. In the **Administrator: Windows PowerShell ISE** window, select line 45 in Step 7 starting with **Invoke-Command**, and then select **F8**.

   > Wait until the installation finishes.

2. Verify that in the command's output, the attribute **FriendlyName** appears and has a value of **S2D-SOFS**. This validates that the command was successful.

3. In the **Failover Cluster Manager** window, select **Roles**.

4. Verify the existence of **S2D-SOFS**, which verifies that the command was successful.

5. In the **Administrator: Windows PowerShell ISE** window, select the three lines (50, 51, and 52) in Step 8, starting with **Invoke-Command**, and then select **F8**.

   > Wait until the installation finishes.

6. Verify that within the command's output, the attribute **Path** appears and has a value of **C:\ClusterStorage\CSV\VM01**. This validates that the command was successful.

7. In the **Failover Cluster Manager** window, select **S2D-SOFS**, and then select the **Shares** tab.

8. Verify the existence of **VM01**, which verifies that the command was successful.

### Task 5: Verify Storage Spaces Direct functionality

1. On  **LON-ADM1**, on the taskbar, select the **File Explorer** icon.

2. In **File Explorer**, in the address bar, enter **\\\s2d-sofs\VM01**, and then select Enter.

3. Create a new folder named **VMFolder**, and then open it.

4. Switch to the **Administrator: Windows PowerShell ISE** window.

5. At the Windows PowerShell command prompt, enter the following command, and then select Enter:

     ```
     Stop-Computer -ComputerName LON-SVR3
     ```

6. Switch to the **Server Manager** window, and then select **All Servers**.

7. In the **Servers** list, select **LON-SVR3**.

8. Verify that **Manageability** changes to **Target computer not accessible**.

  > **Note:** You might have to refresh the Server Manager view.

9. Switch back to the **File Explorer** window.

10. Create a new text document in the **VMFolder**.

11. In **Failover Cluster Manager**, select **Disks**, and then select **Cluster Virtual Disk (CSV)**.

12. Verify that for the **Cluster Virtual Disk (CSV)**, the **Health Status** is **Warning**, and **Operational Status** is **Degraded**. It's important to note that **Operational Status** might also display as **Incomplete**.

13. On the taskbar, select the **Microsoft Edge** icon.

14. In Microsoft Edge, in the **Favorites** menu, select the **Windows Admin Center (WAC)** tab.

15. In the **Windows security** window, in the **Username** text box, enter **Contoso\Administrator**, in the **Password** text box, enter **Pa55w.rd**, and then select **OK**.

16. In the **All connections** page, select **+ Add**.

17. In the **Add resources** blade, scroll to the **Server clusters** pane, and in the pane, select **Add**.

18. In the **Add cluster** blade **Cluster name** text box, enter **```S2DCluster.Contoso.com```**, and then select **Add**.

      > **Note:** Initially, the connection under the current user is denied.

19. Select **s2dcluster.contoso.com**.

20. In the **Specify your credentials** window, select the **Use another account for this connection** radio button. In the **Username** text box, enter **Contoso\\Administrator**, and in the **Password** text box, enter **Pa55w.rd**, and then select Enter.

21. On the **Dashboard** page, under **Alerts**, select **View all**, and verify that there's an alert that indicates that **LON-SVR3** is offline.

22. Start **LON-SVR3**. 

      > While **LON-SVR3** should start quickly, it might take a few minutes for the alert to clear.

**Results**: After this exercise, you'll have successfully implemented and validated **Storage Spaces Direct**.
