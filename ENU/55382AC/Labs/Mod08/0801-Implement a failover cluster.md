---
lab:
    title: 'Lab: Implement a failover cluster'
    module: 'Module 8: Implementing and managing failover clustering'
---

# Lab: Implement a failover cluster

## Scenario

Contoso Ltd. wants to ensure that its critical services, such as file services, are highly available with minimal downtime. You decide to implement a failover cluster with file services to provide improved uptime and availability. 

## Objectives

After completing this lab, you'll be able to:

- Create a failover cluster.
- Verify quorum settings and add a node to the cluster.

## Estimated time: 60 minutes

## Exercise 1: Create a failover cluster

### Scenario

Contoso Ltd. has critical applications and services that need to be highly available. Therefore, you decide to implement failover clustering by using Internet Small Computer System Interface (iSCSI) storage, which you'll configure to support your failover cluster, and then you'll configure a failover cluster. 

To configure a failover cluster, you plan to implement the core components for failover clustering, validate the cluster, and then create the failover cluster. After you create a cluster infrastructure, you're going to configure a highly available file server, and then implement settings for failover and failback. Additionally, you'll also perform failover and failback tests.

The main tasks for this exercise are:

1. Connect cluster nodes to iSCSI shared storage.

2. Install the **Failover Cluster** feature.

3. Validate the servers for failover clustering.

4. Create the failover cluster.

5. Add the file-server application to the failover cluster.

6. Add a shared folder to a highly available file server.

7. Configure failover and failback settings.

8. Validate the highly available file-server deployment.

9. Validate the failover and quorum configuration for the **File Server** role.

### Task 1: Connect cluster nodes to iSCSI shared storage

#### Configure the iSCSI targets

1. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password **Pa55w.rd**.
2. Select **Start**, and then select **Server Manager**.
3. In **Server Manager**, in the **navigation** pane, select **File and Storage Services**.

4. In the **File and Storage Services** pane, select **iSCSI**.

5. In the **iSCSI VIRTUAL DISKS** pane, select **TASKS**, and then, in the **TASKS** drop-down list, select **New iSCSI Virtual Disk**.

6. In the **New iSCSI Virtual Disk Wizard**, on the **Select iSCSI virtual disk location** page, under **Storage location**, select **C:**, and then select **Next**.

7. On the **Specify iSCSI virtual disk name** page, in the **Name** text box, enter **iSCSIDisk1**, and then select **Next**.

8. On the **Specify iSCSI virtual disk size** page, in the **Size** text box, enter **5**, ensure that **GB** is selected in the drop-down list, and then select **Next**.

9. On the **Assign iSCSI target** page, select **New iSCSI target**, and then select **Next**.

10. On the **Specify target name** page, in the **Name** text box, enter **lon-svr1**, and then select **Next**.

11. On the **Specify access servers** page, select **Add**.

12. In the **Select a method to identify the initiator** dialog box, select **Enter a value for the selected type**, and in the **Type** drop-down list, select **IP Address**. In the **Value** text box, enter **172.16.0.22**, and then select **OK**.

13. On the **Specify access servers** page, select **Add**.

14. In the **Select a method to identify the initiator** dialog box, select **Enter a value for the selected type**, and then in the **Type** drop-down list, select **IP Address**. In the **Value** box, enter **172.16.0.23**, and then select **OK**.

15. On the **Specify access servers** page, select **Next**.

16. On the **Enable Authentication** page, select **Next**.

17. On the **Confirm selections** page, select **Create**.

18. On the **View results** page, wait until creation is complete, and then select **Close**.

19. In the **iSCSI VIRTUAL DISKS** pane, select **TASKS**, and then in the **TASKS** drop-down list, select **New iSCSI Virtual Disk**.

20. In the **New iSCSI Virtual Disk Wizard**, on the **Select iSCSI virtual disk location** page, under **Storage location**, select **C:**, and then select **Next**.

21. On the **Specify iSCSI virtual disk name** page, in the **Name** text box, enter **iSCSIDisk2**, and then select **Next**.

22. On the **Specify iSCSI virtual disk size** page, in the **Size** text box, enter **5**, ensure that **GB** is selected in the drop-down list, and then select **Next**.

23. On the **Assign iSCSI target** page, select **lon-svr1**, and then select **Next**.

