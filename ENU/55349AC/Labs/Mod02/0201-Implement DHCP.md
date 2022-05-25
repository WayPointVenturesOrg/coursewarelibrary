# Lab: Implement DHCP

## Lab scenario

Contoso Corportion is planning to open three new North American branch offices. The following table describes the planned computer distribution in the new branch office:

**Planned computer distribution**

| **Location** | **Computer  and device requirements**                        |
| ------------ | ------------------------------------------------------------ |
| Houston      | 300 desktop computers and 100 laptops connecting to both the wireless and wired networks; 50 mobile devices connecting only to the wireless network. |
| Mexico City  | 100 desktop computers and 50 laptops connecting to both the wireless and wired networks; 20 mobile devices connecting only to the wireless network. |
| Portland     | 100 desktop computers and 75 laptops connecting to both the wireless and wired networks; 150 mobile devices connecting only to the wireless network. |

Contoso is using Microsoft Office 365 for all email and file access, with some shared folders in the Toronto regional office. All new offices have fast and highly available network connections to the Toronto office, so Contoso won’t deploy any servers in branch offices. The Contoso network team has assigned the subnets 172.16.18.0/18 to the Toronto main office, which is using the network assignments that the following table lists:

**Toronto office network assignments**

| **IP subnet**                    | **Purpose**                          |
| -------------------------------- | ------------------------------------ |
| 172.16.18.0/24                   | Network devices and network printers |
| 172.16.19.0/24                   | Servers                              |
| 172.16.20.0/24 to 172.16.52.0/24 | Desktop computers                    |
| 172.16.53.0/24 to 172.16.60.0/24 | Wireless devices                     |

Using this information, you must plan and implement Dynamic Host Configuration Protocol (DHCP) to support your design.

## Exercise 1: Plan a DHCP server implementation

### Scenario

You must implement a network-server infrastructure that enables assignment of IP addresses to the Houston, Mexico City, and Portland offices. You’ll use TOR-SVR1 as the primary DHCP server. 

Your solution must meet the following requirements: 

- Wired and wireless clients must be assigned IP addresses from separate IP ranges. 
- Each location must maintain a separate IP address range from other locations. 
- Your solution must include a DHCP failover to provide DHCP address leases if TOR-SVR1 is unavailable.

The main task for this exercise is: 

- Plan a DHCP server implementation.

### Task 1: Plan a DHCP server implementation

Answer the following questions. Your answers will help you develop a plan for implementing a DHCP server infrastructure.

1. What scopes do you need to create to implement the IP addressing scheme that you defined in module 1?

   > **Answer:** Subnet assignments will vary, but possibilities are:
   >
   > Houston: Has 400 potential wired connections and 150 potential wireless connections. Houston will need two /24 subnets supernetted for the wired connections and one /24 subnet for the wireless connections. 
   >
   > Houston will use 172.16.30.0/24 and 172.16.31.0/24 supernetted for wired connections and 172.16.55.0/24 for wireless connections. 
   >
   > Mexico City: Has 150 potential wired connections and 70 potential wireless connections. Mexico City will use 172.16.35.0/24 for wired connections and 172.16.56.0/24 for wireless connections. 
   >
   > Portland: Has 175 potential wired connections and 225 potential wireless connections. Portland will use 172.16.40.0/24 for wired connections and 172.16.57.0/24 for wireless connections. 
   >
   > Wireless scopes will have a short duration of one day, and wired scopes will have a duration of eight days.
   >

2. Where will the Domain Name System (DNS) service come from?

   > **Answer:** LON-DC1 will be the DNS server for all scopes.

3. How will you get DHCP messages from TOR-SVR1 to clients in the Houston, Mexico City, and Portland locations?

   > **Answer:** You’ll configure DHCP relay agents in the branches.

4. What configuration changes do you need to make to NA-RTR to enable the IP addressing scheme through the DHCP relay?

   > **Answer:** You’ll need to assign IP addresses to the interfaces from their respective branch subnets, and then configure them as DHCP relay agents.

5. How will you assign different IP ranges to the clients in each location? How will you assign different IP addresses for wired and wireless clients?

   > **Answer:** You’ll create multiple scopes on the DHCP server, and you’ll need a separate scope for each wired and wireless network. To distinguish between wired and wireless requests, you’ll configure the router as a DHCP relay agent for the wired connections, and then configure the wireless access points as relay agents for wireless requests. 

6. Which IP addresses will you assign to the network interfaces on NA-RTR that are connected to the Houston, Mexico City, and Portland networks?

   > **Answer:** You’ll assign IP address 172.16.30.1 to the Houston interface, IP address 172.16.35.1 to the Mexico City interface, and IP address 172.16.40.1 to the Portland interface.

