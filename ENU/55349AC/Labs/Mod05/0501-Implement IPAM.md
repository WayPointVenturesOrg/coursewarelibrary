# Lab: Implement IPAM

## Lab scenario

The network environment at Contoso Corporation maintains network services in multiple locations, which has become increasingly complex to manage. You have decided to deploy an IP Address Management (IPAM) Server and use it to centrally manage the organization's IP address configuration.

## Exercise 1: Install the IPAM Server feature

### Scenario

You need to implement IPAM for Contoso.com and install the server feature on LON-SVR2. 

The main tasks for this exercise are:

1. Prepare the lab environment.
2. Install the **IPAM Server** feature on LON-SVR2.

### Task 1: Prepare the lab environment

>Note: Running the following scripts will return several warnings, which you can ignore.

1.  Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2.  Select **Start**, and then select **Windows PowerShell ISE**.

3.  At the command prompt in the Windows PowerShell ISE interface, enter the following command, and then select Enter:

   ```
C:\Labfiles\Mod05\LON-SVR1_Mod05_Setup.ps1
   ```

4.  Sign in to **TOR-SVR1** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

5.  Select **Start**, and then select **Windows PowerShell ISE**.

6.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   ```
C:\Labfiles\Mod05\TOR-SVR1_Mod05_Setup.ps1
   ```

7.  Sign in to **SYD-SVR1** as **Contoso\\Administrator** with the password **`Pa55w.rd`**

8.  Select **Start**, and then select **Windows PowerShell ISE**.

9.  At the **Windows PowerShell ISE** command prompt, enter the following command, and then select Enter:

   ```
   C:\Labfiles\Mod05\SYD-SVR1_Mod05_Setup.ps1
   ```

>Note: **SYD-SVR1** restarts when the script completes. 

10.  After **SYD-SVR1** restarts, sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

### Task 2: Install the IPAM Server feature on LON-SVR2

1.  Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2.  Select **Start**, and then select **Server Manager**. In the results pane, select **Add roles and features**.

3.  In the **Add Roles and Features Wizard**, select **Next**.

4.  On the **Select installation type** page, select **Next**.

5.  On the **Select destination server** page, select **Next**.

6.  On the **Select server roles** page, select **Next**.

7.  On the **Select features** page, select the **IP Address Management (IPAM) Server** check box.

8.  In the **Add features that are required for IP Address Management (IPAM) Server?** dialog box, select **Add Features**, and then select **Next**.

9.  On the **Confirm installation selections** page, select **Install**.

10.  When the **Add Roles and Features Wizard** completes, close the wizard.

**Results:** After completing this exercise, you'll have successfully installed the IPAM Server feature.

## Exercise 2: Provision the IPAM Server

### Scenario

You need to configure IPAM discovery for servers in the Contoso.com domain. You'll use IPAM to manage the following servers:

- **LON-DC1**: domain controller (DC), Dynamic Host Configuration Protocol (DHCP), Domain Name System (DNS)

- **LON-SVR1**: DHCP, DNS

- **TOR-SVR1**: DHCP

- **SYD-SVR1**: DC, DNS

The main tasks for this exercise are:

1. Configure the IPAM server for Group Policy object (GPO) deployment.

2. Perform discovery on Contoso.com.

3. Provision the IPAM server to manage the DC, DNS, and DHCP servers.

### Task 1: Configure the IPAM server for GPO deployment

1.  On **LON-SVR2**, in the **Server Manager** navigation pane, select **IPAM**.

2.  In the **IPAM Overview** pane, select **Connect to IPAM server**. Select **LON-SVR2.Contoso.com**, and then select **OK**.

3.  Select **Provision the IPAM server**.

4.  In the **Provision IPAM** wizard, select **Next**.

5.  On the **Configure database** page, ensure that **Windows Internal Database (WID)** is selected, and then select **Next**.

6.  On the **Select provisioning method** page, ensure that **Group Policy Based** is selected.

7.  In the **GPO name prefix** box, enter **IPAM**, and then select **Next**.

8.  On the **Confirm the Settings** page, select **Apply**. Provisioning will take a few moments to complete.

>Note: If provisioning fails with a Windows Internal Database error, open **Services.msc**, restart the Windows Internal Database service, and then repeat steps 3 through 8.

9.  When provisioning completes, select **Close**.

### Task 2: Perform discovery on Contoso.com

1.  In the **IPAM Overview** pane, select **Configure server discovery**.

2.  In the **Configure Server Discovery** dialog box, select **Get forests**, and then in the **Configure Server Discovery** dialog box, select **OK**.

3.  Select **OK** again, and then select **Configure server discovery**.

4.  In the **Configure Server Discovery** dialog box, select **Add** to add the **Contoso.com** domain, and then select **OK**.

5.  In the **IPAM Overview** pane, select **Start server discovery**. 

>Note: Discovery might take 5-10 minutes to run. The yellow bar indicates when discovery is complete. Be sure to select the **Refresh** button after discovery is complete.

