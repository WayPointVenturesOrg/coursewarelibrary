# Lab B: Configure and evaluate IPv6 transition technologies

## Lab scenario

Contoso Corporation has recently purchased several key applications that support IPv6. As a result, you're considering integrating IPv6 on your internal network. To test various IPv6 and IPv4 integration strategies, you've configured a test network environment between the three main company locations. You need to configure and test IPv6 connectivity by using various integration technologies.

The following image illustrates the layout of the completed test environment.

![Illustration that depicts the computers that are configured in this lab. LON-DC1 and LON-SVR1 are located on the lower-left side of the illustration, and represent IPv6-capable hosts located in the same subnet as the IPv6-capable network. TOR-SVR1 is located at the upper-right corner of the illustration, and represents an IPv6 host located on a different subnet, which is also IPv6-capable. The internet is represented as a cloud in the upper-left corner of the illustration. The internet connection is IPv4-only. EU-RTR is in the middle, which represents a router that connects the two subnets and the internet connection.](./Media/Mod03_Infrastructure.gif)

## Exercise 1: Configure 6to4 connectivity

### Scenario

The final option for IPv6 integration with IPv4 is configuring 6to4 connectivity so that clients from the IPv4-only internet can connect to computers on the internal Contoso network.

The main tasks for this exercise are:

1. Configure native IPv6 connectivity.

2. Configure 6to4 connectivity.

3. Verify 6to4 configuration.

4. Verify network connectivity to other subnets.

### Task 1: Configure native IPv6 connectivity

>Note: In the following steps, you will configure EU-RTR as an advertising and forwarding IPv6 router that advertises native IPv6 prefixes to the London and Toronto subnets. 

1.  Switch to **EU-RTR**, and sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**. 

2.  Select **Start**, and then select **Windows PowerShell ISE**.

3.  In the **Windows PowerShell ISE** window, type the following cmdlet, and then press Enter: 

```
Set-NetIPInterface –AddressFamily ipv6 –InterfaceAlias "London_Network" –Advertising Enabled –AdvertiseDefaultRoute Enabled
```

4.  In the **Windows PowerShell ISE** window, type the following cmdlet, and then press Enter: 

```
Set-NetIPInterface –AddressFamily ipv6 –InterfaceAlias "NA_WAN" –Advertising Enabled –AdvertiseDefaultRoute Enabled
```

5.  In the **Windows PowerShell ISE** window, type the following cmdlet, and then press Enter: 

```
New-NetRoute -InterfaceAlias "London_Network" -DestinationPrefix fd00::/64 -Publish Yes
```

6.  In the **Windows PowerShell ISE** window, type the following cmdlet, and then press Enter: 

```
New-NetRoute -InterfaceAlias "NA_WAN" -DestinationPrefix fd00::/64 -Publish Yes
```

7.  In the **Windows PowerShell ISE** window, type the following cmdlet, and then press Enter: 

```
Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
```

8.  In the text box below, document the link-local IPv6 address of “London_Network" adapter. This IPv6 address will be used in the next step. 

>Note: The prefix for link-local addresses is always FE80. When typing the IPv6 address, do not type the percent sign (%) and do not type the numbers after the %. 

Link-local address for London_Network: 

9.  In the **Windows PowerShell ISE** window, type the following command, and then press Enter. When typing the command, ensure that the -NextHop value is the IPv6 address you documented in the previous step:
```
New-NetRoute -InterfaceAlias "London_Network" –DestinationPrefix ::/0 -NextHop (Link-local address for London_Network) –Publish yes
```
### Task 2: Configure 6to4 connectivity

1.  On **EU‑RTR**, in the **Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```
Set-Net6to4Configuration –State Enabled
   ```

2.  In the **Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```
Set-NetIPInterface –InterfaceAlias "6to4 Adapter" –Forwarding Enabled
   ```

3.  In the **Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```
Set-NetIPInterface –InterfaceAlias "London_Network" –Forwarding Enabled
   ```

4.  Switch to **INET1**, sign in as **Administrator** with the password of **`Pa55w.rd`**, and then start **Server Manager.**

5.  In **Server Manager**, select **Tools**, and then select **DNS**.

6.  Right-click **Forward Lookup Zones**, select **New Zone**, and then select **Next**.

