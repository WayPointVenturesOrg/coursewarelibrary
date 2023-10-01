# Lab B: Implement BranchCache

## Lab scenario

Contoso Corporation has several key shared folders that must be accessible to users in remote locations. The Sydney office hosts files from a sales application that are routinely accessed by London-based clients. London users only view the files. They don't edit them, and the files' sizes range from 25 megabytes (MB) to 150 MB. Toronto users need access to files that are hosted in London. These files, which users access throughout the day, are modified by London users and Toronto users, and the London users would like quick, reliable access to them. To ensure that users have the optimal experience when accessing the files, Contoso has decided to implement BranchCache for the file shares located in Sydney, and Distributed File System Replication (DFSR) for the Toronto users.

### Prerequisites

You must complete the following lab(s) before beginning this lab:

- 0701-Implement DFS for branch offices
## Exercise 1: Implementing BranchCache

### Scenario

The users in the London location require intermittent access to several read-only files hosted on the **SYD-SVR1** file server in Sydney. You must configure **LON-SVR1** with BranchCache in hosted cache mode so that you can provide cached files from a file share on **SYD-SVR1**, and you also must configure London clients so that they can use the hosted cache on **LON-SVR1**.

The main tasks for this exercise are:

1. Configure SYD-SVR1 to use BranchCache.
2. Prepare a file share for BranchCache.
3. Configure client firewall rules for BranchCache.
4. Install the BranchCache feature on LON-SVR1.
5. Start the BranchCache host server on LON-SVR1.
6. Configure client computers to use BranchCache in the hosted cache mode.

### Task 1: Configure SYD-SVR1 to use BranchCache

1.  Switch to **SYD-SVR1**, and sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.
2.  Select **Start**, and then select **Server Manager**.
3.  In **Server Manager**, select **Add roles and features**.

4.  In the **Add Roles and Features** **Wizard**, on the **Before you begin** page, select **Next**.

5.  On the **Select installation type** page, select **Next**.

6.  On the **Select destination server** page, select **Next**.

7.  On the **Select server roles** page, expand **File and Storage Services (installed)**, expand **File and iSCSI Services**, and then select the **BranchCache for Network Files** check box.

8.  In the **Add Roles and Features** pop-up window, select **Add Features**, and then select **Next**.

9.  On the **Select features** page, select **Next**.

10.  On the **Confirm installation selections** page, select **Install**.

11.  After the installation succeeded message displays, select **Close**.

12.  On the taskbar, select **Start**, enter **gpedit.msc**, and then select Enter.

13.  In the **Local Group Policy Editor** console, in the navigation pane, under **Computer** **Configuration**, expand **Administrative** **Templates**, expand **Network**, and then select **Lanman** **Server**.

14.  In the **Lanman Server** pane, in the **Setting** list, right-click **Hash Publication for BranchCache** to open the context menu, and then select **Edit**.

15.  In the **Hash Publication for BranchCache** dialog box, select **Enabled**. 
16.  In the **Options** list, select **Allow hash publication only for shared folders on which BranchCache is enabled**, and then select **OK**.
17.  Close the **Local Group Policy Editor**.

### Task 2: Prepare a file share for BranchCache

1.  On **SYD-SVR1**, on the taskbar, select the **File Explorer** icon.

2.  In the **File Explorer** window, navigate to **Local Disk (C:)**.

3.  In the **Local Disk (C:)** window, on the menu, select the **Home** tab, and then select **New Folder**.

4.  Enter **`Share`**, and then select Enter.

5.  Right-click **Share** to open the context menu, and then select **Properties**.

6.  In the **Share Properties** dialog box, on the **Sharing** tab, select **Advanced Sharing**.

7.  In the **Advanced Sharing** dialog box, select the **Share this folder** check box, and then select **Caching**.

8.  In the **Offline Settings** dialog box, select the **Enable BranchCache** check box, and then select **OK**.

9.  In the **Advanced Sharing** dialog box, select **OK**.

10.  In the **Share Properties** dialog box, select **Close**.

11.  On the taskbar, select **Start**, enter **cmd**, and then select Enter.

12.  At the command prompt, enter the following command, and then select Enter:

    ```
Copy C:\windows\system32\mspaint.exe c:\share
    ```

13.  Close the command prompt.

14.  Close File Explorer.

### Task 3: Configure client firewall rules for BranchCache

1.  Switch to **LON-DC1**, and sign in as **Contoso\Administrator** with the password of **`Pa55w.rd`**.

2.  In **Server Manager**, select **Tools**, and then select **Group Policy** **Management**.

3.  In **Group Policy Management**, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click **Default Domain Policy** to open the context menu, and then select **Edit**.

4.  In the **Group Policy Management Editor**, in the **navigation** pane, under **Computer Configuration**, expand **Policies**, expand **Windows Settings**, expand **Security Settings**, and then select **Windows Defender Firewall with Advanced Security**.

