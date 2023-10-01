# Lab: Configure advanced Hyper-V networking features

## Lab scenario

Contoso Corporation has implemented Hyper‑V to manage server and client virtualization initiatives. You have created a couple of test virtual machines (VMs) and familiarized yourself with many of the configuration options. You now muct implement and test network connectivity for the VMs.

## Exercise 1: Create Hyper‑V virtual switches and configure NIC Teaming

### Scenario

The Hyper‑V virtualization platform has been installed so you can test it. Before deploying Hyper‑V in the production environment, you need to understand the different networking options that can be configured. First, you'll review the current networking configuration of the Hyper‑V host. Next, you'll create different types of Hyper‑V virtual switches and explore the connectivity options that exist when using each of them. Finally, you will create a new virtual network adapter and configure Network Interface Card (NIC) teaming within a VM.

The main tasks for this exercise are:

1. Verify the current Hyper‑V network configuration.

2. Create virtual switches.

3. Create virtual network adapters.

4. Use the Hyper‑V virtual switches.

5. Enable NIC Teaming.

### Task 1: Verify the current Hyper‑V network configuration

1.  Sign in to **LON-HV1** as **Administrator** with the password of **`Pa55w.rd`**.

2.  On the task bar, select **Hyper‑V Manager**. The Hyper-V Manager console opens.

3.  In **Hyper‑V Manager**, in the **Actions** pane, select **Virtual Switch Manager**.

4.  In the **Virtual Switch Manager** **for** **LON-HV1** window, select the virtual switch named **Private Network**.

>Note: The Private Network switch is configured to connect to the Private network. 

### Task 2: Create virtual switches

1.  In the **Virtual Switch Manager** **for** **LON-HV1** window, in the console tree, select **New virtual network switch**, and then in the details pane, in the **What type of virtual switch do you want to create?** area, select **External**, and then select **Create Virtual Switch**.

>Note: A new Virtual Switch entry displays, in which you should enter the name and details for the new switch.

2.  In the **Name** box, enter **`External Switch`**.

3.  In the **Connection type** section, verify that **External network** and **Microsoft Hyper-V Network Adapter** are selected. 

4.  Verify that **Allow management operating system to share this network adapter** is selected, and then select **OK**.

5.  In the **Apply Networking Changes** dialog box, select **Yes**.

6.  The **Virtual Switch Manager** window closes. Open it again, and then note the **External Switch** that you just created.

7.  In the **Virtual Switch Manager** **for** **LON-HV1** window, in the console tree, select **New virtual network switch**, and then in the details pane, in the **What type of virtual switch do you want to create?** area, select **Internal**, and then select **Create Virtual Switch**.

8.  In the **Name** box, enter **`Internal Switch`**.

9.  In the **Connection type** section, verify that **Internal network** is selected, and then select **OK**.

10.  Open the **Virtual Switch Manager** again, and note the **Internal Switch** that you just created.

11.  Close the **Virtual Switch Manager** window.

### Task 3: Create a virtual network adapter

1.  In **Hyper‑V Manager**, in the **Virtual Machines** pane, right-click **Server1** to open the context menu, and then select **Settings**.

>Note: Take note of the network adapters currently attached to Server1. There should be three network adapters. One network adapter is connected to the Private Network, and the other two network adapters aren't connected to any network.

2.  Select the first network adapter.

3.  In the details pane, under **Virtual switch**, select **External switch**.

4.  Repeat steps 2 and 3, and change the remaining two Network Adapters to connect to the **External** switch.

5.  Select **OK** to save your changes and close the Settings for the **Server1** window.

>Note: Next, you'll use Windows PowerShell to add a new network adapter to the External switch.

6.  On **LON-HV1**, select **Start**, and then select **Windows PowerShell ISE**.

7.  At the **Windows PowerShell ISE** command prompt, enter the following commands, selecting Enter after each line:

   ```
   Add-VMNetworkAdapter -VMName Server1 -Name "External Network Adapter"
   ```
   ```
   Connect-VMNetworkAdapter -VMName Server1 -Name "External Network Adapter" -SwitchName "External Switch"
   ```
### Task 4: Use the Hyper‑V virtual switches

1.  In **Hyper‑V Manager**, in the **Virtual Machines** pane, right-click **Server1** to open the context menu, and then select **Settings**.

2.  In the **Settings for Server1 on LON-HV1** window, in the console tree, select the **External Network Adapter**. 

   > Note that the virtual switch assigned is **External Switch**.

3.  In the **Settings** window, select **Cancel**.

4.  In the **Hyper‑V Manager** console, connect to and start **Server1**.

5.  Sign in to **Server1** as **Administrator** with the password **Pa55w.rd**.

