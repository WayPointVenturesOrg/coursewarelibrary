---
lab:
    title: 'Lab: Implement and configure network infrastructure services in Windows Server'
    module: 'Module 3: Network infrastructure services in Windows Server'
---

# Lab: Implement and configure network infrastructure services in Windows Server

## Lab scenario

Contoso, Ltd. is a large organization with complex requirements for network services. To help meet these requirements, you'll deploy and configure Dynamic Host Configuration Protocol (DHCP) so that it's highly available to ensure service availability. You'll also set up Domain Name System (DNS) so that Trey Research, a department within Contoso, can have its own DNS server in the testing area. Finally, you'll provide remote access to Windows Admin Center and secure it with Web Application Proxy.

## Objectives

After completing this lab, you'll be able to:

- Deploy and configure DHCP.
- Deploy and configure DNS.

## Estimated time: 45 minutes

## Exercise 1: Deploy and configure DHCP

### Scenario

The Trey Research subdivision of Contoso, Ltd. has a separate office with only about 25 users. They've been manually configuring IP addresses on all of their computers and want to use DHCP instead. You'll install DHCP on **LON-SVR1** with a scope for the Trey Research site. Additionally, you'll configure DHCP failover for high availability with **LON-DC1**.

The main tasks for this exercise are as follows:

1. Install the DHCP role.
2. Authorize the DHCP server.
3. Create a scope.
4. Configure DHCP failover.
5. Verify DHCP functionality.

### Task 1: Install the DHCP role

1. Sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

2. On the taskbar, select **Microsoft Edge**.

3. In **Microsoft Edge**, select **Windows Admin Center**.

>Note: It might take a minute or two for the Windows Admin Center services to start.

4. In the **Windows Security** dialog box, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

5. In **Windows Admin Center**, select **lon-svr1.contoso.com**.

>Note: You can ignore any warning message regarding the update extension catalogs.

6. In the **Specify your credentials** dialog box, select **Use another account for this connection**, and then sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

7. On the **Tools** pane, select **Roles & features**.

8. On the **Roles and features** pane, select the **DHCP Server** checkbox, and then select **Install**.

9. In the **Install Roles and Features** dialog box, select **Yes**.

10. Wait until a notification displays, indicating that the DHCP role is installed. 

>Note: You can select the **Notifications** icon to monitor and verify the current status.

11. In **Windows Admin Center**, select the **Server Manager** drop-down menu, and then select **All connections**.

12. Select **lon-svr1.contoso.com**.

13. On the **Tools** pane, select **Overview**, and then on the **details** pane take note of the message to restart **LON-SVR1**. 

>Note: The message might take a while to display; continue with the next steps regardless.

14. On the **details** pane, select **Restart** and then select **Yes**. Windows Admin Center returns to the **All connections** page.

>Note: Wait 3-4 minutes for **LON-SVR1** to restart.

15. In **Windows Admin Center**, if necessary, select the **Server Manager** drop-down menu, and then select **All connections**.

16. Select **lon-svr1.contoso.com**.

17. On the **Tools** pane, select **DHCP**, and then on the **details** pane, select **Install**. 

>Note: If DHCP isn't available on the **Tools** pane for **LON-SVR1**, close **Microsoft Edge** and sign in to **Windows Admin Center** again.

18. Wait for a notification that the **DHCP PowerShell tools** are installed. If necessary, select the **Notifications** icon to verify the current status. Select **Close** to close the **Notifications** page.

### Task 2: Authorize the DHCP server

1. On **LON-ADM1**, select **Start**, and then select **Server Manager**.
2. In **Server Manager**, select **Notifications** in the menu, and then select **Complete DHCP configuration**.
3. In the **DHCP Post-Install configuration wizard** window, on the **Description** screen, select **Next**.
4. On the **Authorization** screen, select **Commit** to use the **Contoso\\Administrator** credentials.
5. When you complete both tasks, select **Close**.

### Task 3: Create a scope

1. On **LON-ADM1**, in **Windows Admin Center**, while connected to **LON-SVR1**, on the **Tools** pane, select **DHCP**, and then select **New scope**.
2. In the **Create a new scope** dialog box, enter the following information, and then select **Create**.
   - Protocol: **IPv4**
   - Name: **`TreyClients`**
   - Starting IP address: **`10.100.150.50`**
   - Ending IP address: **`10.100.150.254`**
   - DHCP client subnet mask: **`255.255.255.0`**
   - Router: **`10.100.150.1`**
   - Lease duration: **4 days**