24. On the **Confirm selections** page, select **Create**.

25. On the **View results** page, wait until the creation is completed, and then select **Close**.

26. In the **iSCSI VIRTUAL DISKS** pane, select **TASKS**, and then in the **TASKS** drop-down list, select **New iSCSI Virtual Disk**.

27. In the **New iSCSI Virtual Disk Wizard**, on the **Select iSCSI virtual disk location** page, under **Storage location**, select **C:**, and then select **Next**.

28. On the **Specify iSCSI virtual disk name** page, in the **Name** text box, enter **iSCSIDisk3**, and then select **Next**.

29. On the **Specify iSCSI virtual disk size** page, in the **Size** text box, enter **5**, ensure that **GB** is selected in the drop-down list, and then select **Next**.

30. On the **Assign iSCSI target** page, select **lon-svr1**, and then select **Next**.

31. On the **Confirm selections** page, select **Create**.

32. On the **View results** page, wait until the creation is complete, and then select **Close**.


#### Connect nodes to the iSCSI targets

1. Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**.

3. In **Server Manager**, select **Tools**, and then select **iSCSI Initiator**.

4. In the **Microsoft iSCSI** dialog box, select **Yes**.

5. In the **iSCSI Initiator** **Properties** window, select the **Discovery** tab, and then select **Discover Portal**.

6. In the **IP address or DNS name** text box, enter **172.16.0.21**, and then select **OK**.

7. Select the **Targets** tab, and then select **Refresh**. 

8. In the **Targets** list, select **iqn.1991-05.com.microsoft:lon-svr1-lon-svr1-target**, and then select **Connect**.

9. Ensure that **Add this connection to the list of Favorite Targets** is selected, and then select **OK** two times.

10. Switch to **LON-SVR3**.

11. Sign in to **LON-SVR3** as **Contoso\\Administrator** with the password **Pa55w.rd**.

12. On **LON-SVR3**, open **Server Manager**, select **Tools**, and then select **iSCSI Initiator**.

13. In the **Microsoft iSCSI** dialog box, select **Yes**.

14. In the **iSCSI Initiator Properties** window, select the **Discovery** tab, and then select **Discover Portal**.

15. In the **IP address or DNS name** text box, enter **172.16.0.21**, and then select **OK**.

16. Select the **Targets** tab, and then select **Refresh**.

17. In the **Targets** list, select **iqn.1991-05.com.microsoft:lon-svr1-lon-svr1-target**, and then select **Connect**.

18. Ensure that the **Add this connection to the list of Favorite Targets** checkbox is selected, and then select **OK** two times.

19. Switch to **LON-SVR2**.

20. On **LON-SVR2**, in **Server Manager**, select **Tools**, and then select **Computer Management**.

21. Expand **Storage**, and then select **Disk Management**.

22. Right-click or access the context menu for **Disk 5**, and then select **Online**. 

    > **Note:** This should be the first disk that has 5.00 gigabytes (GB) unallocated.

23. Right-click or access the context menu for **Disk 5**, and then select **Initialize Disk**. 

24. In the **Initialize Disk** dialog box, select **OK**.

25. Right-click or access the context menu for the unallocated space next to **Disk 5**, and then select **New Simple Volume**.

26. On the **Welcome** page, select **Next**.

27. On the **Specify Volume Size** page, select **Next**.

28. On the **Assign Drive Letter or Path** page, select **Next**.

29. On the **Format Partition** page, in the **Volume label** text box, enter **Data1**. Select the **Perform a quick format** checkbox, and then select **Next**.

30. Select **Finish**.

31. Repeat steps 22 through 30 for **Disk 6** and **Disk 7**, using **Data2** and **Data3**, respectively, for volume labels. 

    > **Note:** These should be the second and third disks that have 5.00 GB unallocated.

32. Close the **Computer Management** window. 

33. Switch to **LON-SVR3**.

34. On **LON-SVR3**, in Server Manager, select **Tools**, and then select **Computer Management**.

35. Expand **Storage**, and select **Disk Management**.

36. Select and right-click or access the context menu for **Disk Management**, and then select **Refresh**.

37. Right-click or access the context menu for **Disk 3**, and then select **Online**.

