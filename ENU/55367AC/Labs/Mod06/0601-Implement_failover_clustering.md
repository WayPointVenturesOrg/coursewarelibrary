---
lab:
    title: 'Lab: Implement failover clustering'
    module: 'Module 6: High availability in Windows Server'
---

# Lab: Implement failover clustering

## Scenario

As a senior network administrator at Contoso Ltd., you're responsible for implementing failover clustering on servers that are running Windows Server 2022. This implementation provides high availability for network services and applications. You will implement the failover-cluster configuration and deploy applications and services on the failover cluster.

## Objectives

After completing this lab, you'll be able to:

- Configure Internet Small Computer System Interface (iSCSI) storage.
- Configure a failover cluster.
- Deploy and configure a highly available file server
- Validate the deployment of the highly available file server.

## Estimated time: 60 minutes
## Exercise 1: Configure iSCSI storage

### Scenario

Contoso has applications and services that it requires to make its servers highly available. You decide to use iSCSI storage for failover clustering, so you'll install failover clustering on LON-SVR2 and LON-SVR3, and then you'll configure iSCSI storage to support your failover cluster.

The main tasks for this exercise are to:

1. Install the **Failover Clustering** feature.
2. Configure iSCSI virtual disks.

### Task 1: Install the Failover Clustering feature

1. Sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

2. On **LON-ADM1**, select **Start**, and then select **Windows PowerShell ISE**. 

3. In the **Administrator: Windows PowerShell ISE** command-prompt window, enter the following command, and then select Enter:

   ```powershell-notab
   Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
   ```

>Note: This command installs the **Failover Clustering** feature on LON-ADM1. Wait until the installation process is complete and a command prompt appears.

4. On **LON-ADM1**, repeat step 2 to open a new PowerShell ISE session that you'll use to connect to the **LON-SVR2** server.

5. In the new **Administrator:Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$cred=Get-Credential
   ```

6. When prompted, provide the credentials of **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

7. In the new **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$sess = New-PSSession -Credential $cred -ComputerName lon-svr2.contoso.com
   ```

8. After running the previous command, enter the following command, and then select Enter:

   ```powershell-notab
Enter-PSSession $sess
   ```

9. Verify that **lon-svr2.contoso.com** appears at the beginning of the command prompt.

>Note: You're now connected to **LON-SVR2** using PowerShell remoting.

10. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR2**, enter the following command, and then select Enter:

   ```powershell-notab
Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
   ```

11. On **LON-ADM1**, repeat step 2 to open a third PowerShell ISE session, which you'll use to connect to the **LON-SVR3** server.

12. To install the **Failover Clustering** feature on **LON-SVR3**, in the third **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$cred=Get-Credential
   ```

13. When prompted, provide the credentials of **`Contoso\Administrator`** with password **`Pa55w.rd`**.

14. In the third **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$sess = New-PSSession -Credential $cred -ComputerName lon-svr3.contoso.com
   ```

15. After running the previous command, enter the following command, and then select Enter:

   ```powershell-notab
Enter-PSSession $sess
   ```

16. Verify that **lon-svr3.contoso.com** appears at the beginning of the command prompt.

>Note: You're now connected to **LON-SVR3** by using PowerShell remoting.

17. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR3**, enter the following command, and then select Enter:

   ```powershell-notab
Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
   ```

18. Switch to the **Administrator: Windows PowerShell ISE** window for **LON-ADM1**, enter the following command, and then select Enter:

   ```powershell-notab
Add-WindowsFeature FS-iSCSITarget-Server
   ```

>Note: This command installs the **iSCSI Target Server** role on **LON-ADM1**. Wait until the installation finishes and the command prompt returns.

>Note: Verify that the failover-clustering installation is complete on **LON-SVR2** and **LON-SVR3**. If not, wait until the installation is complete, and then continue with the following steps.

19. In the PowerShell window for **LON-SVR2**, enter the following command, and then select Enter:

   ```powershell-notab
Restart-Computer
   ```

20. In the PowerShell window for **LON-SVR3**, enter the following command, and then select Enter:

   ```powershell-notab
Restart-Computer
   ```

21. In the PowerShell window for **LON-ADM1**, enter the following command, and then select Enter:

   ```powershell-notab
Restart-Computer
   ```

>Note: Wait for 3 to 4 minutes for all three servers to restart before continuing with the next task.

### Task 2: Configure iSCSI virtual disks

1. Sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

2. Select **Start**, and then select **Windows PowerShell ISE**.

3. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
New-IscsiVirtualDisk c:\Storage\disk1.VHDX –size 10GB
   ```

4. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
New-IscsiVirtualDisk c:\Storage\disk2.VHDX –size 10GB
   ```

5. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
New-IscsiVirtualDisk c:\Storage\disk3.VHDX –size 10GB
   ```

6. To open another **Windows PowerShell ISE** window, so you can connect to **LON-SVR2**, select **Start**, and then select **Windows PowerShell ISE**.

7. In the new **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$cred=Get-Credential
   ```

8. When prompted, provide the credentials as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

9. In the new **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$sess = New-PSSession -Credential $cred -ComputerName lon-svr2.contoso.com
   ```

10. After running the previous command, enter the following command, and then select Enter:

   ```powershell-notab
Enter-PSSession $sess
   ```

>Note: Verify that **lon-svr2.contoso.com** appears at the beginning of the command prompt. You're now connected to **LON-SVR2** by using PowerShell remoting.

11. To open another **Windows PowerShell ISE** window, so you can connect to **LON-SVR3**, select **Start**, and then select **Windows PowerShell ISE**.

12. In the third **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$cred=Get-Credential
   ```

13. When prompted, provide the credentials as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

14. In the third **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell-notab
$sess = New-PSSession -Credential $cred -ComputerName lon-svr3.contoso.com
   ```

15. After running the previous command, enter the following command, and then select Enter:

   ```powershell-notab
Enter-PSSession $sess
   ```

16. Verify that **lon-svr3.contoso.com** appears at the beginning of the command prompt.

>Note: You should have three **Windows PowerShell ISE** windows opened. Ensure that you always use the proper PowerShell session window that's connected to the specific server on which you want to run a command.

17. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR2**, start the **Microsoft iSCSI Initiator** service by entering the following commands, selecting Enter after each:

   ```
Start-Service msiscsi
Set-Service msiscsi -startuptype "automatic"
   ```
18. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR3**, start the **Microsoft iSCSI Initiator** service by entering the following commands, selecting Enter after each:

   ```
Start-Service msiscsi
Set-Service msiscsi -startuptype "automatic"
   ```
19. On **LON-ADM1**, in the local machine's **Administrator: Windows PowerShell ISE** window, enter:

   ```powershell-notab
New-IscsiServerTarget iSCSI-MOD6 -InitiatorIds "IQN:iqn.1991-05.com.microsoft:lon-svr2.contoso.com","IQN:iqn.1991-05.com.microsoft:lon-svr3.contoso.com"
   ```

### Results

After completing this exercise, you'll have successfully installed the **Failover Clustering** feature and configured the iSCSI Target Server.

## Exercise 2: Configure a failover cluster

### Scenario

In this exercise, you'll configure a failover cluster by implementing the core components for failover clustering. You'll then validate the cluster and create the failover cluster.

The main tasks for this exercise are to:

1. Connect clients to the iSCSI targets.
2. Initialize the disks.
3. Validate and create a failover cluster.

### Task 1: Connect clients to the iSCSI targets

1. In the PowerShell window for **LON-ADM1**, enter each of the following commands, selecting Enter after each:

   ```
Add-IscsiVirtualDiskTargetMapping iSCSI-MOD6 c:\Storage\Disk1.VHDX
   ```
   ```   
Add-IscsiVirtualDiskTargetMapping iSCSI-MOD6 c:\Storage\Disk2.VHDX
   ```
   ```   
Add-IscsiVirtualDiskTargetMapping iSCSI-MOD6 c:\Storage\Disk3.VHDX
   ```

2. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR2**, enter the following commands, selecting Enter after each:

   ```
New-iSCSITargetPortal –TargetPortalAddress LON-ADM1.contoso.com
   ```
   ```   
Connect-iSCSITarget –NodeAddress iqn.1991-05.com.microsoft:lon-adm1-iscsi-mod6-target
   ```
   ```   
Get-iSCSITarget | fl
   ```

3. Verify that after running the last command, the value for the *IsConnected* variable is True.

>Note: This validates that **LON-SVR2** is now connected to the iSCSI target server.

4. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR3**, enter the following commands, selecting Enter after each:

   ```
New-iSCSITargetPortal –TargetPortalAddress LON-ADM1.contoso.com
   ```
   ```   
