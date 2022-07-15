# Lab: Securing AD DS

## Lab scenario

The security team at Contoso Corporation has been examining possible security issues in the organization, focusing on Active Directory Domain Services (AD DS). The security team is particularly concerned with AD DS authentication and security of branch-office domain controllers (DCs).

You need to improve security and monitoring of authentication against the enterprise’s AD DS domain. Contoso has instituted a new password policy, and you need to enforce it for all user accounts and develop a more-stringent password policy for security-sensitive administrative accounts. It's also important that you implement an appropriate audit trail to help monitor authentication attempts within AD DS. 

The second part of your assignment includes deploying and configuring read-only domain controllers (RODCs) to support AD DS authentication within a branch office. Lastly, you need to evaluate the usage of a group managed service account (gMSA) by deploying it to the test server.

## Exercise 1: Implement security policies for accounts, passwords, and administrative groups

### Scenario

Contoso management has indicated that it's important that all management processes are as secure as possible, to help prevent a security breach. The company’s security and management teams have identified business requirements with respect to account logons and password security. In this exercise, you'll define and implement the Group Policy settings to meet the company’s requirements.

#### Supporting documentation

##### Contoso GPO strategy proposal**: **Requirements overview

Contoso has identified the following requirements regarding account logon and password policies:

- All users must use a password that's at least eight characters long. For IT administrators, the minimum length must be 10 characters.

- Passwords for all users must be complex and stored securely.

- All users, except IT administrators, must change their password every 60 days or less.

- IT administrators must change their password every 30 days or less.

- If users enter the wrong password more than five times within 20 minutes, their accounts must be locked. For normal users, accounts are unlocked automatically after one hour.

- For IT administrators, accounts must be locked after three incorrect password attempts. IT administrator accounts are never unlocked automatically. An administrator must unlock the account. IT administrator accounts include all members of the IT group and the Domain Admins group.

- No users should be able to use at least 10 of their previous passwords.

- The membership list for the local Administrators group on all member servers must be limited to only the local Administrator account, the Domain Admins group, and the IT group.

- The Domain Admins group must include only the Administrator account.

- The Enterprise Admins and Schema Admins groups must be empty during normal operations. Users must be added explicitly to these groups only when they need to perform tasks that require this level of administrative rights.

- Other built-in groups, such as Account Operators and Server Operators, should contain no members. If users are added to one of these groups, they should be removed from the group automatically.

- All changes made to user objects and security groups in AD DS must be audited.

##### Proposals

**Password policies and account lockout proposal**

| Setting                                     | Configuration for all users | Configuration for IT administrators |
| ------------------------------------------- | --------------------------- | ----------------------------------- |
| Enforce password history                    |                             |                                     |
| Maximum password age                        |                             |                                     |
| Minimum password age                        |                             |                                     |
| Minimum password length                     |                             |                                     |
| Passwords must meet complexity requirements |                             |                                     |

**GPO strategy proposal**

| Setting                                    | Configuration for all users | Configuration for IT administrators |
| ------------------------------------------ | --------------------------- | ----------------------------------- |
| Store password using reversible encryption |                             |                                     |
| Account lockout duration                   |                             |                                     |
| Account lockout threshold                  |                             |                                     |
| Reset account lockout counter after        |                             |                                     |

1. How can you configure IT administrators to have different password and account lockout settings than regular users?

2. How can you identify IT administrators in terms of more restricted password and account lockout settings?

3. How can you meet the requirement to limit the membership list for the local Administrators groups on all member servers to only the local Administrator account, the Domain Admins group, and the IT group?

4. How can you meet the requirement that the Domain Admins group must include only the Administrator account and that the Enterprise Admins and Schema Admins groups must be empty during normal operations?

5. How can you meet the requirement that other built-in groups, such as Account Operators and Server Operators, must not contain members?

6. How can you meet the requirement that you must audit all changes to AD DS?


The main tasks for this exercise are as follows:

1. Identify the required settings.

