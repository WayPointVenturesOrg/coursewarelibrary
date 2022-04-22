# Lab A: Plan and implement DNS name resolution

## Lab scenario

Contoso users in the Sydney location report that connectivity to websites and shared resources is slow and sometimes result in time-out errors. Currently, the Sydney office only contains Windows 11 client computers. Wide area network (WAN) communication between Sydney and London, where infrastructure servers are hosted, has been intermittent and is the primary cause of the issues. You have been asked to implement a DNS name resolution solution in Sydney that will resolve the majority of these issues.

The current DNS structure for Contoso is as follows:

- Contoso's Internet service provider’s (ISP's) DNS server named **INET1** (131.107.0.100) provides DNS resolution and forwarding for Internet-based domain names.
- The Adatum.com domain namespace hosts web and mail services that are accessible from the Internet and located on the ISP's server named **INET1**. This server is also accessible from inside the Contoso network.
- The Treyresearch.net namespace contains resources used by Contoso employees. However, the DNS records for the Treyresearch.net zone are not located on the DNS server that clients are configured to use. The Treyresearch.net namespace is located on a DNS server that is installed on **LON-SVR1**.

- **LON-DC1** provides DNS name resolution for the Contoso.com domain.

You need to configure a DNS server in the Sydney location named **SYD-SVR1** to provide efficient name resolution for Sydney clients. The DNS server must resolve queries for local clients, and provide name resolution for the sites Adatum.com and TreyResearch.net. Sydney clients should be forwarded to an authoritative server for Contoso.com to resolve internal domain queries. 

The requirements are as follows:

- Forwarding for all DNS lookups for Internet access from Sydney to the ISP’s DNS server.
- Configure conditional forwarding on **SYD-SVR1** for the Contoso.com and Adatum.com zones.
- Host and resolve queries for the Treyresearch.net domain within the Sydney location.

The virtual machines used in this lab provide the following services:

- **INET1** (131.107.0.100). DNS server providing name resolution for Internet-based DNS names and Adatum.com.
- **EU-RTR** (131.107.0.10, 172.16.0.1, 172.16.18.1) Router for Internet, NA_WAN, and PAC_WAN virtual switches.
- **LON-DC1** (172.16.0.10). Domain controller and DNS server hosting the Contoso.com namespace.
- **LON-SVR1** (172.16.0.11). DNS server hosting the Treyresearch.net namespace.
- **SYD-SVR1** (172.16.19.20). The server that you will configure with DNS to provide name resolution for client computers in Sydney.

## Exercise 1: Planning DNS name resolution

### Scenario

You need to create a plan for implementing DNS name resolution for the Sydney office. Review the following questions and determine how to implement DNS on SYD-SVR1 to provide efficient name resolution for the remote location.

The main task for this exercise is as follows: 

1. Plan the DNS infrastructure to support name resolution.

### Task 1: Plan the DNS infrastructure to support name resolution

Read the scenario and answer the following:

1. What is the first step in implementing your new DNS plan for the Sydney office?

   > **Answer:** Install the DNS Server role on **SYD-SVR1**.

2. How will you configure **SYD-SVR1** to resolve DNS queries for Internet-based addresses?

   > **Answer:** Set forwarding to **INET1** (131.107.0.100).

3. How will you configure **SYD-SVR1** to resolve DNS queries for the Adatum.com DNS namespace? 

   > **Answer:** Set conditional forwarding for Adatum.com to **INET1**.

4. How will you configure **SYD-SVR1** to resolve queries for the Treyresearch.net DNS namespace? 

   > **Answer:** Create a Secondary zone for TreyResearch.net on **SYD-SVR1**.

5. How will you configure **SYD-SVR1** to resolve queries for the Contoso.com domain? 

   > **Answer:** Set conditional forwarding for Contoso.com to **LON-DC1** (172.16.0.10).

**Results:** After completing this exercise, you will have created a plan for implementing DNS name resolution for the Sydney office.

## Exercise 2: Implementing DNS servers and zones

### Scenario

You need to install and configure DNS name resolution for the Sydney location according to your DNS implementation plan as follows:

- Install the DNS Server role on **SYD-SVR1**.

- Configure forwarding for Internet and external queries to be directed to a DNS server named **INET1** (131.107.0.100).

- Configure conditional forwarding for the Adatum.com domain. All DNS queries for Adatum.com should be directed to **INET1** (131.107.0.100).

- Configure conditional forwarding for the Contoso.com domain. All DNS queries for Contoso.com should be directed to **LON-DC1** (172.16.0.10).

- Configure a secondary zone for the TreyResearch.net domain to be transferred from the DNS server located on **LON-SVR1** (172.16.0.11).


The main tasks for this exercise are as follows:

1. Install the DNS server role on SYD-SVR1.

2. Configure DNS forwarding to INET1.

3. Configure DNS conditional forwarding.

4. Configure secondary zones and zone transfer.

5. Validate zone transfer.


### Task 1: Install the DNS server role on SYD-SVR1

1. On **SYD‑SVR1**, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.
2. Select **Start**, and then select **Server Manager**.
3. In **Server Manager**, select **Add roles and features**.