7. How will you provide for DHCP failover for TOR-SVR1?

   > **Answer:** You’ll configure a failover relationship with LON-SVR1 as a hot standby DHCP server.

**Results:** After answering all questions in this exercise, you will have planned a DHCP implementation.

## Exercise 2: Implement the DHCP configuration

### Task 1: Install and configure the DHCP server

#### Install the DHCP server role on TOR-SVR1

1. On **TOR-SVR1**, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, and then select **Windows PowerShell**.

3. In the **Administrator: Windows PowerShell** window, enter **`Get-Command *dhcp*`**, and then select Enter.

   > **Note:** The Cmdlet doesn't return any output, which confirms that the DhcpServer PowerShell module isn't installed.

4. Select **Start**, and then select the **Server Manager**.

5. In **Server Manager**, select **Tools**, and then verify in the drop-down list that **DHCP** isn’t available. 

   > **Note:** DHCP isn’t listed because the DHCP console isn’t installed yet.

6. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**. 

   > The **Add Roles and Features Wizard** starts.

7. On the **Before you begin** page, select **Next**.

8. On the **Select installation type** page, select **Next**. 

9. On the **Select destination server** page, select **Next**. 

10. On the **Select server roles** page, select **DHCP Server**. 

11. In the **Add Roles and Features Wizard** dialog box, select **Add Features**, and then select **Next**.

12. On the **Select features** page, select **Next**.

13. On the **DHCP Server** page, select **Next**. 

14. On the **Confirm installation selections** page, select **Install**.

15. Wait until the installation finishes, and then select **Close**.

16. In **Server Manager**, select **Tools**, and then in the drop-down list, verify that **DHCP** is now listed. 

    > **Note:** DHCP is the management tool that was installed when you installed the DHCP server role.

17. In the **Administrator: Windows PowerShell** window, enter **`Get-Command *dhcp*`** (or select the up arrow), and then select Enter.

    > **Note:** The cmdlet now returns many commands that include dhcp in their names, because the DhcpServer PowerShell module was installed when you installed the DHCP server role.

#### Perform post-installation configuration for the DHCP server

1. On **TOR-SVR1**, in **Server Manager**, on the menu bar, select the **Notifications** icon, and then select the **Complete DHCP configuration** link. 

2. In the **DHCP Post-Install configuration** **wizard**, on the **Description** page, select **Next**. 

3. On the **Authorization** page, select **Commit**.

4. On the **Summary** page, select **Close**. 


### Task 2: Configure DHCP scopes for Houston, Mexico City, and Portland

#### Create the scopes for Houston

1. On **TOR-SVR1**, in **Server Manager**, select **Tools**, and then select **DHCP**. 

   > The **DHCP** console opens.

2. In the **DHCP** console, in the navigation pane, select **TOR-SVR1.contoso.com** to expand the server node.

3. In the navigation pane, expand the **IPv4** node.

4. Right-click the **IPv4** node to open the context menu, and then select **New Scope**. 

5. In the **New Scope Wizard**, select **Next**.

6. On the **Scope Name** page, in the **Name** text box, enter **Houston-wired1**, and then select **Next**. 

7. On the **IP Address Range** page, in the **Start IP address** text box, enter **172.16.30.2**, and then in the **End IP address** text box, enter **172.16.30.254**. 

   > **Note:** The subnet mask text box is populated automatically to match the default subnet mask for a class B address range. 

8. Update the value in the **Subnet mask** text box to **255.255.255.0**, and then select **Next**. 

9. On the **Add Exclusions and Delay** page, select **Next**. 

10. On the **Lease Duration** page, select **Next**.

11. On the **Configure DHCP Options** page, select **Next**. 

12. On the **Router (Default Gateway)** page, in the **IP address** text box, enter **172.16.30.1**, select **Add**, and then select **Next**. 

13. On the **Domain Name and DNS Servers** page, select **Next**. 

14. On the **WINS Servers** page, select **Next**.

15. On the **Activate Scope** page, select **Next**, and then select **Finish**. 

16. Repeat steps 4 through 15 to create a second scope with the following settings: 

- Name: **Houston–wired2**

- Start IP address: **172.16.31.2**

- End IP address: **172.16.31.254**

- Subnet mask: **255.255.255.0**

- Router (Default Gateway): **172.16.31.1**


17. Repeat steps 4 through 15 to create a third scope with the following settings: 

- Name: **Houston-wireless**