6.  In the **IPAM Overview** pane, select **Select or add servers to manage and verify IPAM access**. Notice that the **IPAM Access Status** is **Blocked** for the servers. Scroll down to the **Details** view, and then note the status report. 

>Note: You have not yet granted the IPAM server permission to manage servers in the Contoso.com domain by using Group Policy.

### Task 3: Provision the IPAM server to manage the DC, DNS, and DHCP servers

1.  On **LON-SVR2**, click **Start**, and then select **Windows PowerShell ISE**.

2.  At the **Windows PowerShell ISE** command prompt, enter the following command, and then select Enter:

   ```
Invoke-IpamGpoProvisioning –Domain "Contoso.com" -DomainController "lon-dc1.Contoso.com" –GpoPrefixName "IPAM" –IpamServerFqdn "LON-SVR2.Contoso.com" –DelegatedGpoUser "Administrator"
   ```

3.  When prompted to confirm the action, select **Yes**. The command will take a few moments to complete. When the command is complete, select **Yes** at each prompt.

4.  Close Windows PowerShell ISE.

5.  Switch to **LON-DC1**.

6.  In **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.

7.  In the **Active Directory Administrative Center** window, in the navigation pane, select **Global Search**.

8.  In the **Search** box, enter **IPAMUG**, and then select Enter.

9.  Open the **IPAMUG** group.

10.  In the **IPAMUG** dialog box, under **Group scope**, select **Global**.

11.  Scroll to the **Member Of** section, and then select **Add**.

12.  In the **Select Groups** window, enter **Domain Admins**, select **Check Names**, and then select **OK**.

13.  Select **OK** to close the **IPAMUG** dialog box.

14.  Close the **Active Directory Administrative Center** window.

15.  Switch to **LON-SVR2**.

16.  Restart **LON-SVR2**.

17.  On **LON-SVR2**, sign in as **Contoso\Administrator** with the password **`Pa55w.rd`**.

18.  Select **Start**, and then select **Server Manager**. 

19.  Select **IPAM**, and then select **SERVER INVENTORY**.

20.  In the **IPv4 details** pane, right-click **LON-DC1** to open the context menu, and then select **Edit Server**.

21.  In the **Add or Edit Server** dialog box, set the **Manageability status** field to **Managed**, and then select **OK**.

>Note: If a Group Policy Object (GPO) error appears, switch the server back to **Unspecified**, and then restart **LON-DC1**, **LON-SVR1**, **LON-SVR2**, **TOR-SVR1**, and **SYD-SVR1**. Sign back in to all servers as **Contoso\Administrator** with the password **Pa55w.rd**. 

22.  In the **IPv4 details** pane, right-click **lon-svr1** to open the context menu, and then select **Edit Server**.


>Note: If **LON-SVR1** doesn't appear, select **TASKS**, select **Add Server**, and then in the **Add or Edit Server** dialog box, in the **Server name (FQDN)** field, enter **LON-SVR1**. Select the **DHCP server** and **DNS server** check boxes, select **Verify**, and then proceed to step 23.

23.  In the **Add or Edit Server** dialog box, set the **Manageability status** field to **Managed**, and then select **OK**.

24.  In the **IPv4 details** pane, right-click **tor-svr1** to open the context menu, and then select **Edit Server**. 


>Note: If **TOR-SVR1** doesn't appear, select **TASKS**, select **Add Server**, and then in the **Add or Edit Server** dialog box, in the **Server name (FQDN)** field, enter **TOR-SVR1**. Select the **DHCP server** check box, select **Verify**, and then proceed to step 25.

25.  In the **Add or Edit Server** dialog box, set the **Manageability status** field to **Managed**, and then select **OK**.

26.  In the **IPv4 details** pane, right-click **SYD-SVR1** to open the context menu, and then select **Edit Server**.


>Note: If **SYD-SVR1** doesn't appear, select **TASKS**, select **Add Server**, and then in the **Add or Edit Server** dialog box, in the **Server name (FQDN)** field, enter **SYD-SVR1**. Select the **DC** and **DNS server** check boxes, select **Verify**, and then proceed to step 27.

27.  In the **Add or Edit Server** dialog box, set the **Manageability status** field to **Managed**, and then select **OK**.

28.  Switch to **LON-DC1**.

29.  Right-click **Start** to open the context menu, and then select **Windows PowerShell (Admin)**.

30.  At the **Windows PowerShell** command prompt, enter **Gpupdate /force**, and then select Enter.

31.  Close the **Windows PowerShell** window.

32.  Switch to **LON-SVR1**.

33.  Right-click **Start** to open the context menu, and then select **Windows PowerShell (Admin)**.

34.  At the **Windows PowerShell** command prompt, enter **Gpupdate /force**, and then select Enter.

35.  Close the **Windows PowerShell** window.

36.  Switch to **TOR-SVR1**.

37.  Right-click **Start** to open the context menu, and then select **Windows PowerShell (Admin)**.