2. Configure password settings for all users.

3. Configure a Password Settings object (PSO) for IT administrators.

4. Implement administrative security policies.

5. Implement administrative auditing.

### Task 1: Identify the required settings

1. Read the documentation provided.

2. Complete the table of settings according to Contoso Corporation requirements.

| **Setting**                                  | **Configuration for all users** | **Configuration for IT administrators** |
| -------------------------------------------- | ------------------------------- | --------------------------------------- |
| Enforce password history                     | 10                              | 10                                      |
| Maximum password age                         | 60 days                         | 30 days                                 |
| Minimum password age                         | 1 day                           | 1 day                                   |
| Minimum password length                      | 8 characters                    | 10 characters                           |
| Passwords must meet complexity requirements  | True                            | True                                    |
| Store password using reversible encryption   | False                           | False                                   |
| Account lockout duration                     | 1 hour                          | Administrator must unlock               |
| Account lockout threshold                    | 5                               | 3                                       |
| Reset account lockout counter after          | 20 minutes                      | 20 minutes                              |

3. Answer the questions from the **Proposals** document.

- How can you configure that IT administrators have different password and account lockout settings than regular users?

  > **Answer:** Use the Default Domain Policy, which applies to all users, and create a fine-grained password policy object that applies only to the required administrative groups.

- How can you identify IT administrators in terms of more restricted password and account lockout settings?

  > **Answer:** The administrative password and account lockout settings should apply to the IT group and the Domain Admins group.

- How can you meet the requirement to limit the membership list for the local Administrators groups on all member servers to only the local Administrator account, the Domain Admins group, and the IT group?

  > **Answer:** Ensure that you have domain member servers in the same OU hierarchy. Assign a policy to it, and then use the restricted groups feature to restrict the local Administrators group forcefully to contain only administrators, the Domain Admins group, and the IT group.

- How can you meet the requirement that the Domain Admins group must include only the Administrator account and that the Enterprise Admins and Schema Admins groups must be empty during normal operations?

  > **Answer:** You can't configure groups other than local groups with the restricted groups feature. For Domain Admins, Enterprise Admins, and Schema Admins, you must configure the group membership manually and audit their changes.

- How can you meet the requirement that other built-in groups, such as Account Operators and Server Operators, must not contain members?

  > **Answer:** Use the restricted groups feature.

- How can you meet the requirement that you must audit all changes to users or groups in AD DS?

  > **Answer:** Configure advanced auditing policies to audit changes to directory services.

### Task 2: Configure password settings for all users

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > **Server Manager** opens automatically.

2. From **Server Manager**, select **Tools**, and then select **Group Policy Management**.

3. In the **Group Policy Management** console, in the navigation pane, expand **Forest: Contoso.com\\Domains\\Contoso.com\\Group Policy Objects**, and then select the **Default Domain Policy**.

4. Right-click or access the context menu for **Default Domain Policy**, and then select **Edit**.

5. In the **Group Policy Management Editor**, in the navigation pane, expand **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Account Policies**, and then select **Password Policy**.

6. In the details pane, open **Enforce password history**.

7. In the **Enforce password history Properties** dialog box, configure the following settings, and then select **OK**:

   - **Define this policy setting**: selected
   - **Keep password history for:** **10** passwords remembered

8. Open **Maximum password age**.

9. In the **Maximum password age Properties** dialog box, configure the following settings, and then select **OK**.

   - **Define this policy setting**: selected
   - **Password will expire in**: **60** days

10. Open **Minimum password age**.

11. In the **Minimum password age Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting**: selected
    - **Password can be changed after:** **1** days

12. Open **Minimum password length**.

13. In the **Minimum password length Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting:** selected
    - **Password must be at least:** **8** characters

14. Open **Password must meet complexity requirements**.

15. In the **Password must meet complexity requirements Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting:** selected
    - **Enabled:** selected

16. Open **Store passwords using reversible encryption**.