- Start IP address: **172.16.55.2**

- End IP address: **172.16.55.254**

- Subnet mask: **255.255.255.0**

- Lease duration: **1 day**

- Router (Default Gateway): **172.16.55.1**

#### Create a superscope for Houston wired scopes

1. On **TOR-SVR1**, in the **DHCP** console, in the navigation pane, right-click the **IPv4** node to open the context menu, and then select **New Superscope**. 

2. In the **New Superscope Wizard**, select **Next**.

3. On the **Superscope Name** page, in the **Name** text box, enter **Houston-wired**, and then select **Next**. 

4. On the **Select Scopes** page, select and hold the **Ctrl** key, select **[172.16.30.0] Houston-wired1** and **[172.16.31.0] Houston-wired2**, and then select **Next**. 

5. On the **Completing the New Superscope Wizard** page, select **Finish**.


#### Create scopes for Mexico City

1. On **TOR-SVR1**, in the **DHCP** console, in the navigation pane, right-click the **IPv4** node to open the context menu, and then select **New Scope**.

2. In the **New Scope Wizard**, select **Next**.

3. On the **Scope Name** page, in the **Name** text box, enter **MexicoCity-wired**, and then select **Next**. 

4. On the **IP Address Range** page, in the **Start IP address** text box, enter **172.16.35.2**, and in the **End IP address** text box, enter **172.16.35.254**. Update the value in the **Subnet mask** text box to **255.255.255.0**, and then select **Next**

5. On the **Add Exclusions and Delay** page, select **Next**. 

6. On the **Lease Duration** page, select **Next**.

7. On the **Configure DHCP Options** page, select **Next**. 

8. On the **Router (Default Gateway)** page, in the **IP address** text box, enter **172.16.35.1**, select **Add**, and then select **Next**. 

9. On the **Domain Name and DNS Servers** page, select **Next**. 

10. On the **WINS Servers** page, select **Next**.

11. On the **Activate Scope** page, select **Next**, and then select **Finish**. 

12. Repeat steps 1 through 11 to create a scope with the following parameters: 

- **Name: MexicoCity-wireless** 
- **Start IP address: 172.16.56.2**

- **End IP address: 172.16.56.254**
- **Subnet mask: 255.255.255.0**

- **Lease duration: 1 day**

- **Router (Default Gateway): 172.16.56.1**


#### Create scopes for Portland

1. On **TOR-SVR1**, in the **DHCP** console, in the navigation pane, right-click the **IPv4** node to open the context menu, and then select **New Scope**.

2. In the **New Scope Wizard**, select **Next**.

3. On the **Scope Name** page, in the **Name** text box, enter **Portland-wired**, and then select **Next**. 

4. On the **IP Address Range** page, in the **Start IP address** text box, enter **172.16.40.2**, and in the **End IP address** text box, enter **172.16.40.254**. Update the value in the **Subnet mask** text box to **255.255.255.0**, and then select **Next**.

5. On the **Add Exclusions and Delay** page, select **Next**. 

6. On the **Lease Duration** page, select **Next**.

7. On the **Configure DHCP Options** page, select **Next**. 

8. On the **Router (Default Gateway)** page, in the **IP address** text box, enter **172.16.40.1**, select **Add**, and then select **Next**. 

9. On the **Domain Name and DNS Servers** page, select **Next**. 

10. On the **WINS Servers** page, select **Next**.

11. On the **Activate Scope** page, select **Next**, and then select **Finish**. 

12. Repeat steps 1 through 11 to create a scope with the following parameters: 

- **Name** **: Portland-wireless**

- **Start IP address: 172.16.57.2**

- **End IP address: 172.16.57.254**

- **Subnet mask: 255.255.255.0**

- **Lease duration: 1 day**
- **Router (Default Gateway): 172.16.57.1**


### Task 3: Configure network adapters on NA-RTR

1. Switch to the **NA-RTR** virtual machine (VM). 

2. If necessary, sign in as **Administrator** with the password of **Pa55w.rd**.

3. On **NA-RTR**, right-click **Start** to open the context menu, and then select **Network Connections**. 

   > The Settings app opens.

4. In the **Settings** app, in the navigation pane, select **Ethernet**, and then in the details pane, select **Change adapter options**.

5. In the **Network Connections** window, right-click the **HOU_WAN** connection to open the context menu, and then select **Properties**. 

6. Select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**. 

7. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, select the **Use the following IP address** radio button. 

8. In the **IP address** text box, enter **172.16.30.1**, and in the **Subnet mask** text box, enter **255.255.255.0**. Select **OK**, and then select **Close**. 

