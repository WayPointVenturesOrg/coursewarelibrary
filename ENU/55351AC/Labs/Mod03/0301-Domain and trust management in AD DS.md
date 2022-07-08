# Lab: Domain and trust management in AD DS

## Lab scenario

Contoso Corporation has deployed a single Active Directory Domain Services (AD DS) domain with all domain controllers (DCs) located in its London datacenter. As the company has grown and added branch offices with a large numbers of users, it's become increasingly apparent that the current AD DS environment doesn't meet company requirements. The network team is concerned about the amount of AD DS–related network traffic that is crossing wide area network (WAN) links, which are becoming highly utilized.

The company has also become increasingly integrated with partner organizations, some of which need access to shared resources and applications that are located on the Contoso internal network. The Security department at Contoso wants to ensure that access for these external users is as secure as possible. 

As one of Contoso's senior network administrators, you're responsible for implementing an AD DS infrastructure that meets company requirements and for planning an AD DS domain and forest deployment that provides optimal services for internal and external users while maintaining security requirements.

## Exercise 1: Implement forest trusts

### Scenario

Contoso Corporation is working on several projects with a partner organization named Trey Research. To simplify enabling access to resources in the two organizations, they've deployed a WAN between London and Munich, where Trey Research is located. You now must implement and validate a forest trust between the two forests and configure the trust to allow access to only selected servers in London.

The main tasks for this exercise are as follows:

1. Configure stub zones for Domain Name System (DNS) name resolution.

2. Configure a forest trust with selective authentication.

3. Configure a server for selective authentication.


### Task 1: Configure stub zones for DNS name resolution

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager opens automatically.

2. In **Server Manager**, select the **Tools** menu, and then select **DNS**.

3. In the **DNS tree** pane, expand **LON-DC1**, select and right-click or access the context menu for **Forward Lookup Zones**, and then select **New Zone**.

4. In the **New Zone Wizard**, select **Next**.

5. On the **Zone Type** page, select **Stub zone**, and then select **Next**.

6. On the **Active Directory Zone Replication Scope** page, select **To all DNS servers running on domain controllers in this forest: Contoso.com**, and then select **Next**.

7. In the **Zone name** text box, enter **treyresearch.net**, and then select **Next**.

8. On the **Master DNS Servers** page, select **`<Click here to add an IP Address or DNS Name>`**, enter **172.16.10.10**, select Enter, and then select **Next**.

9. On the **Completing the New Zone Wizard** page, select **Next**, and then select **Finish**.

10. Expand **Forward Lookup Zones**, select and right-click or access the context menu for the new stub zone **treyresearch.net**, and then select **Transfer from Master**.

11. Right-click or access the context menu for **treyresearch.net**, and then select **Refresh**.

12. Confirm that the **treyresearch.net** stub zone contains records, and then close **DNS Manager**.

13. Switch to **TREY-DC1**.

14. Sign in as **TreyResearch\\Administrator** with the password of **Pa55w.rd**.

15. In **Server Manager**, select the **Tools** menu, and then select **DNS**.

16. In the tree pane, expand **TREY-DC1**, select and right-click or access the context menu for **Forward Lookup Zones**, and then select **New Zone**.

17. In the **New Zone Wizard**, select **Next**.

18. On the **Zone Type** page, select **Stub zone**, and then select **Next**.

19. On the **Active Directory Zone Replication Scope** page, select **To all DNS servers running on domain controllers in this forest: TreyResearch.net**, and then select **Next**.

20. In the **Zone name** text box, enter **Contoso.com**, and then select **Next**.

21. On the **Master DNS Servers** page, select **`<Click here to add an IP Address or DNS Name>`**, enter **172.16.0.10**, select Enter, and then select **Next**.

22. On the **Completing the New Zone Wizard** page, select **Next**, and then select **Finish**.

23. Expand **Forward Lookup Zones**, select and right-click or access the context menu for the new stub zone **Contoso.com**, and then select **Transfer from Master**.

24. Right-click or access the context menu for **Contoso.com**, and then select **Refresh**.

25. Confirm that the **Contoso.com** stub zone contains records.

26. Close **DNS Manager**.


### Task 2: Configure a forest trust with selective authentication

1. On **LON-DC1**, on the **Tools** menu, select **Active Directory Domain and Trusts**.

