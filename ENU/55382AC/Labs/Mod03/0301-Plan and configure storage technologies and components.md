---
lab:
    title: 'Lab: Plan and configure storage technologies and components'
    module: 'Module 3: Implementing enterprise storage solutions'
---

# Lab: Plan and configure storage technologies and components

## Scenario

You are a Storage Administrator for Contoso, Ltd. Part of your job is to ensure that your data storage systems meet both short-term and long-term business needs that evolve regularly. 

## Objectives

- Plan storage requirements.
- Configure Internet Small Computer System Interface (iSCSI) storage.
- Configure and manage shares.

## Estimated time: 60 minutes

## Exercise 1: Planning storage requirements

### Scenario

Contoso Ltd. wants to design new storage solutions to support several recent changes:

- External customers are more frequently using web applications, and these customers are requiring more and new business services.

- Internal users need more support and more internal infrastructure services.

- Requirements for managing block-level storage and shared file access have expanded.

- A recently acquired company uses a different IT infrastructure than Contoso, and the IT department now needs to manage a mixed environment that includes remote geographical areas in London, New York, and Japan.

- The cost of storage has decreased significantly over recent years.

- The amount of data produced by Contoso business groups continues to increase at a faster rate.


### Requirements

In general, the new storage system should be low‑cost, and have reasonable performance. In addition, storage administrators at both Contoso and the newly acquired company should be able to manage it easily.

The new storage system should include:

- Centralized management and control over the storage infrastructure.

- Support for applications that require large amounts of storage for Microsoft SQL Server databases.

- An easy, inexpensive way to provision block-level storage that has minimal management overhead.

- The provisioning of VMWare ESXi virtual machines (VMs).

- The provisioning of Microsoft Hyper‑V VMs.

- Support for UNIX clients that require access to shared folders.

- Share access for older clients, if it's required.


As part of fulfilling this requirement, you will determine if older clients—including Windows 7 and Windows 8—need access to shares, and you then will remove any legacy shares that your users are not utilizing.

### Proposals

As a senior server administrator at Contoso, you're responsible for implementing the new file storage technologies for the organization. After reviewing the requirements, you propose a plan based on answers to the following questions:

- You plan to evaluate how iSCSI, Fibre Channel, and InfiniBand solutions meet the requirements. Which solution do you expect to select?

- Which storage—block-level storage or file-level storage—do you plan to implement for the SQL Server databases?

- How will your solution minimize administrative overhead for the storage administrators?

- Which server role (or roles) do you plan to use for the provisioning of VMWare ESXi VMs?

- Will you run the Hyper‑V VMs on network file system (NFS) or Server Message Block (SMB)?

- Which file sharing protocol will you use for UNIX clients that require access?

- How do you plan to disable legacy SMB access for existing SMB file shares?


The main tasks for this exercise are as follows:

1. Read the supporting documentation.
1. Record your planned course of action.

### Task 1: Read the supporting documentation

- Read the supporting documentation in the lab exercise scenario.

### Task 2: Record your planned course of action

Record your answers to the following questions:

1. You plan to evaluate how iSCSI, Fibre Channel, and InfiniBand solutions meet your requirements. Which solution do you expect to select?

   > You wouldn't use InfiniBand because the requirements call for reasonable performance and low cost. InfiniBand is for high‑performance solutions, and it's more  expensive. Of the two remaining choices, iSCSI most closely matches the low cost and reasonable performance requirements that you expect. Therefore, you should deploy an iSCSI solution to each of the geographic locations that has an IT infrastructure and requires more storage.

2. Which storage type do you plan to implement for the SQL databases: block-level storage or file-level storage?

   > Based on the requirements alone, you could use either storage type because each has its own advantages and disadvantages. SQL databases can run SMB file shares since the release of SMB 3.0, and the overall performance is similar to that of block-level storage. The answer might depend on whether you have an existing highly available SMB file server infrastructure, and whether the server team or the storage team will manage the storage.

3. How will your solution minimize administrative overhead for storage administrators?

   > By selecting iSCSI, you avoid the complexities of Fibre Channel and InfiniBand solutions. In addition, an iSCSI solution requires less hardware and software. All of these choices reduce the administrative overhead for storage administrators.

4. Which server role (or roles) do you plan to use for VMWare ESXi VM provisioning?

   > You can use the Server for the NFS role to create NFS file shares that VMWare ESXi VMs support.

