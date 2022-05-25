# Lab: Configure and evaluate IPv6 transition technologies

## Lab scenario

Contoso Corporation has recently purchased several key applications that support IPv6. As a result, you're considering integrating IPv6 on your internal network. To test various IPv6 and IPv4 integration strategies, you've configured a test network environment between the three main company locations. You need to configure and test IPv6 connectivity by using various integration technologies.

The following image illustrates the layout of the completed test environment.

![Illustration that depicts the computers that are configured in this lab. LON-DC1 and LON-SVR1 are located on the lower-left side of the illustration, and represent IPv6-capable hosts located in the same subnet as the IPv6-capable network. TOR-SVR1 is located at the upper-right corner of the illustration, and represents an IPv6 host located on a different subnet, which is also IPv6-capable. The internet is represented as a cloud in the upper-left corner of the illustration. The internet connection is IPv4-only. EU-RTR is in the middle, which represents a router that connects the two subnets and the internet connection.](./Media/Mod03_Infrastructure.gif)

## Exercise 1: Review the default IPv6 configuration

### Scenario

To understand how IPv6 works and how the planned infrastructure changes will affect network traffic, you first must identify and document the default IPv6 configuration at Contoso Corporation. 

The main tasks for this exercise are:

1. Identify the default IPv6 configuration.

2. Test link-local address connectivity.

### Task 1: Identify the default IPv6 configuration

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. In **Server Manager**, select **Tools**, and then select **DNS**.

3. In the **DNS** console tree, expand **LON-DC1\\Forward Lookup Zones**, and then select **Contoso.com**. 

   > Notice that **LON-DC1** has one IPv6 address preconfigured for the lab. There are no AAAA records registered for any other computer.

4. Select **Start**, and then select **Windows PowerShell**.

5. At the **Windows PowerShell** command prompt, enter **`ipconfig`**, and then select Enter. 

   > Notice that this command returns a link-local IPv6 address. Take note of this address. As you may recall, the prefix for link-local addresses is always `FE80::/64`.

6. Enter **`Get‑NetIPAddress`**, and then select Enter. 

   > Notice that this command also returns a link-local IPv6 address. 

7. Repeat steps 4 to 6 on **LON-SVR1** and **TOR-SVR1**. Sign in to both servers as **Contoso\\Administrator** with the password of **Pa55w.rd**

   > **Note:** Windows client and server operating systems don't register link-local IPv6 addresses in the Domain Name System (DNS).

### Task 2: Test link-local address connectivity

1. Switch to **LON-DC1**.

2. At the **Windows PowerShell** command prompt, enter **`ping`**, followed by the **LON-SVR1** link-local IPv6 address, and then select Enter.

   > **Note:** The **LON-SVR1** link-local IPv6 address was displayed in step 5 of the previous task. When entering the IPv6 address, don't enter the percent sign (%) or the numbers after the % sign. Four successful replies should display.
3. At the **Windows PowerShell** command prompt, enter **`Test-NetConnection`** followed by the **LON-SVR1** link-local IPv6 address, and then select Enter.

   > **Note:** The **LON-SVR1** link-local IPv6 address was displayed in step 5 of the previous task. When entering the IPv6 address, don't enter the percent sign (%) or the numbers after the % sign.
   >
   > **`Ping Succeeded: True`** from the **LON-SVR1** link-local IPv6 address should display. The **`Test-NetConnection`** cmdlet performs diagnostics for a network connection and displays the results. The results also include a diagnostic message to notify you of whether the **ping** command was successful.
4. 
   At the **Windows PowerShell** command prompt, enter **`Test-NetConnection`** followed by the **TOR-SVR1** link-local IPv6 address.

   > **Note:** The **TOR-SVR1** link-local IPv6 address was displayed in the previous task. When typing the IPv6 address, don't enter the percent sign (%) or the numbers after the % sign.
   >
   > The following should display: the warning message **`DestinationHostUnreachable`** and the result of the diagnostics that displays the message **`Ping Succeeded: False`**. This is because the link-local IPv6 addresses arn't routable and can be used for communication only on local subnet.

**Results:** After completing this exercise, you'll have reviewed the default IPv6 configuration and tested how computers communicate by using link-local IPv6 addresses.

## Exercise 2: Implement DHCPv6

### Scenario

