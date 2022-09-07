---
lab:
    title: 'Lab: Implementing Storage Spaces'
    module: 'Module 4: Implementing Storage Spaces and Data Deduplication'
---

# Lab: Implementing Storage Spaces

## Scenario

Contoso Ltd. has purchased a number of hard disk drives and SSDs and you have been tasked with creating a storage solution that can utilize these new devices to the fullest. With mixed requirements for data access and redundancy, you must ensure that you have a redundancy solution for critical data that does not require fast disk read and write access. You decide to use Storage Spaces and storage tiering to meet the requirements. 

## Objectives

- Create a storage space
- Enable and configure storage tiering

## Estimated time: 40 minutes

## Exercise 1: Create a storage space

### Scenario

Your server does not have a hardware-based RAID card, but you have been asked to configure redundant storage. To support this feature, you must create a storage pool.

After creating the storage pool, you must create a redundant virtual disk. Because the data is critical, the request for redundant storage specifies that you must use a three-way mirrored volume. Shortly after the volume is in use, a disk fails, and you have to replace it by adding another disk to the storage pool.

The main tasks for this exercise are as follows:

1. Create a storage pool from six disks that are attached to the server.

2. Create a three-way mirrored virtual disk.

3. Copy a file to the volume, and verify it is visible in File Explorer.

4. Add and remove disks from the storage pool.


### Task 1: Create a storage pool from six disks that are attached to the server

1. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**.

3. In **Server Manager**, in the navigation pane, select **File and Storage Services**, and then in the **Servers** pane, select **Storage Pools**.

4. In the **STORAGE POOLS** pane, select **TASKS**, and then, in the **TASKS** drop-down list, select **New Storage Pool**.

5. In the **New Storage Pool Wizard**, on the **Before you begin** page, select **Next**.

6. On the **Specify a storage pool name and subsystem** page, in the **Name** text box, enter **StoragePool1**, and then select **Next**.

7. On the **Select physical disks for the storage pool** page, select the first six disks displayed in the **Physical disks** list and then select **Next**.

8. On the **Confirm selections** page, select **Create**.

9. On the **View results** page, wait until the task completes, and then select **Close**.


### Task 2: Create a three-way mirrored virtual disk

1. On **LON-SVR1**, in Server Manager, in the **Storage Pools** pane, select **StoragePool1**.

2. In the **VIRTUAL DISKS** pane, select **TASKS**, and then, from the **TASKS** drop-down list, select **New Virtual Disk**.

3. In the **Select the storage pool** dialog box, select **StoragePool1**, and then select **OK**.

4. In the **New Virtual Disk Wizard**, on the **Before you begin** page, select **Next**.

5. On the **Specify the virtual disk name** page, in the **Name** text box, enter **Mirrored Disk**, and then select **Next**.

6. On the **Specify enclosure resiliency** page, select **Next**.

7. On the **Select the storage layout** page, in the **Layout** list, select **Mirror**, and then select **Next**.

8. On the **Configure the resiliency settings** page, select **Three-way mirror**, and then select **Next**.

9. On the **Specify the provisioning type** page, select **Thin**, and then select **Next**.

10. On the **Specify the size of the virtual disk** page, in the **Specify size** text box, enter **10**, and then select **Next**.

11. On the **Confirm selections** page, select **Create**.

12. On the **View results** page, wait until the task completes. 

13. Ensure that the **Create a volume when this wizard closes** check box is selected, and then select **Close**.

14. In the **New Volume Wizard** window, on the **Before you begin** page, select **Next**.

15. On the **Select the server and disk** page, in the **Disk** pane, select the **Mirrored Disk** virtual disk, and then select **Next**.

16. On the **Specify the size of the volume** page, select **Next** to confirm the default selection.

17. On the **Assign to a drive letter or folder** page, in the **Drive letter** drop-down list, ensure that **H** is selected, and then select **Next**.

18. On the **Select file system settings** page, in the **File system** drop-down list, select **ReFS**, in the **Volume label** text box, enter **Mirrored Volume**, and then select **Next**.

19. On the **Confirm selections** page, select **Create**. 

20. On the **Completion** page, wait until the creation completes, and then select **Close**.


### Task 3: Copy a file to the volume, and verify it is visible in File Explorer

1. On **LON-SVR1**, select **Start**, enter **command prompt**, and then press Enter.

2. At the command prompt, enter the following command, and then press Enter:

   ```
   Copy C:\windows\system32\write.exe H:\
   ```

3. Close **Command Prompt**.

4. On the taskbar, select the **File Explorer** icon.

5. In **File Explorer**, in the **navigation** pane, select **Mirrored Volume (H:)**. 

6. Verify that **write.exe** is visible in the file list.

7. Close **File Explorer**.


### Task 4: Add and remove disks from the storage pool

1. On **LON-SVR1**, in **Server Manager**, in the **STORAGE POOLS** pane, right-click or access the context menu for **StoragePool1**, and then select **Add Physical Disk**.

2. In the **Add Physical Disk** window, select the first disk in the list, and then select **OK**.

   > Notice that the disk is added to **StoragePool1** as shown in the **PHYSICAL DISKS** section.

3. In the **PHYSICAL DISKS** section, right-click or access the context menu for the first disk displayed in the list, and then select **Remove Disk**.

4. At the **Remove Physical Disk** message box, select **Yes**.

   > The wizard begins to remove the physical disk from the storage pool.

5. At the **Remove Physical Disk** message box, select **OK**.


### Results

After completing this exercise, you should have successfully created a storage pool and added six  physical disks to it. Additionally, you should have created a three-way mirrored, thinly-provisioned virtual disk from the storage pool. You also should have copied a file to the new volume and then verified that it is accessible. Finally, you added another physical disk to the storage pool and removed one of the initial physical disks.

