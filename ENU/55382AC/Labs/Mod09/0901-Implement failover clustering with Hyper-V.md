---
lab:
    title: 'Lab: Implement failover clustering with Hyper-V'
    module: 'Module 9: Implementing failover clustering for Hyper-V virtual machines'
---

# Lab: Implement failover clustering with Hyper-V

## Scenario

The initial deployment of virtual machines (VMs) on Hyper-V has been successful for Contoso. As a next step in VM deployment, you're considering ways to ensure that the services and applications deployed on the VMs are highly available. As part of the high-availability implementation, you also need to consider options for making VMs that run on Hyper-V highly available.

As a Contoso senior network administrator, you're responsible for integrating Hyper-V with failover clustering to ensure that VMs deployed on Hyper-V are highly available, for planning VM and storage configuration, and for implementing VMs as highly available services on the failover cluster. 

## Objectives

After completing this lab, you'll be able to:

- Configure a failover cluster for Hyper-V.
- Configure a highly available VM.

## Estimated time: 60 minutes

## Exercise 1: Configure a failover cluster for Hyper-V

### Scenario

You're responsible for implementing Hyper-V VMs as highly available services on a failover cluster, which will use Internet Small Computer System Interface (iSCSI) storage that's already configured and available on **LON-SVR4**. You need to first connect the cluster nodes (**LON-SVR2** and **LON-SVR3**) to the iSCSI storage. Next, you'll install and configure failover clustering and prepare the disk storage for the cluster.

The main tasks for this exercise are:

1. Connect cluster nodes to iSCSI shared storage.
2. Install the **Failover Clustering** feature.
3. Validate and create a failover cluster.
4. Configure disks for a failover cluster.

### Task 1: Connect cluster nodes to iSCSI shared storage

1. Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password **Pa55w.rd**.

2. Select **Start** and then select **Server Manager**.

3. In **Server Manager**, select **Tools**, and then select **iSCSI Initiator**.

4. In the **Microsoft iSCSI** dialog box, select **Yes**.

5. In the **iSCSI Initiator** **Properties** window, select the **Discovery** tab, and then select **Discover Portal**.

6. In the **IP address or DNS name** text box, enter **172.16.0.24**, and then select **OK**.

7. Select the **Targets** tab, and then select **Refresh**. 

8. In the **Targets** list, select **iqn.1991-05.com.microsoft:lon-svr4-svr4target-target**, and then select **Connect**.

9. Ensure that **Add this connection to the list of Favorite Targets** is selected, and then select **OK** two times.

10. Switch to **LON-SVR3**.

11. Sign in to **LON-SVR3** as **Contoso\\Administrator** with the password **Pa55w.rd**.

12. On **LON-SVR3**, open **Server Manager**, select **Tools**, and then select **iSCSI Initiator**.

13. In the **Microsoft iSCSI** dialog box, select **Yes**.

14. In the **iSCSI Initiator Properties** window, select the **Discovery** tab, and then select **Discover Portal**.

15. In the **IP address or DNS name** text box, enter **172.16.0.24**, and then select **OK**.

16. Select the **Targets** tab, and then select **Refresh**.

17. In the **Targets** list, select **iqn.1991-05.com.microsoft:lon-svr4-svr4target-target**, and then select **Connect**.

18. Ensure that the **Add this connection to the list of Favorite Targets** checkbox is selected, and then select **OK** two times.

19. Switch to **LON-SVR2**.

20. On **LON-SVR2**, in **Server Manager**, select **Tools**, and then select **Computer Management**.

21. Expand **Storage**, and then select **Disk Management**.

22. Right-click or access the context menu for **Disk 5**, and then select **Online**. 

    > **Note:** This should be the first disk that has 20.00 gigabytes (GB) unallocated.

23. Right-click or access the context menu for **Disk 5**, and then select **Initialize Disk**. 

24. In the **Initialize Disk** dialog box, select **OK**.

25. Right-click or access the context menu for the unallocated space next to **Disk 5**, and then select **New Simple Volume**.

26. On the **Welcome** page, select **Next**.

27. On the **Specify Volume Size** page, select **Next**.

28. On the **Assign Drive Letter or Path** page, select **Next**.

29. On the **Format Partition** page, in the **Volume label** text box, enter **ClusterDisk**. Select the **Perform a quick format** checkbox, and then select **Next**.

30. Select **Finish**.

