---
lab:
    title: 'Lab: Implementing Data Deduplication'
    module: 'Module 4: Implementing Storage Spaces and Data Deduplication'
---

# Lab: Implementing Data Deduplication

## Scenario

After you have tested the storage redundancy and performance options, you now decide that it would also be beneficial to maximize the available disk space that you have, especially around virtual machine storage which is in ever increasing demand. You decide to test out Data Deduplication solutions to maximize storage availability for virtual machines. 

## Objectives

- Install Data Deduplication
- Configure Data Deduplication
- Check the status of Data Deduplication

## Estimated time: 40 minutes

## Exercise 1: Install Data Deduplication

### Scenario

You decide to install the Data Deduplication role service on intensively used file servers by using Server Manager

The main tasks for this exercise are as follows:

1. Install the Data Deduplication role service.

2. Check the status of Data Deduplication.

3. Verify the virtual machine performance.

### Task 1: Install the Data Deduplication role service

1. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start** and then select **Server Manager**.

3. In **Server Manager**, in the **navigation** pane, select **Dashboard**.

4. In the **details** pane, select **Add roles and features**.

5. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

6. On the **Select installation** **type** page, select **Next**.

7. On the **Select destination server** page, select **Next**.

8. On the **Select server roles** page, in the **Roles** list, expand **File and Storage Services (4 of 12 installed)**. 

9. Expand **File and iSCSI Services (3 of 11 installed)**.

10. Select the **Data Deduplication** check box, and then select **Next**.

11. On the **Select features** page, select **Next**.

12. On the **Confirm installation selections** page, select **Install**. 

13. When installation is complete, on the **Installation progress** page, select **Close**.


### Task 2: Check the status of Data Deduplication

1. On **LON-SVR1**, select **Start** and then select **Windows PowerShell ISE**.

2. In the **Windows PowerShell ISE** command prompt window, enter the following command, and then press Enter:

   ```
   Get-DedupVolume 
   ```

3. In the **Windows PowerShell ISE** command prompt window, enter the following command, and then press Enter:

   ```
   Get-DedupStatus 
   ```

   > These commands return no results. This is because you need to enable it on the volume after installing it.
   >

### Task 3: Verify the virtual machine performance

- On **LON-SRV1**, in the **Windows PowerShell ISE** command prompt window, enter the following, and then press Enter:

  ```
  Measure-Command -Expression {Get-ChildItem –Path E:\ -Recurse}
  ```

  > **Note:** You will use the values returned from the previous command later in the lab.

### Results

After completing this exercise, you should have successfully installed the Data Deduplication role service and enabled it on LON-SVR1.

## Exercise 2: Configure Data Deduplication

### Scenario

You determine that drive E is heavily used and you suspect it contains duplicate files in some folders. You decide to enable and configure the Data Deduplication role to reduce the consumed space on this volume.

The main tasks for this exercise are as follows:

1. Configure Data Deduplication.

2. Configure optimization to run now and view the status.

3. Verify if the file has been optimized.

4. Verify VM performance again.

### Task 1: Configure Data Deduplication

1. On LON-SVR1, in **Server Manager**, in the navigation pane, select **File and Storage Services**, and then select **Disks**.

2. In the **Disks** pane, select **1**.

3. In the **VOLUMES** pane, select **E**.

4. Right-click or access the context menu for **E**, and then select **Configure Data Deduplication**.

5. In the **Allfiles (E:\\) Deduplication Settings** dialog box, in the **Data deduplication** list, select **General purpose file server**.

6. In the **Deduplicate files older than (in days)** text box, enter **0**.

7. Select **Set Deduplication Schedule**.

8. In the **LON-SVR1** **Deduplication Schedule** dialog box, select the **Enable throughput optimization** check box, and then select **OK**.

9. In the **Allfiles (E:\\) Deduplication Settings** dialog box, select **Add**. 

10. In the **Select Folder** dialog box, expand **Allfiles (E:)**, select **shares** and then select **Select Folder**.

11. In the **Allfiles (E:\\) Deduplication Settings** dialog box, select **Add**. 

12. In the **Select Folder** dialog box, expand **Allfiles (E:)**, select **virtualmachines** and then select **Select Folder**.

13. In the **Allfiles (E:\\) Deduplication Settings** dialog box, select **Add**. 

14. In the **Select Folder** dialog box, expand **Allfiles (E:)**, select **ISOs** and then select **Select Folder**.

15. In the **Allfiles (E:\\) Deduplication Settings** dialog box, select **OK**.

    > You have excluded the **Shares**, **virtualmachines**, and **ISOs** folders from data deduplication.

### Task 2: Configure optimization to run now and view the status

1. On **LON-SRV1**, in the **Windows PowerShell ISE** window, enter the following command, and then press Enter:

   ```
   Start-DedupJob E: -Type Optimization –Memory 50
   ```

2. In the **Windows PowerShell ISE** window, enter the following command, and then press Enter:

   ```
   Get-DedupJob –Volume E:
   ```

   > **Note:** Verify the status of the optimization job from the previous command. Repeat the previous command until the Progress shows as 100%. If you get a message that No MSFT_DedupJob objects exist, repeat steps 1 and 2. Step 2 needs to be completed immediately after step 1.

### Task 3: Verify if the file has been optimized

1. On **LON-SVR1**, open **File Explorer**, and navigate to **E:\\Labfiles\\Mod04**.

2. Right-click or access the context menu for **ContosoP1AnnualReport.docx**, and then select **Properties**. 

3. In the **Properties** window, observe the values of **Size** and **Size on disk** and note any differences.

4. Repeat steps 2 and 3 for a few more files to verify deduplication.

5. Switch to **Windows PowerShell ISE**.

6. In the command prompt window, enter the following command, and then press Enter:

   ```
   Get-DedupStatus –Volume E: |fl
   ```

7. In the command prompt window, enter the following command, and then press Enter:

   ```
   Get-DedupVolume –Volume E: |fl
   ```

   > **Note:** Observe the number of optimized files.

8. In **Server Manager**, in the navigation pane, select **File and Storage Services**, and then select **Disks**.

9. In the **DISKS** pane, select **1**.

10. In the **VOLUMES** pane, select **E**.

11. Select **Refresh** and observe the values for **Deduplication Rate** and **Deduplication Savings**. 

    > **Note:** Because most of the files on drive E are small, you may not notice a significant amount of saved space.

### Task 4: Verify VM performance again

- In the **Windows PowerShell ISE** window, enter the following command, and then press Enter:

  ```
  Measure-Command -Expression {Get-ChildItem –Path E:\ -Recurse}
  ```

  > **Note:** Compare the values returned from the previous command with the value of the same command earlier in the lab to assess if system performance has changed.

### Results

After completing this exercise, you should have successfully configured Data Deduplication for the appropriate data volume on **LON-SVR1**.