17. In the **Store passwords using reversible encryption Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting:** selected
    - **Disabled:** selected

18. In the navigation pane, select **Account Lockout Policy**.

19. In the details pane, open **Account lockout duration**.

20. In the **Account lockout duration Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting:** selected
    - **Account is locked out for:**  **60** minutes

21. In the **Suggested Value Changes** dialog box, select **OK**.

22. Open **Account lockout threshold**.

23. In the **Account lockout threshold Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting:** selected
    - **Account will lock out after:** **5** invalid logon attempts 

24. Open **Reset account lockout counter after**.

25. In the **Reset account lockout counter after Properties** dialog box, configure the following settings, and then select **OK**.

    - **Define this policy setting:** selected
    - **Reset account lockout counter after:** **20** minutes

26. Close the **Group Policy Management Editor** and the **Group Policy Management** console.


### Task 3: Configure a PSO for IT administrators

1. On **LON-DC1**, from **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.

2. In **Active Directory Administrative Center**, in the navigation pane, select **Contoso (local)**.

3. In the details pane, scroll to and open **System**, and then open **Password Settings Container**.

4. In the **Tasks** pane, in the **Password Settings Container** section, select **New**, and then select **Password Settings**.

5. In the **Create Password Settings** dialog box, in the **Password Settings** section, in the **Name** field, enter **Contoso Administrators Password Settings**.

6. In the **Precedence** field, enter **10**, and then ensure that **Enforce minimum password length** is selected.

7. In the **Minimum password length (characters)** text box, enter **10**, and then ensure that **Enforce password history** is selected.

8. In the **Number of passwords remembered** text box, enter **10**, ensure that **Password must meet complexity requirements** is selected, and then ensure that **Store password using reversible encryption** isn't selected.

9. Under **Password age options**, ensure that **Enforce minimum password age** is selected.

10. In the **User cannot change the password within (days)** text box, enter **1**, and then ensure that the **Enforce maximum password age** check box is selected.

11. In the **User must change the password after (days)** text box, enter **30**, and then select the **Enforce account lockout policy** check box.

12. In the **Number of failed logon attempts allowed** text box, enter **3**.

13. In the **Reset failed logon attempts count after (mins)** text box, enter **20**, and then select **Account will be locked out,** **Until an administrator manually unlocks the account**.

14. In the **Directly Applies To** section, select **Add**.

15. In the **Select Users or Groups** dialog box, under **Enter the object names to select**, enter **IT**, and then select **Check Names**.

16. The **Name Not Found** dialog box appears because IT is not a global group but a Universal Group. select **Cancel**.

17. Switch to **Server Manager**, select **Tools**, and then select **Windows PowerShell**.

18. At the Windows PowerShell command prompt, enter the following command, and then select Enter:

    ```
    Get-ADGroup IT
    ```

    > Verify that the IT group has a group scope of **Universal**.
    >

19. At the command prompt, enter the following command, and then select Enter:

    ```
    Set-ADGroup IT –GroupScope Global
    ```

20. Switch back to the **Create Password Settings: Contoso Administrative Password Settings** dialog box.

21. In the **Select Users or Groups** dialog box, under **Enter the object names to select**, enter **IT; Domain Admins**, and then select **Check Names**. The names are both resolved. Select **OK**.

22. Select **OK** to close the **Create Password Settings: Contoso Administrative Password Settings** dialog box and create the PSO.

23. In **Active Directory Administrative Center**, in the navigation pane, select **Overview**.

24. In the details pane, in the **Global Search** box, enter **Tonnie Thomsen**, and then select Enter. The user object Tonnie Thomsen is found.

25. In the **Tasks** pane, select **View resultant password settings**. Note that the **Contoso Administrative Password Settings** PSO applies, because Tonnie is in the IT group, and then select **Cancel**.

26. In the **Global Search** box, enter **Susan Kemp**, and then select Enter.

27. In the **Tasks** pane, select **View resultant password settings**. Note that no resultant fine-grained password settings apply, because Susan isn't in the IT group and the Default Domain Policies settings apply to her, and then select **OK**.