3. On **LON-ADM1**, switch to **Server Manager**.
4. In **Server Manager**, select **All Servers**.
5. On the **Servers** details pane, right-click or access the context menu for **LON-SVR1**, and then select **DHCP Manager**.
6. In the DHCP window, expand **LON-SVR1.Contoso.com**, expand **IPv4**, expand **Scope [10.100.150.0] TreyClients**, and then select **Scope Options**.
7. Select the **Action** menu, and then select **Configure Options**.
8. In the **Scope Options** dialog box, select the **006 DNS Servers** checkbox.
9. In the IP address box, enter **`172.16.0.10`**, select **Add**, and then select **OK**.

### Task 4: Configure DHCP failover

1. On **LON-ADM1**, in the DHCP window, select **IPv4**, select the **Action** menu, and then select **Configure Failover**.

2. In the **Configure Failover** window, verify that the **Select all** checkbox is checked, and then select **Next**.

3. On the **Specify the partner server to use for failover** screen, in the **Partner Server** box, enter **`LON-DC1`**, and then select **Next**.

4. On the **Create a new failover relationship** screen, enter the following information, and then select **Next**.

   - Relationship Name: **`LON-SVR1 to LON-DC1`**
   - Maximum Client Lead Time: **1 hour**
   - Mode: **Hot standby**
   - Role of Partner Server: **Standby**
   - Addresses reserved for standby server: **5%**
   - State Switchover Interval: **Not selected**
   - Enable Message Authentication: **Enabled**
   - Shared Secret: **`DHCP-Failover`**

5. Select **Finish**.

6. In the **Configure Failover** dialog box, select **Close**.

7. Under **LON-SVR1.Contoso.com**, select **IPv4**, and then verify that only one scope is listed.

8. On **LON-ADM1**, switch to **Server Manager**.

9. In **Server Manager**, select **All Servers**.

10. On the **Servers** details pane, right-click or access the context menu for **LON-DC1**, and then select **DHCP Manager**.

11. Expand **LON-DC1.Contoso.com**, select **IPv4**, and then verify that two scopes are listed.

12. Select **Scope [172.16.0.0] Contoso**, select the **Action** menu, and then select **Configure Failover**.

13. In the **Configure Failover** window, select **Next**.

14. On the **Specify the partner server to use for failover** screen, in the **Partner Server** box, enter **`LON-SVR1`**, select the **Reuse existing failover relationships configured with this server (if any exist)** checkbox, and then select **Next**.

15. On the **Select from failover relationships which are already configured on this server** screen, select **Next**, and then select **Finish**.

16. In the **Configure Failover** dialog box, select **Close**.

17. Switch to the **DHCP** console for **LON-SVR1.Contoso.com**.

18. Under **LON-SVR1.Contoso.com**, select **IPv4**, and then verify that both scopes are listed. If necessary, refresh the console to observe both scopes.

>Note: Notice that the **172.16.0.0** scope is now replicated to **LON-SVR1**.

### Task 5: Verify DHCP functionality

1. Sign in to **LON-CL1** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

2. Select **Start**, and then select **Settings**.

3. In the **Settings** window, select **Network & internet**, and then select **Advanced network settings**.

4. Under **Related settings**, select **More network adapter options**.

5. In **Network Connections**, right-click or access the context menu for **Ethernet**, and then select **Properties**.

6. In the **Ethernet Properties** dialog box, select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**.

7. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, select **Obtain an IP address automatically**, select **Obtain DNS server address automatically**, and then select **OK** and close the window.

8. Right-click or access the context menu for **Ethernet**, and then select **Status**.

9. In the **Ethernet Status** dialog box, select **Details**.

10. In the **Network Connection Details** dialog box, verify that DHCP is enabled, an IP address was obtained, and that the **LON-SVR1 (172.16.0.12)** DHCP server issued the lease.

11. Select **Close**, and then select **Disable**.

12. Switch to **LON-ADM1**.

13. On **LON-ADM1**, switch to the the **DHCP** window for **LON-SVR1.Contoso.com**.

14. Under **LON-SVR1.contoso.com**, expand **IPv4**, expand **Scope [172.16.0.0] Contoso**, and then select **Address Leases**.

>Note: Verify that **LON-CL1.Contoso.com** is listed as a lease.

15. Select **LON-SVR1.Contoso.com**, select the **Action** menu, select **All Tasks**, and then select **Stop**.

16. On **LON-ADM1**, switch to the the **DHCP** window for **LON-DC1.Contoso.com**.

17. Under **LON-DC1.Contoso.com**, expand **IPv4**, expand **Scope [172.16.0.0] Contoso**, and then select **Address Leases**.

>Note: Verify that **LON-CL1.Contoso.com** is listed as a lease.