5. Will you run the Hyper-V VMs on NFS or SMB?

   > The Hyper‑V virtual machines can run on SMB, but NFS doesn't support them. Therefore, you will need to run the VMs on SMB.

6. Which file sharing protocol will you use for UNIX clients that require access?

   > Historically, NFS was the protocol of choice for UNIX clients to access file shares. However, today most UNIX clients equally support NFS and SMB natively. Therefore, you can use either of the technologies. If you have an existing NFS file sharing deployment, you will likely choose NFS. If you have an existing SMB file sharing deployment, you will likely choose SMB.

7. How do you plan to disable legacy SMB access for existing SMB file shares?

   > First, you need to locate all of the existing file servers that have legacy SMB shares. You can check for legacy shares on the current host by using the following command at a Windows PowerShell prompt:
   >
   > ```
   > Get-SmbServerConfiguration | Select EnableSMB1Protocol
   > ```
   >
   > You also can create a Windows PowerShell script to check for legacy shares on all the file servers.
   >
   > After you have located all of the existing file servers that have legacy SMB shares, you then need to disable  SMB access. You can disable the SMB 1 protocol on each server by using the following command:
   >
   > ```
   > Set-SmbServerConfiguration ‑EnableSMB1Protocol $false
   > ```
   >
   > You also can create a Windows PowerShell script to disable legacy SMB access across all of your servers.

### Results

After completing this exercise, you will have successfully planned a storage solution that will meet your organization’s requirements.

## Exercise 2: Configuring iSCSI storage

### Scenario

You need to implement highly available iSCSI storage by using Multipath I/O (MPIO). There are two independent network paths between the file server and the iSCSI target. You will configure MPIO to use both paths to provide redundancy at the network level.

The main tasks for this exercise are as follows:

1. Install the iSCSI target feature.

2. Create and configure an iSCSI target.

3. Configure MPIO.

4. Connect to the iSCSI target.

5. Initialize the iSCSI disks.

### Task 1: Install the iSCSI target feature

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager starts automatically.

2. In **Server Manager**, select the **Manage** menu, and then select **Add Roles and Features**.

3. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, select **Next**.

5. On the **Select destination server** page, ensure that **Select a server from the server pool** is selected, and then select **Next**.

6. On the **Select server roles** page, expand **File and Storage Services (2 of 12 Installed)**, expand **File and iSCSI Services (1 of 11 Installed)**, select the **iSCSI Target Server** checkbox, and then select **Next**.

7. On the **Select features** page, select **Next**.

8. On the **Confirm installation selections** page, select **Install**.

9. When the installation completes, select **Close**.


### Task 2: Create and configure an iSCSI target

1. On **LON‑DC1**, in **Server Manager**, in the navigation pane, select **File and Storage Services**.

2. In the **File and Storage Services** pane, select **iSCSI**.

3. In the **iSCSI VIRTUAL DISKS** pane, select **TASKS**, and then select **New iSCSI Virtual Disk**.

4. In the **New iSCSI Virtual Disk Wizard**, on the **Select iSCSI virtual disk location** page, under **Storage location**, select volume **C:**, and then select **Next**.

5. On the **Specify iSCSI virtual disk name** page, in the **Name** text box, enter **iSCSIDisk1**, and then select **Next**.

6. On the **Specify iSCSI virtual disk size** page, in the **Size** text box, enter **5**. Ensure that **GB** is selected, and then select **Next**.

7. On the **Assign iSCSI target** page, ensure that the **New iSCSI target** option is selected, and then select **Next**.

8. On the **Specify target name** page, in the **Name** text box, enter **LON‑DC1**, and then select **Next**.

9. On the **Specify access servers** page, select **Add**.

10. In the **Select a method to identify the initiator** dialog box, select **Enter a value for the selected type**. In the **Type** list, select **IP Address**. 
In the **Value** text box, enter **10.100.100.3**, and then select **OK**.

11. On the **Specify access servers** page, select **Add**.

12. In the **Select a method to identify the initiator** dialog box, select **Enter a value for the selected type**. In the **Type** list, select **IP Address**. In the **Value** text box, enter **10.200.100.3**, and then select **OK**.

13. On the **Specify access servers** page, select **Next**.

14. On the **Enable Authentication** page, select **Next**.

15. On the **Confirm selections** page, select **Create**.

16. On the **View results** page, wait until the virtual disk is created, and then select **Close**.

17. In the **iSCSI VIRTUAL DISKS** pane, select **TASKS**, and then select **New iSCSI Virtual Disk**.