4. On the **Before you begin** page, select **Next**.

5. On the **Select installation type** page, select **Next**.

6. On the **Select destination server** page, select **Next**.

7. On the **Select server roles** page, select **DNS Server**.

8. When the **Add Roles and Features Wizard** displays, select **Add Features**, and then select **Next**.

9. On the **Select features** page, select **Next**.

10. On the **DNS Server** page, select **Next**.

11. On the **Confirm installation selections** page, select **Install**.

12. On the **Installation progress** page, when the **Installation succeeded** message appears, select **Close**.


### Task 2: Configure DNS forwarding to INET1

1. On **SYD-SVR1**, in **Server Manager**, select **Tools**, and then select **DNS**.

2. In **DNS Manager**, expand **SYD-SVR1**, select and right-click **SYD-SVR1**, and then select **Properties**.

3. In the **SYD-SVR1 Properties** dialog box, select the **Forwarders** tab.

4. On the **Forwarders** tab, select **Edit**. 
5. In the **Edit Forwarders** window, enter **131.107.0.100**, press Enter and select **OK**.
6. In the **SYD-SVR1 Properties** window, select **OK**.


### Task 3: Configure DNS conditional forwarding

1. On **SYD-SVR1**, with the **SYD-SVR1** node still expanded in the **DNS Manager** console tree, select **Conditional Forwarders**.

2. Right-click **Conditional Forwarders**, and then select **New Conditional Forwarder**.

3. In the **New Conditional Forwarder** window, in the **DNS Domain** text box, type **Contoso.com**, and then, in the IP Address text area, type **172.16.0.10**, press Enter, and then select **OK**.

   > **Note:** You might see a red **X** icon beside the IP address after you press Enter. This is normal. Continue by selecting **OK** in the window. The red **X** icon will resolve after this. You can return to the **Conditional Forwarder** dialog box, and select **Edit**, which will now show a green **Check Mark** icon in place of the red **X** icon.

4. Right-click **Conditional Forwarders**, and then select **New Conditional Forwarder**.

5. In the **New Conditional Forwarder** window, in the **DNS Domain** text box, type **Adatum.com**, and then, in the IP address text area, type **131.107.0.100**, press Enter, and then select **OK**.


### Task 4: Configure secondary zones and zone transfer

1. On **SYD-SVR1**, in the **DNS Manager** console, select and then right-click **Forward Lookup Zones**, and then select **New Zone**.

2. In the **New Zone Wizard**, select **Next**.

3. On the **Zone Type** page, select **Secondary zone**, and then select **Next**.

4. On the **Zone Name** page, in the **Zone name** text box, type **TreyResearch.net**, and then select **Next**.

5. On the **Master DNS Servers** page, type **172.16.0.11**, press Enter, and then select **Next**.

6. On the **Completing the New Zone Wizard** page, select **Finish**.

7. Switch to **LON-SVR1** and if necessary sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

8. Select **Start** and then select **Server Manager**.

9. In **Server Manager**, select **Tools**, and then select **DNS**.

10. In the console tree, select **LON-SVR1**, and then select and expand **Forward Lookup Zones**.

11. Select and right-click **TreyResearch.net**, and then select **Properties**.

12. In the **TreyResearch.net Properties** page, select the **Zone Transfers** tab.

13. Under the **Allow zone transfers** area, select **Only to the following servers**, and then select **Edit**.

14. In the IP address text area, type **172.16.19.20**, press Enter, and then select **OK.**

15. In the **TreyResearch.net Properties** dialog box**,** while still in the **Zone Transfers** tab, select **Notify**.

16. In the **Notify** window, under the **Automatically notify** area, select **The following servers**. In the IP address text area, type **172.16.19.20**, press Enter, and then select **OK.**

17. In the **TreyResearch.net Properties** page, select **OK**.

18. Switch to **SYD-SVR1**, and then in the DNS console, in the console tree, select the **TreyResearch.net** zone.

19. In the details pane, you should see the **Start of Authority (SOA)** and **Name Server (NS)** resource records for **LON-SVR1.Contoso.com**.


### Task 5: Validate zone transfer

1. Switch to **LON-SVR1**, and in the **DNS** console, in the console tree, select the **TreyResearch.net** zone.

2. Right-click **TreyResearch.net**, and then select **New Host (A or AAAA).**

3. In the **New Host** window, in the **Name** text box, type **ATL-SVR1**, in the **IP address** text box, type **172.16.18.125**, and then select **Add Host**.

4. In the **DNS** message window, select **OK**, and then in the **New Host** window, select **Done**.

5. Switch to **SYD-SVR1**, and then in the **DNS** console, in the console tree, select the **TreyResearch.net** zone.

6. Right-click **TreyResearch.net**, and then select **Refresh**. 

   > In the details pane, you should now see the **ATL-SVR1** host record, along with the **Start of Authority (SOA)** and **Name Server (NS)** resource records for **LON-SVR1.Contoso.com**.

**Results:** After completing this exercise, you will have installed and configured DNS on **SYD‑SVR1**.
