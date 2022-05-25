# Lab: Plan an IPv4 addressing scheme

## Lab scenario

Contoso Corporation is an international organization with its North American regional office located in Toronto, with plans to open three branch offices in Houston, Texas; Mexico City, Mexico; and Portland, Oregon.

The following table describes the planned computer distribution in the branch offices:

| **Location** | **Computer and device requirements**                         |
| ------------ | ------------------------------------------------------------ |
| Houston      | 300 desktop computers and 100 laptop computers connecting to both the wireless and wired networks; 50 tablet computers connecting only to the wireless network. |
| Mexico City  | 100 desktop computers and 50 laptop computers connecting to both the wireless and wired networks; 20 tablet computers connecting only to the wireless network. |
| Portland     | 100 desktop computers and 75 laptop computers connecting to both the wireless and wired networks; 150 tablet computers connecting only to the wireless network. |

Contoso has a Microsoft 365 tenant for all email and file access for the North American branch offices, with some shared folders in the Toronto regional office located on servers that are running the Windows Server operating system (OS). All offices have fast and highly available network connections to the Toronto office, so Contoso isn't currently planning to deploy any servers in the branch offices.

The Contoso network team has assigned the subnets 172.16.18.0/18 to the Toronto regional office, which is currently using the network assignments that the following table lists: 

| **IP   subnet**                  | **Purpose**                          |
| -------------------------------- | ------------------------------------ |
| 172.16.18.0/24                   | Network devices and network printers |
| 172.16.19.0/24                   | Servers                              |
| 172.16.20.0/24 to 172.16.52.0/24 | Desktop computers                    |
| 172.16.53.0/24 to 172.16.60.0/24 | Wireless devices                     |

You need to plan an IPv4 address assignment for each of the branch offices, using IP addresses from the list of addresses assigned to the Toronto office. You also need to ensure that the IP addresses assigned to computers connected to wired connections differ from the IP addresses assigned to devices connected to the wireless networks.

## Exercise 1: Plan IPv4 address assignments

### Scenario

You need to plan the IP address assignment for each North American branch office, and your IP addressing scheme must meet the following requirements:

- Wired and wireless clients must be assigned IP addresses from different IP address ranges.

- Each branch office location should have dedicated IP address ranges.

- Subnets in branch-office locations must be as simple as possible.

- Branch-office subnets must have IP addresses for all potential wired and wireless clients that might request an IP address.


The main task for this exercise is:

1. Plan the IPv4 implementation.


### Task 1: Plan the IPv4 implementation

1. How will you determine the number of IP addresses that each location requires? 

   > **Answer**: This exercise's key factors are the number of systems per location and the requirements.

2. How do laptops with both wired and wireless network adapters affect the number of IP addresses required?

   > **Answer**: There is a requirement for all potential wired and wireless clients to have addresses. Having clients that could potentially be either wired or wireless will increase the number of required addresses.

3. What is the simplest subnet class to use when planning an IP addressing scheme for each North America branch location?

   > **Answer**: The starting point for each location would be to use /24 subnets.

4. In the Houston office, what is the number of potential wired and wireless clients?

   > **Answer**: There are 400 potential wired clients (300 desktops and 100 laptops) and 150 potential wireless clients (100 laptops and 50 tablets).

5. In the Houston office, how many /24 subnets are required for wired connections? How many are required for wireless?

   > **Answer**: Two /24 subnets is the minimum required for wired connections (each /24 supports a maximum of 253 clients + 1 gateway). One /24 subnet would suffice for the potential wireless clients.

6. In the Mexico City office, what's the number of potential wired and wireless clients?

   > **Answer**: There are 150 potential wired connections (100 desktops and 50 laptops) and 70 potential wireless connections (70 laptops and 20 tablets).

7. In the Mexico City office, how many /24 subnets are required for wired connections? How many for wireless?

   > **Answer**: One /24 subnet would be required for the wired connections, and one /24 subnet for the potential wireless connections.