38.  At the **Windows PowerShell** command prompt, enter **Gpupdate /force**, and then select Enter.

39.  Close the **Windows PowerShell** window.

40.  Switch to **SYD-SVR1**.

41.  Right-click **Start** to open the context menu, and then select **Windows PowerShell (Admin)**.

42.  At the **Windows PowerShell** command prompt, enter **Gpupdate /force**, and then select Enter.

43.  Close the **Windows PowerShell** window.

44.  Switch back to **LON-SVR2**.

45.  In **Server Manager**, right-click **LON-DC1** to open the context menu, and then select **Refresh Server Access Status**. Repeat this step for **LON-SVR1**, **TOR-SVR1**, and **SYD-SVR1**.

46.  When completed, refresh IPv4 by selecting **Refresh**. 

>Note: It might take up to five minutes for the status to change. If the status doesn't change, restart **LON-DC1**, **LON-SVR1**, **LON-SVR2**, **TOR-SVR1**, and **SYD-SVR1**, and then repeat steps 44 to 46. Ensure that you restart **LON-DC1** before restarting the other virtual machines (VMs).

47.  In the **IPAM Overview** pane, select **Retrieve data from managed servers**. This action will take a few moments to complete.

**Results**: After completing this exercise, you'll have successfully provisioned an IPAM server.

## Exercise 3: Manage IP address spaces by using IPAM

### Scenario

You need to use IPAM to confirm the status of the current DHCP and DNS environment and make the following changes:

- Add an IP address block for the Toronto subnet, which you configure using static IP addresses:

  - Network ID: **172.16.18.0**
  - Prefix length: **24**
  - Start IP address: **172.16.18.0**
  - End IP address: **172.16.18.255**
  - Description: **Toronto addresses**

- Create an IP address reservation in the Houston scope for a network printer that's being installed:

  - Server IP: **172.16.20.200**

- Deactivate the DHCP scope for the Portland office.

The main tasks for this exercise are:

1. Add an IP address block.

2. Create an IP address reservation.

3. Deactivate the Portland **Wired** scope.


### Task 1: Add an IP address block

1.  On **LON-SVR2**, in **Server Manager**, in the navigation pane, select **IP Address Blocks**.

2.  In the **IPv4** pane, next to the **Current view**, select **IP Address Ranges**.


>Note: Note the three IP address ranges that display from **TOR-SVR1**.

3.  On the upper-right side of the window, select **TASKS**, and then select **Add IP Address Block**.

4.  In the **Add or Edit IPv4 Address Block** window, enter the following in the text boxes, and then select **OK**:

   - Network ID: **`172.16.18.0`**

   - Prefix length: **24**

   - Start IP address: **`172.16.18.0`**

   - End IP address: **`172.16.18.255`**

   - Description: **`Toronto subnet`**

5.  In the **IPv4** pane, next to the **Current view**, select **IP Address Blocks**.


>Note: Note the newly created address block for Toronto. 

### Task 2: Create an IP address reservation

1.  In **Server Manager**, on the **IPAM configuration** page, in the navigation pane, select **IP Address Blocks**.

2.  In the **IPv4** pane, next to the **Current view**, select **IP Address Ranges**.

3.  Right-click either of the IP address ranges with a **Network** value of **172.16.20.0/23** to open the context menu, and then select **Edit IP Address Range**. 


>Note: If the expected IP address ranges don't display, perform the following tasks: 
   >
   > - In **Server Manager**, right-click **LON-DC1** to open the context menu, and then select **Refresh Server Access Status**. Repeat this step for **LON-SVR1**, **TOR-SVR1**, and **SYD-SVR1**.
   >
   > - When completed, refresh **IPv4** by selecting **Refresh**. 
   >
   > - If the IP address ranges don't display, restart **LON-DC1**, **LON-SVR1**, **LON-SVR2**, **TOR-SVR1**, and **SYD-SVR1**, and then repeat steps 1 and 2. Ensure that you restart **LON-DC1** before restarting the other VMs.
   >
   > - In the **IPAM Overview** pane, select **Retrieve data from managed servers**. This action will take a few moments to complete.

4.  In the **Edit IP Address Range** window, select **Reservations**.

5.  In the **Reservation** box, enter **`172.16.20.200`**, select **Add**, and then select **OK**.


### Task 3: Deactivate the Portland Wired scope

1.  In the navigation pane, select the **DHCP Scopes** node, and then in the details pane, right-click the first scope listed with a **Scope ID** of **172.16.23.0** to open the context menu, and then select **Deactivate DHCP Scope**.

2.  Repeat step 1 for the second scope with a listed **Scope ID** of **172.16.23.0**.


>Note: This scope is duplicated as a result of DHCP failover configuration between **TOR-SVR1** and **LON-SVR1**. The preceding steps deactivate the scopes on both servers.

**Results**: After completing this exercise, you'll have successfully managed IP address spaces by using IPAM.