28. Close **Active Directory Administrative Center** and **Windows PowerShell**.


### Task 4: Implement administrative security policies

1. On **LON-DC1**, from **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.

2. In **Active Directory Administrative Center**, in the navigation pane, select **Contoso (local)**.

3. 
   In the **Tasks** pane, in the **Contoso (local)** section, select **New**, and then select **Organizational Unit**.

4. In the **Create Organizational Unit** dialog box, in the **Name** field, enter **Contoso Servers**, and then select **OK**.

5. In **Active Directory Administrative Center**, in the details pane, open **Computers**, select **LON-SVR1**, and then select and hold the Shift key and select **LON-SVR2**. Both servers now are selected.

6. In the **Tasks** pane, in the **2 items selected** section, select **Move**.

7. In the **Move** dialog box, select **Contoso Servers**, and then select **OK**.

8. Close **Active Directory Administrative Center**.

9. In **Server Manager**, select **Tools**, and then select **Group Policy Management**.

10. In the **Group Policy Management** console, under **Forests: Contoso.com\\Domains\\Contoso.com**, locate and select **Contoso Servers**. 

11. Right-click or access the context menu for **Contoso Servers**, and then select **Create a GPO in this domain, and Link it here**.

12. In the **New GPO** dialog box, in the **Name** field, enter **Restricted Administrators on Member Servers**, and then select **OK**.

13. In the details pane, right-click or access the context menu for the **Restricted Administrators on Member Servers** GPO, and then select **Edit**.

14. In the **Group Policy Management Editor** window, expand **Computer Configuration\\Policies\\Windows Settings\\Security Settings**, and then select **Restricted Groups**.

15. Right-click or access the context menu for **Restricted Groups**, and then select **Add Group**.

16. In the **Add Group** dialog box, in the **Group** field, enter **Administrators**, and then select **OK**.

17. In the **Administrators Properties** dialog box, under **Members of this group**, select **Add**.

18. In the **Add Member** dialog box, select **Browse**.

19. In the **Select Users, Service Accounts or Groups** dialog box, in the **Enter the object names to select** text box, enter **Domain Admins; IT**, select **Check Names**, and then select **OK**.

20. In the **Add Member** dialog box, in the **Members of this group** section, add **;Administrator** to the string, and then select **OK**.

21. Verify that the **Administrator Properties** dialog box now depicts the following in **Members of this group**, and then select **OK**:

    - **Contoso\Domain Admins**
    - **Contoso\IT**
    - **Administrator**

22. Close the **Group Policy Management Editor** window.

23. Switch to **LON-SVR1**.

24. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

25. On **LON-SVR1**, select **Start**, enter **cmd**, and then select **Command Prompt**.

26. In the **Administrator: Command Prompt** window, enter the following command, and then select Enter:

    ```
    gpupdate /force
    ```

    > Wait until the command updates the Computer Policy and the User Policy.
    >

27. On **LON-SVR1**, select **Start**, and then select **Server Manager**. 

28. From **Server Manager**, select **Tools**, and then select **Computer Management**.

29. In **Computer Management**, expand **System Tools\\Local Users and Groups**, and then select **Groups**.

30. Open **Administrators**, and verify that **Contoso\\Domain Admins**, **Contoso\\IT**, and the local **Administrator** are members of this group.

31. Close all open windows except for Server Manager.

32. Switch back to **LON-DC1**, and then switch to Group Policy Management.

33. In the **Group Policy Management** console, expand **Domain Controllers**, right-click or access the context menu for the **Default Domain Controllers Policy** link, and then select **Edit**.

34. In the **Group Policy Management Editor** window, expand **Computer Configuration\\Policies\\Windows Settings\\Security Settings**, and then select **Restricted Groups**.

35. Right-click or access the context menu for **Restricted Groups**, and then select **Add Group**.

36. In the **Add Group** dialog box, in the **Group** field, enter **Server Operators**, and then select **OK**.