8. In the Portland office, what's the number of potential wired and wireless clients?

   > **Answer**: There are 175 potential wired connections (100 desktops and 75 laptops) and 225 potential wireless connections (75 laptops and 150 tablets).

9. In the Portland office, how many /24 subnets are required for wired connections? How many for wireless?

   > **Answer**: One /24 subnet would be required for the potential wired connections, and one /24 subnet would be required for the potential wireless connections.

10. Given the assigned IP range of 172.16.20.0/24 to 172.16.52.0/24 for wired clients, which subnets will you use for the Houston, Mexico City, and Portland offices?

    > **Answer**: Answers will vary. One possible option is:
    >
    > Houston:    172.16.30.0/24; 172.16.31.0/24
    >
    > Mexico City: 172.16.35.0/24
    >
    > Portland:   172.16.40.0/24
    >

11. Given the assigned IP range of 172.16.53.0/24 to 172.16.60.0/24 for wireless clients, which subnets will you use for the Houston, Mexico City, and Portland offices?

    > **Answer**: Answers will vary. One possible option is:
    >
    > Houston:    172.16.55.0/24
    >
    > Mexico City: 172.16.56.0/24
    >
    > Portland:   172.16.57.0/24
    >

**Results:** After completing this exercise, you should have planned an IPv4 network.

## Exercise 2: Verify IPv4 communication

### Scenario

You have completed the IPv4 configuration between the London headquarters and the new Toronto office. You have also deployed a server in the North American region that European clients will need to access. Users need to be able to copy files from their client systems in London to the Toronto server. You need to use IPv4 tools to verify connectivity between the London domain controller and the Toronto server. After you verify the configuration, you need to be prepared to troubleshoot and fix any connectivity issues that could arise.

The main tasks for this exercise are:

1. Verify IPv4 traffic.

2. Prepare LON-CL1 for troubleshooting.

3. Prepare LON-CL2 for troubleshooting.

### Task 1: Verify IPv4 traffic

1. Sign in to LON-DC1 as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. On **LON-DC1**, select **Start**, and then select **Windows PowerShell**.

3. At the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection 172.16.0.1
   ```

4. Review the results. The response is from EU-RTR, which is the default gateway for the London_Network.

5. On **LON-DC1**, in the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Test-NetConnection -TraceRoute TOR-SVR1.contoso.com
   ```

6. Review the results. The response is from TOR-SVR1, which is the Toronto-based server.


### Task 2: Prepare LON-CL1 for troubleshooting

1. Sign in to LON-CL1 as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. On **LON‑CL1**, open a **File Explorer** window, and then browse to **\\\\LON-DC1\\Labfiles\\Mod01**.

3. Copy **LON-CL1.ps1** from **\\\\LON-DC1\\Labfiles\\Mod01** to the **LON-CL1** desktop.

   > **Note:** Do not open the file. This script creates the problem that you'll troubleshoot and repair in the next exercise. Opening the file can cause issues with the lab tasks.

4. Close **File Explorer**.

5. On the desktop, right-click or access the context menu for the **LON-CL1.ps1** file, and then select **Run with PowerShell**.

6. If prompted to confirm, enter **y**, and then select Enter.


### Task 3: Prepare LON-CL2 for troubleshooting

1. Sign in to LON-CL2 as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. On **LON‑CL2**, open a **File Explorer** window, and then browse to **\\\\LON‑DC1\\Labfiles\\Mod01**.

3. Copy **LON-CL2.ps1** from **\\\\LON-DC1\\Labfiles\\Mod01** to the **LON-CL2** desktop.

   > **Note:** Do not open the file. This script creates the problem that you'll troubleshoot and repair in the next exercise. Opening the file can cause issues with the lab tasks.

4. Close **File Explorer**.

5. On the desktop, right-click or access the context menu for the **LON-CL2.ps1** file, and then select **Run with PowerShell**.

6. If prompted to confirm, enter **y**, and then select Enter.


**Results**: After completing this exercise, you'll have verified that the London computers can communicate with the Toronto server.

## Exercise 3: Troubleshoot IPv4

### Scenario