Contoso Corporation is planning to implement IPv6 throughout its internal network. To manage the IPv6 addresses assigned to clients, you need to configure DHCP to assign the IPv6 addresses.

The main tasks for this exercise are:

1. Create and configure Dynamic Host Configuration Protocol version 6 (DHCPv6) scopes.
2. Verify configuration by testing allocation of IPv6 addresses.

### Task 1: Create and configure DHCPv6 scopes

1. On **LON-DC1**, in the **Server Manager** window, select **Tools**, and then select **DHCP**.

2. In the **DHCP** console, expand **lon-dc1.Contoso.com**, expand **IPv6**, select and then right-click **IPv6** to open the context menu, and then select **New Scope**.

3. In the **New Scope Wizard**, select **Next**.

4. On the **Scope Name** page, in the **Name** text box, enter **Headquarters** **IPv6**, and then select **Next**.

5. On the **Scope Prefix** page, in the **Prefix** text box, enter **`fd00:0000:0000:0000::`**, and then select **Next**.

6. On the **Add Exclusions** page, enter the following, select **Add**, and then select **Next**: 

   Start IPv6 Address: **`0000:0000:0000:0000`**
   End IPv6 Address: **`0000:0000:0000:00ff`**

7. On the **Scope Lease** page, select **Next**.

8. On the **Completing the New Scope Wizard** page, select **Finish**.

9. Close the DHCP console.


### Task 2: Verify configuration by testing allocation of IPv6 addresses

1. Switch to **LON-CL1**, and then sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, enter **PowerShell**, and then select Enter.

3. In the **Windows PowerShell** window, enter **`Ipconfig /renew6`**, and then select Enter.

4. Verify that the IPv6 address is in the IP range `FD00::/64`.

**Results:** After completing this exercise, you'll have configured DHCP to assign IPv6 addresses, and verified that the addresses are assigned correctly.

## Exercise 3: Configure network integration by using ISATAP

### Scenario

The first option for testing IPv4 to IPv6 integration is to implement an ISATAP router. You need to configure an ISATAP router and verify that users can connect to other subnets by using IPv6.

The main tasks for this exercise are:

1. Configure an ISATAP router.

2. Verify the ISATAP configuration on the client.

3. Verify network connectivity to other subnets.

### Task 1: Configure an ISATAP router 

1. On **LON-DC1**, in the **Windows PowerShell** window, enter the following commands, and then select Enter after each command:

   ```
   dnscmd /info /globalqueryblocklist
   
   dnscmd /config /globalqueryblocklist wpad 
   ```

   > This step reviews the content of the global query block list and then removes the name **ISATAP** from the list.

2. In the **DNS** console tree, right-click **LON-DC1** to open the context menu, point to **All Tasks**, and then select **Restart**.

3. In the **DNS** console tree, expand **LON-DC1**, and then expand **Forward Lookup Zones**.

4. Select and then right-click **Contoso.com** to open the context menu, and then select **New Host (A or AAAA)**. 

5. In the **New Host** dialog box, in the **Name** box, enter **isatap**. In the **IP address** box, enter **172.16.0.1**, and then select **Add Host**, select **OK**, and then select **Done**.

6. Switch to **EU‑RTR**, and then sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

7. From the **Start** menu, select **Windows PowerShell**.

8. In the **Windows PowerShell** window, enter the following command to enable ISATAP, and then select Enter:

   ```
   Set-NetIsatapConfiguration -State Enabled
   ```

9. In the **Windows PowerShell** window, enter the following command, and then select Enter to configure the IP address of London_Network as the ISATAP router:

   ```
   Set-NetIsatapConfiguration -Router 172.16.0.1
   ```

10. Enter the following command, and then select Enter:

   ```
   Get-NetIPAddress | Format-Table InterfaceAlias,InterfaceIndex,IPAddress
   ```

11. Record the **InterfaceIndex** of the ISATAP interface that's assigned to the **London_Network**. (IPv6 address contains 172.16.0.1)

12. Enter the following command, and then select Enter:

    ```
    Get-NetIPInterface -InterfaceIndex *IndexYouRecorded* -PolicyStore ActiveStore | Format-List
    ```

13. Verify that forwarding is enabled for the interface and that advertising is disabled.

