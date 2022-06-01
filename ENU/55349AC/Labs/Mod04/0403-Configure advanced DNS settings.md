# Lab C: Configure advanced DNS settings

## Lab scenario

You want to make Domain Name System (DNS) zone management easier. You want to configure DNS policies in Windows Server, so that users in different geographical areas can connect to a different web server. You must then test and troubleshoot the DNS configuration that you've created.

### Prerequisites

You must complete the following lab(s) before beginning this lab:

- 0401-Planning and implementing DNS name resolution
- 0402-Integrating DNS with AD DS

## Exercise 1: Configuring DNS policies

### Scenario

If you configure DNS policies correctly, when clients in the Toronto location query for the IP address of `www.contoso.com`, they should receive different name-resolution answers than clients in the London location who're mapping to `www.contoso.com`.

The main tasks for this exercise are:

1. Verify DNS name resolution before configuring DNS policies.
2. Configure DNS policies.
3. Validate DNS name resolution after configuring DNS policies.

### Task 1: Verify DNS name resolution before configuring DNS policies

1. Switch to **LON-DC1**, and if necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Open **Server Manager**, select **Tools**, and then select **DNS**.

3. In the **DNS Manager** console, expand **LON-DC1**, expand **Forward Lookup Zones**, and then select **Contoso.com**.

4. Right-click **Contoso.com** to open the context menu, and then select **New Alias (CNAME)**.

5. In the **New Resource Record** window, in the **Alias Name** text box, enter **www**, and in the **Fully qualified domain name (FQDN) for target host** text box, enter **LON-DC1.Contoso.com**, and then select **OK**. 

6. Switch to **TOR-SVR1** and if necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

7. On **TOR-SVR1**, right-click **Start**, and then select **Windows PowerShell**.

8. In the **Windows PowerShell** console, enter the following two commands, and select Enter after each command:

   ```
   ipconfig /flushdns
   
   nslookup www.contoso.com
   ```

9. Verify that the last command returns the IP address **172.16.0.10**.

10. Switch to **LON-CL1** and, if necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

11. Right-click the **Start** icon to open the context menu, and then select **Windows Terminal (Admin)**.

12. In the **Administrator: Windows PowerShell** console, enter the following two commands, and select Enter after each command:

    ```
    ipconfig /flushdns
    
    nslookup www.contoso.com
    ```

13. Verify that the last command returns the IP address **172.16.0.10**.


### Task 2: Configure DNS policies

1. Switch to **LON-DC1**, right-click **Start** to open the context, and then select **Windows PowerShell**.

2. On **LON-DC1**, in the **Windows PowerShell** window, enter the following command, and then select Enter: 

   ```
   Import-Module DnsServer
   ```

   > **Note:** There's a text file on **LON-DC1** in **E:\Labfiles\Mod04** named **ConfigurePolicies.txt** that has all of the following cmdlets that you can copy and paste into Windows PowerShell.

3. At the Windows PowerShell command prompt, enter the following cmdlets, and select Enter after each cmdlet:

   ```
   Add-DnsServerClientSubnet -Name "UKSubnet" -IPv4Subnet "172.16.0.0/24"
   
   Add-DnsServerClientSubnet -Name "CanadaSubnet" -IPv4Subnet "172.16.18.0/24"
   
   Add-DnsServerZoneScope -ZoneName "Contoso.com" -Name "UKZoneScope"
   
   Add-DnsServerZoneScope -ZoneName "Contoso.com" -Name "CanadaZoneScope"
   
   Add-DnsServerResourceRecord -ZoneName "Contoso.com" -A -Name "www" -IPv4Address "172.16.0.41" -ZoneScope "UKZoneScope"
   
   Add-DnsServerResourceRecord -ZoneName "Contoso.com" -A -Name "www" -IPv4Address "172.16.18.17" -ZoneScope "CanadaZoneScope"
   
   Add-DnsServerQueryResolutionPolicy -Name "UKPolicy" -Action ALLOW -ClientSubnet "eq,UKSubnet" -ZoneScope "UKZoneScope,1" -ZoneName "Contoso.com"
   
   Add-DnsServerQueryResolutionPolicy -Name "CanadaPolicy" -Action ALLOW -ClientSubnet "eq,CanadaSubnet" -ZoneScope "CanadaZoneScope,1" -ZoneName Contoso.com
   ```

