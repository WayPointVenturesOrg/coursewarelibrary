---
lab:
    title: 'Lab: Implement Hyper-V Replica and Windows Server Backup'
    module: 'Module 7: Disaster Recovery in Windows Server'
---

# Lab: Implement Hyper-V Replica and Windows Server Backup

## Scenario

You work as an administrator at Contoso, Ltd. Contoso wants to assess and configure new disaster recovery and backup features and technologies. As the system administrator, you've been tasked with performing that assessment and implementation. You decide to evaluate **Hyper-V Replica** and **Windows Server Backup**.

## Objectives

After completing this lab, you'll be able to:

- Configure and implement **Hyper-V Replica**.
- Configure and implement backup with **Windows Server Backup**.

## Estimated time: 45 minutes
## Exercise 1: Configure and implement Hyper-V Replica

### Scenario

Before you start with a cluster deployment, you've decided to evaluate the new technology in Hyper-V for replicating virtual machines (VMs) between hosts. You want to be able to manually mount a copy of a VM on another host if the active copy or host fails.

The main tasks for this exercise are to:

1. Configure a replica on two host machines.
2. Configure VM replication.
3. Validate a failover.

### Task 1: Configure a replica on two host machines

1. On **LON-ADM1**, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

2. Select **Start**, and then select **Windows PowerShell ISE**. 

3. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$cred=Get-Credential
   ```

4. When prompted, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

5. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$sess = New-PSSession -Credential $cred -ComputerName LON-svr1.contoso.com
   ```

6. Next, enter the following command, and then select Enter:

   ```powershell-notab
   Enter-PSSession $sess
   ```

>Note: You should get a [LON-svr1.contoso.com] title in your command prompt. From this point, all the commands that you enter run on **LON-SVR1**.

7. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
   Get-Netfirewallrule -displayname "Hyper-V Replica HTTP Listener (TCP-In)"
   ```

>Note: You'll receive the properties of this firewall rule. Search for the value of the *Enabled* variable. It should be set to **False**. To enable **LON-SVR1** as a replication host, you must enable this firewall rule.

8. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
Enable-Netfirewallrule -displayname "Hyper-V Replica HTTP Listener (TCP-In)"
   ```

9. In the **Administrator: Windows PowerShell** window, enter the following command, and then select Enter:

   ```powershell-notab
   Get-Netfirewallrule -displayname "Hyper-V Replica HTTP Listener (TCP-In)"
   ```

>Note: You'll receive the properties of this firewall rule. Search for the value of the *Enabled* variable. Now it should be set to **True**.

10. To configure **LON-SVR1** as a Replica server for **Hyper-V Replica**, enter the following command in the PowerShell window, and then select Enter:

   ```powershell-notab
Set-VMReplicationServer -ReplicationEnabled $true -AllowedAuthenticationType Kerberos -ReplicationAllowedFromAnyServer $true -DefaultStorageLocation c:\ReplicaStorage
   ```

11. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
Get-VMReplicationServer
   ```

>Note: You should get the configuration setting that you configured in the previous step, which is as follows:
   >
   > - **RepEnabled:True**
   > - **AuthType:Kerb**
   > - **KerAuthPort:80**
   > - **CertAuthPort:443**
   > - **AllowAnyServer:True**

12. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
Get-VM
   ```

>Note: **LON-CORE1** should be listed as a virtual machine (VM) that's configured on this Hyper-V server. Leave the **Administrator: Windows PowerShell ISE** window open.

13. Select **Start**, and then enter **Windows PowerShell ISE**. This will open another instance of Windows PowerShell ISE.

14. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$cred=Get-Credential
   ```

15. When prompted, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

16. In the **Administrator: Windows PowerShell** window, enter the following command, and then select Enter:

   ```powershell-notab
$sess1 = New-PSSession -Credential $cred -ComputerName LON-svr2.contoso.com
   ```

17. Next, enter the following command, and then select Enter:

   ```powershell-notab
Enter-PSSession $sess1
   ```

>Note: You should get a [LON-svr2.contoso.com] title in your command prompt. From this point, all commands that you enter run on **LON-SVR2**.

18. Repeat steps 7 through 12 in the PowerShell ISE window where you have a session opened on **LON-svr2.contoso.com**. This will configure **LON-SRV2** for **Hyper-V Replica**. 

>Note: In step 12, you should get no result when running the **Get-VM** command because no VMs are configured on **LON-SVR2**.

19. Leave both PowerShell sessions open for the next task.

### Task 2: Configure VM replication

1. Switch to the PowerShell window where you have a remote PowerShell session opened for **LON-svr1.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Enable-VMReplication LON-CORE1 -ReplicaServerName LON-SVR2.contoso.com -ReplicaServerPort 80 -AuthenticationType Kerberos -computername LON-SVR1.contoso.com
   ```