18. Close all open windows on **LON-ADM1**.

19. Switch to **LON-CL1**.

20. On **LON-CL1**, in the **Network Connections** window, right-click or access the context menu for **Ethernet**, and then select **Enable**.

21. In the menu bar, select **View status of this connection**, and then select **Details**. Verify that the DHCP server is now **LON-DC1 (172.16.0.10)**.

22. Close all open windows on **LON-CL1**.

**Results**: After this exercise, you should have successfully installed, configured, and verified DHCP functionality.

## Exercise 2: Deploy and configure DNS

### Scenario

The staff who work at the Trey Research location within Contoso need to have their own DNS server to create records in their test environment. However, their test environment still needs to be able to resolve internet DNS names and resource records for Contoso.com. To meet these needs, you're configuring forwarding to your internet service provider (ISP) and creating a conditional forwarder for **contoso.com** to **LON-DC1**. There's also a test application that needs a different IP address resolution based on user location. You're using DNS policies to configure **testapp.treyresearch.net** to resolve differently for users at the head office.

The main tasks for this exercise are as follows:

1. Install the DNS role.
2. Create a DNS zone.
3. Configure forwarding.
4. Configure conditional forwarding.
5. Configure DNS policies.
6. Verify DNS policy functionality.

### Task 1: Install the DNS role

1. On **LON-ADM1**, on the taskbar, select **Microsoft Edge**.

2. In **Microsoft Edge**, select **Windows Admin Center**.

3. In the **Windows Security** dialog box, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

4. In **Windows Admin Center**, select **LON-SVR1.contoso.com**.

5. In the **Specify your credentials** dialog box, select **Use another account for this connection**, and then sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

6. On the **Tools** pane, select **Roles & features**.

7. On the **Roles and features** pane, select the **DNS Server** checkbox, and then select **Install**.

8. In the **Install Roles and Features** dialog box, select **Yes**.

>Note: Wait until a notification displays, indicating that the DNS role is installed. If necessary, select the **Notifications** icon to verify the current status.

9. In **Windows Admin Center**, select the **Server Manager** drop-down menu, and then select **All connections**.

10. Select **LON-SVR1.contoso.com**.

11. On the **Tools** pane, select **DNS**, and then on the **details** pane, select **Install**. 

>Note: If **DNS** isn't available in the **Tools** pane for **LON-SVR1**, close **Microsoft Edge** and sign in to **Windows Admin Center** again.

12. Wait until a notification displays, indicating that the **DNS PowerShell tools** are installed. If necessary, select the **Notifications** icon to verify the current status.

### Task 2: Create a DNS zone

1. On **LON-ADM1**, in **Windows Admin Center**, ensure that the **DNS** node is selected.

2. Select **Actions** and then select **Create a new DNS zone**.

3. In the **Create a new DNS zone** dialog box, enter the following information, and then select **Create**:

   - Zone type: **Primary**
   - Zone name: **```TreyResearch.net```**
   - Zone file: **Create a new file**
   - Zone file name: **```TreyResearch.net.dns```**
   - Dynamic update: **Do not allow dynamic updates**

4. Select **TreyResearch.net**, and then select **Create a new DNS record**.

5. In the **Create a new DNS record** dialog box, enter the following information, and then select **Create**:

   - DNS record type: **Host (A)**
   - Record name: **`TestApp`**
   - IP address: **`172.30.99.234`**
   - Time to live: **`600`**

6. Select **Start**, and then select **Windows PowerShell ISE**.

7. At the **Windows PowerShell** prompt, enter the following, and then select Enter:

   ```powershell-notab
   Resolve-DnsName -Server LON-svr1.contoso.com -Name testapp.treyresearch.net
   ```

>Note: Notice that the name **testapp.treyresearch.net** resolves to **172.30.99.234**.

8. Close the **Windows PowerShell ISE** window.

### Task 3: Configure forwarding

1. On **LON-ADM1**, select **Start**, and then select **Server Manager**.
2. In **Server Manager**, select **All Servers**.
3. On the **Servers** details pane, right-click or access the context menu for **LON-SVR1**, and then select **DNS Manager**.
4. In **DNS Manager**, select **LON-SVR1.Contoso.com**, select **Action**, and then select **Properties**.
5. In the **LON-SVR1.Contoso.com Properties** dialog box, select the **Forwarders** tab, and then select **Edit**.
6. In the **Edit Forwarders** dialog box, in the **IP addresses for forwarding servers** box, enter **`131.107.0.100`**, and then select **OK**.
7. In the **LON-SVR1.Contoso.com Properties** dialog box, select **OK**.