9. In the **Network Connections** window, right-click the **MEX_WAN** connection to open the context menu, and then select **Properties**. 

10. Select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**. 

11. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, select the **Use the following IP address** radio button.

12. In the **IP address** text box, enter **172.16.35.1**, and in the **Subnet mask** text box, enter **255.255.255.0**. Select **OK**, and then select **Close**. 

13. In the **Network Connections** window, right-click the **POR_WAN** connection to open the context menu, and then select **Properties**. 

14. Select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**. 

15. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, select the **Use the following IP address** radio button.

16. In the **IP address** text box, enter **172.16.40.1**, and in the **Subnet mask** text box, enter **255.255.255.0**. Select **OK**, and then select **Close**. 


## Exercise 3: Implement DHCP failover

### Task 1: Deploy the DHCP server role on LON-SVR1 

#### Install the DHCP server role on LON-SVR1

1. Switch to the **LON-SVR1** VM.

2. If necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. On **LON-SVR1**, select **Start**, and then select **Server Manager**.

4. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

5. On the **Before you begin** page, select **Next**.

6. On the **Select installation type** page, select **Next**. 

7. On the **Select destination server** page, select **Next**. 

8. On the **Select server roles** page, select **DHCP Server**. 

9. In the **Add Roles and Features Wizard** dialog box, select **Add Features**, and then select **Next**.

10. On the **Select features** page, select **Next**.

11. On the **DHCP Server** page, select **Next**.

12. On the **Confirm installation selections** page, select **Install**. 

13. Wait until the installation has succeeded, and then select **Close**.


#### Perform the DHCP server post-installation configuration

1. On **LON-SVR1**, in **Server Manager**, on the menu bar, select the **Notifications** icon, and then select the **Complete DHCP configuration** link. 

2. In the **DHCP Post-Install configuration** **wizard**, on the **Description** page, select **Next**. 

3. On the **Authorization** page, select **Commit**.

4. On the **Summary** page, select **Close**. 


### Task 2: Configure DHCP failover between TOR-SVR1 and LON-SVR1

1. Switch to the **TOR-SVR1** VM.

2. In the **DHCP** console, in the navigation pane, right-click the **IPv4** node to open the context menu, and then select **Configure Failover**. 

3. On the **Introduction to DHCP Failover** page, verify that all **TOR-SVR1** scopes are selected (there should be seven scopes), and then select **Next**. 

4. On the **Specify the partner server to use for failover** page, select **Add Server**. The **Add Server** dialog box opens.

5. In the **Add Server** dialog box, in the **This server** text box, enter **172.16.0.11**, which is the IP address of LON-SVR1, and then select **OK**, and select **Next**.

6. On the **Create a new failover relationship** page, in the **Mode** drop-down list box, select **Hot standby**, and then set the **Maximum Client Lead Time** to **1 minute**. 

   > **Note:** This low Maximum Client Lead Time (MCLT) value is for the purposes of the lab environment. 

7. In the **Shared Secret** text box, enter **Pa55w.rd**, select **Next**, and then select **Finish**. 

8. In the **Configure Failover** dialog box, select **Close**. 

9. Switch to the **LON-SVR1** VM.

10. On **LON-SVR1**, in **Server Manager**, select **Tools**, and then select **DHCP**. The **DHCP** console opens.

11. In **DHCP** console, in the navigation pane, expand the **lon-svr1.contoso.com** node, expand the **IPv4** node, and then verify that superscope and five scopes are listed. 

    > **Note:** They’re all synchronized from the TOR-SVR1 DHCP server.

### Task 3: Configure a DHCP relay agent on NA-RTR for Houston, Mexico City, and Portland

1. Switch to the **NA-RTR** VM.

2. On **NA-RTR**, select **Start**, and then select **Server Manager**. 

3. In **Server Manager**, select **Tools**, and then select **Routing and Remote Access**. 

   > **Note: **Routing and Remote access is part of the Remote Access role, which was preinstalled on NA-RTR.

4. In the **Routing and Remote Access** console, in the navigation pane, expand the **IPv4** node, right-click the **General** node to open the context menu, and then select **New Routing Protocol**. 

5. In the **New Routing Protocol** dialog box, verify that **DHCP Relay Agent** is selected, and then select **OK**. 

6. In the **Routing and Remote Access** console, in the navigation pane, right-click **DHCP Relay Agent** node to open the context menu, and then select **Properties**. 

