---
lab:
    title: 'Lab: Manage a failover cluster'
    module: 'Module 8: Implementing and managing failover clustering'
---

# Lab: Manage a failover cluster

## Scenario

Contoso Ltd. recently implemented failover clustering to provide increased availability for critical services. The implementation is new and your manager has asked you to go through some failover-cluster management tasks so that you are prepared to manage it moving forward. 

## Objectives

After completing this lab, you will be able to:

- Evict a node and verify changes.
- Change the quorum from a disk witness to a file-share witness.
- Verify high availability.

## Estimated time: 30 minutes

## Exercise 1: Evict a node and verify quorum settings

### Scenario

You have recently added a node to the cluster to test your organization’s application scalability. Some of your organization employees have moved to another department, and they will not use the clustered application any more. According to your test, you will not need the current number of nodes in the cluster, so you will evict one node from the cluster.

The main tasks for this exercise are as follows:

1. Evict node LON-SVR4.

2. Verify changes to the cluster.

### Task 1: Evict node LON-SVR4

1. Sign in to **LON-SVR3** as **Contoso\\Administrator** with the password of **Pa55w.rd**.
2. Select **Start** and then select **Server Manager**.
3. From **Server Manager**, select **Tools** and then select **Failover Cluster Manager**.
4. In **Failover Cluster Manager**, expand the **Cluster1.Contoso.com** cluster, and then select **Nodes**.

5. Right-click or access the context menu for the **LON-SVR4** node, select **More Actions**, and then select **Evict**.

6. In the **Evict node LON-SVR4** dialog box, select **Yes** to evict the node.


### Task 2: Verify changes to the cluster

1. Select **Start** and then select **Windows PowerShell ISE**.

2. In the **Windows PowerShell ISE** console, enter following cmdlet, and then press Enter:

   ```
   Get-ClusterNode | select name, nodeweight, ID, state
   ```

   > Verify that LON-SVR4 does not display in the results.
   >

### Results

After completing this exercise, you will have evicted a node from the cluster, and verified the changes in the cluster.

## Exercise 2: Change the quorum from a disk witness to a file-share witness

### Scenario

You have introduced a new application in your organization that works better by using scenarios with the File Share Witness quorum model. You need to modify the quorum model for the Failover cluster.

The main tasks for this exercise are as follows:

1. Get the current quorum model.

2. Create a file share on LON-SVR1.

3. Change the current quorum model to a file-share witness.

4. Verify that the current quorum model is a file share witness.

### Task 1: Get the current quorum model

1. Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start** and then select **Windows PowerShell ISE**.

3. In the **Windows PowerShell ISE** console, enter the following command, and then press Enter:

   ```
   Get-ClusterQuorum | Select Cluster, QuorumResource, QuorumType
   ```

### Task 2: Create a file share on LON-SVR1

1. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.
2. On **LON-SVR1**, on the taskbar, select **File Explorer**, right-click or access the context menu for the disk **Local Disk (C:)**, select **New**, and then select **Folder**. 
3. Type **FSW**, and press Enter.

4. Right-click or access the context menu for **FSW**, select **Give access to**, and then select **Specific people**. 

5. In the **Network access** dialog box, enter **Everyone**, and then select **Add**. 

6. In the **Read** list, select **Read/Write**. 

7. Select **Share**, and then select **Done**.


### Task 3: Change the current quorum model to a file-share witness

1. Switch to **LON-SVR2**.

2. On **LON-SVR2**, in the **Windows PowerShell ISE** console, enter the following command, and then press Enter:

   ```
   Set-ClusterQuorum -NodeAndFileShareMajority "\\LON-SVR1\FSW"
   ```

### Task 4: Verify that the current quorum model is a file share witness

1. On **LON-SVR2**, in the **Windows PowerShell ISE** console, enter the following command, and then press Enter:

   ```
   Get-ClusterQuorum | Select Cluster, QuorumResource, QuorumType
   ```

### Results

After completing this exercise, you will have changed the quorum from disk witness to file share witness.

## Exercise 3: Verify high availability

### Scenario

You want to test your high-availability solution by taking one of your servers offline, and then verify that your application, services, and data are still available to clients. After you verify that high availability works, you will bring the server back online.

The main tasks for this exercise are as follows:

1. Simulate server failure.

2. Verify functionality in Cluster1 and verify file availability.

3. Validate whether the file is still available.

### Task 1: Simulate server failure

1. Switch to **LON-SVR2** and from **Server Manager** open **Failover Cluster Manager**.

2. In the **Failover Cluster Manager** console, expand **Cluster1.Contoso.com**, and then select **Roles**. 

3. In the **Owner Node** column, notice the current owner of **ContosoFS**.

   > **Note:** The owner will be **LON-SVR2** or **LON-SVR3**.

4. If **LON-SVR3** is not the owner, right-click or access the context menu for **ContosoFS**, select **Move**, select **Select Node**, select **LON-SVR3**, and then select **OK**.

5. Shut down **LON-SVR3**.


### Task 2: Verify functionality in Cluster1 and verify file availability

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. On **LON-DC1**, open **File Explorer**. 

3. In the address bar, enter **`\\ContosoFS\`**, and then press Enter.

   > Verify that you can access the location and that you can open the **Docs** folder. 
   >

4. Create a test text document named **test2.txt** inside this folder.


### Task 3: Validate whether the file is still available

1. Start the **LON-SVR3** virtual machine.

   > Wait for LON-SVR3 to fully start before continuing with the next steps.

2. On **LON-SVR2**, in the **Failover Cluster Manager** console, expand **Cluster1.Contoso.com**, and then select **Roles**. 

3. Right-click or access the context menu for **ContosoFS**, select **Move**, select **Select Node**, select **LON-SVR3**, and then select **OK**.

4. On **LON-DC1**, open **File Explorer**. 

5. In the address bar, enter **`\\ContosoFS\`**, and then press Enter.

   > Verify that you can access the location and that you can open the **Docs** folder. 
   >

6. Create a test text document named **test3.txt** inside this folder.


### Results

After completing this exercise, you will have tested failover cluster high availability successfully by taking a server offline and then bringing it back online.