2. In the **Active Directory Domains and Trusts** console, right-click or access the context menu for **Contoso.com**, and then select **Properties**.

3. In the **Contoso.com Properties** dialog box, select the **Trusts** tab, and then select **New Trust**.

4. On the **New Trust Wizard** page, select **Next**.

5. On the **Trust Name** page, in the **Name** text box, enter **treyresearch.net**, and then select **Next**.

6. On the **Trust Type** page, select **Forest trust**, and then select **Next**.

7. On the **Direction of Trust** page, select **One-way: outgoing**, and then select **Next**.

8. On the **Sides of Trust** page, select **Both this domain and the specified domain**, and then select **Next**.

9. On the **User Name and Password** page, enter **Administrator** as the user name and **Pa55w.rd** as the password in the appropriate boxes, and then select **Next**.

10. On the **Outgoing Trust Authentication Level-Local Forest** page, select **Selective authentication**, and then select **Next**.

11. On the **Trust Selections Complete** page, select **Next**.

12. On the **Trust Creation Complete** page, select **Next**.

13. On the **Confirm Outgoing Trust** page, select **Next**.

14. On the **Completing the New Trust Wizard** page, select **Finish**.

15. In the **Contoso.com Properties** dialog box, select the **Trusts** tab.

16. On the **Trusts** tab, under **Domains trusted by this domain (outgoing trusts)**, select **treyresearch.net**, and then select **Properties**.

17. In the **treyresearch.net Properties** dialog box, select **Validate**.

18. Review the “The trust has been validated. It is in place and active” message that displays, select **OK**, and then at the prompt, select **No**.

19. In the **TreyResearch.net Properties** dialog box, select **OK**, and then select **OK** in the **Contoso.com Properties** dialog box.

20. Close **Active Directory Domains and Trusts**.


### Task 3: Configure a server for selective authentication

1. On **LON-DC1**, in **Server Manager**, on the **Tools** menu, select **Active Directory Users and Computers**.

2. In the **Active Directory Users and Computers** console, on the **View** menu, select **Advanced Features**.

3. Expand **Contoso.com**, and then select **Computers**.

4. Right-click or access the context menu for **LON-SVR2**, and then select **Properties**.

5. In the **LON-SVR2 Properties** dialog box, select the **Security** tab, and then select **Add**.

6. On the **Select Users, Computers, Service Accounts, or Groups** page, select **Locations**.

7. Select **TreyResearch.net**, and then select **OK**.

8. In the **Enter the object name to select (examples:)** text box, enter **IT**, and then select **Check Names**. 
9. When prompted for credentials, enter **TreyResearch\\Administrator** with the password **Pa55w.rd**, and then select **OK**.
10. On the **Select Users, Computers, Service Accounts, or Groups** page, select **OK**.

11. In the **LON-SVR2 Properties** window, ensure that **IT (TreyResearch\\IT)** is highlighted, select the **Allow** check box that's in line with **Allowed to authenticate**, and then select **OK**.

12. Switch to **LON-SVR2**.
13. Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password of **Pa55w.rd**.
14. On the taskbar, select the **File Explorer** icon.

15. In the **File Explorer** window, expand **This PC**, and then select **Local Disk (C)**.

16. Right-click or access the context menu in the details pane, select **New**, and then select **Folder**.

17. In the **Name** text box, enter **IT-Data**, and then select Enter.

18. Right-click or access the context menu for **IT-Data**, and then select **Properties**.

19. In the **IT-Data Properties** dialog box, select the **Sharing** tab, and then select **Advanced Sharing**.

20. In the **Advanced Sharing** dialog box, select **Share this folder**, and then select **Permissions**.

21. In the **Permissions for IT-Data** dialog box, select **Add**.

22. On the **Select Users, Computers, Service Accounts, or Groups** page, select **Locations**.

23. Select **TreyResearch.net**, and then select **OK**.

24. In the **Enter the object name to select (examples:)** text box, enter **IT**, and then select **Check Names**. 
25. When prompted for credentials, enter **TreyResearch\\Administrator** with the password **Pa55w.rd**, and then select **OK**.
26. On the **Select Users, Computers, Service Accounts, or Groups** page, select **OK**.

27. In the **Permissions for IT-Data** dialog box, select **OK**.

28. In the **Advanced Sharing** dialog box, select **OK**.

