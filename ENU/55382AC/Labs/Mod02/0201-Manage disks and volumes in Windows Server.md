---
lab:
    title: 'Lab: Manage disks and volumes in Windows Server'
    module: 'Module 2: Configuring local storage'
---

# Lab: Manage disks and volumes in Windows Server

## Scenario

Your manager has asked you to add disk space to a file server that's running Windows Server. This server will potentially grow significantly in size in the upcoming months, and you might need flexibility in your storage options. You also have been asked to create a new virtual hard disk (VHD) and optimize the cluster and sector size to accommodate large file sizes for storage on Microsoft Hyper-V-based virtual machines (VMs). 

## Objectives

- Create and manage volumes.
- Resize volumes.
- Manage VHDs.

## Estimated time: 40 minutes

## Exercise 1: Create and manage volumes

### Scenario

In the test lab, you start by creating a number of volumes on the installed hard disks. 

The main tasks for this exercise are as follows:

1. Create a hard disk volume and format for Resilient File System (ReFS).
1. Create a mirrored volume.

### Task 1: Create a hard disk volume and format for ReFS

1. On **LON-SVR1**, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, and then select **Windows PowerShell ISE**.

3. To list all the available disks that have yet to be initialized, at the Windows PowerShell command prompt, enter the following command, and then select Enter: 

   ```
   Get-Disk | Where-Object PartitionStyle –Eq "RAW"
   ```

   > Notice that there are nine disks that are offline and not initialized.

4. To initialize disk 2, at the command prompt, enter the following command, and then select Enter: 

   ```
   Initialize-disk 2
   ```

5. To review the partition table enter, at the command prompt, enter the following command, and then select Enter: 

   ```
   Get-disk
   ```

   > All disks  now display. and Disks 0, 1, and 2 are online.

6. To create an ReFS volume by using all available space on disk 2, at the Windows PowerShell command prompt, enter the following command, and then select Enter: 

   ```
   New-Partition -DiskNumber 2 -UseMaximumSize -AssignDriveLetter | Format-Volume -NewFileSystemLabel "Simple" -FileSystem ReFS
   ```

7. On the taskbar, select **File Explorer**. Notice that a new volume named **Simple** has been created.

   > **Question**: Which drive letter has been assigned to the newly created Simple volume? 
   >
   > **Answer**: Answers might vary, but will most likely be drive **F**. 

### Task 2: Create a mirrored volume

1. Right-click or access the context menu for **Start**, and then select **Disk** **Management**.

2. In the lower half of the Disk Management window, scroll down and right-click or access the context menu for **Disk 3**, and then select **Online**. 

3. Right-click or access the context menu for **Disk 4**, and then select **Online**. 

4. Close and reopen **Disk Management**.

5. In the **Initialize Disk** dialog box, select **OK** to initialize Disks 3 and 4.

6. On Disk 3, right-click or access the context menu for **Unallocated**, and then select **New Mirrored Volume**.

7. In the **New Mirrored Volume Wizard**, select **Next**.

8. On the **Select Disks** page, in the **Available** list, select **Disk 4**, and then select **Add >**.

9. In the **Select the amount of space in MB** box, accept the default value, and then select **Next**. 

10. On the **Assign Drive Letter or Path** page, in the **Assign the following drive letter** box, select **M**, and then select **Next**. 

11. On the **Format Volume** page, in the **Volume label** text box, enter **MIRROR**.

12. Select the **Perform a quick format** checkbox, and then select **Next**. 

13. Select **Finish** to create the mirrored volume. 

14. In the **Disk Management** message box, select **Yes** to convert both disks to dynamic disks.

### Results

After completing this exercise, you will have successfully created volumes using PowerShell and Disk Management.

## Exercise 2: Resizing volumes

### Scenario

You create a new volume, and then realize that you must resize it. You decide to use Diskpart.exe to complete this process.

The main tasks for this exercise are as follows:

1. Create a simple volume and resize it.
1. Shrink a volume.

### Task 1: Create a simple volume and resize it

1. Switch to **Windows PowerShell ISE**. 