38. Right-click or access the context menu for **Disk 4**, and then select **Online**.

39. Right-click or access the context menu for **Disk 5**, and then select **Online**.

    > **Note:** Be sure that the online disks that you switch to are 5.00 GB in size.

40. Close the **Computer Management** window.


### Task 2: Install the Failover Cluster feature

1. Switch to **LON-SVR2**.

2. On **LON-SVR2**, in **Server Manager**, select **Add roles and features**.

3. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, select **Next**.

5. On the **Select destination server** page, ensure that **Select a server from the server pool** is selected, and then select **Next**.

6. On the **Select server roles** page, select **Next**.

7. On the **Select features** page, in the **Features** list, select **Failover Clustering**. 

8. In the **Add features that are required for Failover Clustering** window, select **Add Features**, and then select **Next**.

9. On the **Confirm installation selections** page, select **Install**.

10. When installation completes and you receive the **Installation succeeded on LON-SVR2.Contoso.com** message, select **Close**.

11. On **LON-SVR3** and **LON-SVR4**, repeat steps 2 through 10. 

    > **Note:** If necessary, sign in to **LON-SVR4** as **Contoso\\Administrator** with the password **Pa55wr.d**.


### Task 3: Validate the servers for failover clustering

1. Switch to **LON-SVR2**.

2. On **LON-SVR2**, in **Server Manager**, select **Tools**, and then select **Failover Cluster Manager**.

3. In **Failover Cluster Manager**, in the **Actions** pane, select **Validate Configuration**.

4. In the **Validate a Configuration Wizard**, select **Next**.

5. In the **Enter Name** text box, enter **LON-SVR2**, and then select **Add**.

6. In the **Enter Name** text box, enter **LON-SVR3**, select **Add**, and then select **Next**.

7. Verify that **Run all tests (recommended)** is selected, and select **Next**.

8. On the **Confirmation** page, select **Next**.

   > Wait for the validation tests to finish, which might take between 5 and 7 minutes, and then on the **Summary** page, scroll through the report. Verify that all tests completed without errors. Some warnings are expected.
   >

9. On the **Summary** page, select **Finish**. 


### Task 4: Create the failover cluster

1. On **LON-SVR2**, in the **Failover Cluster Manager**, in the **Actions** pane, select **Create Cluster**.

2. On the **Before you begin** page, select **Next**.

3. On the **Select Servers** page, in the **Enter server name** box, enter **LON-SVR2**, and then select **Add**.

4. In the **Enter server name** box, enter **LON-SVR3**, select **Add**, and then select **Next**.

5. On the **Access Point for** **Administering the Cluster** page, in the **Cluster Name** text box, enter **Cluster1**.

6. In the **Address** text box, enter **172.16.0.125**, and then select **Next**.

7. On the **Confirmation** page, select **Next**.

8. On the **Summary** page, select **Finish**.


### Task 5: Add the file-server application to the failover cluster

1. On **LON-SVR2**, in the **Failover Cluster Manager** console, expand **Cluster1.Contoso.com**, expand **Storage**, and then select **Disks**. 

2. Ensure that three disks named **Cluster Disk 1**, **Cluster Disk 2**, and **Cluster Disk 3** are present and online.

3. Right-click or access the context menu for **Roles**, and then select **Configure Role**.

4. On the **Before You Begin** page, select **Next**.

5. On the **Select Role** page, select **File Server**, and then select **Next**.

6. On the **File Server Type** page, select **File Server for general use**, and then select **Next**.

7. On the **Client Access Point** page, in the **Name** text box, enter **ContosoFS**. In the **Address** text box, enter **172.16.0.130**, and then select **Next**.

8. On the **Select Storage** page, select the **Cluster Disk 2** checkbox, and then select **Next**.

9. On the **Confirmation** page, select **Next**.

10. On the **Summary** page, select **Finish**.


### Task 6: Add a shared folder to a highly available file server

1. Switch to **LON-SVR3**.
2. On **LON-SVR3**, in the **Server Manager** console, select **Tools**, and then select **Failover Cluster Manager**.
3. Expand **Cluster1.Contoso.com**, select **Roles**, right-click or access the context menu for **ContosoFS**, and then select **Add File Share**.

4. In the **New Share Wizard**, on the **Select the profile for this share** page, select **SMB Share – Quick**, and then select **Next**.