Two users in London report that no one can copy files to the Toronto server. After investigation, you discover that Arnold on LON-CL1 is unable to connect to anything. Amy on LON-CL2 can connect to the London server but can't connect to the Toronto server.

You need to use the IPv4 tools to troubleshoot and resolve the issues.

The main tasks for this exercise are:

1. Troubleshoot IPv4 connectivity between LON-CL1 and the Toronto server.

2. Troubleshoot IPv4 connectivity between LON-CL2 and the Toronto server.


### Task 1: Troubleshoot IPv4 connectivity between LON-CL1 and the Toronto server

Use your knowledge of IPv4 to troubleshoot and repair the connectivity problem between the London and Toronto networks. Consider using any of the Windows PowerShell tools discussed in this module. To solve the issue: 

1. On **LON‑CL1**, select **Start**, enter **PowerShell**, and then select **Windows PowerShell**. 

2. At the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection LON-DC1
   ```

3. Verify that the results contain **PingSucceded:False** from **LON-DC1**.

4. To verify the **LON-CL1** IP address, at the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Get-NetIPAddress
   ```

   > Notice that the IPv4 address for London_Network is 169.254.x.x. This indicates that the client is configured for Dynamic Host Configuration Protocol (DHCP) and hasn't received an address.
   >

5. To configure the **LON-CL1** IP address, at the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   New-NetIPAddress -InterfaceAlias "London_Network" -IPAddress 172.16.0.50 -PrefixLength 24
   ```

6. To verify that communications have been fixed, at the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection TOR-SVR1
   ```

7. Confirm that you receive a reply from **172.16.18.20** that contains **PingSucceded:True**.


### Task 2: Troubleshoot IPv4 connectivity between LON-CL2 and the Toronto server

Use your knowledge of IPv4 to troubleshoot and repair the connectivity problem between the London and Toronto networks. Consider using any of the Windows PowerShell tools discussed in this module. To solve this issue: 

1. On **LON‑CL2**, open a **Windows PowerShell** window.

2. At the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection LON-DC1
   ```

   > Confirm that the **LON-DC1** server is reachable by verifying that you receive a reply from **172.16.0.10** that contains **PingSucceded:True**.
   >

3. At the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection TOR-SVR1
   ```

   > Verify that the results contain **PingSucceded:False** from **TOR-SVR1**. Also, note the yellow message: **WARNING: Ping to 172.16.18.20  failed with status: DestinationHostUnreachable**.
   >

4. Complete the following to verify the router's default gateway is accessible.

   At the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection 172.16.0.1
   ```

   > Confirm that the router is reachable by verifying that you receive a reply from **172.16.0.1** that contains **PingSucceded:True**.

5. Complete the following to verify that the traffic is being routed correctly.

   At the Windows PowerShell prompt, enter the following command, and then select Enter:

   ```
   Test-NetConnection -TraceRoute 172.16.18.20
   ```

   > Notice that none of the TraceRoute packets left the 172.16.0.51 interface.

6. Complete the following to verify the IP Configuration.

   At the Windows PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Get-NetIpConfiguration
   ```

   > Notice that the IPv4DefaultGateway is set incorrectly to 172.16.0.2.

7. Fix the IPv4DefaultGateway by running the following commands, selecting Enter at the end of each line:

   ```
   Remove-NetIPAddress -InterfaceAlias "London_Network" -IPAddress 172.16.0.51 -PrefixLength 24 -DefaultGateway 172.16.0.2 -Confirm:$false
   
   New-NetIPAddress -InterfaceAlias "London_Network" -IPAddress 172.16.0.51 -PrefixLength 24 -DefaultGateway 172.16.0.1 -Confirm:$false
   ```

8. Complete the following to verify the communications have been fixed.

   At the Windows PowerShell prompt, enter the following command, and then select Enter: 

   ```
   Test-NetConnection TOR-SVR1
   ```

9. Confirm that the **TOR-SVR1** server is reachable by verifying that you receive a reply from **172.16.18.20** that contains **PingSucceded:True**.


**Results**: After completing this lab, you should have resolved all IPv4 connectivity issues.