7.  On the **Zone Type** page, select **Next**.

8.  On the **Zone Name** page, in the **Zone name** box, enter **`ipv6.microsoft.com`**, and then select **Next**.

9.  On the **Zone File** page, select **Next**.

10.  On the **Dynamic Update** page, select **Do not allow dynamic updates**, select **Next**, and then select **Finish**.

11.  In the **DNS** console, in the console tree, select and then right-click the **ipv6.microsoft.com** zone to open the context menu, and then select **New Host (A or AAAA)**.

12.  In the **New Host** dialog box, in the **Name** box, enter **`6to4`**. In the **IP address** box, enter **`131.107.0.10`**, select **Add Host**, select **OK**, and then select **Done**.

### Task 3: Verify 6to4 configuration

1.  On **EU-RTR**, in the **Windows PowerShell ISE** window, enter the following command, and then select Enter:

   ```
   Get-NetIPAddress | Format-Table IPAddress,Interfacealias
   ```

>Note: Notice the **`2002:836b:a::836b:a`** IPv6 address assigned to the **6TO4 Adapter**.
   >
   > This is a 6to4 address that **EU-RTR** automatically assigns based on the public IPv4 address **131.107.0.10**, which is assigned to the **Internet** interface.
   >
   > **Note:** Note the IPv6 address of the **6to4** adapter where **836b:a** in the hexadecimal system corresponds to **131.107.0.10**. That is:
   >
   > **83** hexadecimal = **131** decimal
   > **6b** hexadecimal = **107** decimal
   > **0** hexadecimal = **0** decimal (preceding zero is skipped)
   > **a** hexadecimal = **10** decimal

2.  Switch to **LON-CL1** and sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

3.  To move **LON-CL1** from the London_Network to the simulated Internet network, select **Start**, enter **Network connections**, and then select **View network connections**.

4.  Right-click **London_Network**, and then select **Disable**.

5.  Right-click **Internet**, and then select **Enable**.

6.  Close the **Network Connections** window. If the **Networks** pane displays, select **Yes**.

7.  On **LON-CL1**, open  **Windows PowerShell ISE**, and then enter the following command to enable 6to4 connectivity, and then select Enter:

   ```
Set-Net6to4Configuration –State Enabled
   ```

8.  In the **Windows PowerShell ISE** window, enter the following to review the current IP addresses: 

   ```
   Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
   ```
   ```
   ipconfig
   ```

>Note: Notice the address starting with **2002:836b:** assigned to the **6TO4 Adapter**. This is a 6to4 address corresponding to its public IPv4 address. Also notice that the default gateway for the **6TO4 Adapter** is set to **`2002:836b:a::836b:a`**, a 6to4 address assigned to **EU-RTR**.
   >
   > **Note:** If **LON-CL1** doesn't display the address starting with **2002:836b:**, restart the VM, and then retry step 8.

9.  On **EU-RTR**, in the **Windows PowerShell ISE** window, enter the following to view the IP addresses, and then select Enter: 

   ```
   Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
   ```

>Note: Notice and document the address starting with **fd00** assigned **EU-RTR** on the **London_Network** interface, because you'll use it in the next task. 

10.  Switch to **LON-SVR1**, and sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**

11.  Open the **Windows PowerShell ISE** window, and then enter the following, and then press Enter to review the IP addresses: 

```
Get-NetIPAddress | Format-Table IPAddress,InterfaceAlias
```

>Note: Notice and document the address starting with **fd00** assigned to **LON-SVR1** on the **London_Network** interface, because you'll use it in the next task.

### Task 4: Verify network connectivity to other subnets

1.  Switch to **LON-CL1**.

2.  In the **Windows PowerShell ISE** window, enter the following command, and then press Enter to test communication.

```
Test-NetConnection (address starting with **fd00** assigned **EU-RTR**)
```

>Note: A message **Ping Succeeded: True** should display in the reply.

3.  In the **Windows PowerShell ISE** window, enter the following command, and then select Enter to test communication.

```
Test-NetConnection (address starting with **fd00** assigned to **LON-SVR1**)
```

>Note: A message **Ping Succeeded: True** should display in the reply.

**Results:** After completing this exercise, you should have configured 6to4 transition technology and verified the connectivity when using the 6to4 transition technology.
