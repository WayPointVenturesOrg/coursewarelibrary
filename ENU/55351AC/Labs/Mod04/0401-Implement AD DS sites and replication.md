# Lab: Implement AD DS sites and replication

## Lab scenario

Contoso Corporation has a single AD DS domain, with all the domain controllers located in the London datacenter. As the company has grown and added branch offices with large numbers of users, it has become apparent that the current AD DS environment does not meet the company’s requirements. Users in some branch offices report that it can take a long time for them to sign in to their computers. Connectivity to network resources such as the company’s Distributed File Systems (DFS) can be slow, and can sporadically fail.

As one of the senior network administrators, you are responsible for planning and implementing an AD DS infrastructure that will help address the organization’s business requirements. You are responsible for configuring AD DS sites and replication to optimize the user experience and network utilization within the organization.

## Exercise 1: Modify the default site

### Scenario

Contoso has decided to implement additional AD DS sites to optimize the network utilization for AD DS network traffic. Your first step in implementing the new environment is to install a new domain controller for the Toronto site. You then will reconfigure the default site and assign appropriate IP address subnets to the site.

Finally, your task is to change the name of the default site to **LondonHQ** and associate it with the **172.16.0.0/24** IP subnet, which is the subnet range for the London head office.

The main tasks for this exercise are as follows:

1. Install the Toronto domain controller.

2. Rename the default site.

3. Configure IP subnets that are associated with the default site.


### Task 1: Install the Toronto domain controller

1. Sign in to **TOR-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager starts automatically.

2. In **Server Manager**, select **Manage**, and then from the drop-down list, select **Add Roles and Features**.

3. On the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, confirm that **Role-based or feature-based installation** is selected, and then select **Next**.

5. On the **Select destination server** page, ensure that **Select a server from the server pool** is selected and that **TOR-DC1.Contoso.com** is highlighted, and then select **Next**.

6. On the **Select server roles** page, select the **Active Directory Domain Services** check box.

7. On the **Add features that are required for Active Directory Domain Services?** page, select **Add Features**, and then select **Next**.

8. On the **Select features** page, select **Next**.

9. On the **Active Directory Domain Services** page, select **Next**.

10. On the **Confirm installation selections** page, select **Install**.

11. After the AD DS binaries have installed, select the **Promote this server to a domain controller** link.

12. In the **Deployment Configuration** window, select **Add a domain controller to an existing domain**, and then select **Next**.

13. In the **Domain Controller Options** window, ensure that both the **Domain Name system (DNS) server** and **Global Catalog (GC)** check boxes are selected.

14. Confirm that **Site name:** is set to **Default-First-Site-Name**, and then under **Type the Directory Services Restore Mode (DSRM) password**, enter **Pa55w.rd** in both the **Password** and **Confirm password** boxes and then select **Next**.

15. On the **DNS Options** page, select **Next**.

16. In the **Additional Options** page, select **Next**.

17. In the **Paths** window, select **Next**.

18. In the **Review Options** window, select **Next**.

19. In the **Prerequisites Check** window, select **Install**. 

    > The server will restart automatically.

20. After **TOR-DC1** restarts, sign in as **Contoso\\Administrator** with the password **Pa55w.rd**.


### Task 2: Rename the default site

1. Switch to **LON-DC1**.
2. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password **Pa55w.rd**.
3. In **Server Manager**, select **Tools**, and then select **Active Directory Sites and Services**.
4. In **Active Directory Sites and Services**, in the navigation pane, expand **Sites**.

5. Right-click or access the context menu for **Default-First-Site-Name**, and then select **Rename**.

6. Enter **LondonHQ**, and then press Enter.

7. Expand **LondonHQ**, expand the **Servers** folder, and then verify that both **LON-DC1** and **TOR-DC1** belong to the **LondonHQ** site.


### Task 3: Configure IP subnets that are associated with the default site

1. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, and then select the **Subnets** folder.

2. Right-click or access the context menu for **Subnets**, and then select **New Subnet**.

3. In the **New Object – Subnet** dialog box, under **Prefix**, enter **172.16.0.0/24**.

4. Under **Select a site object for this prefix**, select **LondonHQ**, and then select **OK**.


**Results:** After completing this exercise, you will have successfully reconfigured the default site and assigned IP address subnets to the site.

## Exercise 2: Create additional sites and subnets

### Scenario

The next step to implement the AD DS site design is to configure the new AD DS site. The first site to implement is the Toronto site for the North American datacenter. The network team in Toronto also wants to dedicate a site named **TestSite** in the Toronto datacenter. You have been instructed that the Toronto IP subnet address is **172.16.1.0/24**, and the test network IP subnet address is **172.16.100.0/24**.

The main tasks for this exercise are as follows:

1. Create the AD DS sites for Toronto.

2. Create IP subnets that are associated with the Toronto sites.


### Task 1: Create the AD DS sites for Toronto

1. If necessary, on **LON-DC1**, open the **Server Manager** console, select **Tools**, and then select **Active Directory Sites and Services**.

2. In the **Active Directory Sites and Services** console, in the navigation pane, right-click or access the context menu for **Sites**, and then select **New Site**.

