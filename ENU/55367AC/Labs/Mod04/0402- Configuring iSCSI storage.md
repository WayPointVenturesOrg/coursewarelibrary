---
lab:
    title: 'Lab: Configure iSCSI storage'
    module: 'Module 4: File servers and storage management in Windows Server'
---

# Lab B: Configure iSCSI storage

## Scenario

You're exploring the option of using Internet Small Computer System Interface (iSCSI) to decrease the cost and complexity of configuring centralized storage at Contoso Ltd. To test this, you must install the **iSCSI Target Server** role, configure the iSCSI targets, and configure the iSCSI initiators to provide access to the targets.

## Objectives

After completing this lab, you'll be able to:

- Install and configure the **iSCSI Target Server** role.
- Configure and connect to iSCSI targets.

## Estimated time: 30 minutes

## Exercise 1: Install and configure the iSCSI Target Server role

### Scenario

You plan to install the **iSCSI Target server** role service on **LON-SVR3** by using PowerShell remote. You'll install the role service, configure a disk on **LON-SVR3**, and enable firewall rules to allow for iSCSI connectivity.

The main task for this exercise is:

- Install the **iSCSI Target Server** role.

### Task 1: Install the iSCSI Target Server role

1. Sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

2. Select **Start**, and then select **Windows PowerShell (ISE)**.

3. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```
Invoke-Command -ComputerName LON-SVR3 -ScriptBlock {Install-WindowsFeature –Name FS-iSCSITarget-Server –IncludeManagementTools}
   ```

4. Enter the following command, and then select Enter:

   ```
Enter-PSSession -ComputerName LON-SVR3 -Credential "Contoso\Administrator"
   ```

5. In the **Windows PowerShell credential request** pop-up window, in the **Password** text box, enter **`Pa55w.rd`**, and then select **OK**.

6. In the **Administrator: Windows PowerShell ISE** window, enter the following commands, selecting Enter at the end of each line:

   ```
   Get-Disk
   ```
   ```
   Initialize-Disk -Number 2
   ```
   ```
   New-Partition -DiskNumber 2 -UseMaximumSize -AssignDriveLetter
   ```
>Note: In the following command, drive letter **Y** is placeholder text only. The drive letter to use will be returned to you in the previous command's results.

   ```
Format-Volume -DriveLetter Y -FileSystem ReFS
   ```

7. Repeat step 6 for disk 3, replacing 2 with the number 3.

8. In the **Administrator: Windows PowerShell ISE** window, enter the following commands, selecting Enter at the end of each line:

   ```
New-NetFirewallRule -DisplayName "iSCSITargetIn" -Profile "Any" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 3260
   ```

   ```
New-NetFirewallRule -DisplayName "iSCSITargetOut" -Profile "Any" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 3260
   ```