18. In the **New iSCSI Virtual Disk Wizard**, on the **Select iSCSI virtual disk location** page, under **Storage location**, select volume **C:**, and then select **Next**.

19. On the **Specify iSCSI virtual disk name** page, in the **Name** text box, enter **iSCSIDisk2**, and then select **Next**.

20. On the **Specify iSCSI virtual disk size** page, in the **Size** text box, enter **5**. Ensure that **GB** is selected, and then select **Next**.

21. On the **Assign iSCSI target** page, select **lon‑dc1**, and then select **Next**.

22. On the **Confirm selections** page, select **Create**.

23. On the **View results** page, wait until the virtual disk is created, and then select **Close**.


### Task 3: Configure MPIO

1. Switch to **LON-SVR1** and then sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**.

3. In **Server Manager**, select the **Manage** menu, and then select **Add Roles and Features**.

4. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

5. On the **Select installation type** page, select **Next**.

6. On the **Select destination server** page, ensure that **Select a server from the server pool** is selected, and then select **Next**.

7. On the **Select server roles** page, select **Next**.

8. On the **Select features** page, select **Multipath I/O**, and then select **Next**.

9. On the **Confirm installation selections** page, select **Install**.

10. When installation is complete, select **Close**.

11. Restart **LON-SVR1**, and then sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

12. Select **Start**, and then select **Server Manager**.

13. In Server Manager, select **Tools**, and then select **iSCSI Initiator**.

14. In the **Microsoft iSCSI** message box, select **Yes**.

15. In the **iSCSI Initiator Properties** dialog box, on the **Targets** tab, in the **Target** text box, enter **10.100.100.2**, and then select **Quick Connect**.

16. In the **Quick Connect** box, select **Done**.

17. In the **iSCSI Initiator Properties** dialog box, select **OK** to close the dialog box.

18. In Server Manager, on the menu bar, select **Tools**, and then select **MPIO**.

19. In the **MPIO Properties** dialog box, on the **Discover Multi-Paths** tab, select **Add support for iSCSI devices**, and then select **Add**.

20. Select **OK** at the message prompt, and then select **OK** to close the **MPIO Properties**.

21. In Server Manager, on the menu bar, select **Tools**, and then select **MPIO**.

22. In the **MPIO Properties** dialog box, on the **MPIO Devices** tab, notice that **Device Hardware Id MSFT2005iSCSIBusType_0x9** has been added to the list.

23. In the **MPIO Properties** dialog box, select **OK** to close the dialog box.


### Task 4: Connect to the iSCSI target

1. On **LON‑SVR1**, in Server Manager, on the menu bar, select **Tools**, and then select **iSCSI Initiator**.

2. In the **iSCSI Initiator Properties** dialog box, on the **Targets** tab, select **Disconnect**.

3. In the **Disconnect From All Sessions** dialog box, select **Yes**.

4. In the **iSCSI Initiator Properties** dialog box, on the **Targets** tab, select **Connect**.

5. In the **Connect To Target** dialog box, select the **Enable multi-path** checkbox. Verify that the **Add this connection to the list of Favorite Targets** checkbox is selected, and then select **Advanced**.

6. In the **Advanced Settings** dialog box, on the **General** tab, change the **Local adapter** from **Default** to **Microsoft iSCSI Initiator**.

7. In the **Initiator IP** list, select **10.100.100.3**.

8. In the **Target portal IP** list, select **10.100.100.2 / 3260**.

9. In the **Advanced Settings** dialog box, select **OK**.

10. In the **Connect To Target** dialog box, select **OK**.

11. In the **iSCSI Initiator Properties** dialog box, on the **Targets** tab, select **Connect**.

12. In the **Connect To Target** dialog box, select **Enable multi-path**. Verify that the **Add this connection to the list of Favorite Targets** checkbox is selected, and then select **Advanced**.

13. In the **Advanced Settings** dialog box, on the **General** tab, change the **Local adapter** from **Default** to **Microsoft iSCSI Initiator**.

14. In the **Initiator IP** list, select **10.200.100.3**.

15. In the **Target portal IP** list, select **10.200.100.2 / 3260**.

16. In the **Advanced Settings** dialog box, select **OK**.

17. In the **Connect To Target** dialog box, select **OK**.

18. In the **iSCSI Initiator Properties** dialog box, on the **Volumes and Devices** tab, select **Auto Configure**.