5.  In the **navigation** pane, expand **Windows Defender Firewall with Advanced Security**, and then select **Inbound** **Rules**.

6.  In the **Group Policy Management Editor**, on the **Action** menu, select **New Rule**.

7.  In the **New Inbound Rule Wizard**, on the **Rule Type** page, select **Predefined**, select **BranchCache – Content Retrieval (Uses HTTP)**, and then select **Next**.

8.  On the **Predefined Rules** page, select **Next**.

9.  To create the firewall inbound rule, on the **Action** page, select **Finish**.

10.  In the **Group Policy** **Management Editor**, in the navigation pane, select **Inbound Rules**, and then on the **Action** menu, select **New Rule**.

11.  On the **Rule Type** page, select **Predefined**, select **BranchCache – Peer Discovery (Uses WSD)**, and then select **Next**.

12.  On the **Predefined** **Rules** page, select **Next**.

13.  On the **Action** page, select **Finish**.

14.  Close the **Group Policy Management Editor** and **Group Policy Management** console.

### Task 4: Configure client firewall rules for BranchCache

1.  Switch to **LON-SVR1**, and sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.
2.  Open **Server Manager**, and then select **Add roles and features**.
3.  In the **Add Roles and Features** **Wizard**, on the **Before you begin** page, select **Next**.

4.  On the **Select installation type** page, select **Next**.

5.  On the **Select destination server** page, select **Next**.

6.  On the **Select server roles** page, expand **File and Storage Services (installed)**, expand **File and iSCSI Services**, and then select the **BranchCache for Network Files** check box.

7.  On the **Select server roles** page, select **Next**.

8.  On the **Select features** page, select **BranchCache**, and then select **Next**.

9.  On the **Confirm installation selections** page, select **Install**.

10.  After the installation succeeded message displays, select **Close**.

### Task 5: Configure client firewall rules for BranchCache

1.  On **LON-SVR1**, select **Start**, and then select the **Windows PowerShell ISE** icon.

2.  In the **Windows PowerShell ISE** command prompt window, enter the following cmdlet, and then select Enter:

   ```
Enable-BCHostedServer –RegisterSCP
   ```

3.  In the **Windows PowerShell ISE** window, enter the following cmdlet, and then select Enter:

   ```
   Get-BCStatus
   ```

>Note: Ensure that **BranchCache** is enabled and running.

### Task 6: Configure client firewall rules for BranchCache

1.  Switch to **LON-DC1**.

2.  In **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

3.  In the **Active Directory Users and Computers** window, open the **Computers** container.

4.  Right-click **LON-CL1** to open the context menu, and then select **Move**.

5.  In the **Move** window, select **IT**, and then select **OK**.

6.  Right-select **LON-CL2**, and then select **Move**.

7.  In the **Move** window, select **IT**, and then select **OK**.

8.  Close **Active Directory Users and Computers**.

9.  In **Server Manager**, select **Tools**, and then select **Group Policy Management**.

10.  In the **Group Policy Management** console, in the navigation pane, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click **IT** to open the context menu, and then select **Create a GPO in this domain and link it here**.

11.  In the **New GPO** window, enter **`BCClient`**, and then select **OK**.

12.  In the **Group Policy Management** console, in the navigation pane, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, expand **IT**, right-click **BCClient** to open the context menu, and then select **Edit**.

13.  In the **Group Policy Management Editor**, in the navigation pane, under **Computer** **Configuration**, expand **Policies**, expand **Administrative** **Templates**, expand **Network**, and then select **BranchCache**.

14.  In the **BranchCache** results pane, in the **Setting** list, right-click **Turn on BranchCache** to open the context menu, and then select **Edit**.

15.  In the **Turn on BranchCache** dialog box, select **Enabled**, and then select **OK**.

16.  In the **BranchCache** results pane, in the **Setting** list, right-click **Enable Automatic Hosted Cache Discovery by Service Connection Point** to open the context menu, and then select **Edit**.

17.  In the **Enable Automatic Hosted Cache Discovery by Service Connection Point** dialog box, select **Enabled**, and then select **OK**. 

18.  In the **BranchCache** results pane, in the **Setting** list, right-click **Configure** **BranchCache for network files** to open the context menu, and then select **Edit**.

19.  In the **Configure BranchCache for network files** dialog box, select **Enabled**; in the **Type the maximum round trip network latency (milliseconds) after which caching begins** box, enter **0**, and then select **OK**. 

>**Note:** This setting simulates access from a branch office and isn't typically required.

20.  Close the **Group Policy Management Editor** and the **Group Policy Management** console.

21.  Restart **LON-CL1**, and sign in as **Contoso\Administrator** with the password **`Pa55w.rd`**.

22.  On the taskbar, select **Start**, enter **cmd**, and then select Enter.

23.  In the **Command Prompt** window, enter the following command, and then select Enter:

    ```
gpupdate /force
    ```