3. In the **New Object – Site** dialog box, in the **Name** text box, enter **Toronto**.

4. Under **Select a site link object for this site**, select **DEFAULTIPSITELINK**, and then select **OK**.

5. In the **Active Directory Domain Services** dialog box, select **OK**. 

   > The Toronto site displays in the navigation pane.

6. In the **Active Directory Sites and Services** console, in the navigation pane, right-click or access the context menu for **Sites**, and then select **New Site**.

7. In the **New Object – Site** dialog box, in the **Name** text box, enter **TestSite**.

8. Under **Select a site link object for this site**, select **DEFAULTIPSITELINK**, and then select **OK**. 

   > The TestSite displays in the navigation pane.

### Task 2: Create IP subnets that are associated with the Toronto sites

1. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, and then select the **Subnets** folder.

2. Right-click or access the context menu for **Subnets**, and then select **New Subnet**.

3. In the **New Object – Subnet** dialog box, under **Prefix**, enter **172.16.1.0/24**.

4. Under **Select a site object for this prefix**, select **Toronto**, and then select **OK**.

5. Right-click or access the context menu for **Subnets**, and then select **New Subnet**.

6. In the **New Object – Subnet** dialog box, under **Prefix**, enter **172.16.100.0/24**.

7. Under **Select a site object for this prefix**, select **TestSite**, and then select **OK**.

8. In the navigation pane, select the **Subnets** folder. Verify in the details pane that the two subnets are created and associated with their appropriate site.

   > **Note:** There are three subnets in total (**172.16.0.0** was created in Exercise 1, Task 3, “Configure IP subnets that are associated with the default site”).

**Results**: After completing this exercise, you will have successfully created two additional sites representing the IP subnet addresses in Toronto.

## Exercise 3: Configure AD DS replication

### Scenario

Now that the AD DS sites have been configured for Toronto, your next step is to configure the site links to manage replication between the sites and then to move the **TOR-DC1** domain controller to the **Toronto** site. Currently, all sites belong to **DEFAULTIPSITELINK**.

You need to modify site links so that **LondonHQ** and **Toronto** belong to one common site link called **LON-TOR**. You should configure this link to replicate every hour. Additionally, you should link the **TestSite** site only to the **Toronto** site by using a site link named **TOR-TEST**. Replication should not be available from the **Toronto** site to the **TestSite** site during working hours from 9 AM to 3 PM. 

Finally, you will use tools to monitor replication between the sites.

The main tasks for this exercise are as follows:

1. Configure site links between AD DS sites.

2. Move TOR-DC1 to the Toronto site.

3. Monitor AD DS site replication.


### Task 1: Configure site links between AD DS sites

1. If necessary, on **LON-DC1**, open the **Server Manager** console, select **Tools**, and then select **Active Directory Sites and Services**.

2. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, expand **Inter-Site Transports**, and then select the **IP** folder.

3. Right-click or access the context menu for **IP**, and then select **New Site Link**.

4. In the **New Object – Site Link** dialog box, in the **Name** text box, enter **TOR-TEST**.

5. Under **Sites not in this site link**, press Ctrl on the keyboard, select **Toronto**, select **TestSite**, select **Add**, and then select **OK**.

6. Right-click or access the context menu for **TOR-TEST**, and then select **Properties**.

7. In the **TOR-TEST Properties** dialog box, select **Change Schedule**.

8. In the **Schedule for TOR-TEST** dialog box, highlight the range from **Monday 9 AM** to **Friday 3 PM**, as follows:

   - Select the **Monday at 9:00AM** tile, press and hold the mouse button, and then drag the cursor to the **Friday at 3:00 PM** tile.

9. Select **Replication Not Available**, and then select **OK**.

10. Select **OK** to close **TOR-TEST Properties**.

11. Right-click or access the context menu for **DEFAULTIPSITELINK**, and then select **Rename**.

12. Enter **LON-TOR**, and then press Enter.

13. Right-click or access the context menu for **LON-TOR**, and then select **Properties**.

14. Under **Sites in this site link**, select **TestSite**, and then select **Remove**.

15. In the **Replicate Every** spin box, change the value to **60** minutes, and then select **OK**.


### Task 2: Move TOR-DC1 to the Toronto site

1. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, expand **LondonHQ**, and then expand the **Servers** folder.

2. Right-click or access the context menu for **TOR-DC1**, and then select **Move**.

3. In the **Move Server** dialog box, select **Toronto**, and then select **OK**.

4. In the navigation pane, expand the **Toronto** site, expand **Servers**, and then select **TOR-DC1**.


### Task 3: Monitor AD DS site replication

1. On **LON-DC1**, select **Start**, and then select the **Windows PowerShell** icon.

2. At the **Windows PowerShell** prompt, enter the following, and then press Enter:

   ```
   Repadmin /kcc
   ```

   > This command recalculates the inbound replication topology for the server.
   >

3. At the **Windows PowerShell** command prompt, enter the following command, and then press Enter:

   ```
   Repadmin /showrepl
   ```

4. Verify that the last replication with **TOR-DC1** was successful.