6.  On **Server1**, select **Start**, and then select **Server Manager**.

7.  In the **Server Manager** console tree, select the **Local Server** node.

8.  Next to **Ethernet 4**, select **IPv4 address assigned by DHCP, IPv6 enabled**.

9.  In the **Network Connections** window, right-click **Ethernet 4** to open the context menu, and then select **Status**.

10.  In the **Ethernet 4 Status** window, select **Details**.

>Note the IP address and other settings assigned to the network adapter. These settings have been assigned from the Dynamic Host Configuration Protocol (DHCP) server installed on LON-DC1. The External Network Adapter communicates with the external network attached to LON-HV1.

11.  On **Server1**, leave Server Manager open, and then close all other open windows.

### Task 5: Enable NIC Teaming

1.  On **Server1**, in **Server Manager**, select the **Local Server** node.

2.  In the **Properties** pane, next to **NIC Teaming**, select the **Disabled** hyperlink.

3.  Maximize the **NIC Teaming** dialog box, and then in the **TEAMS** pane, select **Tasks** and then select **New Team**.

4.  In the **New team** dialog box, in the **Team name** box, enter **`Server1 NIC Team`**, and then select all adapters.

>Note: Ensure that **Ethernet**, **Ethernet2**, **Ethernet3**, and **Ethernet4** are all selected.

5.  Expand **Additional properties**.

6.  Under **Additional properties**, note the following:

   - Teaming Mode: **Switch Independent**
   - Load Balancing: **Address Hash**
   - Standby adapter: **None (all adapters Active)** 

>Note: This is where you an modify the load-balancing mode. However, since this is a guest VM, some settings aren't available.

7.  Next to **Standby adapter**, select **Ethernet4**.

8.  In the **NIC Teaming** dialog box, select **OK**.

>Note: After a minute or two, the **Server1 NIC Team** should show a Status of **OK**. All Adapters, except **Ethernet4**, should show an **Active** state. **Ethernet4** shows that it's in a Standby state.

9.  Close the **NIC Teaming** window.

10.  On **Server1**, in **Server Manager** refresh the **Local Server Properties** page.

>Note: Notice that all Ethernet instances have been replaced by a single Server1 NIC Team instance, which is configured to use DHCP.

11.  Leave Server Manager open for the next exercise.

12.  Close the Server1 on **LON-HV1** window.

**Results**: After completing this exercise, you'll have successfully configured a Hyper‑V virtual switch and network adapters, and enabled NIC Teaming.

## Exercise 2: Configure advanced features of a virtual switch

### Scenario

You need to validate how DHCP guarding can be used in a virtual environment to protect against unauthorized DHCP server. You also need to evaluate the use and configuration of Hyper-V Switch Embedded Teaming (SET) and virtual-switch bandwidth management.

The main tasks for this exercise are:

1. Configure and use DHCP guard.

2. Configure and use Hyper-V SET.

3. Configure and use bandwidth management.


### Task 1: Configure and use DHCP guard

First, you'll configure Server2 and install the DHCP server role.

1.  On LON-HV1, in **Hyper‑V Manager**, in the **Virtual Machines** pane, right-click **Server2** to open the context menu, and then select **Settings**.

2.  Select **Network Adapter**.

3.  In the details pane, under **Virtual switch**, select **External switch**.

4.  Select **OK** to save changes and close the **Settings for the Server2** window.

5.  In the **Hyper‑V Manager** console, connect to and start **Server2**.

6.  Sign in to **Server2** as **Administrator** with the password **Pa55w.rd**.

7.  Select **Start**, and then select **Server Manager**.

8.  In **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

9.  In the **Add Roles and Features Wizard**, select **Next** three times.

10.  On the **Select Server Roles** page, select **DHCP Server**.

11.  In the **Add Roles and Features that are required** dialog box that opens, select **Add Features**, and then select **Next**.

12.  On the **Select Features** page, select **Next**.

13.  On the **DHCP Server** page, select **Next**.

14.  On the **Confirm installation selections** page, select **Install**. 

15.  When the DHCP Server role installation successfully completes, select **Close**.

16.  In **Server Manager**, select **Tools**, and then select **DHCP**.

17.  In the console tree, expand **server2**, select and then right-click **IPv4** to open the context menu, and then select **New Scope**.

18.  In the **New Scope Wizard**, on the **Welcome** page, select **Next**.

19.  On the **Scope Name** page, in the **Name** box, enter **`Unauthorized Scope`**, and then select **Next**.

20.  On the **IP Address Range** page, in the **Start IP address** box, enter **`172.16.0.200`**, and in the **End IP address** box, enter **`172.16.0.210`**. In the **Subnet Mask** box, enter **255.255.0.0**, and then select **Next**.