31. Repeat steps 22 through 30 for **Disk 6** and **Disk 7**, using **ClusterVMs** and **Quorum**, respectively, for volume labels. 

    > **Note:** These should be the second and third disks that have 20.00 GB unallocated.

32. Close the **Computer Management** window. 

33. Switch to **LON-SVR3**.

34. On **LON-SVR3**, in Server Manager, select **Tools**, and then select **Computer Management**.

35. Expand **Storage**, and select **Disk Management**.

36. Select and right-click or access the context menu for **Disk Management**, and then select **Refresh**.

37. Right-click or access the context menu for **Disk 3**, and then select **Online**.

38. Right-click or access the context menu for **Disk 4**, and then select **Online**.

39. Right-click or access the context menu for **Disk 5**, and then select **Online**.

    > **Note:** Be sure that the online disks that you switch to indicate they're 20.00 GB in size.

40. Close the **Computer Management** window.


### Task 2: Install the Failover Clustering feature

1. Switch to **LON-SVR2**.

2. On **LON-SVR2**, select **Start**, and then select **Windows PowerShell ISE**. 

3. In the **Administrator: Windows PowerShell ISE** command-prompt window, enter the following command, and then select Enter:

   ```powershell
   Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
   ```

   > This command installs the **Failover Clustering** feature on LON-SVR2.

4. On **LON-SVR2**, repeat step 2 to open a new PowerShell Integrated Scripting Environment (ISE) session that you'll use to connect to the **LON-SVR3** server.

