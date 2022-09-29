---
lab:
    title: 'Lab: Implement data deduplication'
    module: 'Module 4: File servers and storage management in Windows Server'
---

# Lab: Implement Data Deduplication

## Scenario

At Contoso, Ltd., you notice many duplicate files exist on shared file-server locations, so you decide to test the **Data Deduplication** role service to help save storage space on file shares. You'll need to install the **Data Deduplication** role service, and then configure and verify that the feature works as expected.

## Objectives

After completing this lab, you'll be able to:

- Install the **Data Deduplication** role service.
- Configure and verify data deduplication.

## Estimated time: 15 minutes

## Exercise 1: Install the Data Deduplication role service

### Scenario

You plan to install the **Data Deduplication** role service on LON-SVR3 by using Server Manager. You'll begin by creating a new shared folder on **LON-SVR3**, and then assign it drive letter **M**. You'll then generate sample files that you'll use for your Data Deduplication testing.

The main task for this exercise is:

1. Install the **Data Deduplication** role.

### Task 1: Install the Data Deduplication role

1. Sign in to **LON-ADM1** as **Contoso\\Administrator** with the password **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**.

3. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

4. In the **Add Roles and Features Wizard**, select **Next** twice.

5. On the **Select destination server** page, in the **Server Pool** pane, select **```LON-SVR3.Contoso.com```**, and then select **Next**.

6. On the **Select server roles** page, in the **Roles** pane, expand the **File and Storage Services** item, and then expand the **File and iSCSI Services** item, select the **Data Deduplication** checkbox, and then select **Next**.

7. On the **Select features** page, select **Next**, and then in the **Confirm installation selections** page, select **Install**.

8. While the role service is installing, on the taskbar, select the **File Explorer** icon.

9. In **File Explorer**, expand drive **C**.

10. Right-click or access the context menu for the **Labfiles** folder, and then select **Give access to**. In the next context menu, select **Specific people…**.

11. In the **Type a name and then Click Add, or click the arrow to find someone** text box, enter **Users**, and then select **Add**.

12. In the **Network access** window, select **Share**, and when the **Your folder is shared** section opens, select **Done**.

13. Close **File Explorer**.

14. In Server Manager, on the **Add Roles and Features Wizard installation succeeded** page, select **Close**.

15. Switch to **LON-SVR3**.

16. Sign in to **LON-SVR3** as **Contoso\\Administrator** with the password **Pa55w.rd**.

      > After a few moments **sconfig** starts automatically and the server configuration tool opens.

17. On the server configuration screen, enter **`15`**, and then select Enter to exit to the command line (Windows PowerShell).

      > Note that the prompt changes with the **PS** cursor to let you know you're now in PowerShell.

18. In the **PowerShell** window, enter the following commands, selecting Enter after each line:

      ```
      Get-Disk
      ```

      ```
      Initialize-Disk -Number 1
      ```

      ```
      New-Partition -DiskNumber 1 -UseMaximumSize -DriveLetter M
      ```

      ```
      Format-Volume -DriveLetter M -FileSystem ReFS
      ```

      ```
      cmd
      ```

19. In the **Command prompt** window, enter the following commands, selecting Enter after each line:

       ```
       Net use x: \\LON-ADM1\Labfiles
       ```

       ```
       M:
       ```

       ```
       Md Data
       ```

       ```
       copy x:\mod04\createlabfiles.cmd M:
       ```

       ```
       CreateLabFiles.cmd
       ```

       ```
       Cd data
       ```

      ```
      dir
      ```

      > Make note of the files copied to the **M:\Data** file share.

**Results**: After this exercise, you'll have successfully installed the **Data Deduplication** server role and configured a file share.

## Exercise 2: Configure and verify data deduplication

### Scenario

You determine that drive **M** is heavily used, and you suspect that it contains duplicate files in some folders. You need to enable and configure the **Data Deduplication** role to reduce the consumed space on this volume.

The main tasks for this exercise are:

1. Enable and configure data deduplication.
2. Verify data deduplication.

### Task 1: Enable and configure Data Deduplication

1. Return to **LON-ADM1**.
2. In the Server Manager console tree, select **File and Storage Services**, and then select **Disks**.
3. In the **Disks** pane, scroll down to **LON-SVR3**, and then under **LON-SVR3**, in the **Number** column, select disk number **1**.
3. In the **Volumes** pane, right-click or access the context menu for the **M** volume, and then from the context menu, select **Configure Data Deduplication**.
4. In the **Volume (M:\) Deduplication Settings** wizard, select the **Data deduplication** drop-down menu, and then change the selection to the **General purpose file server** setting.
5. Set **Deduplicate files older than (in days):** to **0**.
6. Select the **Set Deduplication Schedule** button.
7. In the **LON-SVR3 Deduplication Schedule** window, select **Enable throughput optimization**, and then select **OK**.
8. In the **Volume (M:\) Deduplication Settings Wizard**, select **OK**.

### Task 2: Verify data deduplication

1. Switch to **LON-SVR3**.

2. At the **Command Prompt** window, enter **`PowerShell`**.

3. At the **PowerShell** prompt, enter the following command, and then select Enter:

     ```
     Start-DedupJob m: -Type Optimization –Memory 50
     ```

     > Wait approximately 5 minutes before continuing with the next step.

4. To verify data-deduplication status, run the following commands, selecting Enter at the end of each line:

     ```
     Get-DedupStatus –Volume M: | fl
     ```

     ```
     Get-DedupVolume –Volume M: |fl
     ```

     ```
     Get-DedupMetadata –Volume M: |fl
     ```

5. Return to **LON-ADM1**.

6. Refresh the **Server Manager** **Disks** page.

7. In **Server Manager**, on the **Disks** page, scroll to **LON-SVR3**, select disk **1**, and then select Volume **M**.

8. In the **Volumes** section, using scrolling, observe the values for **Deduplication Rate** and **Deduplication Savings**. 

     > Values might differ, but you should observe an approximately 78% deduplication rate and a 52.1 gigabytes (GB) deduplication savings or higher.

**Results**: After this exercise, you'll have successfully enabled and verified data deduplication.