9. In the **Administrator: Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Exit-PSSEssion
   ```

**Results:** After this exercise, you'll have successfully installed the **iSCSI Target Server** role, and configured disks and firewall rules to support iSCSI.

## Exercise 2: Configure and connect to iSCSI Targets

### Scenario

Now that you've installed the **iSCSI Target Server** role, you need to configure the iSCSI target. You'll create two iSCSI virtual disks, both 5 gigabytes (GB) in size, and then configure an iSCSI target named iSCSIFarm, connect **LON-DC1** to the target, and then verify that the disks are available on **LON-DC1**.

The main tasks for this exercise are:

1. Configure iSCSI targets.
2. Verify iSCSI disks.

### Task 1: Configure iSCSI targets

1. On **LON-ADM1**, select **Start**, and then select **Server Manager**.

2. In Server Manager, in the console tree, select **File and Storage Services**, select **Disks**, and then scroll down to the **LON-SVR3** server. 

>Note: Note that disks **2** and **3** are **Online**. These are the disks you initialized earlier in the lab.

3. Select Disk number **2**, and then verify the volume-drive letter. It should indicate **Drive E**.

4. Select Disk number **3**, and then verify the volume-drive letter. It should indicate **Drive F**.

5. In the **Server Manager** window, in **File and Storage Services**, select **iSCSI**.

6. In the **ISCSI Virtual Disks** pane, select **Tasks**, and then select **New iSCSI Virtual Disk**.

7. In the **New iSCSI Virtual Disk Wizard**, on the **Select iSCSI virtual disk location** page, under the **LON-SVR3** server, select the **E:** volume, and then select **Next**.

8. In the **Specify iSCSI virtual disk name** page, in the **Name** text box, enter **`iSCSIDisk1`**, and then select **Next**.

9. On the **Specify iSCSI virtual disk size** page, in the **Size** text box, enter **`5`**. Leave all other settings as they are, and then select **Next**.

10. On the **Assign iSCSI target** page, ensure the **New iSCSI target** radio button is selected, and then select **Next**.

11. In the **Specify target name** page, in the **Name** field, enter **`iSCSIFarm`**, and then select **Next**.

12. In the **Specify access servers** page, select the **Add** button.

13. In the **Select a method to identify the initiator** window, next to **Query initiator computer for ID**, select the **Browse** button.

14. In the **Select Computer** window, in the **Enter the object name to select** text box, enter **`LON-DC1`**, select **Check Names**, and then select **OK**.

15. In the **Select a method to identify the initiator** window, select **OK**.

16. On the **Specify access servers** page, select **Next**.

17. On the **Enable Authentication** page, select **Next**.

18. On the **Confirm selections** page, select **Create**.

19. On the **View results** page, select **Close**.

20. Create the second iSCSI virtual disk (F:), by repeating steps 6 through 10 and then steps 18 and 19, using the following settings:

     - Storage Location: **F:**
     - Name: **`iSCSIDisk2`**
     - Disk size: **5 GB**, **Dynamically Expanding**
     - iSCSI target: **iSCSIFarm**

21. Switch to **LON-DC1**, and then sign in as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

22. Select **Start**, and then select **Windows PowerShell ISE**.

23. In the **Windows PowerShell ISE** window, enter the following commands, selecting **Enter** after each command:

```
Start-Service msiscsi
iscsicpl
```

>Note: The **iscsicpl** command opens the **iSCSI Initiator Properties** dialog box.

24. In the **iSCSI Initiator Properties** dialog box, on the **Targets** tab, in the **Target** text box, enter **`LON-SVR3`**, and then select **Quick Connect**.

25. In the **Quick Connect** dialog box, note that the discovered target name is **iqn.1991-05.com.microsoft:lon-svr3-iscscifarm-target**, and then select **Done**.

26. In the **iSCSI Initiator Properties** dialog box, select **OK**.

### Task 2: Verify iSCSI disks

1. Switch back to **LON-ADM1**.

2. In **Server Manager**, select **File and Storage Services**, and then select **Disks**. In the **Tasks** drop-down list box, select **Refresh**.

>Note: Notice the two new **5 GB** disks on the **LON-DC1** server that are offline and that the **Bus Type** is **iSCSI**.

3. Switch back to **LON-DC1**.

4. In the **Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```
   Get-Disk
   ```

>Note: Both disks are present and healthy, but offline. To use them, you need to initialize and format them on **LON-DC1**.

5. In the **Windows PowerShell ISE** window, enter the following commands, selecting Enter after each command:

   ```
Initialize-Disk -Number 1
   ```

   ```
New-Partition -DiskNumber 1 -UseMaximumSize -DriveLetter E
   ```

   ```
Format-Volume -DriveLetter E -FileSystem ReFS
   ```

6. Repeat step 5, using disk number **2** and disk letter **F**.

7. Return to **LON-ADM1**.

8. In **Server Manager**, refresh the page in the **Tasks** drop-down list, and note that both the drives on **LON-DC1** are now **Online**.

**Results**: After this exercise, you'll have successfully configured iSCSI targets and verified iSCSI disks.