2. At the Windows PowerShell command prompt, enter the following command, and then select Enter: 

   ```
   Initialize-disk 5
   ```

3. At the Windows PowerShell command prompt, enter the following command, and then select Enter: 

   ```
   Start-Process Diskpart
   ```

   > A separate command prompt window opens to run Diskpart.

4. At the Diskpart command prompt, enter the following command, and then select Enter: 

   ```
   List disk
   ```

5. At the command prompt, enter the following command, and then select Enter: 

   ```
   Select disk 5
   ```

6. At the command prompt, enter the following command, and then select Enter: 

   ```
   Convert dynamic
   ```

7. At the command prompt, enter the following command, and then select Enter: 

   ```
   Create volume simple size=10000 disk=5
   ```

8. At the command prompt, enter the following command, and then select Enter: 

   ```
   Assign letter=z
   ```

9. At the command prompt, enter the following command, and then select Enter: 

   ```
   Format
   ```

10. Switch to **Disk Management**. 

    > Notice the NTFS volume on **Disk 5** has a size of approximately **10** gigabytes (GB).

11. Switch to the Diskpart command prompt.
 
12. Enter the following command, and then select Enter: 

    ```
    Extend size 10000
    ```

12. Switch to **Disk Management**.

    > Notice that the NTFS volume on **Disk 5** is now approximately **20** GB in size.
    >

### Task 2: Shrink a volume

1. Switch to the Diskpart command prompt.
 
2. Enter the following command, and then select Enter: 

   ```
   Shrink desired=15000
   ```

3. Switch back to **Disk Management**. 

4. Verify the presence of an NTFS volume on **Disk 5** that's size is approximately **5** GB. 

5. Close all open windows on **LON-SVR1**.


### Results

After completing this exercise, you will have successfully resized a volume.

## Exercise 3: Managing VHDs

### Scenario

You need to create and configure a VHD for use in Microsoft Hyper-V running in Windows Server. The VHD will be for the Sales department. You will use Windows PowerShell to achieve these objectives. 

The main tasks for this exercise are as follows:

1. Create a VHD.
1. Reconfigure the VHD.

### Task 1: Create a VHD 

1. Select **Start**, and then select **Windows PowerShell ISE**. 

2. At the Windows PowerShell command prompt, enter the following command, and then select Enter: 

   ```
   New-VHD -Path c:\sales.vhd -Dynamic -SizeBytes 10Gb | Mount-VHD -Passthru |Initialize-Disk -Passthru |New-Partition -AssignDriveLetter -UseMaximumSize |Format-Volume -FileSystem NTFS -Confirm:$false -Force
   ```

### Task 2: Reconfigure the VHD

1. To dismount the VHD, at the command prompt, enter the following command, and then select Enter: 

   ```
   Dismount-vhd C:\Sales.vhd
   ```

2. To check the properties of the VHD, at the command prompt, enter the following command, and then select Enter: 

   ```
   Get-vhd C:\Sales.vhd
   ```

   > **Question**: What is the physical sector size? 
   >
   > **Answer**: Answers will vary, but will most likely be 512. 

3. To convert to a .vhdx file, at the command prompt, enter the following command, and then select Enter: 

   ```
   Convert-VHD –Path C:\Sales.vhd –DestinationPath c:\Sales.vhdx
   ```

4. To change the sector size, at the command prompt, enter the following command, and then select Enter: 

   ```
   Set-VHD –Path c:\Sales.vhdx –PhysicalSectorSizeBytes 4096
   ```

5. To check the properties of the .vhdx file, at the command prompt, enter the following command, and then select Enter: 

   ```
   Get-vhd C:\Sales.vhdx
   ```

   > **Question**: What is the physical sector size? 
   >
   > **Answer**: Answers will vary, but will most likely be 4,096. 

6. To optimize the .vhdx file, at the command prompt, enter the following command, and then select Enter: 

   ```
   Optimize-VHD –Path c:\Sales.vhdx –Mode Full
   ```

### Results

After completing this exercise, you will have successfully created and managed VHDs by using Windows PowerShell.