Connect-iSCSITarget –NodeAddress iqn.1991-05.com.microsoft:lon-adm1-iscsi-mod6-target
   ```
   ```   
Get-iSCSITarget | fl
   ```

5. Verify that after you run the last command, the value for the *IsConnected* variable is True.

>Note: This validates that **LON-SVR3** is now connected to the iSCSI target server.

### Task 2: Initialize the disks

1. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR2**, enter the following command, and then select Enter:

   ```powershell-notab
   Get-Disk
   ```

>Note: Ensure that three disks are in the **Offline** operational status. These should be disks with numbers 4, 5, and 6.

2. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR2**, enter the following commands, selecting Enter after each:

   ```
   Get-Disk | Where OperationalStatus -eq 'Offline' | Initialize-Disk -PartitionStyle MBR
   ```
   ```   
   New-Partition -DiskNumber 4 -Size 5gb -AssignDriveLetter
   ```
   ```   
   New-Partition -DiskNumber 5 -Size 5gb -AssignDriveLetter
   ```
   ```   
   New-Partition -DiskNumber 6 -Size 5gb -AssignDriveLetter
   ```
   ```   
   Format-Volume -DriveLetter E -FileSystem NTFS
   ```
   ```   
   Format-Volume -DriveLetter F -FileSystem NTFS
   ```
   ```   
   Format-Volume -DriveLetter G -FileSystem NTFS
   ```

### Task 3: Validate and create a failover cluster

1. Switch to **LON-SVR2**, and then sign in as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

>Note: You must sign in to **LON-SVR2** because you can't run cluster commands over remote PowerShell.

2. At the **SConfig** menu, enter `15` to exit to the command line, and then select Enter.

3. At the command prompt on **LON-SVR2**, enter **`Test-Cluster LON-SVR2, LON-SVR3`**, and then select Enter.

>Note: Wait a few minutes for the cluster-validation test to complete. You can expect a few warning messages to appear, but there should be no errors.

4. At the command prompt on **LON-SVR2**, enter the following command, and then select Enter:

```
New-Cluster -Name WFC2022 -Node lon-svr2 -StaticAddress 172.16.0.125
```

>Note: A cluster name of **Name WFC2022** should display as a result. Verify that there are no errors.

5. At the command prompt on **LON-SVR2**, enter the following command, and then select Enter:

   ```powershell-notab
   Add-ClusterNode -Name LON-SVR3
   ```

>Note: When a command prompt appears, verify that no errors are reported.

### Results

After completing this exercise, you'll have installed and configured the **Failover Clustering** feature.

## Exercise 3: Deploy and configure a highly available file server

### Scenario

After you have created a cluster infrastructure, you decide to configure a highly available file server and implement settings for failover and failback.

The main tasks for this exercise are to:

1. Add the file-server application to the failover cluster.
2. Add a shared folder to a highly available file server.
3. Configure the failover and failback settings.

### Task 1: Add the file-server application to the failover cluster

1. Switch to **LON-ADM1**.

2. On **LON-ADM1**, open **Server Manager**, and then from the **Tools** menu, select **Failover Cluster Manager**.

3. In the **Failover Cluster Manager** console, select **Connect to Cluster**.

4. To connect to the cluster that you created in the previous exercise, in the **Select Cluster** window, enter **`WFC2022`**, and then select **OK**.

5. Expand **WFC2022.contoso.com**, select **Roles**, and then notice that no roles display. This is because no cluster roles are configured yet.

6. Select **Nodes**, and then notice that the **LON-SVR2** and **LON-SVR3** nodes both display a status of **Up**.

7. Expand **Storage**, and then select **Disks**. 

>Note: Notice that three cluster disks have a status of **Online**.

8. On the **Failover Cluster Manager** page, right-click or access the context menu for **Roles**, and then select **Configure Role**.

9. On the **Before You Begin** page, select **Next**.

10. On the **Select Role** page, select **File Server**, and then select **Next**.

11. On the **File Server Type** page, select **File Server for general use**, and then select **Next**.

12. On the **Client Access Point** page, in the **Name** box, enter **`FSCluster`**.

13. In the **Address** box, enter **`172.16.0.130`**, and then select **Next**.

14. On the **Select Storage** page, select **Cluster Disk 1** and **Cluster Disk 2**, and then select **Next**.

15. On the **Confirmation** page, select **Next**.

16. On the **Summary** page, select **Finish**.

17. In the **Storage** node, select **Disks**.

>Note: Verify that three cluster disks are online. **Cluster Disk 1** and **Cluster Disk 2** should be assigned to **FSCluster**.

### Task 2: Add a shared folder to a highly available file server

1. On **LON-ADM1**, in **Failover Cluster Manager**, select **Roles**, select **FSCluster**, and then in the **Actions** pane, select **Add File Share**.
2. On the **Select Profile** page, select **SMB Share - Quick**, and then select **Next**.
3. On the **Share Location** page, select **Next**.
4. On the **Share Name** page, enter **`Docs`** for the share name, and then select **Next**.
5. On the **Other Settings** page, select **Next**.
6. On the **Permissions** page, select **Next**.
7. On the **Confirmation** page, select **Create**.
8. On the **View results** page, select **Close**.

### Task 3: Configure the failover and failback settings

1. On **LON-ADM1**, in the **Failover Cluster Manager** console, select **Roles**, select **FSCluster**, and then select **Properties**.

2. Select the **Failover** tab, and then select **Allow failback**.

3. Select **Failback between**, and then enter:

   - **`4`** in the first text box.
   - **`5`** in the second text box.

4. Select the **General** tab.

5. Under **Preferred owners**, select both **LON-SVR2** and **LON-SVR3**.

6. Select the **LON-SVR3** object, select **Up**, and then select **OK**.

>Note: **LON-SVR3** is now the first preferred owner.

### Results

After completing this exercise, you'll have configured a highly available file server.

## Exercise 4: Validate deployment of a highly available file server

### Scenario

When you implement a failover cluster, you want to perform failover and failback tests. Additionally, you want to change the witness disk in the quorum.

The main tasks for this exercise are to:

1. Validate the highly available file-server deployment.
2. Validate the failover and quorum configuration for the **File Server** role.

### Task 1: Validate the highly available file-server deployment

1. On **LON-ADM1**, open File Explorer, and then try to access the **\\\FSCluster** location.

2. In **FSCluster**, open the **Docs** folder.

>Note: Verify that you can access the **Docs** folder.

3. Inside the **Docs** folder, right-click within the folder to access the context menu, select **New**, and then select **Text Document**.

4. To accept the document's default name of **New Text Document.txt**, select Enter.

5. In the **Failover Cluster Manager** console, right-click or access the context menu for **FSCluster**, select **Move**, select **Select Node**, choose the available node from the **Cluster nodes** list, and then select **OK**.

6. On **LON-ADM1**, in File Explorer, verify that you can still access the **\\\FSCluster** location.

### Task 2: Validate the failover and quorum configuration for the File Server role

1. On **LON-ADM1**, in **Failover Cluster Manager**, determine the current owner for the **FSCluster** role. If you select **Roles** and observe the value in the **Owner Node** column, it should be **LON-SVR2** or **LON-SVR3**.
2. Select **Nodes**, and then right-click or access the context menu for the node that's the current owner of the **FSCluster** role.
3. Select **More Actions**, and then select **Stop Cluster Service**.
4. Try to access **\\\FSCluster** from **LON-ADM1** to verify that **FSCluster** has moved to another node and that the **\\\FSCluster** location is still available.
5. Select **Nodes**, and then right-click or access the context menu for the node that has the status of **Down**.
6. Select **More Actions**, and then select **Start Cluster Service**.
7. In the **Failover Cluster Manager** console, right-click or access the context menu for the **WFC2022.Contoso.com** cluster, select **More Actions**, and then select **Configure Cluster Quorum Settings**.
8. On the **Before you begin** page, select **Next**.
9. On the **Select Quorum Configuration Options** page, select **Use default quorum configuration**, and then select **Next**.
10. On the **Confirmation** page, select **Next**, and then select **Finish**.
11. Browse to the **Disks** node, select the disk marked **Disk Witness in Quorum**, and then in the **Actions** pane, select **Take Offline**.
12. In the **Offline Cluster Disk** prompt, select **Yes**.
13. Verify that **FSCluster** is still available by trying to access it from **LON-ADM1**.
14. In the **Failover Cluster Manager** console, select the disk marked **Disk Witness in Quorum**, and then in the **Actions** pane, select **Bring Online**.
15. On **LON-ADM1**, close all open windows.

### Results

After completing this exercise, you validated high availability when using the **Failover Clustering** feature.