### Task 3: Validate DNS name resolution after configuring DNS policies

1. Switch to **LON-CL1**.

2. In the **Administrator: Command Prompt** window, enter the following two commands, and select Enter after each command:

   ```
   ipconfig /flushdns
   
   nslookup www.contoso.com
   ```

   > You should get the result **172.16.0.41** because LON-CL1 is in the UKZoneScope.
   >

3. Switch to **TOR-SVR1**.

4. In the **Windows PowerShell** window, enter the cmdlets, and select Enter after each one: 

   ```
   Ipconfig /flushdns
   
   Nslookup www.contoso.com
   ```

   > You should get a result of **172.16.18.17** because TOR-SVR1 is in the CanadaZoneScope.

**Results:** After completing this exercise, you'll have configured DNS policies, and then tested that the policies work successfully.

## Exercise 2: Validating the DNS implementation

### Scenario

**LON-CL1** is a laptop device. The user associated with it is traveling to the Sydney office and will use it there for a few months. You must change its network-adapter properties to enable this, and then test to ensure that it works with **SYD-SVR1** as its primary domain controller and DNS server. You'll use **Nslookup** and the Windows PowerShell cmdlets to validate the DNS configuration.

The main tasks for this exercise are:

1. Connect the client to the appropriate virtual local area network (LAN).
2. Use DNS tools to confirm proper client configuration.
3. Test DNS name resolution to external and internal hosts.

### Task 1: Connect the client to the appropriate virtual LAN

1. Switch to the **LON-CL1** virtual machine (VM).

2. If necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. On **LON-CL1**, right-click **Start** to open the context menu, and then select **Windows Terminal**.

4. In the **Windows PowerShell** console, enter the following cmdlet, and then select Enter:

   ```
   Get-DnsClientServerAddress
   ```

   > Note that the DNS server address is **172.16.0.10** from the London_Network. This is **LON-DC1**.

5. On **LON-CL1**, select **Start**, enter **network conn**, and then select **View network Connections**. 

   > The **Network Connections** window opens.

6. In the **Network Connections** window, right-click the **London_Network** connection to open the context menu, and then select **Disable**.

7. In the **Network Connections** window, right-click the **PAC_WAN** connection to open the context menu, and then select **Enable**. 

   > **Note:** By doing this, you disconnect LON-CL1 from the London network, and then connect it to the PAC_WAN network.

8. In the **Network Connections** window, right-click the **PAC_WAN** connection to open the context menu, and then select **Properties**.

9. Select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**.

10. Select **Use the following IP address** and then configure the following:

    - IP address: **172.16.19.50**
    - Subnet mask: **255.255.255.0**
    - Default gateway: **172.16.19.1**

11. In the **Preferred DNS server** box, enter **172.16.19.20**, and then select **OK**.

12. In the **PAC_WAN Properties** dialog box, select **Close**.

### Task 2: Use DNS tools to confirm proper client configuration

1. On **LON-CL1**, in Windows PowerShell, enter the following cmdlets, and select Enter after each line:

   ```
   Clear-DnsClientCache
   
   Get-DnsClientServerAddress
   ```

   > Note that the DNS server address assigned to PAC_WAN is **172.16.19.20**. This is **SYD-SVR1**.
   >

2. On **SYD-SVR1**, in **Server Manager**, select **Tools**, and then select **DNS**.

3. In **DNS Manager**, expand **SYD-SVR1**, expand **Forward Lookup Zones**, and then select **Contoso.com**.

4. In the details pane, examine the **LON-CL1** host record. The IP address should be **172.16.19.50**.

5. If the address still appears as **172.16.0.50**, perform the following:

   - Switch to **LON-CL1**.

   - On **LON-CL1**, in the **Windows PowerShell** console, enter the following cmdlet, and then select Enter:

     `Register-DnsClient` 

   - Switch to **SYD-SVR1**. In the console tree, right-click **Contoso.com** to open the context menu, and then select **Refresh**.


   > The host record for **LON-CL1** should have an IP address of **172.16.19.50**.
   >