24.  At the command prompt, enter the following command, and then select Enter: 

    ```
    netsh branchcache show status all
    ```

>Note: Verify that **BranchCache** is enabled with the status of **Running** and that the options from Group Policy are applied. If the status is **Stopped**, repeat steps 23 and 24.

25.  Restart **LON-CL2**, and sign in as **Contoso\Administrator** with the password **`Pa55w.rd`**.

26.  Select **Start**, and then enter **cmd.exe**. Select Enter.

27.  In the **Command Prompt** window, enter the following command, and then select Enter:

    ```
    gpupdate /force
    ```

28.  In the **Command Prompt** window, enter the following command, and then select Enter: 

    ```
    netsh branchcache show status all
    ```

>Note: Verify that **BranchCache** is enabled with status **Running** and that the options from Group Policy are applied. If the status is **Stopped**, repeat steps 27 and 28.

**Results:** Upon completion of this exercise, you'll have implemented BranchCache.

## Exercise 2: Validating the deployment

### Scenario

You need to verify that the BranchCache configuration you implemented for the Toronto and Sydney locations is functioning properly.

The main tasks for this exercise are:

1. Simulate slow link to the branch office.
2. Verify BranchCache functionality for SYD-SVR1.

### Task 1: Simulate slow link to the branch office

1.  On **SYD-SVR1**, select **Start**, enter **gpedit.msc**, and then select Enter. 

2.  In the navigation pane of the **Local Group Policy Editor** console, under **Computer** **Configuration**, expand **Windows Settings**, right-click **Policy-based QoS** to open the context menu, and then select **Create new policy**.

3.  On the **Create a QoS policy** page of the **Policy-based QoS Wizard**, in the **Policy name** box, enter **`Limit to 100 KBps`**, select the **Specify Outbound Throttle Rate** check box, enter **`100`**, and then select **Next**.

4.  On the **This QoS policy applies to** page, select **Next**.

5.  On the **Specify the source and destination IP addresses** page, select **Next**.

6.  On the **Specify the protocol and port numbers** page, select **Finish**.

7.  Close the **Local Group Policy Editor**.

### Task 2: Verify BranchCache functionality for SYD-SVR1

1.  Switch to **LON-CL1**. 

2.  Select Start, enter **perfmon**, and then select Enter.

3.  In the navigation pane of the **Performance Monitor** console, under **Monitoring** **Tools**, select **Performance** **Monitor**.

4.  In the **Performance Monitor result** pane, select the **Delete (Delete Key)** icon. 

5.  In the **Performance Monitor result** pane, select the **Add (Ctrl+N)** icon.

6.  In the **Add** **Counters** dialog box, under **Select** **counters** **from** **computer**, select **BranchCache**, select **Add**, and then select **OK**.

7.  Select the arrow to the right of **Change graph type**, and then select **Report**. Notice that the value of all performance statistics is zero.

8.  Repeat steps 1 through 7 for **LON-CL2** and **LON-SVR1**.

9.  Switch to **LON-CL1**.

10.  On the taskbar, select the **File Explorer** icon.

11.  In **File Explorer**, in the address bar, enter **`\\SYD-SVR1\Share`**, and then select Enter.

12.  In **File Explorer**, right-click **mspaint.exe** to open the context menu, and then select **Copy**.

13.  In **File Explorer**, right-click **Desktop** to open the context menu, and then select **Paste**.

>Note: This file copy will take some time because of the 100-Kbps bandwidth limit placed on **SYD-SVR1**.

14.  In **Performance Monitor**, select any counter, and then select Ctrl+A.

15.  Right-click any counter to open the context menu, and then select **Scale Selected Counters**.

>Note: Note that several counters are no longer at zero, which indicates that BranchCache is active.

16.  Switch to **LON-SVR1**.

17.  On **LON-SVR1**, switch to **Performance Monitor**, and then note that counter statistics reflect BranchCache activity on **LON-SVR1**.

18.  On **LON-SVR1**, switch to the **Windows PowerShell ISE** window.

19.  In the **Windows PowerShell ISE** window, enter the following command, and then select Enter:

    ```
    Get-BCStatus
    ```

>Note: Note that under **DataCache**, the **CurrentActiveCacheSize** value is 909312 bytes, which is the size of mspaint.exe.

20.  Switch to **LON-CL2**.

21.  On **LON-CL2**, on the taskbar, select the **File Explorer** icon.

22.  In **File Explorer**, in the address bar, enter **`\\SYD-SVR1\Share`**, and then select Enter.

23.  In **File Explorer**, right-click **mspaint.exe** to open the context, and then select **Copy**.

24.  In **File Explorer**, right-select **Desktop** to open the context menu, and then select **Paste**.

>Note: Note that the file copy time is much faster than to LON-CL1, because the file is cached on **LON-SVR1**.

**Results:** Upon completion of this exercise, you'll have validated BranchCache.
