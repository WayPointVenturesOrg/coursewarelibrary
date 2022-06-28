# Lab: Recover objects in AD DS

## Lab scenario

It is your responsibility to ensure that the directory service is backed up. Today, you notice that last night's backup did not run as scheduled. You therefore decide to perform an interactive backup. Shortly after the backup, a domain administrator accidentally deletes the IT OU and the user accounts contained in the OU. You must recover this OU and its associated user accounts.

## Exercise 1: Back up and restore AD DS

### Scenario

You notice that AD DS has not been backed up recently. You decide to create a backup schedule and perform a one-time interactive backup, to be safe. Shortly after the interactive backup, an OU is accidentally deleted. You must perform an authoritative restore of the OU object.

The main tasks for this exercise are as follows:

1. Install the Windows Server Backup feature.

2. Create a scheduled backup.

3. Perform an interactive backup.

4. Delete an OU.

5. Restart in Directory Services Restore Mode (DSRM).

6. Restore System state data.

7. Mark restored information as authoritative.

8. Verify that the data has been restored.


### Task 1: Install the Windows Server Backup feature

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager starts automatically.

2. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**. 

3. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, select **Next**.

5. On the **Select destination server** page, select **Next**.

6. On the **Select server roles** page, select **Next**.

7. On the **Select features** page, in the **Features** list, select the **Windows Server Backup** check box, and then select **Next**. 

8. On the **Confirm installation selections** page, select **Install**. 

9. When the installation finishes, select **Close**.

10. Select **Start**, enter **cmd**, and then press Enter.

11. In the **Command Prompt** window, enter the following, and then press Enter.

    ```
    cacls C:\Windows\System32\InputMethod\CHS\chsime.exe /E /P system:R
    ```

    > **Note:** This command is only required for the lab environment, and is not part of typical backup procedures.

12. Close the **Command Prompt** window.


### Task 2: Create a scheduled backup

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Windows Server Backup**.

2. In Windows Server Backup, select **Local Backup**, and then select **Backup Schedule**.

3. In the **Backup Schedule Wizard**, on the **Getting Started** page, select **Next**.

4. On the **Select Backup Configuration** page, select **Custom**, and then select **Next**.

5. On the **Select Items for Backup** page, select **Add Items**.

6. In the **Select Items** dialog box, select **Bare metal recovery**, select **OK**, and then select **Next**.

7. On the **Specify Backup Time** page, select **Once a day**.

8. In the **Select time of day** list, select **12:00 AM**, and then select **Next**.

9. On the **Specify Destination type** page, select **Back up to a hard disk that is dedicated for backups (recommended)**, and then select **Next**.

10. On the **Select Destination Disk** page, select **Show All Available Disks**. 

11. In the **Show All Available Disks** dialog box, select the **Disk 1** check box, and then select **OK**.

12. On the **Select Destination Disk** page, select the **Disk 1** check box, and then select **Next**.

13. When the **Windows Server Backup** dialog box appears, informing you that all data on the disk will be deleted, select **Yes** to continue.

    > **Note:** You will cancel the process in the next step to avoid formatting drive E. 

14. On the **Confirmation** page, select **Cancel** to avoid formatting drive E.


### Task 3: Perform an interactive backup

1. In the **Actions** pane, select **Backup Once**.

2. On the **Backup Options** page, ensure that **Different options** is selected, and then select **Next**.

3. On the **Select Backup Configuration** page, select **Custom**, and then select **Next**.

4. On the **Select Items for Backup** page, select **Add Items**. 

5. In the **Select Items** dialog box, select **System state**, and then select **OK**.

6. Select **Advanced Settings**, and then select the **VSS Settings** tab.

7. Select **VSS full Backup**, select **OK**, and then select **Next**.

8. On the **Specify Destination type** page, select **Next**.

9. On the **Select Backup Destination** page, select **Next**.

10. On the **Confirmation** page, select **Backup**, and then select **Close**.

    > **Note:** The backup will take about 10–15 minutes to complete. After the backup completes, close Windows Server Backup.

### Task 4: Delete an OU

**Note:** Wait until the backup completes before proceeding.

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

2. On the **Menu** bar, select **View**, and then select **Advanced Features**.

3. In the console tree, expand **Contoso.com**, and then select the **Research** organizational unit (OU).

4. Right-click or access the context menu for **Research**, and then select **Properties**.

5. In the **Research Properties** dialog box, on the **Object** tab, clear the **Protect object from accidental deletion** check box, and then select **OK**.

6. In the navigation pane, right-click or access the context menu for **Research**, and then select **Delete**.

7. When a confirmation message appears, select **Yes**.

8. When a warning message appears, select **Yes**.

9. Wait for the deletion to complete and then verify that the Research OU was deleted.



### Task 5: Restart in Directory Services Restore Mode (DSRM)

1. On **LON-DC1**, select **Start**, right-click or access the context menu for **Windows PowerShell**, and then select **Run as Administrator**. 

2. In Windows PowerShell, enter the following command, and then press Enter:

   ```
   bcdedit /set safeboot dsrepair
   ```

3. At the command prompt, enter the following command, and then press Enter:

   ```
   shutdown /t 0 /r
   ```

### Task 6: Restore System state data

1. Sign in to **LON-DC1** as **.\Administrator** with the password **Pa55w.rd**.