5. At the **Windows PowerShell** command prompt, enter the following command, and then press Enter:

   ```
   Repadmin /bridgeheads
   ```

   > This command displays the bridgehead servers for the site topology.
   >

6. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Repadmin /replsummary
   ```

   > This command displays a summary of replication tasks. Verify that no errors appear.
   >

7. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   DCDiag /test:replications
   ```

8. Verify that all connectivity and replication tests pass successfully.

9. Switch to **TOR-DC1**, and then repeat steps 1 through 8 to view information from **TOR-DC1**. For step 4, verify that the last replication with **LON-DC1** was successful.


**Results**: After completing this exercise, you will have successfully configured site links and monitored replication.

## Exercise 4: Monitoring and troubleshooting AD DS replication

### Scenario

After AD DS sites and replication are established, Contoso experiences replication issues. 

You need to use monitoring and troubleshooting tools to diagnose the issue and resolve it.

The main tasks for this exercise are as follows:

1. Produce an error.

2. Monitor AD DS site replication.

3. Troubleshoot AD DS replication.


### Task 1: Produce an error

1. If necessary, on **LON-DC1**, open **Server Manager**.

2. In **Server Manager**, select **Tools**, and then select **Active Directory Sites and Services**.

3. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, expand **LondonHQ**, expand the **Servers** folder, expand **LON-DC1**, and then select **NTDS Settings**.

4. In the details pane, right-click or access the context menu for the **TOR-DC1** connection object, and then select **Replicate Now**.

5. In the **Replicate Now** dialog box, select **OK**.

6. In **Active Directory Sites and Services**, examine all the objects you created earlier, and then on the taskbar, select the **Windows PowerShell** icon.

7. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Get-ADReplicationUpToDatenessVectorTable –Target Contoso.com
   ```

   > **Note:** This cmdlet will show you the last several replication events. Make a note of the date and time of the last (top) event.

8. Switch to **TOR-DC1**.

9. Select **Start**, and then select **Windows PowerShell**.

10. At the **Windows PowerShell** command prompt, enter the following, and then press Enter after each command:

    ```
    CD \Labfiles\Mod04
    
    .\Mod04Ex4.ps1
    ```

### Task 2: Monitor AD DS site replication

1. If necessary, on **TOR-DC1**, open the **Server Manager** console, select **Tools**, and then select **Active Directory Sites and Services**.

2. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, expand **Toronto**, expand **Servers**, expand **TOR-DC1**, and then select **NTDS Settings**.

3. In the details pane, right-click or access the context menu for **LON-DC1**, and then select **Replicate Now**.

4. Select **OK** on the **Replicate Now** pop-up.

5. On **TOR-DC1**, on the taskbar, select the **Windows PowerShell** icon.

6. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Get-ADReplicationUpToDatenessVectorTable –Target Contoso.com
   ```

   > **Note:** This cmdlet will show you the last several replication events. Note that the last date and time shown (**Replication from** **LON-DC1**) is not updating. This indicates that one-way replication is not occurring.

7. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Get-AdReplicationSubnet –filter *
   ```

   > **Note:** This cmdlet will show detailed information about any subnets assigned to any sites. Note that nothing is returned.

8. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Get-AdReplicationSiteLink –filter *
   ```

   > **Note:** This cmdlet will show detailed information about any site links assigned to particular sites. Note that nothing is returned.

### Task 3: Troubleshoot AD DS replication

1. On TOR-DC!, at the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Ipconfig /all
   ```

   > Examine the results. Notice that the DNS server address is incorrectly set to **10.0.0.1**.
   >

2. At the **Windows PowerShell** command prompt, enter the following, and then press Enter:

   ```
   Get-DnsClient | Set-DnsClientServerAddress -ServerAddresses ("172.16.0.10","172.16.0.25")
   ```

3. Run the **`Ipconfig /all`** command again. 

   > The DNS server addresses should be **172.16.0.10** and **172.16.0.25**.

4. If necessary, on **TOR-DC1**, open the **Server Manager** console, select **Tools**, and then select **Active Directory Sites and Services**.

5. In the **Active Directory Sites and Services** console, in the navigation pane, expand **Sites**, expand **Toronto**, expand **Servers**, expand **TOR-DC1**, and then select **NTDS Settings**.

6. In the details pane, right-click or access the context menu for **LON-DC1**, and then select **Replicate Now**.

7. In the **Replication Now** window, select **OK**.

8. In **Active Directory Sites and Services**, examine all objects that you created earlier. Are any missing?

9. On **TOR-DC1**, open **File Explorer** and browse to **C:\\Labfiles\\Mod04**.

10. Right-click or access the context menu for the **Mod04EX4Fix.ps1** file, and then select **Run with PowerShell**. Enter **`Y`** when prompted about execution policy, and then press Enter.

11. In **Active Directory Sites and Services**, examine all the objects that you created earlier. Ensure that the site link has been created in the **Inter-Site Transports** node, and subnets have been created in the **Subnets** node.

12. On **LON-DC1** and **TOR-DC1**, close all open windows.


**Results**: After completing this exercise, you will have successfully diagnosed and resolved replication issues.