6. In the console tree, right-click **SYD-SVR1** to open the context menu, and then select **Clear Cache**.


### Task 3: Test DNS name resolution to external and internal hosts

1. On **LON-CL1**, in the **Windows PowerShell** console, enter the following cmdlets, and select Enter after each line:

   ```
   Clear-DnsClientCache
   
   Nslookup mail.adatum.com
   ```

   > You should get a nonauthoritative reply of **10.10.0.50**.
   >

2. On **LON-CL1**, in the **Windows PowerShell** console, enter the following cmdlet, and then select Enter:

   ```
   Nslookup treyresearch.net
   ```

   > You should get a reply of **172.16.19.20**.
   >

**Results:** After completing this exercise, you should have validated the DNS infrastructure's implementation.

## Exercise 3: Troubleshooting DNS

### Scenario

A user has reported a networking-related problem to the help desk. You must investigate and attempt a resolution.

| **Incident Record**                                          |
| ------------------------------------------------------------ |
| **Incident Reference Number:** 723101                        |
| **Date and time of Call**: May 22; 09:01 AM                  |
| **User**: Susan Kemp (Research Department)                   |
| **Incident Details**: Susan is unable to access any network  resources. |
| **Additional Information**: Susan is the only one  affected in the department. She can't access the Research data folder on LON-DC1. |
| **Plan of Action**:                                          |
| **Resolution**:                                              |

The main tasks for this exercise are:

1. Review the scenario.
2. Simulate the problem.
3. Resolve the problem.

### Task 1: Review the scenario

1. Review the help desk **Incident Record 723101**.

### Task 2: Simulate the problem

1. Switch to **LON-CL1**.

2. From the Taskbar, select **File Explorer**.

3. In File Explorer, in the address bar, enter **\\\\LON-DC1\\Labfiles\\Mod04**, and then select Enter.

4. In the details pane, right-click **Scenario.vbs** to open the context menu, and then select **Copy**.

5. In the console tree of **File Explorer**, select the **Documents** folder, and then, in the empty space of the details pane, right-click and open the context menu, and then select **Paste**. 
6. Run the **Scenario.vbs** script.
7. Close File Explorer.

### Task 3: Resolve the problem

1. On **LON-CL1**, while still in **Windows PowerShell**, enter the following command, and then select Enter:

   ```
   Get-DnsClientCache
   ```

   > Notice the records that are returned. 
   >

2. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter: 

   ```
   Clear-DnsClientCache
   ```

3. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter. Notice that the address returned is the default gateway:

   ```
   test-connection lon-dc1
   ```

4. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter. Notice that the wrong IP address is returned for **LON-DC1**:

   ```
   Get-DnsClientCache | fl
   ```

5. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter. Notice that the correct record is returned from the DNS server:

   ```
   nslookup LON-DC1
   ```

6. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   notepad C:\windows\system32\drivers\etc\hosts
   ```

7. Scroll to the end of the file, delete **172.16.0.1 lon-dc1.Contoso.com**, and then select Enter. 

   > Note: Be sure to verify that there aren't other entries listed. If there are, delete the additional entries that refer to lon-dc1.

8. Select **File**, select **Save**, and then close **Notepad**.

9. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   Clear-DnsClientCache
   ```

10. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

    ```
    test-connection lon-dc1
    ```

11. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter. You can now view the correct record for **LON-DC1** in the cache:

    ```
    Get-DnsClientCache | fl
    ```

12. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter. Note that the command runs successfully:

    ```
    Resolve-Dnsname LON-DC1 | fl
    ```

13. On the task bar, select **File Explorer**.

14. In the **File Explorer** address bar, enter **\\\\LON-DC1\\Labfiles**, and then select Enter. The folder opens.

15. Close **File Explorer**.

16. Review the **Resolution** with your class:

    > **The client had an incorrect entry in the hosts file. Because this entry is used to populate the DNS resolver cache, the client couldn't resolve the host name LON-DC1.** 
    >
    > **Removed the entry, and the client was able to connect to resources.**

**Results:** After completing this exercise, you should have resolved the name-resolution problems successfully.