29. Switch to **TREY-DC1**.

30. Sign out of TREY-DC1 and then sign back in to **TREY-DC1** as **TreyResearch\\Abbi** with the password **Pa55w.rd**.

31. Select **Start**, enter **\\\\LON-SVR2.Contoso.com\\IT-Data**, and then select Enter. The folder opens.
32. Sign out of TREY-DC1.

**Results:** After completing this exercise, you'll have successfully implemented forest trusts.

## Exercise 2: Implement child domains in AD DS

### Scenario

Contoso Corporation has decided to deploy a new child domain in the Contoso.com forest for the North American region. The first DC will deploy in Toronto, and the domain name will be Na.Contoso.com. You need to configure and install the new DC.

The main tasks for this exercise are as follows:

1. Install a DC in a child domain.

2. Verify the default trust configuration.



### Task 1: Install a domain controller in a child domain

1. Sign in to **TOR-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

3. On the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, confirm that the **Role-based or feature-based installation** option is selected, and then select **Next**.

5. On the **Select destination server** page, ensure that the **Select a server from the server pool** option is selected and that **TOR-DC1.Contoso.com** is highlighted, and then select **Next**.

6. On the **Select server roles** page, select **Active Directory Domain Services**.

7. On the **Add features that are required for Active Directory Domain Services?** page, select **Add Features**.

8. On the **Select server roles** page, select **Next**.

9. On the **Select features** page, select **Next**.

10. On the **Active Directory Domain Services** page, select **Next**.

11. On the **Confirm installation selections** page, select **Install**. 

12. After the Active Directory Domain Services (AD DS) binaries have installed, select the **Promote this server to a domain controller** link.

13. In the **Deployment Configuration** window, select **Add a new domain to an existing forest**.

14. Verify that **Select domain type** is set to **Child Domain** and that **Parent domain name** is set to **Contoso.com**.

15. In the **New domain name** text box, enter **na**.

16. Confirm that **Supply the credentials to perform this operation** is set to **Contoso\Administrator (Current user)**, and then select **Next**.

    > **Note:** If the credentials are not set to **Contoso\\Administrator**, use the **Change** button to enter the credentials **Contoso\\Administrator** with the password **Pa55w.rd**.

17. In the **Domain Controller Options** window, ensure that **Domain functional level** is set to **Windows Server 2016**.

18. Ensure that both the **Domain Name system (DNS) server** and **Global Catalog (GC)** check boxes are selected.

19. Confirm that **Site name:** is set to **Default-First-Site-Name**.

20. Under **Type the Directory Services Restore Mode (DSRM) password**, enter **Pa55w.rd** in both text boxes, and then select **Next**.

21. On the **DNS Options** page, select **Next**.

22. On the **Additional Options** page, select **Next**.

23. On the **Paths** page, select **Next**.

24. On the **Review Options** page, select **Next**.

25. On the **Prerequisites Check** page, confirm that there are no issues, and then select **Install**.

    > **Note:** If you receive a warning that indicates that “Windows Server 2016 DCs have a default for the security setting named ‘Allow cryptography algorithms compatible with Windows NT 4.0’”, you may safely ignore it.

26. After the configuration completes, the server restarts automatically.


### Task 2: Verify the default trust configuration

1. Sign in to **TOR-DC1** as **NA\\Administrator** with the password **Pa55w.rd**.

2. Select **Start**, and then select **Server Manager**. 

3. In **Server Manager**, on the **Tools** menu, select **Active Directory Domains and Trusts**.

4. 
   In the **Active Directory Domains and Trusts** console, expand **Contoso.com**, right-click or access the context menu for **na.Contoso.com**, and then select **Properties**.

5. In the **na.Contoso.com Properties** dialog box, select the **Trusts** tab, in the **Domains trusted by this domain (outgoing trusts)** text box, select **Contoso.com**, and then select **Properties**.

6. In the **Contoso.com Properties** dialog box, select **Validate**, and then select **Yes, validate the incoming trust**.

7. In the **User name** text box, enter **administrator**, in the **Password** text box, enter **Pa55w.rd**, and then select **OK**.

8. When the “The trust has been validated. It is in place and active” message appears, select **OK**.

9. Select **OK** twice to close the **Contoso.com Properties** dialog box.


**Results**: After completing this exercise, you will have successfully implemented a child domain in AD DS.