19. In the **iSCSI Initiator Properties** dialog box, on the **Targets** tab, in the **Targets** list, select **iqn.1991-05.com.microsoft:lon‑dc1-lon‑dc1-target**, and then select **Devices**.

20. In the **Devices** dialog box, select **MPIO**.

21. Verify that in **Load balance policy**, **Round Robin** is selected.

22. Under **This device has the following paths**, notice that two paths are listed. Select the first path, and then select **Details**.

23. Note the IP address of the source and target portals, and then select **OK**.

24. Select the second path, and then select **Details**.

25. Verify that this path is using another network, and then select **OK**.

26. In the **Device Details** dialog box, select **OK**.

27. In the **Devices** dialog box, select **OK**.

28. In the **iSCSI Initiator Properties** dialog box, select **OK**.


### Task 5: Initialize the iSCSI disks

1. On **LON‑SVR1**, in Server Manager, select **File and Storage Services**, and then in the left pane, select **Disks**.

2. In the **Disks** pane, right-click or access the context menu for an offline disk with a bus type of **iSCSI**, and then select **Bring Online**.

3. In the **Bring Disk Online** dialog box, select **Yes** to bring the disk online.

4. Right-click or access the context menu for the iSCSI disk that you just brought online, and then select **New Volume**.

5. In the **New Volume Wizard**, on the **Before you begin** page, select **Next**.

6. On the **Select the server and disk** page, ensure that your iSCSI disk is selected, and then select **Next**.

7. In the **Offline or Uninitialized Disk** dialog box, to initialize the disk as a GUID partition table (GPT) disk, select **OK**.

8. On the **Specify the size of the volume** page, to accept the default setting of using the entire disk size for the volume, select **Next**.

9. On the **Assign to a drive letter or folder** page, in the **Drive letter** list, select **J**, and then select **Next**.

10. On the **Select file system settings** page, in the **Volume label** text box, enter **SMBShares**, and then select **Next**.

11. On the **Confirm selections** page, to finish creating the volume, select **Create**.

12. After the volume is created, on the **Completion** page, select **Close**.

13. In Server Manager, in the right pane, right-click or access the context menu for the remaining offline disk with a bus type of iSCSI, and then select **Bring Online**.

14. In the **Bring Disk Online** dialog box, to bring the disk online, select **Yes**.

15. Right-click or access the context menu for the iSCSI disk that you just brought online, and then select **New Volume**.

16. In the **New Volume Wizard**, on the **Before you begin** page, select **Next**.

17. On the **Select the server and disk** page, ensure that your iSCSI disk is selected, and then select **Next**.

18. In the **Offline or Uninitialized Disk** dialog box, to initialize the disk as a GPT disk, select **OK**.

19. On the **Specify the size of the volume** page, select **Next** to accept the default setting of using the entire disk size for the volume.

20. On the **Assign to a drive letter or folder** page, in the **Drive letter** list, select **K**, and then select **Next**.

21. On the **Select file system settings** page, in the **File system** box, select **NTFS**.

22. In the **Volume label** text box, enter **NFSShares**, and then select **Next**.

23. On the **Confirm selections** page, select **Create** to finish creating the volume.

24. After the volume is created, on the **Completion** page, select **Close**.

25. On the taskbar, select **File Explorer**. Browse to **This PC**, and then verify that the **SMBShares** and **NFSShares** volumes are listed.


### Results

After completing this exercise, you will have successfully configured an iSCSI target that uses MPIO for redundancy.

## Exercise 3: Configuring and managing the share infrastructure

### Scenario

After configuring iSCSI storage for **LON-SVR1**, you need to create shares to support clients that are running both Windows and Linux operating systems. 

The main tasks for this exercise are as follows:

1. Create an SMB share on iSCSI storage.

2. Create an NFS share on iSCSI storage.

3. Use Windows PowerShell to view share information.

4. Disable the legacy SMB1 protocol.

### Task 1: Create an SMB share on iSCSI storage

1. On **LON-SVR1**, in Server Manager, in the navigation pane, select **File and Storage Services**, and then select **Shares**.

2. In the **SHARES** area, select **TASKS**, and then select **New Share**.

3. In the **New Share Wizard**, on the **Select the profile for this share** page, in the **File share profile** box, select **SMB Share – Quick**, and then select **Next**.

4. On the **Select the server and path for this share** page, select **LON-SVR1**. Select **Select by volume**, select **J:**, and then select **Next**.

5. On the **Specify share name** page, in the **Share name** text box, enter **Data**, and then select **Next**.