### Task 4: Configure conditional forwarding

1. On **LON-ADM1**, in **DNS Manager**, expand **LON-SVR1.Contoso.com**, and then select **Conditional Forwarders**.

2. Select **Action**, and then select **New Conditional Forwarder**.

3. In the **New Conditional Forwarder** dialog box, in the **DNS Domain** box, enter **```Contoso.com```**.

4. In the **IP addresses of the master servers** box, enter **`172.16.0.10`**, select **Enter**, and then select **OK**.

5. Close **DNS Manager** and **Server Manager**.

6. Select **Start**, and then select **Windows PowerShell ISE**.

7. At the **Windows PowerShell** prompt, enter the following, and then select Enter:

   ```powershell-notab
   Resolve-DnsName -Server LON-svr1.contoso.com -Name LON-dc1.contoso.com
   ```

>Note: Notice that the DNS server on **LON-SVR1** can resolve the **LON-DC1.Contoso.com** name to IP address **172.16.0.10**.

8. Close the **Windows PowerShell ISE** window.

### Task 5: Configure DNS policies

1. On **LON-ADM1**, in **Windows Admin Center**, while connected to **LON-SVR1.contoso.com**, select the **PowerShell** node.

2. At the **Password** prompt, enter **`Pa55w.rd`**, and then select **Enter**.

3. To create a head office subnet, enter the following, and then select Enter:

   ```powershell-notab
Add-DnsServerClientSubnet -Name "HeadOfficeSubnet" -IPv4Subnet "172.16.0.0/24"
   ```

4. To create a zone scope for the head office, enter the following, and then select Enter:

   ```powershell-notab
Add-DnsServerZoneScope -ZoneName "TreyResearch.net" -Name "HeadOfficeScope"
   ```

5. To add a new resource record for the head office scope, enter the following, and then select Enter:

   ```powershell-notab
Add-DnsServerResourceRecord -ZoneName "TreyResearch.net" -A -Name "testapp" -IPv4Address "172.30.99.100" -ZoneScope "HeadOfficeScope"
   ```

6. To create a new policy that links the head office subnet and the zone scope, enter the following, and then select Enter:

   ```powershell-notab
Add-DnsServerQueryResolutionPolicy -Name "HeadOfficePolicy" -Action ALLOW -ClientSubnet "eq,HeadOfficeSubnet" -ZoneScope "HeadOfficeScope,1" -ZoneName "TreyResearch.net"
   ```

7. Close **Windows Admin Center**.

### Task 6: Verify DNS policy functionality

1. On **LON-CL1**, select **Start**, and then enter **Windows PowerShell ISE**.

2. Select **Windows PowerShell ISE**.

3. At the **Windows PowerShell** prompt, enter **`ipconfig`**, and then select **Enter**. 

>Note: Note that the Ethernet adapter has an IP address that's part of the HeadOfficeSubnet (**172.16.0.0**) configured in the policy.

4. To test the DNS policy, at the Windows PowerShell prompt, enter the following command and then select Enter:

   **```Resolve-DnsName -Server LON-svr1.contoso.com -Name testapp.treyresearch.net```** 

>Note: The name resolves to the IP address **172.30.99.100** that was configured in the HeadOfficePolicy.

5. Select **Start**, and then select **Settings**.

6. In the **Settings** window, select **Network & internet**, and then select **Advanced network settings**.

7. Select **More network adapter options**.

8. In **Network Connections**, right-click or access the context menu for **Ethernet**, and then select **Properties**.

9. In the **Ethernet Properties** dialog box, select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**.

10. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, select **Use the following IP address**, enter the following information, and then select **OK**:

   - IP Address: **`172.16.11.100`**
   - Subnet mask: **`255.255.0.0`**
   - Default gateway: **`172.16.0.1`**
   - Preferred DNS server: **`172.16.0.10`**

11. Select **Close** twice.

12. To test the DNS policy, at the **Windows PowerShell** prompt, enter the following, and then select Enter:

   ```powershell-notab
Resolve-DnsName -Server LON-svr1.contoso.com -Name testapp.treyresearch.net
   ```

13. Notice that the name resolves to **172.30.99.234** because the client is no longer in the HeadOfficeSubnet location.

14. Close all open windows.

>Note: When the client is on HeadOfficeSubnet **(172.16.0.0/24)** the record **testapp.treyresearch.net** resolves to **172.30.99.100**. When the client is moved off of HeadOfficeSubnet, **testapp.treyresearch.net** resolves to **172.30.99.234**.

**Results**: After this exercise, you should have successfully installed and configured the DNS server role to support name resolution, forwarding, and DNS policies.