>Note: If you recieve an error stating that the clocks on the client and server machines are skewed, sign in to both LON-SVR1 and LON-SVR2. You can verify the date and time settings by selecting menu option 9 in the Server Configuration tool. After you sign in to both machines, rerun the command from step 1.


2. After you've verified that you didn't receive any error message from the previous command, enter the following command, and then select Enter:

   ```powershell-notab
   Start-VMInitialReplication LON-CORE1
   ```

>Note: This starts the initial replication process for the VM **LON-CORE1**, from **LON-SVR1** to **LON-SVR2**.

3. After you've verified that you didn't receive any error message from the previous command, enter the following command, and then select Enter:

   ```powershell-notab
   Get-VMReplication
   ```

>Note: This command retrieves the replication status.

>Note: In the result table, search for the value in the **State** column. It should be **InitialReplicationInProgress**. Wait for five minutes, and then repeat this command. Verify that the value in the **State** column is **Replicating**. Don't proceed to the next steps until you get this value. Additionally, ensure that **Primary server** is set to **LON-SVR1** and **ReplicaServer** is set to **LON-SVR2**.

4. Switch to the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   get-vm
   ```

>Note: Verify that you now have the **LON-CORE1** VM on **LON-SVR2**. This means that the VM successfully replicated.

5. Leave both Windows PowerShell sessions open for the next task.

### Task 3: Validate a failover

1. Switch to the PowerShell window where you have a remote PowerShell session opened for **LON-svr1.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Start-VMFailover -Prepare -VMName LON-CORE1 -computername LON-SVR1.contoso.com
   ```

>Note: When prompted, select **Yes to All**. This command prepares for the planned failover of **LON-CORE1** by replicating any pending changes.

2. Switch to the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Start-VMFailover -VMName LON-CORE1 -computername LON-SVR2.contoso.com
   ```

>Note: When prompted, select **Yes to all**. This command fails over the replica VM.

3. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Set-VMReplication -Reverse -VMName LON-CORE1 -computername LON-SVR2.contoso.com
   ```

>Note: This command switches the replica VM to a primary VM.

4. In the PowerShell window where you have the remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Start-VM -VMName LON-CORE1 -computername LON-SVR2.contoso.com
   ```

>Note: This command starts the VM that's been switched from a replica VM to a primary VM.

5. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Get-VM
   ```

>Note: In the resulting table, search for the value in the **State** column. It should be **Running**.

6. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
   Get-VMReplication
   ```

>Note: In the resulting table, search for the value in the **State** column. It should be **Replicating**. Additionally, ensure that the **Primary server** is now set to **LON-SVR2** and that **ReplicaServer** is set to **LON-SVR1**.

7. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following command, and then select Enter:

   ```powershell-notab
Stop-VM LON-CORE1
   ```

8. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr1.contoso.com**, enter the following commands, and then select Enter:

```
Exit-PSSession
Remove-PSSession $sess
```
9. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr2.contoso.com**, enter the following commands, and then select Enter:

   ```
Exit-PSSession
   ```
   ```