5. On the **Select the server and path for this share** page, select **Next**.

6. On the **Specify share name** page, in the **Share name** text box, enter **Docs**, and then select **Next**.

7. On the **Configure share settings** page, review the available options but don't make any changes, and then select **Next**.

8. On the **Specify permissions to control access** page, select **Next**.

9. On the **Confirm selections** page, select **Create**.

10. On the **View results** page, select **Close**.


### Task 7: Configure failover and failback settings

1. On **LON-SVR3**, in the **Failover Cluster Manager** console, select **Roles**, right-click or access the context menu for **ContosoFS**, and then select **Properties**.

2. In the **ContosoFS Properties** dialog box, select the **Failover** tab, and then select **Allow failback**.

3. Select **Failback between**, and set the values to **4** and **5** hours.

4. Select the **General** tab.

5. Select both **LON-SVR2** and **LON-SVR3** as preferred owners.

6. Select **LON-SVR3**, and select **Up** so that it's first in the preferred owners list.

7. To close the **ContosoFS** **Properties** dialog box, select **OK**.


### Task 8: Validate the highly available file-server deployment

1. Switch to **LON-DC1** and sign in as **Contoso\\Administrator** with the password **Pa55w.rd**.

2. On **LON-DC1**, open **File Explorer**. In the address bar, enter **`\\ContosoFS`**, and then select Enter.

3. Verify that you can access the location and that you can open the **Docs** folder. 

4. Create a text document inside the **Docs** folder named **test.txt**.

5. Switch to **LON-SVR2**.

6. On **LON-SVR2**, in the **Failover Cluster Manager** console, expand **Cluster1.Contoso.com**, and then select **Roles**. 

7. In the **Owner Node** column, note the current owner of **ContosoFS**.

   > **Note:** The owner will be **LON-SVR2** or **LON-SVR3**.

8. Right-click or access the context menu for **ContosoFS**, select **Move**, and then select **Select Node**.