37. In the **Server Operators Properties** dialog box, keep the default settings of **This group should contain no members**, and then select **OK**.

38. Repeat the steps 35 to 37 for the **Account Operators** group.

39. Close the **Group Policy Management Editor** window and the **Group Policy Management** console.


### Task 5: Implement administrative auditing

1. On **LON-DC1**, from **Server Manager**, select **Tools**, and then select **Group Policy Management**.

2. In the **Group Policy Management** console, expand **Forest: Contoso.com\\Domains\\Contoso.com\\Group Policy Objects**, and then select the **Default Domain Controllers Policy**.

3. Right-click or access the context menu for **Default Domain Controllers Policy**, and then select **Edit**.

4. In the **Group Policy Management Editor** window, expand **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Advanced Audit Policy Configuration\\Audit Policies**, and then select **DS Access**.

5. In the details pane, open **Audit Directory Service Changes**.

6. In the **Audit Directory Service Changes Properties** dialog box, select **Configure the following audit events**, select the **Success** check box, and then select **OK**.

7. In the navigation pane, navigate to **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Advanced Audit Policy Configuration\\Audit Policies**, and then select **Account Management**.

8. In the details pane, open **Audit Security Group Management**.

9. In the **Audit Security Group Management** **Properties** dialog box, select **Configure the following audit events**, select the **Success** check box, and then select **OK**.

10. In the navigation pane, navigate to **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Local Policies**, select **Security Options**, and then open **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings**.

11. In the **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings** dialog box, select **Define this policy setting**, ensure that **Enabled** is selected, and then select **OK**.

12. Close the **Group Policy Management Editor** and the **Group Policy Management** console.

13. On **LON-DC1**, select **Start**, enter **cmd**, and then select **Command Prompt**.

14. In the **Administrator: Command Prompt** window, enter the following command, and then select Enter: 

    ```
    gpupdate /force
    ```

15. From **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

16. In **Active Directory Users and Computers**, from the **View** menu, enable the **Advanced Features** view.

17. In the navigation pane, select **Contoso.com**, right-click or access the context menu for **Contoso.com**, and then select **Properties**.

18. In the **Contoso.com Properties** dialog box, on the **Security** tab, select **Advanced**.

19. In the **Advanced Security Settings for Contoso** dialog box, on the **Auditing** tab, open the **Success** auditing entry for **Everyone** with **Special** access, which applies to **This object only**.

20. In the **Auditing Entry for Contoso** dialog box, in the **Applies to** drop-down list box, select **This object and all descendent objects**.

21. Select **OK** three times to close all open dialog boxes.

22. In **Active Directory Users and Computers**, in the navigation pane, if necessary, expand **Contoso.com**, and then select to select **Users**.

23. In the details pane, open **Domain Admins**.

24. In the **Domain Admins Properties** dialog box, select the **Members** tab, and then select **Add**.

25. In the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box, in the **Enter the object names to select** text box, enter **Tonnie**, select **Check Names**, and then select **OK**.

26. In **Active Directory Users and Computers**, in the navigation pane, select **Marketing**.

27. In the details pane, open **Billie Vester**.

28. In the **Billie Vester Properties** dialog box, on the **Address** tab, in the **City** text box, select **Seattle**, enter **Birmingham**, and then select **OK**.

29. Close **Active Directory Users and Computers**.

30. In **Server Manager**, select **Tools**, and then select **Event Viewer**.

31. In **Event Viewer**, expand **Windows Logs**, and then select **Security**.

32. In the details pane, search for the most recent **Event ID** **4728**, and then open the event.

33. In the **Event Properties – Event 4728, Microsoft Windows security auditing** dialog box, you get the message “A member was added to a security-enabled global group.” 

    > You'll observe that Contoso\\Administrator invoked the change and that Contoso\\Tonnie was added to the Contoso\\Domain Admins group.