7. In the **DHCP Relay Agent Properties** dialog box, in the **Server address** box, enter **172.16.18.20**, which is the IP address of TOR-SVR1, and then select **Add**. Then, in the **Server address** box, enter **172.16.0.11**, which is the IP address of LON-SVR1, select **Add**, and then select **OK**. 

8. Right-click the **DHCP Relay Agent** node to open the context menu, and then select **New Interface**. 

9. In the **New Interface for DHCP Relay Agent** dialog box, ensure that **HOU_WAN** interface is selected, and then select **OK**. 

   > The **DHCP Relay Properties – HOU_WAN Properties** dialog box opens.

10. In the **DHCP Relay Properties – HOU_WAN Properties** dialog box, select **OK**. 

11. Repeat steps 8 through 10 twice, first selecting the **MEX_WAN** interface, and then selecting the **POR_WAN** interface.

**Results:** After completing this exercise, you’ve implemented your plan for the DHCP configuration.

## Exercise 4: Validate the DHCP implementation

### Task 1: Test the DHCP allocation to the correct subnets

1. Switch to the **LON-CL1** VM.

2. If necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. On **LON-CL1**, select **Start**, enter **network conn**, and then select **View network Connections**. 

   > The **Network Connections** window opens.

4. In the **Network Connections** window, right-click the **London_Network** connection to open the context menu, and then select **Disable**.

5. In the **Network Connections** window, right-click the **HOU_WAN** connection to open the context menu, and then select **Enable**. 

   > **Note:** By doing this, you disconnect LON-CL1 from the London network and connect it to the HOU_WAN network.

6. Right-click the **HOU_WAN** connection to open the context menu, and then select **Properties**.

7. In the **HOU_WAN Properties** dialog box, select **Internet Protocol Version 4 (TCP/IPv4)**, and then select **Properties**. 

8. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, ensure that the **Obtain an IP address automatically** radio box is selected, select **OK**, and then select **Close**.

9. On **LON-CL1**, right-click **Start** to open the context menu, and then select **Windows Terminal**. 

10. In the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   ipconfig /all 
   ```

   > **Note:** LON-CL1 should have IP address 172.16.30.2, obtained from the DHCP server with IP address 172.16.18.20 (TOR-SVR1). 

11. In the **Network Connections** window, right-click the **HOU_WAN** connection to open the context menu, and then select **Disable**.

12. In the **Network Connections** window, right-click the **MEX_WAN** connection to open the context menu, and then select **Enable**. 

    > **Note:** By doing this, you disconnect LON-CL1 from the HOU_WAN network and connect it to the MEX_WAN network.

13. In the **Windows PowerShell** window, enter the following command, and then select Enter:

    ```
    ipconfig /all 
    ```

    > **Note:** LON-CL1 should have IP address 172.16.35.2, obtained from the DHCP server with IP address 172.16.18.20 (TOR-SVR1). 

14. In the **Network Connections** window, right-click the **MEX_WAN** connection to open the context menu, and then select **Disable**.

15. In the **Network Connections** window, right-click the **POR_WAN** connection to open the context menu, and then select **Enable**. 

    > **Note:** This disconnects LON-CL1 from the MEX_WAN network and connects it to the POR_WAN network.

16. In the **Windows PowerShell** window, enter the following command, and then select Enter:

    ```
    ipconfig /all 
    ```

    > **Note:** LON-CL1 should have IP address 172.16.40.2, obtained from the DHCP server with IP address 172.16.18.20 (TOR-SVR1). 

### Task 2: Test DHCP failover

1. Switch to the **TOR-SVR1** VM.

2. On **TOR-SVR1**, in **Server Manager**, select **Tools**, and then select **Services**. The **Services** console opens.

3. In the **Services** console, in the details pane, select the **DHCP Server** service, and then on the taskbar, select the **Stop Service** icon. 

4. Switch to the **LON-CL1** VM.

5. On **LON-CL1**, in the **Windows PowerShell** window, enter **ipconfig /release**, and then select Enter. 

6. In the **Windows PowerShell** window, enter **ipconfig /renew**, and then select Enter. Wait a few seconds for LON-CL1 to obtain TCP/IP settings.

7. In the **Windows PowerShell** window, enter **ipconfig /all**, and then select Enter.

   > **Note:** LON-CL1 should obtain an IP address from the DHCP server with IP address 172.16.0.11 (LON-SVR1). Because you stopped DHCP server on TOR-SVR1, the IP address was obtained from the standby DHCP server, LON-SVR1.

**Results:** After completing this exercise, you’ll have tested that you obtained the correct IP address for the connected subnet and that the standby DHCP server provided an IP address when the active DHCP server was stopped.
