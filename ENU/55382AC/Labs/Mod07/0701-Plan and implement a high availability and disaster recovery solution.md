---
lab:
    title: 'Lab: Plan and implement a high-availability and disaster-recovery solution'
    module: 'Module 7: Overview of high availability and disaster recovery'
---

# Lab: Plan and implement a high-availability and disaster-recovery solution

## Scenario

Contoso Ltd. is looking to assess and configure new high-availability features and technologies available by using Windows Server 2022. As the system administrator, you've been tasked with performing that assessment and implementation. 

## Objectives

After completing this lab, you'll be able to:

- Plan for an appropriate high-availability and disaster-recovery solution.
- Implement storage migration.
- Configure Hyper-V Replica.

## Estimated time: 60 minutes
## Exercise 1: Plan for an appropriate high-availability and disaster-recovery solution

### Scenario

Contoso Ltd. has its headquarters in New York and is reviewing its current disaster-recovery strategy after a recent fire in a London branch office that resulted in data loss. Contoso is also reviewing current strategies around high availability, and is considering an upgrade to Windows Server 2022, but wants to determine if there are any features that it can leverage. Budgets are tight and management is wondering whether there are any possible cost savings that could help offset the expenditure to replace existing legacy storage with a Hyper-V cluster. Contoso has the following business requirements:

- Public facing financial transactions take place online.
- There are 1,000 employees across Application/Product Development, Human Resources (HR), Finance, Customer Service, Information Technology (IT), and Sales.
- Finance can't tolerate any downtime in their SQL and finance applications, which are running on Hyper-V. 
- The finance team requires less than 1 minute downtime for their recovery time objective (RTO) and zero data loss as their recovery point objective (RPO) on their customer-facing transactions.
- The finance division is also growing at a very fast rate, and they expect increased demand for application and services.

The solution should:

- Allow for monthly updates, with no downtime.
- Allow for existing legacy storage to be replaced, without downtime, to the Hyper-V cluster.
- Provide a disaster-recovery strategy that allows for recovery of critical virtual machines (VMs) should there be another disaster event in either office location.

The main task for this exercise is:

- Design the appropriate high-availability and disaster-recovery solution

### Task 1: Design the appropriate high-availability and disaster-recovery solution

Read the scenario, and then record your answers to the following question:

1. What actions should you take and which technologies should you consider using?

<details>
<summary>**Answer**</summary>
   > - Create a Business Recovery Plan to outline and prioritize the divisional and service requirements, with the customer-facing financial requirements having the most critical requirements
   > - Consider using Live Migration for monthly planned downtime to allow for updates to your VMs.
   > - Consider using Storage Migration to migrate VM storage off the existing server, to upgrade the existing servers’ storage, and to migrate back the VM storage to the server without any VM downtime.
   > - Consider using Hyper-V Recovery Manager solution, integrated with Hyper-V Replica, to provide disaster recovery for critical VMs should disaster occur in any offices.
</details>

### Results

After completing this exercise, you'll have successfully designed the appropriate high-availability and disaster-recovery solution that'll meet your organization’s requirements.

## Exercise 2: Implement storage migration

### Scenario

To upgrade the storage for the new host servers, you need to be able to to move existing VM storage between Hyper-V hosts without service downtime. You plan to test Hyper-V storage migration and verify that it'll meet your requirements. 

The main task for this exercise is:

- Configure and perform storage migration.

### Task 1: Configure and perform storage migration

1. Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2. On the taskbar, select **Hyper-V Manager**.

>The Hyper-V Manager console opens.

3. In Hyper-V Manager, in the **navigation** pane, select **LON-SVR2**.

>When you select **LON-SVR2**, the **details** and **Actions** panes display to manage VMs that are available on this host.

4. In the **details** pane, in the **Virtual Machines** section, right-click or access the context menu for **LON-SVR5**, and then select **Start**.

>This starts **LON-SVR5** to allow you to validate storage migration without service disruption.

5. In the **details** pane, in the **Virtual Machines** section, right-click or access the context menu for **LON-SVR5**, and then select **Settings**.

6. In **Settings for LON-SVR5**, under **IDE Controller 0**, select **Hard Drive**. 

>Confirm that **LON-SVR5.vhd** is stored at **E:\\Labfiles\\LON-SVR5**.

7. Select **OK** to close the **Settings for LON-SVR5**.

8. In **Hyper-V Manager**, right-click or access the context menu for **LON-SVR5**, and then select **Move**.

9. In the **Move “LON-SVR5” Wizard**, on the **Before You Begin** page, select **Next**.

10. On the **Choose Move Type** page, select the **Move the virtual machine’s storage** option, and then select **Next**.

11. On the **Choose Options for Moving** **Storage** page, select the **Move all of the virtual machine's data to a single location** option, and then select **Next**.

12. On the **Choose a new location for virtual machine** page, in the **Folder** text box, type **`C:\VMs\LON-SVR5`**, and then select **Next**.

13. On the **Completing Move Wizard** page, select **Finish**. 

