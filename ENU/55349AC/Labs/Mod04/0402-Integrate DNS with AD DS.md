# Lab B: Integrate DNS with AD DS

## Lab scenario

After making additional improvements to the WAN connection between London and Sydney locations, you have been asked to enable **SYD-SVR1** to update and replicate records for the Contoso.com domain.

### Prerequisites

To following lab(s) must be completed before this lab:

- 0401-Planning and implementing DNS name resolution

## Exercise 1: Integrating DNS with AD DS

### Scenario

You need to deploy another Active Directory-integrated DNS server in Contoso.com. To do this, you will promote **SYD-SVR1** to a domain controller, and integrate DNS with the AD DS database for Contoso.com.

The main tasks for this exercise are as follows:

1. View resource records for the Sydney location.
2. Install AD DS on SYD-SVR1.
3. Review resource records on SYD-SVR1.

### Task 1: View resource records for the Sydney location

1. If necessary, sign in to **SYD-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. From **Server Manager**, open the **DNS Manager** console.

3. In the **DNS Manager** console, in the console tree, expand **SYD-SVR1**, and then select and expand **Forward Lookup** **Zones**.

   > Note that **Contoso.com** does not appear in the list of zones hosted on SYD-SVR1.
   >

4. Expand the **Conditional** **Forwarders** node, right-click **Contoso.com**, and then select **Delete**. 

5. In the **DNS** window, select **Yes** and then close the **DNS Manager** console.

6. Switch to **LON-DC1** and, if necessary, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

7. On **LON-DC1**, open **Server Manager**, select **Tools**, and then select **DNS**.

8. In the console tree, expand **LON-DC1**, select and expand **Forward Lookup Zones**, and then select **Contoso.com**.

   > Note the resource records in the details pane. You will compare these to the resource records on **SYD-SVR1** after it is promoted to be a domain controller.
   >

9. Do not close the **DNS Manager** console on **LON-DC1**.


### Task 2: Install AD DS on SYD-SVR1

1. Switch to **SYD-SVR1** and open **Server Manager**.

2. In the **Server Manager** console, select **Add roles and features**.

3. On the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, select **Next**.

5. On the **Select destination server** page, select **Next**.

6. On the **Select server roles** page, select **Active Directory Domain Services**.

7. When the **Add Roles and Features Wizard** appears, select **Add Features**, and then select **Next**.

8. On the **Select features** page, select **Next**.

9. On the **Active Directory Domain Services** page, select **Next**.

10. On the **Confirm installation selections** page, select **Install**.

11. On the **Installation progress** page, when the **Installation succeeded** message displays, *do not* close it. Instead, select **Promote this server to a domain controller**.

12. In the **Active Directory Domain Services Configuration Wizard**, on the **Deployment Configuration** page, ensure that **Add a domain controller to an existing domain** is selected, and then select **Next**.

13. On the **Domain Controller Options** page, ensure that **Domain Name System (DNS) server** and the **Global Catalog (GC)** are selected, enter **Pa55w.rd** in both text boxes, and then select **Next**.

14. On the **DNS Options** page, select **Next**.

15. On the **Additional Options** page, select **Next**.

16. On the **Paths** page, select **Next**.

17. On the **Review Options** page, select **Next**.

18. On the **Prerequisites Check** page, select **Install**.

    > **Note:** The server automatically restarts as part of the procedure.

19. After **SYD‑SVR1** restarts, sign in as **Contoso\\Administrator** with the password **Pa55w.rd**.

20. On the **Taskbar**, right-click the **Network** icon, and then select **Open Network and Internet settings**.

21. On the **Status** page, in the **Advanced network settings** section, select **Network and Sharing Center**.

22. In the **Network and Sharing Center** window, select the **PAC_WAN** hyperlink.

23. In the **PAC_WAN Status** window, select **Properties**.

24. In the **PAC_WAN Properties** dialog box, select **Internet Protocol Version 4 (TCP/IP4)**, and then select **Properties**.

25. In the **Internet Protocol Version 4 (TCP/IP4) Properties** dialog box, in the **Preferred DNS server** text box, type **172.16.19.20**, and in the **Alternate DNS server** text box, type **172.16.0.10**, and then select **OK**.

26. Select **Close** two times and then close the **Network and Sharing Center** and **Settings** windows.


### Task 3: Review resource records on SYD-SVR1

1. On **SYD-SVR1**, open **Server Manager**, select **Tools**, and then select **DNS**.

2. In the **DNS Manager** console, in the console tree, expand **SYD-SVR1**, expand **Forward Lookup Zones**, and then select the **Contoso.com** zone.

3. Right-click **Contoso.com**, and then select **Properties**.

4. In the **Contoso.com Properties** dialog box, select the **Start of Authority** tab. 

5. Ensure that **SYD-SVR1** shows as the **Primary server** and then select **Cancel**.

6. With the **Contoso.com** zone still selected, review the resource records in the details pane. 

   > All the resource records that displayed in the **Contoso.com** zone on **LON-DC1** also displays on **SYD-SVR1**.

7. In the console tree, right-click the **Contoso.com** zone, and then select **New Host (A or AAAA)**.

8. In the **New Host** window, in the **Name** text box, type **SYD-CL1**, in the **IP address** text box, type **172.16.19.150**, and then select **Add Host**.

9. In the **DNS** window, select **OK**, and then in the **New Host** window, select **Done**.

10. Switch to **LON-DC1**, and in the **DNS Manager**, select and then right-click the **Contoso.com** zone and then select **Refresh**. 

    > In the details pane, you should now see the **SYD-CL1** host record.

11. If the **SYD-CL1** record does not appear, perform the following actions on **LON-DC1**:

    - In **Server Manager**, in the **Tools** drop-down list, select **Active Directory Sites and Services**.

    - In the **Active Directory Sites and Services** window, in the console tree, expand **Sites**, expand **Default-First-Site-Name**, and then expand **Servers**.

    - Expand **LON-DC1**, and then select **NTDS Settings**.

    - In the details pane, right-click the replication link, and then select **Replicate Now**.

    - In the **Replicate Now** window, select **OK** and close Active Directory Site and Services.

12. Repeat step 10 above. The **SYD-CL1** resource record should display in the **Contoso.com** zone.

13. Close all open windows.


**Results:** After completing this exercise, you will have successfully integrated DNS with AD DS.