34. In **Event Viewer**, in the **Windows Logs\\Security Log** node, search for the two most recent **Event IDs** **5136**, and then open the older of the two events.

35. In the **Event Properties – Event 5136, Microsoft Windows security auditing** dialog box, you will observe the following message: “A directory service object was modified.” 

    > You'll observe that Contoso\\Administrator has modified the user object **cn=Billie Vester** and deleted the **Seattle** value. On the right side of the dialog box, select the Up Arrow to move to the next event.
    >
    > **Note:** In the **Event Properties** details page, notice that Contoso\\Administrator modified Billie Vester and added the **Birmingham** value.

36. Close all open windows except for **Server Manager**.


**Results:** After this exercise, you'll have identified and configured the security policies for Contoso.

## Exercise 2: Deploying and configuring an RODC

### Scenario

In this exercise, you'll configure the server **LON-SVR1** as an RODC in the branch office. To avoid travel costs, you decide to do the conversion remotely, working with a desktop-support technician and the branch’s only IT staff member. This user already has installed a Windows Server named **LON-SVR1**. You'll stage a delegated installation of an RODC so that this administrative user can complete the installation. After the deployment is complete, you'll configure a domain-wide password replication policy and the password replication policy specific to **LON-SVR1**.

The main tasks for this exercise are as follows:

1. Stage a delegated installation of an RODC.

2. Run the Active Directory Domain Services Installation Wizard on an RODC to complete the deployment process.

3. Configure the domain-wide password replication policy.

4. Create a group to manage password replication to the branch office RODC.

5. Evaluate the resultant password replication policy.

### Task 1: Stage a delegated installation of an RODC

#### Preparation

To prestage an RODC account, the computer name must not be in use in the domain. Therefore, you first need to remove **LON-SVR1** from the domain by performing the following steps:

1. On **LON-SVR1**, in **Server Manager**, select **Local Server**.

2. In the **Properties for LON-SVR1** section, select the domain **Contoso.com**.

3. In the **System Properties** dialog box, select **Change**.

4. In the **Computer Name/Domain Changes** dialog box, in the **Member of** section, select **Workgroup**, enter **MUNICH**, and then select **OK**.

5. In the **Computer Name/Domain Changes** dialog box, select **OK**.

6. In the **Computer Name/Domain Changes** dialog box, at the “Welcome to the MUNICH workgroup” message, select **OK**.

7. In the **Computer Name/Domain Changes** dialog box, at the “You must restart your computer to apply these changes” message, select **OK**.

8. In the **System Properties** dialog box, select **Close**.

9. In the **Microsoft Windows** dialog box, select **Restart Now**.

10. Sign in as **Administrator** with the password of **Pa55w.rd**.

11. Switch to **LON-DC1**. 
12. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.
13. In the navigation pane, expand **Contoso.com**, select **Contoso Servers**, right-click or access the context menu for **LON-SVR1**, and then select **Delete**.

14. In the **Active Directory Domain Services** dialog box, confirm the deletion by selecting **Yes**.

15. In the **Confirm Subtree Deletion** dialog box, select **Yes**.


#### Stage a delegated installation of an RODC

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Sites and Services**.

2. In **Active Directory Sites and Services**, in the navigation pane, select **Sites**. From the **Action** menu, select **New Site**.

3. In the **New Object – Site** dialog box, in the **Name** field, enter **Munich**, select the **DEFAULTIPSITELINK** site link object, and then select **OK**.

4. In the **Active Directory Domain Services** dialog box, select **OK**.

5. Switch to **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.

6. In **Active Directory Administrative Center**, in the navigation pane, select **Contoso (local)**, and then in the details pane, open the **Domain Controllers** OU.

7. In the **Tasks** pane, in the **Domain Controllers** section, select **Pre-create a Read-only domain controller account**.

8. In the **Active Directory Domain Services Installation Wizard**, on the **Welcome to the Active Directory Domain Services Installation Wizard** page, select **Next**.

9. On the **Network Credentials** page, select **Next**.