>A message box displays that states **Performing the move**. While the move is completing, connect to **LON-SVR5** and verify that the VM is still accessible during the move. Wait until the move is complete.

14. In Hyper-V Manager, right-click or access the context menu for **LON-SVR5**, and then select **Settings**.

15. In **Settings for LON-SVR5**, under **IDE Controller 0**, select **Hard Drive**. 

16. Confirm that **LON-SVR5.vhd** is stored on the **C:\\VMs\\LON-SVR5** folder structure, and then select **OK** to close the **Settings for LON-SVR5** dialog box.

>This confirms that the virtual hard disk (VHD) was moved while the VM was running.

### Results

After completing this exercise, you should have moved Hyper-V storage to a new location without service disruption.

## Exercise 3: Configure Hyper-V Replica

### Scenario

You need to evaluate the Hyper-V Replica feature that replicates VMs between hosts. You want to be able to mount a copy of a VM to another host if the active copy or host fails. 

The main tasks for this exercise are:

1. Enable replication on both host machines.
2. Configure replication for the **LON-SVR5** VM.
3. Validate a planned failover to the replica site.

### Task 1: Enable replication on both host machines

1. Sign in to **LON-SVR3** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.
2. On **LON-SVR3**, on the taskbar, select **Hyper-V Manager**.
3. In Hyper-V Manager, right-click or access the context menu for **LON-SVR3**, and then select **Hyper-V Settings**.

4. In **Hyper-V Settings** **for** **LON-SVR3**, select **Replication Configuration**.

5. In the **Replication Configuration** pane, select **Enable this computer as a Replica server**.

6. In the **Authentication and ports** section, select **Use Kerberos (HTTP)**.

7. In the **Authorization and storage** section, select **Allow replication from any authenticated server**, and then select **Browse**.

8. Expand **This PC**, select to expand **Local Disk (C)**, and then select **New folder**. For the folder name, type **`VMReplica`**, and then select Enter. 
9. Select the **C:\\VMReplica** folder, and then select **Select Folder**.
10. In **Hyper-V Settings** **for LON-SVR3**, select **OK**. 

11. In the **Settings** dialog box, read the notice, and then select **OK**.

12. Select **Start**, and then enter **Windows Firewall**.
13. In the search results, select **Windows Defender Firewall**.
14. Select **Advanced settings**, and then select **Inbound Rules**.

15. In the right pane, in the rule list, find and right-click or access the context menu for the **Hyper-V Replica HTTP Listener (TCP-In)** rule, and then select **Enable Rule**.

16. Close the **Windows Defender Firewall with Advanced Security** console, and then close **Windows Defender Firewall**.

17. Switch to **LON-SVR2**, and repeat steps 1 through 16.

### Task 2: Configure replication for LON-SVR5 VM

1. On **LON-SVR2**, in the **Hyper-V Manager** console, right-click or access the context menu for **LON-SVR5**, and then select **Enable Replication**.

>The **Enable Replication for LON-SVR5** wizard starts.

2. On the **Before You Begin** page, select **Next**.

3. On the **Specify Replica Server** page, in the **Replica server** box, type **`LON-SVR3`**, and then select **Next**.

4. On the **Specify Connection Parameters** page, select **Use Kerberos authentication (HTTP)**, and then select **Next**.

5. On the **Choose Replication VHDs** page, select **Next**.

6. On the **Configure Replication Frequency** page, from drop-down list box, select **30 seconds**, and then select **Next**.

7. On the **Configure Additional Recovery Points** page, select **Maintain** **only the latest recovery point**, and then select **Next**.

8. On the **Choose Initial Replication Method** page, select **Send initial copy over the network**, select **Start replication immediately**, and then select **Next**.

9. On the **Completing the Enable Replication wizard** page, select **Finish**.

>Wait approximately five minutes. You can monitor the progress of the initial replication in the **Status** column in the **Hyper-V Manager** console. When it completes (progress reaches 100 percent), switch to **LON-SVR3**, and ensure that **LON-SVR5** displays in an **Off** state in **Hyper-V Manager**. 

### Task 3: Validate a planned failover to the replica site

1. On **LON-SVR2**, in Hyper-V Manager, right-click or access the context menu for **LON-SVR5**.

2. Select **Replication**, and then select **View** **Replication Health**.

>Review content of the window that appears, and ensure that there are no errors.

3. To close the Replication Health for **LON-SVR5**, select **Close**.

4. On **LON-SVR2**, in Hyper-V Manager, right-click or access the context menu for **LON-SVR5**, and then select **Shut Down**.

>Wait for **LON-SVR5** to shut down. To perform a planned failover, the VM must not be running.

5. On **LON-SVR2**, in Hyper-V Manager, right-click or access the context menu for **LON-SVR5**, point to **Replication,** and then select **Planned** **Failover**.

6. In the **Planned Failover** window, ensure that the option **Start the Replica virtual machine after failover** is selected, and then select **Fail Over**.

7. Switch to **LON-SVR3**, and in Hyper-V Manager, ensure that **LON-SVR5** is running.

### Results

After completing this exercise, you'll have configured and validated Hyper-V Replica.