6. On the **Configure share settings** page, select the **Enable access-based enumeration** checkbox, and then select **Next**.

7. On the **Specify permissions to control access** page, select **Customize permissions**.

8. In the **Advanced Security Settings for Data** window, on the **Permissions** tab, select **Add**.

9. In the **Permission Entry for Data** window, select **Select a principal**, enter **Domain Users**, and then select **OK**.

10. In the **Basic permissions** area, select the **Modify** checkbox, and then select **OK**.

11. In the **Advanced Security Settings for Data** window, select **OK**.

12. On the **Specify permissions to control access** page, select **Next**.

13. On the **Confirm selections** page, select **Create**.

14. When the share creation is complete, select **Close**.


### Task 2: Create an NFS share on iSCSI storage

1. On **LON-SVR1**, in the **SHARES** area, select **TASKS**, and then select **New Share**.

2. In the **New Share Wizard**, on the **Select the profile for this share** page, in the **File share profile** box, select **NFS Share – Quick**, and then select **Next**.

3. On the **Select the server and path for this share** page, select **LON-SVR1**, select **Select by volume**, select **K:**, and then select **Next**.

4. On the **Specify share name** page, in the **Share name** text box, enter **LinuxData**, and then select **Next**.

5. On the **Specify authentication methods** page, select **Kerberos v5 authentication(Krb5)**, and then select **Next**.

6. On the **Specify the share permissions** page, select **Add**.

7. In the **Add Permissions** window, select **All Machines.**

8. In the **Share permissions** box, select **Read / Write**, and then select **Add**.

9. On the **Specify the share permissions** page, select **Next**.

10. On the **Specify permissions to control access** page, select **Next**.

11. On the **Confirm selections** page, select **Create**.

12. On the **View results** page, select **Close**.


### Task 3: Use Windows PowerShell to view share information

1. Switch to **LON-DC1**.

2. On **LON-DC1**, on the taskbar, select **File Explorer**.

3. In **File Explorer**, in the address bar, enter **\\\\LON-SVR1\\Data**, and then select Enter.

4. Select the **Home** tab, select **New item**, and then select **Text Document**.

5. Enter **NewFile**, and then select Enter to rename the document.

6. Open **NewFile.txt** to open it in Notepad.

7. Leave Notepad open for later in the task.

8. Switch to **LON-SVR1**.

9. On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

10. At the Windows PowerShell prompt, enter the following command, and then select Enter:

    ```
    Get-NfsShare
    ```

11. Enter the following command, and then select Enter:

    ```
    Get-NfsShare LinuxData | FL *
    ```

12. Enter the following command, and then select Enter:

    ```
    Get-SmbShare
    ```

13. Enter the following command, and then select Enter:

    ```
    Get-SmbShare Data | FL *
    ```

14. Enter the following command, and then select Enter:

    ```
    Get-SmbSession
    ```

15. Enter the following command, and then select Enter:

    ```
    Get-SMBSession -ClientUserName Contoso\Administrator | FL *
    ```

16. Enter the following command, and then select Enter:

    ```
    Get-SmbOpenFile
    ```

    > **Note:** There are two entries for **Contoso\\Administrator**: File Explorer creates one, and Notepad creates the other. If **NewFile.txt** isn't included, it's because the file connection is maintained only for brief periods when you open the file initially or save it. If you don't have two entries, switch to **LON-DC1**, close Notepad, and then open **NewFile.txt**. Then, on **LON-SVR1**, repeat step 16. 

17. Leave the Windows PowerShell prompt open for the next task.


### Task 4: Disable the legacy SMB1 protocol

1. On **LON-SVR1**, at the **Windows PowerShell** prompt, enter the following command, and then select Enter:

   ```
   Set-SmbServerConfiguration -AuditSmb1Access $true
   ```

2. For the confirmation message, select **Yes**.

3. Enter the following command, and then select Enter:

   ```
   Get-SmbServerConfiguration | FL enable*
   ```

4. Enter the following command, and then select Enter:

   ```
   Set-SmbServerConfiguration -EnableSMB1Protocol $false
   ```

5. At the confirmation message, select **Yes**.

6. Enter the following command, and then select Enter:

   ```
   Get-WindowsFeature *SMB*
   ```

7. Enter the following command, and then select Enter:

   ```
   Remove-WindowsFeature FS-SMB1
   ```

8. Close the Windows PowerShell prompt.


### Results

After completing this exercise, you will have successfully created SMB and NFS shares.
