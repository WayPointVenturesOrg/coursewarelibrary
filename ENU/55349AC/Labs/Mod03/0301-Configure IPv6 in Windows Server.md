# Lab: Configure IPv6 in Windows Server

## Lab scenario

Contoso Corporation has recently purchased several key applications that support IPv6. As a result, you're considering integrating IPv6 on your internal network.  You need to configure and test IPv6 connectivity and address assignment.


## Exercise 1: Review the default IPv6 configuration

### Scenario

To understand how IPv6 works and how the planned infrastructure changes will affect network traffic, you must first identify and document the default IPv6 configuration at Contoso Corporation. 

The main tasks for this exercise are:

1. Identify the default IPv6 configuration.

2. Test link-local address connectivity.

3. View the IPv6 Routing Table and test IPv6 configuration.

### Task 1: Identify the default IPv6 configuration

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

2. In **Server Manager**, select **Tools**, and then select **DNS**.

3. In the **DNS** console tree, expand **LON-DC1\\Forward Lookup Zones**, and then select **Contoso.com**. 

>Note: Notice that **LON-DC1** has one IPv6 address preconfigured for the lab. There are no AAAA records registered for any other computer.

4. Close **DNS Manager**.

5. Select **Start**, and then select **Windows PowerShell ISE**.

6. At the **Windows PowerShell ISE** command prompt, enter **`ipconfig`**, and then select Enter. 

>Note: Notice that this command returns a link-local IPv6 address. Enter this address in the text box below. When entering the IPv6 address, don't enter the percent sign (%) or the numbers after the % sign. As you may recall, the prefix for link-local addresses is always FE80::/64.

**LON-DC1 link-local address:** 

7. Enter **`Get-NetIPAddress`**, and then select Enter. 

>Note: Notice that this command also returns a link-local IPv6 address. 

8. Repeat steps 4 to 6 on **LON-SVR1** and **TOR-SVR1**. 

>Note: Sign in to both LON-SVR1 and TOR-SVR1 as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

**LON-SVR1 link-local address:** 

**TOR-SVR1 link-local address:** 

>Note: Windows client and server operating systems don't register link-local IPv6 addresses in the Domain Name System (DNS).

### Task 2: Test link-local address connectivity

1. Switch to **LON-DC1**.

2. At the **Windows PowerShell ISE** command prompt, enter **`ping (LON-SVR1 link-local address)`**

>Note: This is the **LON-SVR1** link-local IPv6 address that was displayed in the previous task. Four successful replies should display.

3. At the **Windows PowerShell ISE** command prompt, enter the following command and then select Enter. 

**`Test-NetConnection (LON-SVR1 link-local address)`**.

>Note: **Ping Succeeded: True** from the **LON-SVR1** link-local IPv6 address should display. The **Test-NetConnection** cmdlet performs diagnostics for a network connection and displays the results. The results also include a diagnostic message to notify you whether the **ping** command was successful.

4. At the **Windows PowerShell ISE** command prompt, enter the following command to test the connection to TOR-SVR1. 

>Note: TOR-SVR1 is located in a different subnet from LON-DC1 and LON-SVR1 separated by a router.

**`Test-NetConnection (TOR-SVR1 link-local address)`**

>Note: The following should display: the warning message **DestinationHostUnreachable** and the result of the diagnostics that displays the message **Ping Succeeded: False**. This is because the link-local IPv6 addresses aren't routable and can be used for communication only on the local subnet.

### Task 3: View the IPv6 Routing Table

1. Switch to **LON-DC1**.

2. At the **Windows PowerShell ISE** command prompt, enter **`Start-Process netsh`**, and then press Enter.

3.  At the **netsh** command prompt, enter the following commands and then press Enter after each command. 

   **`interface ipv6`**

   **`show route`**

   **`show interface`**

4. At the **netsh** command prompt, enter **`show neighbors`**, and then press Enter.

>Note: This will provide you with the content of the neighbor cache.  To review the additional parameters that are available for this command, enter **`show neighbors /?`**.

5. At the **netsh** command prompt, enter **`show destinationcache`**, and then press Enter.

>Note: To review the additional parameters that are available for this command, enter **`show destinationcache /?`**.

**Results:** After completing this exercise, you'll have reviewed the default IPv6 configuration and tested how computers communicate by using IPv6 addresses.

## Exercise 2: Implement DHCPv6

### Scenario

Contoso Corporation is planning to implement IPv6 throughout its internal network. To manage the IPv6 addresses assigned to clients, you need to configure DHCP to assign the IPv6 addresses.

The main tasks for this exercise are:

1. Create and configure DHCPv6 scopes.
2. Verify configuration by testing the allocation of IPv6 addresses.

### Task 1: Create and configure DHCPv6 scopes

1. On **LON-DC1**, in the **Server Manager** window, select **Tools**, and then select **DHCP**.

2. In the **DHCP** console, expand **lon-dc1.Contoso.com**, expand **IPv6**, select and then right-click **IPv6** to open the context menu, and then select **New Scope**.

3. In the **New Scope Wizard**, select **Next**.

4. On the **Scope Name** page, in the **Name** text box, enter **`Headquarters IPv6`**, and then select **Next**.

5. On the **Scope Prefix** page, in the **Prefix** text box, enter **`fd00:0000:0000:0000::`**, and then select **Next**.

6. On the **Add Exclusions** page, enter the following, select **Add**, and then select **Next**: 

   **Start IPv6 Address:** **`0000:0000:0000:0000`**
   
   **End IPv6 Address:** **`0000:0000:0000:00ff`**

7. On the **Scope Lease** page, select **Next**.

8. On the **Completing the New Scope Wizard** page, select **Finish**.

9. Close the DHCP console.

### Task 2: Verify configuration by testing allocation of IPv6 addresses

1. Switch to **LON-CL1**, and then sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2. Select **Start**, enter **PowerShell ISE**, and then select Enter.

3. In the **Windows PowerShell ISE** window, enter **`Ipconfig /renew6`**, and then select Enter.

4. Verify that the IPv6 address is in the IP range **FD00::/64**.

**Results:** After completing this exercise, you'll have configured DHCP to assign IPv6 addresses, and verified that the addresses are assigned correctly.

