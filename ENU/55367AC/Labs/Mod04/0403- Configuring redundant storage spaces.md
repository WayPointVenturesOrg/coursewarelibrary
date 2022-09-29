---
lab:
    title: 'Lab: Configure redundant storage spaces'
    module: 'Module 4: File servers and storage management in Windows Server'
---

# Lab: Configure redundant storage spaces

## Scenario

You're exploring the use of storage spaces and methods of creating storage redundancy, and you plan to implement the **Storage Spaces** feature on Windows Server 2022 to simplify storage access and provide storage-level redundancy.

## Objectives

After completing this lab, you'll be able to:

- Configure redundant storage spaces.

## Estimated time: 30 minutes

## Exercise 1: Configure the redundant Storage Spaces feature

### Scenario

To meet some high-availability requirements, you need to evaluate redundancy options for Storage Spaces. Additionally, you want to test the provisioning of new disks to the storage pool.

The main tasks for this exercise are:

1. Create a storage pool.
2. Create a three-way mirrored disk.
3. Copy a file to the volume, and then verify its visibility in File Explorer.
4. Disconnect the disk, and then verify file availability.
5. Add a new disk to the storage pool.

> **Note:** In **Windows Server 2022**, you can't disconnect a disk in a storage pool, only remove it. You also can't remove a disk from a three-way mirror without adding a new disk first.

### Task 1: Create a storage pool

1. Sign in to **LON-ADM1** as **Contoso\\Administrator** with the password **Pa55w.rd**.
2. Select **Start**, and then select **Server Manager**.
3. In **Server Manager**, in the navigation pane, select **File and Storage Services**, and then select **Disks**.
4. In the **Disks** pane, scroll down, and note that **LON-SVR3** disks 1 through 4 are **Offline** and set to **Unknown**.
5. Under **LON-SVR3**, right-click or access the context menu for each offline disk, select **Bring Online**, and then in the **Bring Disk Online** window, select **Yes**.
6. Verify that all disks are now online, and then in Server Manager, in the **navigation** pane, select **File and Storage Services**, and then select **Storage Pools**.
7. In Server Manager, in the **STORAGE POOLS** area, in the **TASKS** list, select **Refresh**.
8. In Server Manager, in the **STORAGE POOLS** area, in the **TASKS** list, select **New Storage Pool**.
9. In the **New Storage Pool Wizard**, on the **Before you begin** page, select **Next**.
10. On the **Specify a storage pool name and subsystem** page, in the **Name** text box, enter **SP1**. In the **Description** text box, enter **Storage Pool 1**, select **LON-SVR3**, and then select **Next**.
11. On the **Select physical disks for the storage pool** page, select the checkbox for the first three disks, and then select **Next**.
12. On the **Confirm selections** page, review the settings, and then select **Create**.
13. Select **Close**.

### Task 2: Create a three-way mirrored disk

1. In **Server Manager**, in **Storage Pools**, select **SP1**.
2. In the **VIRTUAL DISKS** area, select **TASKS**, and then select **New Virtual Disk**.
3. In the **Select the storage pool** dialog box, select **SP1**, and then select **OK**.
4. In the **New Virtual Disk Wizard**, on the **Before you begin** page, select **Next**.
5. On the **Specify the virtual disk name** page, in the **Name** text box, enter **Three-Mirror**, and then select **Next**.
6. On the **Specify enclosure resiliency** page, select **Next**.
7. On the **Select the storage layout** page, select **Mirror**, and then select **Next**.
8. On the **Specify the provisioning enter** page, select **Thin**, and then select **Next**.
9. On the **Specify the size of the virtual disk** page, in the **Specify size** text box, enter **25**, and then select **Next**.
10. On the **Confirm selections** page, review the settings, and then select **Create**.
11. On the **View results** page, clear the **Create a volume when this wizard closes** checkbox, and then select **Close**.
12. In **Server Manager**, in the **navigation** pane, select **Volumes**.
13. In the **VOLUMES** area, select **TASKS**, and then select **New Volume**.
14. In the **New Volume Wizard**, on the **Before you begin** page, select **Next**.
15. On the **Select the server and disk** page, select **LON-SVR3**, select **Three-Mirror**, and then select **Next**.
16. On the **Specify the size of the volume** page, select **Next**.
17. On the **Assign to a drive letter or folder** page, select **Drive letter**, select **T**, and then select **Next**.
18. On the **Select file system settings** page, in the **File system** drop-down list, select **ReFS**. In the **Volume label** text box, enter **TestData**, and then select **Next**.
19. On the **Confirm selections** page, select **Create**.
20. On the **Completion** page, select **Close**.

### Task 3: Copy a file to the volume, and then verify visibility in File Explorer

1. On **LON-ADM1**, in the taskbar, select the **File Explorer** icon.
2. In the **File Explorer** window, in the **Address bar**, enter **\\\\LON-SVR3\t$**.
3. Right-click or access the context menu in the empty details pane, and then select **New Folder**. Name the folder **Test data**, and then select **Enter**.
4. Double-click **Test data**, or right-click to activate its context menu, and then select **Open**.
5. Right-click or access the context menu for the empty **details** pane, select **New**, and then **Text Document**. Name the new document **document1**, and then select **Enter**.

### Task 4: Disconnect the disk, and then verify file availability

1. On **LON-ADM1**, in Server Manager, in **File and Storage Services**, select **Storage Pools**, and then select **SP1**.
2. In the **Physical Disks** pane, select the **TASKS** drop-down list, and then select **Add Physical Disk**.
3. In the **Add Physical Disk** dialog box, select the checkbox next to **Msft Virtual Disk (LON-SVR3)**.
4. in the **Allocation** drop-down list, ensure **Automatic** is selected, and then select **OK**.
5. In the **PHYSICAL DISKS** pane, right-click the top disk in the list, and then select **Remove disk**.
6. In the **Remove Physical Disk** window, select **Yes**.
7. Review the statement in the **Remove Physical Disk** window, and then select **OK**.
8. Return to **File Explorer**.
9. Open **Document1.txt**, add some text, and then save and close the file.

### Task 5: Add a new disk to the storage pool

1. In Server Manager, on **LON-ADM1**, in **File and Storage Services**, select **Storage Pools**.
2. In **Storage Pools**, in the **TASKS** drop-down list, select the **Rescan Storage** item.
3. In the **Rescan Storage** window, select **Yes**.
4. In the **Physical Disks** pane, select the **TASKS** drop-down list, and then select **Add Physical Disk**.
5. In the **Add Physical Disk** window, select the checkbox next to **Msft Virtual Disk (LON-SVR3)**.
6. In the **Allocation** drop-down list, ensure **Automatic** is selected, and then select **OK**.
7. Return to File Explorer.
8. Open **Document1**, add some additional text, and then save and close the file.
9. Close all open windows.

**Results**: After this exercise, you'll have successfully created a storage pool that contains a three-way mirrored disk, removed and added another disk to the storage pool, and verified file access.