10. On the **Specify the Computer Name** page, enter the computer name **LON-SVR1**, and then select **Next**.

11. On the **Select a Site** page, select **Munich**, and then select **Next**.

12. On the **Additional Domain Controller Options** page, accept the default selections of **DNS Server** and **Global Catalog**, and then select **Next**.

13. On the **Delegation of RODC Installation and Administration** page, select **Set**.

14. In the **Select User or Group** dialog box, in the **Enter the object name to select** field, enter **Alberto**, and then select **Check Names**.

15. Verify that **Alberto Hermosilla** is resolved, and then select **OK**.

16. On the **Delegation of RODC Installation and Administration** page, select **Next**.

17. On the **Summary** page, review your selections, and then select **Next**.

18. On the **Completing the Active Directory Domain Services Installation Wizard** page, select **Finish**.


### Task 2: Run the Active Directory Domain Services Installation Wizard on an RODC to complete the deployment process

1. Switch to **LON-SVR1**. 

2. Open **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

3. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

4. On the **Select installation type** page, accept the default of **Role-based or feature-based installation**, and then select **Next**.

5. On the **Select destination server** page, accept the default with **LON-SVR1** being selected, and then select **Next**.

6. On the **Select server roles** page, in the **Roles** list, select **Active Directory Domain Services**.

7. In the **Add Roles and Features Wizard**, accept to install the features and management tools, select **Add Features**, and then select **Next**.

8. On the **Select features** page, select **Next**.

9. On the **Active Directory Domain Services** page, select **Next**.

10. On the **Confirm installation selections** page, select **Install**.

11. Wait until the role installs. You can select **Close** at any time, but monitor the Notification icon in **Server Manager**.

12. When the installation of the new role is finished, select the **Notification** icon.

13. In the **Post-deployment Configuration** message box, select **Promote this server to a domain controller**.

14. In the **Active Directory Domain Services Configuration Wizard**, on the **Deployment Configuration** page, leave the default to **Add a domain controller to an existing domain**.

15. In the **Supply the credentials to perform this operation** section, select **Change**.

16. In the **Windows Security** dialog box, enter the following credentials, and then select **OK**:

    - User name: **Contoso\Alberto**
    - Password: **Pa55w.rd**

17. Under **Specify the domain information for this operation**, select **Select**, select the domain **Contoso.com**, select **OK**, and then select **Next**.

    > You'll receive a notification that an RODC account that matches the server's name exists in the directory.
    >

18. On the **Domain Controller Options** page, accept the default to **Use existing RODC account**, in the **Password** and **Confirm password** fields, enter **Pa55w.rd**, and then select **Next**.

19. On the **Additional Options** page, accept the defaults, and then select **Next**.

20. On the **Paths** page, accept the defaults, and then select **Next**.

21. On the **Review Options** page, review your options, and then select **Next**.

22. After the prerequisites check has been performed, select **Install**.

    > **Note:** The computer will configure AD DS and restart, but you can proceed to the next task.

### Task 3: Configure the domain-wide password-replication policy

1. Switch to **LON-DC1**. 

2. In **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.

3. In Active Directory Administrative Center, in the navigation pane, select **Contoso (local)**.

4. In the details pane, open **IT**.

5. Locate the **IT** group, right-click or access the context menu for the group, and then select **Add to another group**.

6. In the **Select Groups** dialog box, in the **Enter the object names to select** text box, enter **denied**, and then select **Check Names**.

7. Verify that the name of the group is expanded to **Denied RODC Password Replication Group**, and then select **OK**.

   > **Note:** The members of the IT group have elevated permissions, so storing their password on an RODC would be a security risk. Therefore, you add the IT group to the global Deny List, which applies to every RODC in the domain.

8. Close the Active Directory Administrative Center.


### Task 4: Create a group to manage password replication to the branch office RODC

1. Switch to **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

2. In the navigation pane, expand **Contoso.com**, and then select **Users**.