14. The ISATAP interface for an ISATAP router must have forwarding enabled and advertising enabled. Enter the following command, and then select Enter:

    ```
    Set-NetIPInterface -InterfaceIndex *IndexYouRecorded* -Advertising Enabled
    ```

15. Create a new IPv6 network that'll be used for the ISATAP network. enter the following command, and then select Enter:

    ```
    New-NetRoute -InterfaceIndex *IndexYouRecorded* -DestinationPrefix fd00::/64 -Publish Yes
    ```

16. View the IP address configuration for the ISATAP interface. enter the following command, and then select Enter:

    ```
    Get-NetIPAddress -InterfaceIndex *IndexYouRecorded*
    ```

17. Verify that an IPv6 address is listed on the `fd00::/64` network, and then close the **Windows PowerShell** window.


### Task 2: Verify the ISATAP configuration on the client

1. Restart **TOR-SVR1** and **LON-SVR1**, and then sign in as **Contoso\\Administrator** by using the password **Pa55w.rd**.

2. On **TOR-SVR1**, from the **Start** menu, select **Windows PowerShell**.

3. In the **Windows PowerShell** window, enter the following command  to enable ISATAP, and then select Enter:

   ```
   Set-NetIsatapConfiguration -State Enabled
   ```

4. In the **Windows PowerShell** command prompt, enter the following command, and then select Enter to verify that the ISATAP tunnel adapter has received an IPv6 address starting with `fd00`:

   ```
   Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
   ```

   > **Note:** The **InterfaceAlias** of the ISATAP tunnel adapter will start with *isatap*.

5. Switch to **LON-SVR1**.

6. On **LON-SVR1**, from the **Start** menu, select **Windows PowerShell**.

7. In the **Windows PowerShell** window, enter the following command  to enable ISATAP, and then select Enter:

   ```
   Set-NetIsatapConfiguration -State Enabled
   ```

8. In the **Windows PowerShell** command prompt, enter the following command, and then select Enter to verify that the ISATAP tunnel adapter has received an IPv6 address starting with `fd00`:

   ```
   Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
   ```

9. Make note of the IPv6 address associated with the ISATAP adapter, which will be used later in the lab.

10. On **LON-DC1**, switch to the **DNS** management console.

11. In the **DNS** management console tree, expand **LON-DC1**, and then expand **Forward Lookup Zones**.

12. Select **Contoso.com**, and then select **Refresh** button to verify that there are new AAAA records registered.


### Task 3: Verify network connectivity to other subnets

1. On **TOR‑SVR1**, open the **Windows PowerShell** command prompt, and then verify the connection with the **LON‑SVR1** tunnel ISATAP adapter’s IPv6 address by entering the following cmdlet and selecting Enter:

   ```
   Test-NetConnection *IPv6AddressYouRecorded*
   ```

2. Notice that the message **`Ping Succeeded: True`** is received from **LON‑SVR1** ISATAP tunnel adapter.

3. Switch to **LON-SVR1**.

4. On **LON‑SVR1**, from the **Windows PowerShell** command prompt, enter the following command to ping only IPv6, and then select Enter:

   ```
   ping TOR-SVR1 -6
   ```

   > You should receive four replies from the IPv6 address of TOR-SVR1.

**Results:** After completing this exercise, you'll have configured an ISATAP router to allow communication between an IPv6-only network and an IPv4-only network.

## Exercise 4: Configure 6to4 connectivity

### Scenario

The final option for IPv6 integration with IPv4 is configuring 6to4 connectivity so that clients from the IPv4-only internet can connect to computers on the internal Contoso network.

The main tasks for this exercise are:

1. Configure 6to4 connectivity.

2. Verify 6to4 configuration.

3. Verify network connectivity to other subnets.

### Task 1: Configure 6to4 connectivity

1. On **EU‑RTR**, on the taskbar, select the **Windows PowerShell** icon.

2. In the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Set-Net6to4Configuration –State Enabled
   ```

3. In the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Set-NetIPInterface –InterfaceAlias “6to4 Adapter” –Forwarding Enabled
   ```