21.  On the **Add Exclusions and Delay** page, select **Next**.

22.  On the **Lease Duration** page, select **Next**.

23.  On the **Configure DHCP Options** page, ensure that **Yes, I want to configure these options now** is selected, and then select **Next**.

24.  On the **Router (Default Gateway)** page, in the **IP Address** box, enter **`172.16.0.1`**, select **Add**, and then select **Next**.

25.  On the **Domain Name and DNS Servers** page, accept the defaults, and then select **Next**.

26.  On the **WINS servers** page, select **Next**.

27.  On the **Activate Scope** page, ensure that **Yes, I want to activate this scope now** is selected, and then select **Next**.

28.  On the **Completing the New Scope Wizard** page, select **Finish**.

29.  Close the **Server2 on LON-HV1** window.

>Note: You'll now configure DHCP guard to ensure that Server2 doesn't issue DHCP leases to other computers on the network.

30.  On **LON-HV1**, select **Start**, and then select **Windows PowerShell ISE**.

31.  At the **Windows PowerShell ISE** command prompt, enter the following command to prevent **Server2** from issuing a DHCP lease, and then select Enter:

    ```
Set-VMNetworkAdapter -VMName Server2 -DhcpGuard On
    ```

32.  On LON-HV1, in **Hyper‑V Manager**, in the **Virtual Machines** pane, right-click **Server2** to open the context menu, and then select **Settings**.

33.  Select and then expand **Network Adapter**.

34.  Select **Advanced Features**.

>Note: Notice that **Enable DHCP guard** has been enabled.

35.  Select **Cancel** to close the **Settings for the Server2** window.

36.  Close the **Server2 on LON-HV1** window.

37.  Connect to **Server1**.

38.  On **Server1**, right-click **Start** to open the context menu, and then select **Windows PowerShell (Admin)**.

39.  In the **Windows PowerShell** window, enter the following commands, selecting Enter after each line:

    ```
    IPConfig /release
    ```
    ```
    IPConfig/renew
    ```

40.  In the notification area of the taskbar, right-click the **Network** icon to open the context menu, and then select **Open Network and Internet settings**.

41.  In the **Settings** window, select **Change adapter options**.

42.  In the **Network Connections** window, right-click **Server1 NIC Team** to open the context menu, and then select **Status**.

43.  In the **Server1 NIC Team Status** window, select **Details**. 

>Note: Note that it still has an **DHCP Server IP Address** from **LON-DC1**. Even though Server2 is configured as a DHCP server, it doesn't issue a DHCP lease.

44.  Close all open windows on Server1.

45.  Close the **Server1 on LON-HV1** window.

### Task 3: Hyper-V Switch Embedded Teaming (SET)

1.  On **LON-HV1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  At the Windows PowerShell prompt, enter **`Get-NetAdapter`** and then select Enter.

>Note: Notice the list of Ethernet and vEthernet adapters. You'll configure a new SET for Ethernet 2 and Ethernet 3.

3.  At the **Windows PowerShell** command prompt, enter the following command to create a SET named SET1, and then select Enter:

   ```
New-VMSwitch -Name SET1 -NetAdapterName "Ethernet 2","Ethernet 3"
   ```

4.  In **Hyper‑V Manager**, in the **Actions** pane, select **Virtual Switch Manager**.

5.  In the **Virtual Switch Manager** **for** **LON-HV1** window, select the virtual switch named **SET1**.

>Note: Ethernet 2 and Ethernet 3 have been configured as a Hyper-V Switch Embedded Team. Notice that you can't change any settings other than the name of the switch and description. 

6.  Select **Cancel** to close the **Virtual Switch Manager** **for** **LON-HV1** window.

7.  On LON-HV1, in **Hyper‑V Manager**, in the **Virtual Machines** pane, right-click **Server2** to open the context menu, and then select **Settings**.

8.  Select **Network Adapter**.

9.  In the details pane, under **Virtual switch**, select **Set1**.

10.  Select **OK** to save changes and close the **Settings for Server2** window.

### Task 4: Configure and use bandwidth management

1.  In **Hyper‑V Manager**, in the **Virtual Machines** pane, right-click **Server1** to open the context menu, and then select **Settings**.
2.  In the **Settings for Server1 on LON-HV1** window, in the console tree, select the **External Network Adapter**. 
3.  In the details pane, in the **Bandwidth Management** area, select **Enable bandwidth management.**
4.  In the **Maximum bandwidth** box, enter **100**, and then select **OK**.

**Results**: After completing this exercise, you'll have successfully configured the advanced features of the Hyper‑V virtual switch.