3. On the **Action** menu, select **New**, and then select **Group**.

4. In the **New Object – Group** dialog box, enter the group name **Munich Allowed RODC Password Replication Group**, select **OK**, and then open the **Munich Allowed RODC Password Replication Group**.

5. On the **Members** tab, select **Add**.

6. In the **Select Users, Contacts, Computers, Services Accounts, or Groups** dialog box, in the **Enter the object names to select** text box, enter **Julia**, select **Check Names**, and then select **OK**.

7. In the **Munich Allowed RODC Password Replication Group Properties** dialog box, select **OK**.

8. Close **Active Directory Users and Computers**.

9. Open **Active Directory Administrative Center**, and then from the **Domain Controllers** OU, review the properties for **LON-SVR1**.

10. In the **Extensions** section, on the **Password Replication Policy** tab, select **Add**.

11. In the **Add Groups, Users and Computers** dialog box, select **Allow passwords for the account to replicate to this RODC**, and then select **OK**.

12. In the **Select Users, Computers, Service Accounts, or Groups** dialog box, in the **Enter the object names to select** text box, enter **Munich**, select **Check Names**, and then select **OK**.

13. In the **LON-SVR1** dialog box, select **OK** to close the dialog box.


### Task 5: Evaluate the resultant password replication policy

1. In **Active Directory Administrative Center**, in the **Tasks** pane, in the **LON-SVR1** section, select **Properties**.

2. In the properties of **LON-SVR1**, in the **Extensions** section, on the **Password Replication Policy** tab, select **Advanced**.

   > **Note:** Note that this dialog box depicts all accounts with passwords that are stored in the RODC.

3. Select **Accounts that have been authenticated to this Read-only Domain Controller**, and then note that this only depicts those accounts that have the permissions and already have been authenticated by this RODC.

4. Select the **Resultant Policy** tab, and then add **Julia Linares**. Notice that Julia Linares has a resultant policy of **Allow**.

5. Close all open windows except for Server Manager.


**Results**: After this exercise, you'll have deployed and configured an RODC.

## Exercise 3: Creating and associating a group MSA

### Scenario

You need to configure a group MSA to support a new web-based application that's being deployed. Using a group MSA will help maintain the password security requirements for the account.

The main tasks for this exercise are as follows:

1. Create and associate an MSA.

2. Install a group MSA.

### Task 1: Create and associate an MSA

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Active Directory Module for Windows PowerShell**.

2. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   Add-KdsRootKey –EffectiveTime ((get-date).addhours(-10))
   ```

3. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   New-ADServiceAccount –Name Webservice –DNSHostName LON-DC1 –PrincipalsAllowedToRetrieveManagedPassword LON-DC1$
   ```

4. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   Add-ADComputerServiceAccount –identity LON-DC1 –ServiceAccount Webservice
   ```

5. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   Get-ADServiceAccount -Filter *
   ```

   > Note the output of the command, and then ensure the newly-created account is listed.
   >

### Task 2: Install a group MSA

1. On **LON-DC1**, at the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   Install-ADServiceAccount –Identity Webservice
   ```

2. In **Server Manager**, select the **Tools** menu, and then select **Internet Information Services (IIS) Manager**.

3. Expand **LON-DC1 (Contoso\\Administrator)**, and then select **Application Pools**.

4. In the details pane, right-click or access the context menu for the **DefaultAppPool**, and then select **Advanced Settings**.

5. In the **Advanced Settings** dialog box, in the **Process Model** section, select **Identity**, and then select the **ellipsis** (…).

6. In the **Application Pool Identity** dialog box, select **Custom Account**, and then select **Set**.

7. In the **Set Credentials** dialog box, enter **Contoso\\Webservice$** in the **User name** field, and then select **OK** three times.

8. In the **Actions** pane, select **Stop** to stop the application pool.

9. Select **Start** to start the application pool.

10. Close **Internet Information Services (IIS) Manager**.


**Results**: After completing this exercise, you'll have configured a group MSA.