4. In the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Set-NetIPInterface –InterfaceAlias “London_Network” –Forwarding Enabled
   ```

5. Switch to **INET1**, sign in as **Administrator** with the password of **Pa55w.rd**, and then start **Server Manager.**

6. In **Server Manager**, select **Tools**, and then select **DNS**.

7. Right-click **Forward Lookup Zones**, select **New Zone**, and then select **Next**.

8. On the **Zone Type** page, select **Next**.

9. On the **Zone Name** page, in the **Zone** **name** box, enter **ipv6.microsoft.com**, and then select **Next**.

10. On the **Zone File** page, select **Next**.

11. On the **Dynamic Update** page, select **Do not allow dynamic updates**, select **Next**, and then select **Finish**.

12. In the **DNS** console, in the console tree, select and then right-click the **ipv6.microsoft.com** zone to open the context menu, and then select **New Host (A or AAAA)**.

13. In the **New Host** dialog box, in the **Name** box, enter **6to4**. In the **IP address** box, enter **131.107.0.10**, select **Add Host**, select **OK**, and then select **Done**.


### Task 2: Verify 6to4 configuration

1. On **EU-RTR**, in the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Get-NetIPAddress | Format-Table IPAddress,Interfacealias
   ```

   > Notice the **`2002:836b:a::836b:a`** IPv6 address assigned to the **6TO4 Adapter**.
   >
   > This is a 6to4 address that **EU-RTR** automatically assigns based on the public IPv4 address **131.107.0.10**, which is assigned to the **Internet** interface.
   >
   > **Note:** Note the IPv6 address of the **6to4** adapter where **`836b:a`** in the hexadecimal system corresponds to **131.107.0.10**. That is:
   >
   > **83** hexadecimal = **131** decimal
   > **6b** hexadecimal = **107** decimal
   > **0** hexadecimal = **0** decimal (preceding zero is skipped)
   > **a** hexadecimal = **10** decimal

2. Switch to **LON-CL1**.

3. To move the client from the intranet to the public network, select **Start**, enter **Network connections**, and then select **View network connections**.

4. Right-click **London_Network**, and then select **Disable**.

7. Right-click **Internet**, and then select **Enable**.

8. Close the **Network Connections** window. If the **Networks** pane displays, select **Yes**.

9. On **LON-CL1**, in the **Windows PowerShell** window, enter the following to enable 6to4 connectivity, and then select Enter:

   ```
   Set-Net6to4Configuration –State Enabled
   ```

10. In the **Windows PowerShell** window, enter the following to review the current IP addresses: 

    ```
    Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
    
    ipconfig
    ```

    > Notice the address starting with **`2002:836b:`** assigned to the **6TO4 Adapter**. This is a 6to4 address corresponding to its public IPv4 address. Also notice that the default gateway for the **6TO4 Adapter** is set to **`2002:836b:a::836b:a`**, a 6to4 address assigned to **EU-RTR**.
    >
    > **Note:** If **LON-CL1** doesn't display the address starting with **`2002:836b:`**, restart the VM, and then retry step 8.

9. On **EU-RTR**, in the **Windows PowerShell** window, enter the following to view the IP addresses, and then select Enter: 

   ```
   Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
   ```

   > Notice and document the address starting with **`fd00`** assigned to the **London_Network** isatap interface, because you'll use it in the next task.

10. On **LON-SVR1**, in the **Windows PowerShell** window, enter the following, and then press Enter to review the IP addresses: 

    ```
    Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias 
    ```

    > Notice and document the address starting with **`fd00`** assigned to the **London_Network** isatap interface, because you'll use it in the next task.


### Task 3: Verify network connectivity to other subnets

1. Switch to **LON-CL1**.

2. In the **Windows PowerShell** window, enter the following command, and then press Enter to test communication.

   ```
   Test-NetConnection *EU-RTR IPv6 address*
   ```

   > **Note:** Use the IPv6 address for **EU-RTR** on the London_Network isatap adapter you documented in the previous task.
   >
   > A message **`Ping Succeeded: True`** should display in the reply.

3. In the **Windows PowerShell** window, enter the following command, and then select Enter to test communication.

   ```
   Test-NetConnection *LON-SVR1 IPv6 address*
   ```

   > **Note:** Use the IPv6 address for **LON-SVR1** on the **London_Network** isatap adapter you documented in the previous task.
   >
   > A message **`Ping Succeeded: True`** should display in the reply.


**Results:** After completing this exercise, you should have configured 6to4 transition technology and verified the connectivity when using the 6to4 transition technology.