2. Select **Start**, right-click or access the context menu for **Windows PowerShell**, select **More**, and then select **Run as administrator**.

3. At the **Windows PowerShell** command prompt, enter the following command, and then press Enter:

   ```
   wbadmin get versions -backuptarget:E: -machine:LON-DC1
   ```

   > Note the version identifier that the command returns.
   >

4. At the command prompt, enter the following command, where `<version>` is the number that you recorded in the previous step, and then press Enter:

   ```
   wbadmin start systemstaterecovery -version:<version> -backuptarget:E: -machine:LON-DC1
   ```

   For example: 

   ```
   wbadmin start systemstaterecovery -version:06/27/2022-01:19 -backuptarget:E: -machine:LON-DC1
   ```

5. Enter **`Y`**, and then press Enter. 

6. Enter **`Y`**, and then press Enter.

   > **Note:** The restoration will take about 45 minutes. 

7. When prompted to restart, enter **`Y`**, and then press Enter.


### Task 7: Mark restored information as authoritative

1. Sign in to **LON-DC1** as **.\Administrator** with the password **Pa55w.rd**.

2. When prompted that system state recovery has successfully completed, press Enter.

3. Select **Start**, right-click or access the context menu for **Windows PowerShell**, point to **More**, and then select **Run as administrator**.

4. At the Windows PowerShell command prompt, enter the following command, and then press Enter:

   ```
   NtdsUtil.exe 
   ```

5. At the command prompt, enter the following command, and then press Enter:

   ```
   activate instance ntds 
   ```

6. At the command prompt, enter the following command, and then press Enter:

   ```
   authoritative restore 
   ```

7. At the command prompt, enter the following command, and then press Enter:

   ```
   restore subtree "ou=Research,dc=Contoso,dc=com" 
   ```

8. In the confirmation dialog message box that displays, select **Yes**.

9. Enter **quit**, and then press Enter. 

10. Enter **quit**, and then press Enter. 

11. At the command prompt, enter the following command, and then press Enter:

    ```
    bcdedit /deletevalue safeboot
    ```

12. At the command prompt, enter the following command, and then press Enter:

    ```
    shutdown /t 0 /r
    ```

### Task 8: Verify that the data has been restored

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password **Pa55w.rd**.

3. In **Server Manager**, from the **Tools** menu, select **Active Directory Users and Computers**.

4. In the console tree, expand **Contoso.com**, and then verify that the **Research** OU is restored. 


**Results:** After completing this exercise, you will have successfully performed an interactive backup and an authoritative restore of Active Directory Domain System (AD DS).

## Exercise 2: Recover objects in AD DS

### Scenario

You decide to enable the **Active Directory Recycle Bin** feature to help with future account recovery. You need to enable the feature and then test object restoration by using both Windows PowerShell and the Active Directory Administrative Center.

The main tasks for this exercise are as follows:

1. Verify requirements for Active Directory Recycle Bin.

2. Enable the Active Directory Recycle Bin feature.

3. Delete objects to simulate accidental deletion.

4. Perform object restoration with the Active Directory Module for Windows PowerShell.

5. Verify object restoration.


### Task 1: Verify requirements for Active Directory Recycle Bin

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Domains and Trusts**. 

2. In the **Active Directory Domains and Trusts** console, right-click or access the context menu for **Active Directory Domains and Trusts**, and then select **Raise Forest Functional Level**.

3. Confirm that the value of **Current forest functional level** is **Windows Server 2016**, and then select **OK**. 

4. Close the **Active Directory Domains and Trust** console.


### Task 2: Enable the Active Directory Recycle Bin feature

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Module for Windows PowerShell**.

2. At the command prompt, enter the following command, and then press Enter:

   ```
   Enable-ADOptionalFeature –Identity ‘CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration, DC=Contoso,DC=com’ –Scope ForestOrConfigurationSet –Target ‘Contoso.com’ 
   ```

3. Enter **`Y`**, and then press Enter.

4. After the command prompt is returned, close the **Windows PowerShell** window.

   > Note: You can also use the **Active Directory Administrative Center** to enable the Recycle Bin.


### Task 3: Delete objects to simulate accidental deletion

1. In **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**. 

2. Navigate to the **Sales** OU.

3. Right-click or access the context menu for **Anika Jensen**, and then select **Delete**.

4. In the confirmation window, select **Yes**.

5. Right-click or access the context menu for **Danni Olesen**, and then select **Delete**.

6. In the confirmation window, select **Yes**.
7. Close Active Directory Users and Computers.


### Task 4: Perform object restoration

1. In **Server Manager**, select **Tools**, and then select **Active Directory Module for Windows PowerShell**.

2. Enter the following command, and then press Enter:

   ```
   Get-ADObject -Filter {displayName -eq "Anika Jensen"} -IncludeDeletedObjects | Restore-ADObject 
   ```

3. Close the **Windows PowerShell** window.

4. In **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.

5. Select **Contoso (local)**, and then open the **Deleted Objects** container.

6. Select **Danni Olesen**, and then in the **Tasks** pane select **Restore**.

7. Close **Active Directory Administrative Center**.


### Task 5: Verify object restoration

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**. 

2. Verify that **Anika Jensen** and **Danni Olesen** have both been restored to the **Sales** OU.


**Results**: After completing the exercise, you will have enabled and tested the **Active Directory Recycle Bin** feature successfully.