Remove-PSSession $sess1
   ```

10. Close both PowerShell windows.

>Note: If you want to verify the results of this exercise by using graphical user interface (GUI) tools, you can start Hyper-V Manager on **LON-ADM1**, and then add the **LON-SVR1** and **LON-SVR2** servers to the **Hyper-V** console. You can then verify that the **LON-CORE1** VM exists on both **LON-SVR1** and **LON-SVR2** and that replication is running from **LON-SVR2** to **LON-SVR1**.

**Results**: After completing this exercise, you should have configured **Hyper-V Replica** and tested failover.

## Exercise 2: Configure and implement backup with Windows Server Backup

### Scenario

You need to evaluate **Windows Server Backup** for your servers. You decide to configure **Windows Server Backup** on **LON-SVR1** and perform a trial backup to a network share located on **LON-ADM1**.

The main tasks for this exercise are to:

1. Configure **Windows Server Backup** options.
2. Perform a backup.

### Task1: Configure Windows Server Backup options

1. If necessary, sign in to **LON-ADM1** as **`Contoso\Administrator`** with password **`Pa55w.rd`**.

2. Select **File Explorer** on the taskbar.

3. In the **File Explorer** window, select **Local Disk (C:)** in the **navigation** pane.

4. Right-click or access the context menu in an empty space in the **details** pane, select **New**, and then select **Folder**. You can also open **File Explorer**, select the **Home** menu, and then select the **New Folder** option. Name the new folder **`BackupShare`**. 

5. Right-click or access the context menu for the **BackupShare** folder, select **Give access to**, and then select **Specific people**.

6. In the **Network access** window, enter **`Authenticated Users`**, and then select **Add**. In the **Permission Level** column, set the value for **Authenticated Users** to **Read/Write**, select **Share**, and then select **Done**.

7. Select **Start**, and then select **Windows PowerShell ISE**. 

8. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
   $cred=Get-Credential
   ```

>Note: When prompted, sign in as **`Contoso\Administrator`** with password **`Pa55w.rd`**

9. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
   $sess = New-PSSession -Credential $cred -ComputerName LON-svr1.contoso.com
   ```

   Next, enter the following command, and then select Enter:

   ```powershell-notab
   Enter-PSSession $sess
   ```

>Note: You should get a [LON-svr1.contoso.com] title in your command prompt. From this point, all commands that you enter run on **LON-SVR1**.

10. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
Import-Module Servermanager
   ```

   Next, enter the following command, and then select Enter:

   ```powershell-notab
Get-WindowsFeature Windows-Server-Backup
   ```

>Note: Ensure that the **Install State for Windows Server Backup** feature is **Available**.

11. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
Install-WindowsFeature Windows-Server-Backup
   ```

>Note: Wait until you get the result. Ensure that **True** displays in the **Success** column.

12. Repeat the command:

   ```powershell-notab
Get-WindowsFeature Windows-Server-Backup
   ```

>Note: Ensure that the **Install State for Windows Server Backup** feature is now **Installed**.

13. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
wbadmin /?
   ```

>Note: You'll get the list of commands that are available for the **Windows Server Backup** command-line tool.

14. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
Get-Command -Module WindowsServerBackup -CommandType Cmdlet
   ```

>Note: You'll get a list of available PowerShell cmdlets for **Windows Server Backup**.

### Task 2: Perform a backup

1. In the PowerShell window where you have a remote PowerShell session opened for **LON-svr1.contoso.com**, enter the following commands, and then select Enter:

   ```
$Policy = New-WBPolicy
   ```
   ```
$Filespec = New-WBFileSpec -FileSpec "C:\Files"
   ```

2. After you've run the commands from the previous step, where you defined variables for the backup policy and the file path to back up, add this to the backup policy by entering the following command, and then selecting Enter:

   ```powershell-notab
Add-WBFileSpec -Policy $Policy -FileSpec $FileSpec
   ```

3. Now, you must configure a backup location on the **LON-ADM1** network share by entering the following commands, and then selecting Enter:

   ```
   $Cred = Get-Credential
   ```
>Note:  When prompted, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**

   ```
$NetworkBackupLocation = New-WBBackupTarget -NetworkPath "\\LON-ADM1\BackupShare" -Credential $Cred
   ```

4. Now you must add this backup location to the backup policy by entering the following command, and then selecting Enter (if prompted, enter **Y**, and then select Enter):

   ```powershell-notab
Add-WBBackupTarget -Policy $Policy -Target $NetworkBackupLocation
   ```

5. Before starting a backup job, you must configure more options to enable Volume Shadow Copy Service backups by entering the following command, and then selecting Enter:

   ```powershell-notab
Set-WBVssBackupOptions -Policy $Policy -VssCopyBackup
   ```

6. To start a backup job, to back up the content of the **C:\\Files** folder on **LON-SVR1** to a network share on **LON-ADM1**, you must enter the following command, and then select Enter:

   ```powershell-notab
   Start-WBBackup -Policy $Policy
   ```

>Note: Wait until you receive the "The backup operation completed" message. 

7. On **LON-ADM1**, open File Explorer, and then browse to **C:\\BackupShare**. Open the folder, and then ensure that the backup files are there.

8. Close all open windows on **LON-ADM1**.

**Results**: After completing this exercise, you should have configured **Windows Server Backup** and performed a backup.