9. In the **Move Clustered Role** dialog box, select the cluster node (it'll be **LON-SVR2** or  **LON-SVR3**), and then select **OK**.

10. Verify that **ContosoFS** has moved to a new owner.

11. Switch to **LON-DC1**.

12. To verify that you can still access the **ContosoFS** location, open **File Explorer**, and in the address bar, enter **`\\ContosoFS`**, and then select Enter. 


### Task 9: Validate the failover and quorum configuration for the File Server role

1. Switch to **LON-SVR2**.

2. On **LON-SVR2**, in the **Failover Cluster Manager** console, select **Roles**.

3. In the **Owner Node** column, verify the current owner for the **ContosoFS** role. 

   > **Note:** The owner will be **LON-SVR2** or **LON-SVR3**.

4. Select **Nodes**, and then select the node that's the current owner of the **ContosoFS** role.

5. Right-click or access the context menu for the node, select **More Actions**, and then select **Stop Cluster Service**. 

6. In the **Failover Cluster Manager** console, select **Roles**, and verify that **ContosoFS** is running.

   > **Note:** This confirms that **ContosoFS** has moved to another node.

7. Switch to **LON-DC1**.

8. On **LON-DC1**, to verify that you can still access the **ContosoFS** location, open **File Explorer**. In the address bar, enter **`\\ContosoFS`**, and then select Enter.

9. Switch to **LON-SVR2**.

10. In the **Failover Cluster Manager** console, select **Nodes**, right-click or access the context menu for the stopped node, select **More Actions**, and then select **Start Cluster Service**.

11. Expand **Storage**, and then select **Disks**. 

12. In the center pane, find the disk that's assigned to **Disk Witness in Quorum**. 

    > **Note:** You can review this in the **Assigned To** column.

13. Right-click or access the context menu for the disk, select **Take Offline**, and then select **Yes**.

14. Switch to **LON-DC1**.

15. On **LON-DC1**, to verify that you can still access the **ContosoFS** location, open **File Explorer**, and in the address bar, enter **`\\ContosoFS`**, and then select Enter. 

    > **Note:** This verifies that the cluster is running even if the witness disk is offline.

16. Switch to **LON-SVR2**.

17. In the **Failover Cluster Manager** console, expand **Storage**, select **Disks**, right-click or access the context menu for the disk that is in **Offline** status, and then select **Bring Online**.

18. Right-click or access the context menu for **Cluster1.Contoso.com**, select **More Actions**, and then select **Configure Cluster Quorum Settings**.

19. On the **Before You Begin** page, select **Next**.

20. On the **Select Quorum Configuration** **Option** page, select **Advanced** **quorum** **configuration**, and then select **Next**.

21. On the **Select** **Voting** **Configuration** page, review the available settings.

    > **Note:** Notice that you can select a node or nodes that will, or will not, have a vote in the cluster.

22. Don't make any changes, and then select **Next**.

23. On the **Select Quorum Witness** page, ensure that **Configure a disk** **witness** is selected, and then select **Next**.

24. On the **Configure Storage Witness** page, select **Cluster Disk 3**, and then select **Next**.

25. On the **Confirmation** page, select **Next**.

26. On the **Summary** page, select **Finish**.


### Results

After completing this exercise, you'll have created a failover cluster successfully, configured a highly available file server, and tested the failover scenarios.

## Exercise 2: Verify quorum settings, and add a node to the cluster

### Scenario

It's becoming increasingly important that many of your network applications and services have increased scalability and remain highly available at all times. Your responsibility is to increase the current cluster's number of nodes and to evaluate and suggest a new quorum model. 

The main tasks for this exercise are:

1. Remotely connect to a cluster.

2. Check the assigned votes in the **Nodes** section.

3. Verify the status of the disk witness.

4. Add a node to the cluster.

5. Verify the assigned votes.

### Task 1: Remotely connect to a cluster

1. Sign in to **LON-CL1** with the username **Contoso\\Administrator** and the password **Pa55w.rd**.

2. Select **Start**, select **Windows Tools**, and then select **Failover Cluster Manager**. 

3. In **Failover Cluster Manager**, right-click or access the context menu for **Failover Cluster Manager**, and then select **Connect to Cluster**. 

4. In the **Select Cluster** dialog box, in the **Cluster name** box, enter **Cluster1.Contoso.com**, and select **OK**.

5. Expand **Cluster1.Contoso.com**, and then select **Roles**. 


### Task 2: Check the assigned votes in the Nodes section

1. Switch to **LON-SVR2**.

2. On **LON-SVR2**, select **Start**, and then select **Windows PowerShell ISE**. 

3. In the **Windows PowerShell ISE** console, run following cmdlet to check the assigned votes:

   ```
   Get-ClusterNode | select name, nodeweight, ID, state
   ```

4. Verify that the cluster node's **NodeWeight** property has a value **1**, which means that the node's quorum vote is assigned and the cluster is managing it.


### Task 3: Verify the status of the disk witness

1. On **LON-SVR2**, in the **Windows PowerShell ISE** console, enter the following cmdlet, and then select Enter:

   ```
   Get-ClusterQuorum | Select Cluster, QuorumResource, QuorumType
   ```

### Task 4: Add a node to the cluster

1. On **LON-SVR2**, in the Failover Cluster Manager, select **Nodes**.

2. In the **Actions** pane, select **Add Node**.

3. On the **Before You Begin** page, select **Next**.

4. On the **Select Servers** page, in the **Enter server name** box, enter **LON-SVR4**, select **Add**, and then select **Next**.

5. On the **Validation Warning** page, select **Next**. 

6. Complete the validation by using the defaults. 

7. On the **Summary** page of the **Validate a Configuration Wizard**, select **Finish**.

8. In the **Add Node Wizard**, on the **Confirmation** page, select **Next**.

9. On the **Summary** page, select **Finish**. 


### Task 5: Verify the assigned votes

1. On **LON-SVR2**, in the **Windows PowerShell ISE** console, enter following cmdlet, and then select Enter:

   ```
   Get-ClusterNode | select name, nodeweight, ID, state
   ```

2. Verify that the cluster node's **NodeWeight** property has a value of **1**, which means that the node's quorum vote is assigned and the cluster is managing it.

3. Close the **Windows PowerShell ISE** console.


> **NOTE:** When you finish the exercise, leave the VMs running for the subsequent lab.

### Results

After completing this exercise, you'll have added another node in the cluster successfully, and changed the quorum to the witness disk.