5. In the new **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell
   $cred=Get-Credential
   ```

6. When prompted, provide the credentials as **Contoso\\Administrator** with password **Pa55w.rd**.

7. In the new **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```powershell
   $sess = New-PSSession -Credential $cred -ComputerName lon-svr3.contoso.com
   ```

8. After running the previous command, enter the following command, and then select Enter:

   ```powershell
   Enter-PSSession $sess
   ```

9. Verify that **`lon-svr3.contoso.com`** appears at the beginning of the command prompt.

   > You're now connected to **LON-SVR3** using PowerShell remoting.

10. In the **Administrator: Windows PowerShell ISE** window for **LON-SVR3**, enter the following command, and then select Enter:

    ```powershell
    Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
    ```

    > Wait until the Failover clustering feature installation is complete on **LON-SVR2** and **LON-SVR3**, and then continue with the following steps. 

11. <!--- CONAN: Can we remove everything up to "close" since we just said it in the sentence above, and then just start with Close both..."? ---> After the Failover clustering feature is installed on LON-SVR2 and LON-SVR3, close both Windows PowerShell ISE windows.

### Task 3: Validate and create a failover cluster

1. On **LON-SVR2**, select **Start**, and then select **Windows PowerShell ISE**.

1. At the **Windows PowerShell ISE** command prompt, enter **`Test-Cluster LON-SVR2, LON-SVR3`**, and then select Enter.

   > Wait for a few minutes for the cluster validation test to complete. You can expect a few warning messages to appear, but there should be no errors.

1. At the **Windows PowerShell ISE** command prompt, enter the following command, and then select Enter:

   ```powershell
   New-Cluster -Name VMCluster -Node lon-svr2 -StaticAddress 172.16.0.126
   ```

   > You should receive a cluster name as a result. It should display **Name VMCluster**. Verify that there are no errors.

1. At the **Windows PowerShell ISE** command prompt,  enter the following command, and then select Enter:

   ```powershell
   Add-ClusterNode -Name LON-SVR3
   ```

   > This command adds LON-SVR3 as a second node to the cluster. When a command prompt appears, verify that no errors are reported.

5. Close the **Windows PowerShell ISE**.


### Task 4: Configure disks for a failover cluster

1. On **LON-SVR2**, in the **Server Manager** console, select **Tools** and then select **Failover Cluster Manager**.

2. In the **Failover Cluster Manager** console, expand **VMCluster.Contoso.com**, expand **Storage**, and then select **Disks**. 

3. Ensure that three disks named **Cluster Disk 1**, **Cluster Disk 2**, and **Cluster Disk 3** are present and online.

4. Right-click or access the context menu for **Cluster Disk 1**, and then select **Add to Cluster Shared Volumes**.

5. Right-click or access the context menu for **VMCluster.Contoso.com**, select **More Actions**, select **Configure Cluster Quorum Settings**, and then select **Next**.

6. On the **Select Quorum Configuration Option** page, select **Use default quorum configuration**, and then select **Next**.

7. On the **Confirmation** page, select **Next**.

8. On the **Summary** page, select **Finish.**

9. Ensure that **LON-SVR2** is the owner of the disk that you just assigned to the **Cluster Shared Volume**. You can read the owner value in the **Owner Node** column. If that isn't the case, then move the disk to **LON-SVR2** before proceeding to the next task. 

> **Note:** To move the disk: 
>
> - Right-click or access the context menu for **Cluster Disk 1**, and then select **Move**. 
>
> - Select **Select Node**, select **LON-SVR2**, and then select **OK**.
>

### Results

After completing this exercise, you'll have successfully configured the failover-clustering infrastructure for Hyper-V.

## Exercise 2: Configure a highly available VM

### Scenario

After you have configured the Hyper-V failover cluster, you need to add VMs as highly available resources.

The main tasks for this exercise are:

1. Move VM storage to the Cluster Shared Volume.

2. Configure the VM as highly available.

3. Failover a highly available VM.

4. Configure drain on shutdown.

### Task 1: Move VM storage to the Cluster Shared Volume

1. On **LON-SVR2**, from the taskbar, select **Hyper-V Manager**.

2. In **Hyper-V Manager**, in the **Virtual Machines** section, select **LON-SVR5**.

3. In the **Actions** pane, under **LON-SVR5**, select **Move**.

   > The **Move "LON-SVR5" Wizard** starts.

4. On the **Before You Begin** page, select **Next**.

5. On the **Choose Move Type** page, select **Move the virtual machine's storage** and then select **Next**.

6. On the **Choose Options for Moving Storage** page, select **Move all of the virtual machine's data to a single location**, and then select **Next**.

7. On the **Choose a new location for virtual machine** page, in the **Folder** box, enter **`C:\ClusterStorage\Volume1\`** and then select **Next**.

8. On the **Completing Move Wizard** page, select **Finish**.

9. Close **Hyper-V Manager**.


### Task 2: Configure the VM as highly available

1. On **LON-SVR2**, in the **Failover Cluster Manager** console, expand **VMCluster.Contoso.com**, and then select **Roles**.

2. Right-click or access the context menu for **Roles**, and then select **Configure Role**.

   > The **High Availability Wizard** starts.

3. On the **Before You Begin** page, select **Next**.

4. On the **Select Role** page, select **Virtual Machine**, and then select **Next**.

5. On the **Select Virtual Machine** page, select **LON-SVR5** and then select **Next**.

6. On the **Confirmation** page, select **Next**.

7. On the **Summary** page, ensure that the result is successful, and then select **Finish**.

   > Notice that **LON-SVR5** is now available in Failover Cluster Manager. 

8. Right-click or access the context menu for **LON-SVR5**, and then select **Start**.

   > Ensure that **LON-SVR5** starts successfully.

### Task 3: Failover a highly available VM

1. On **LON-SVR2**, in the **Failover Cluster Manager** console, expand **VMCluster.Contoso.com**, and then select **Roles**.

2. Right-click or access the context menu for **LON-SVR5**, select **Move**, select **Live Migration**, and then select **Select Node**.

3. In the **Move Virtual Machine** dialog box, select **LON-SVR3**, and then select **OK**. 

   > Wait until the machine is migrated to **LON-SVR3**. You'll notice that the **Owner** **Node** column changes the value when migration completes.

4. In **Failover Cluster Manager**, right-click or access the context menu for **LON-SVR5**, and select **Shut Down**.

### Task 4: Configure drain on shutdown

1. On **LON-SVR2**,  select **Start**, and then select **Windows PowerShell ISE**.

2. At the **Windows PowerShell ISE** command prompt, enter the following command, and then select Enter:

   ```
   (Get-Cluster).DrainOnShutdown
   ```

   > **Note:** This should return a value of “**1**”.

3. On **LON-SVR2**, switch to **Failover Cluster Manager**.

4. Select **Roles** in **Failover Cluster Manager**.

   > Notice that **LON-SVR3** currently owns **LON-SVR5**.

5. Shut down the **LON-SVR3** VM.

6. On **LON-SVR2**, monitor the **Failover Cluster Manager**, and verify that **LON-SVR5** live migrates to **LON-SVR2** before shutting down **LON-SVR3** .


### Results

After completing this exercise, you'll have successfully configured a VM as highly available.