## Exercise 2: Enable and configure storage tiering

### Scenario

Management wants you to implement storage tiers to take advantage of the high-performance attributes of a number of SSDs, while utilizing less expensive hard disk drives for less frequently accessed data.

The main tasks for this exercise are as follows:

1. Use the Get-PhysicalDisk cmdlet to view all available disks on the system.

2. Create a new storage pool.

3. View the media types.

4. Specify the media type for the sample disks and verify that the media type is changed.

5. Create pool-level storage tiers by using Windows PowerShell.

6. Create a new virtual disk with storage tiering by using the New Virtual Disk Wizard.

### Task 1: Use the Get-PhysicalDisk cmdlet to view all available disks on the system

1. On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

2. In **Windows PowerShell ISE**, at the command prompt, enter the following command, and then press Enter:

   ```
   Get-PhysicalDisk
   ```

### Task 2: Create a new storage pool

1. At the **Windows PowerShell ISE** command prompt, enter the following command, and then press Enter:

   ```
   $canpool = Get-PhysicalDisk –CanPool $true
   ```

2. At the command prompt, enter the following command, and then press Enter:

   ```
   New-StoragePool -FriendlyName "TieredStoragePool" -StorageSubsystemFriendlyName "Windows Storage*" -PhysicalDisks $canpool
   ```

3. Open **File Explorer**, and then browse to **E:\\Labfiles\\Mod04**.

4. Right-click or access the context menu for **mod4.ps1**, select **Run with PowerShell**, and press **Y** if prompted. 

   > This script configures the disk names for the next part of the exercise.


### Task 3: View the media types

- On **LON-SVR1**, at the **Windows PowerShell ISE** command prompt, enter the following command, and then press Enter:

  ```
  Get-StoragePool –FriendlyName TieredStoragePool | Get-PhysicalDisk | Select FriendlyName, MediaType, Usage, BusType
  ```

### Task 4: Specify the media type for the sample disks and verify that the media type is changed

1. On **LON-SVR1**, at the **Windows PowerShell ISE** command prompt, enter the following command, and then press Enter:

   ```
   Set-PhysicalDisk –FriendlyName PhysicalDisk1 –MediaType SSD
   ```

2. At the command prompt, enter the following command, and then press Enter:

   ```
   Set-PhysicalDisk –FriendlyName PhysicalDisk2 –MediaType HDD
   ```

3. At the command prompt, enter the following command, and then press Enter:

   ```
   Get-PhysicalDisk | Select FriendlyName, MediaType, Usage, BusType
   ```

### Task 5: Create pool-level storage tiers by using Windows PowerShell

1. On **LON-SVR1**, at the **Windows PowerShell ISE** command prompt, enter the following command, and then press Enter:

   ```
   New-StorageTier –StoragePoolFriendlyName TieredStoragePool -FriendlyName HDD_Tier –MediaType HDD
   ```

2. At the command prompt, enter the following command, and then press Enter:

   ```
   New-StorageTier –StoragePoolFriendlyName TieredStoragePool -FriendlyName SSD_Tier –MediaType SSD
   ```

### Task 6: Create a new virtual disk with storage tiering by using the New Virtual Disk Wizard

1. On **LON-SVR1**, in **Server Manager**, in the **Storage Pools** pane, select **Refresh**, and then select **TieredStoragePool**.

2. In the **VIRTUAL DISKS** pane, select **TASKS**, and then in the **TASKS** drop-down list, select **New Virtual Disk**.

3. In the **Select the storage pool** dialog box, select **TieredStoragePool**, and then select **OK**.

4. In the **New Virtual Disk Wizard**, on the **Before you begin** page, select **Next**.

5. On the **Specify the virtual disk name** page, in the **Name** text box, enter **TieredVirtDisk**, select **Create storage tiers on this virtual disk**, and then select **Next**.

6. On the **Specify enclosure resiliency** page, select **Next**.

7. On the **Select the storage layout** page, select **Simple**, and then select **Next**.

8. On the **Specify the provisioning type** page, select **Next**.

9. On the **Specify the size of the virtual disk** page, in both the **Specify** **size** text boxes, enter **2**, and then select **Next**.

10. On the **Confirm selections** page, select **Create**.

11. On the **View results** page, wait until the task completes. 

12. Ensure that **Create a volume when this wizard closes** is selected, and then select **Close**.

13. In the **New Volume Wizard**, on the **Before you begin** page, select **Next**.

14. On the **Select the server and disk** page, in the **Disk** pane, select the **TieredVirtDisk** virtual disk, and then select **Next**.

15. On the **Specify the size of the volume** page, select **Next** to confirm the default selection.

16. On the **Assign to a drive letter or folder** page, in the **Drive letter** drop-down list, ensure that **R** is selected, and then select **Next**.

17. On the **Select file system settings** page, in the **Volume label** text box, enter **Tiered Volume**, and then select **Next**.

18. On the **Confirm selections** page, select **Create**. 

19. On the **Completion** page, wait until the creation completes, and then select **Close**.

20. In **Server Manager**, right-click or access the context menu for the virtual disk you just created, and then select **Properties**.

21. In the **TieredVirtDisk** **Properties** window, on the **General** tab, observe the **Storage tiers**, **Capacity**, **Allocated space**, and **Used pool space** details. 

22. Select the **Health** tab, and observe the **Storage layout** details, and then select **OK**.

23. Close all open windows on LON-SVR1.


### Results

After completing this exercise, you should have successfully enabled and configured storage tiering.
