---
lab:
    title: 'Lab: Implement identity services and Group Policy'
    module: 'Module 2: Windows Server identity services'
---

# Lab: Implement identity services and Group Policy

## Lab scenario

You are an administrator at Contoso Ltd. The company is expanding its business with several new locations. The Active Directory Domain Services (AD DS) Administration team is currently evaluating methods available in Windows Server for rapid and remote domain controller deployment. The team is also searching for a way to automate certain AD DS administrative tasks. Additionally, the team wants to establish configuration management based on Group Policy Objects (GPO) and enterprise certification authority (CA) hierarchy.

## Objectives

After completing this lab, you’ll be able to:

- Deploy a new domain controller on Server Core.

- Configure Group Policy.

- Deploy and use certificate services.

## Exercise 1: Deploy a new domain controller on Server Core

### Scenario

As a part of business restructuring, Contoso wants to deploy new domain controllers in remote sites with minimal engagement of IT in remote locations. You need to use DC deployment to deploy new domain controllers.

The main tasks for this exercise are as follows:

1. Deploy AD DS on a new Windows Server Core server.
1. Manage objects in AD DS.

### Task 1: Deploy AD DS on a new Windows Server Core server

1. Sign in to **LON-ADM1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

1. Select **Start**, and then select **Windows PowerShell ISE**.

1. At the command prompt in the Windows PowerShell command-line interface, enter the following command, and then select Enter:

    ```powershell
    Install-WindowsFeature –Name AD-Domain-Services –ComputerName LON-SVR1
    ```

    > The Active Directory Domain Services role installs on LON-SVR1. Wait until the installation completes.

1. Enter the following command to verify that the AD DS role is installed on **LON-SVR1**, and then select Enter:

   ```PowerShell
   Get-WindowsFeature –ComputerName LON-SVR1
   ```

1. In the output of the previous command, search for **Active Directory Domain Services**. Verify that this check box is selected. Search for **Remote Server Administration Tools**. Notice the **Role Administration Tools** node below it, and then notice the **AD DS and AD LDS Tools** node.

   > **Note**: Under the **AD DS and AD LDS Tools** node, only **Active Directory module for Windows PowerShell** has been installed and not the graphical tools, such as the Active Directory Administrative Center. If you centrally manage your servers, you will not usually need these on each server. If you want to install them, you must specify the AD DS tools by running the **Add-WindowsFeature** cmdlet with the **RSAT-ADDS** command name.

   > **Note**: You might need to wait a brief time after the installation process completes before verifying that the AD DS role has installed. If you do not observe the expected results from the **Get-WindowsFeature** command, you can try again after a few minutes.

1. Select **Start**, and then select **Server Manager**.

1. On **LON-ADM1**, in **Server Manager**, select the **All Servers** view.

     > Notice that LON-SVR1 has been added as a managed server to LON-ADM1. This server was added as part of the lab setup for this course. 

1. Select the **Notifications** flag symbol.

1. Note the post-deployment configuration of **LON-SVR1**, and then select the **Promote this server to a domain controller** link.

1. In the **Active Directory Domain Services Configuration Wizard**, on the **Deployment Configuration** page, under **Select the deployment operation**, verify that **Add a domain controller to an existing domain** is selected.

1. Ensure that the ```Contoso.com``` domain is specified, and then in the **Supply the credentials to perform this operation** section, select **Change**.

1. In the **Credentials for deployment operation** dialog box, in the **User name** box, enter **Contoso\\Administrator**, and then in the **Password** box, enter **Pa55w.rd**.

1. Select **OK**, and then select **Next**.

1. On the **Domain Controller Options** page, verify that the **Domain Name System (DNS) server** and **Global Catalog (GC)** check boxes are selected. Ensure that the **Read-only domain controller (RODC)** check box is cleared.

1. In the **Type the Directory Services Restore Mode (DSRM) password** section, enter and confirm the password **Pa55w.rd**, and then select **Next**.

1. On the **DNS Options** page, select **Next**.

1. On the **Additional Options** page, select **Next**.

1. On the **Paths** page, keep the default path settings for the **Database** folder, **Log files** folder, and **SYSVOL** folder, and then select **Next**.

1. On the **Review Options** page, select **View script** to open the generated Windows PowerShell script.

1. In Notepad, edit the generated Windows PowerShell script:

      - Delete the comment lines that begin with the number sign (**#**).
      - Remove the **Import-Module** line.
      - Remove the grave accents (**`**) at the end of each line.
      - Remove the line breaks.

1. Now the **Install-ADDSDomainController** command and all the parameters are on one line. Place the cursor in front of the line, and then, on the menu, select **Select All** to select the whole line. On the menu, select **Edit**, and then select **Copy**.

1. Switch to the **Active Directory Domain Services Configuration Wizard**, and then select **Cancel**.

1. When prompted for confirmation, select **Yes** to cancel the wizard.

1. Switch to the **Windows PowerShell ISE** window.

1. At the Windows PowerShell command prompt, enter the following command:

     ```PowerShell
     Invoke-Command –ComputerName LON-SVR1 { }
     ```

1. Place the cursor between the braces (**{ }**), and then paste the content of the copied script line from the clipboard. The whole line should now be as follows:

     ```PowerShell
     Invoke-Command –ComputerName LON-SVR1 {Install-ADDSDomainController -NoGlobalCatalog:\$false -CreateDnsDelegation:\$false -Credential (Get-Credential) -CriticalReplicationOnly:\$false -DatabasePath "C:\Windows\NTDS" -DomainName "Contoso.com" -InstallDns:\$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:\$false -SiteName "Default-First-Site-Name" -SysvolPath "C:\Windows\SYSVOL" -Force:\$true}
     ```

1. Select Enter to start the command.

1. In the **Windows PowerShell Credential Request** dialog box, enter **Contoso\\Administrator** in the **User name** box, enter **Pa55w.rd** in the **Password** box, and then select **OK**.

1. When prompted for the password, in the **SafeModeAdministratorPassword** text box, enter **Pa55w.rd**, and then select Enter.

1. When prompted for confirmation, in the **Confirm SafeModeAdministratorPassword** text box, enter **Pa55w.rd**, and then select Enter.

      > Wait until the command runs and the **Status Success** message is returned. The **LON-SVR1** virtual machine restarts.

1. Close Notepad without saving the file.

1. After **LON-SVR1** restarts, on **LON-ADM1**, switch to **Server Manager**, and on the left side, select the **AD DS** node and then select the **Refresh** button.

      > Note that **LON-SVR1** has been added as a server and that the warning notification has disappeared.

## Task 2: Manage objects in AD DS

1. On **LON-ADM1**, switch to **Windows PowerShell ISE**.
1. Create an OU called **Seattle** in the domain by running the following command:

   ```powershell
   New-ADOrganizationalUnit -Name:"Seattle" -Path:"DC=Contoso,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"LON-DC1.Contoso.com"
   ```

1. Create a user account for **Ty Carlson** in the **Seattle** OU by running the following command:

   ```powershell
   New-ADUser -Name Ty -DisplayName "Ty Carlson" -GivenName Ty -Surname Carlson -Path "ou=Seattle,dc=contoso,dc=com"
   ```

1. Set the password for the account by running the following command:

   ```powershell
   Set-ADAccountPassword Ty
   ```

1. When you receive a prompt for the current password, select Enter.
1. When you receive a prompt for the desired password, enter **Pa55w.rd**, and then select Enter.
1. When you receive a prompt to repeat the password, enter **Pa55w.rd**, and then select Enter.
1. To enable the account, run the following command:

   ```powershell
   Enable-ADAccount Ty
   ```

1. Test the account by switching to **LON-CL1**, and then sign in as **Ty** with the password **Pa55w.rd**.
1. After a successful sign-in, sign out of **LON-CL1**.
1. On **LON-ADM1**, in the **Administrator: Windows PowerShell ISE** window, run the following command:

    ```powershell
    New-ADGroup SeattleBranchUsers -Path "ou=Seattle,dc=contoso,dc=com" -GroupScope Global -GroupCategory Security
    ```

1. In the **Administrator: Windows PowerShell ISE** window, run the following command:

    ```powershell
    Add-ADGroupMember SeattleBranchUsers -Members Ty
    ```

1. Confirm that the user is in the group by running the following command:

    ```powershell
    Get-ADGroupMember SeattleBranchUsers
    ```

**Results**: After this exercise, you should have successfully created a new domain controller and managed objects in AD DS.

## Exercise 2: Configure Group Policy

### Scenario

You need to create a Group Policy Object (GPO) named **CONTOSO Standards**. This GPO will provide a domain-wide setting to prevent access to registry editing tools, set the screen saver timeout value, and password protect the screensaver. You will also configure the GPO to allow **Remote Event Log Management** and **Windows Management Instrumentation (WMI)** through Windows Defender Firewall.

The main tasks for this exercise are as follows:

1. Create and edit a GPO.
1. Link the GPO.
1. Review the effects of the GPO’s settings.
1. Create and link the required GPOs.
1. Verify the order of precedence.
1. Configure the scope of a GPO with security filtering.
1. Verify the application of settings.

### Task 1: Create and edit a GPO

1. On **LON-ADM1**, from Server Manager, select **Tools**, and then select **Group Policy Management**.
2. If necessary, switch to the **Group Policy Management** window.
3. In the **Group Policy Management** console, on the navigation pane, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, and then select the **Group Policy Objects** container.
4. On the navigation pane, right-click or access the context menu for the **Group Policy Objects** container, and then select **New**.
5. In the **Name** text box, enter **CONTOSO Standards**, and then select **OK**.
6. In the details pane, right-click or access the context menu for the **CONTOSO Standards** GPO, and then select **Edit**.
7. In the **Group Policy Management Editor** window, on the navigation pane, expand **User Configuration**, expand **Policies**, expand **Administrative Templates**, and then select **System**.
8. Open the **Prevent access to registry editing tools** policy setting.
9. In the **Prevent access to registry editing tools** dialog box, select **Enabled**, and then select **OK**.
10. On the navigation pane, expand **User** **Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Control Panel**, and then select **Personalization**.
11. On the **details** pane, open the **Screen saver timeout** policy setting.
12. In the **Screen saver timeout** dialog box, select **Enabled**. In the **Seconds** text box, enter **600**, and then select **OK**. 
13. Open the **Password protect the screen saver** policy setting.
14. In the **Password protect the screen saver** dialog box, select **Enabled**, and then select **OK**.
15. On the navigation pane, expand **Computer Configuration**, expand **Policies**, expand **Windows Settings**, expand **Security Settings**, expand **Windows Defender Firewall with Advanced Security** and then expand **Windows Defender Firewall with Advanced Security** and then select **Inbound Rules**.
16. Right-click or access the context menu for **Inbound Rules** and then select **New Rule**.
17. On the **Rule Type** page, select **Predefined**, and then in the drop-down menu select **Remote Event Log Management**. Select **Next**.
18. On the **Predefined Rules** page, select **Next**.
19. On the **Action** page, select **Allow the connection**, and then select **Finish**.
20. Right-click or access the context menu for **Inbound Rules** and then select **New Rule**.
21. On the **Rule Type** page, select **Predefined**, and then in the drop-down menu select **Windows Management Instrumentation (WMI)**. Select **Next**.
22. On the **Predefined Rules** page, select **Next**.
23. On the **Action** page, select **Allow the connection**, and then select **Finish**.
24. Close the **Group Policy Management Editor** window.

### Task 2: Link the GPO

1. In the **Group Policy Management** window, in the navigation pane, right-click or access the context menu for the **Contoso.com** domain, and then select **Link an Existing GPO**.
1. In the **Select GPO** dialog box, select **CONTOSO Standards**, and then select **OK**.

### Task 3: Review the effects of the GPO’s settings

1. Switch to **LON-CL1**, and then restart the virtual machine.

2. Sign in as **Contoso\\Ty** with the password **Pa55w.rd**.

3. Select the **Start** button and then enter **Firewall**.

4. In the search results, select **Allow an app through Windows Firewall**.

5. In the **Allowed apps and features** list, verify that the following check boxes are selected, and then close the window:

    - **Remote Event Log Management**
    - **Windows Management Instrumentation (WMI)**

6. Select the **Start** button and then enter **screen saver**.

7. In the search box select **Change screen saver**. 

8. In the **Screen Saver Settings** dialog box, notice that the **Wait** option is dimmed. You cannot change the time-out. Notice that the **On resume, display logon screen** option is selected and dimmed and that you cannot change the settings.

   > **Note**: If the **On resume, display logon screen** option is not selected and dimmed, open a command prompt, run **gpupdate /force**, and repeat the preceding steps.

9. Select **OK** to close the **Screen Saver Settings** dialog box.

10. Right-click or access the context menu for **Start**, and then select **Run**.

11. In the **Run** dialog box, in the **Open** text box, enter **regedit**, and then select **OK**.

     > Notice that the registry editor has been disabled by the GPO.

12. In the **Registry Editor** dialog box, select **OK**.

13. Sign out of **LON-CL1**.

### Task 4: Create and link the required GPOs

1. On **LON-ADM1**, in the **Group Policy Management** console, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, and then select **Seattle**.
1. Right-click or access the context menu for the **Seattle** organizational unit (OU), and then select **Create a GPO in this domain, and Link it here**.
2. In the **New GPO** dialog box, in the **Name** text box, enter **Seattle Application Override**, and then select **OK**.
3. On the details pane, right-click or access the context menu for the **Seattle Application Override** GPO, and then select **Edit**.
4. In the console tree, expand **User Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Control Panel**, and then select **Personalization**.
5. Open the **Screen saver timeout** policy setting.
6. Select **Disabled**, and then select **OK**.
7. Close the **Group Policy Management Editor** window.

### Task 5: Verify the order of precedence

1. In the **Group Policy Management Console** tree, select the **Seattle** OU.
1. Select the **Group Policy Inheritance** tab.

   > Notice that the **Seattle Application Override** GPO has higher precedence than the **CONTOSO Standards** GPO. The screen saver time-out policy setting that you just configured in the Seattle Application Override GPO is applied after the setting in the CONTOSO Standards GPO. Therefore, the new setting will overwrite the standards setting and will prevail. Screen saver time-out will be disabled for users within the scope of the Seattle Application Override GPO.

### Task 6: Configure the scope of a GPO with security filtering

1. On **LON-ADM1**, in the **Group Policy Management** console, expand the **Seattle** OU, and then select the **Seattle Application Override** GPO under the **Seattle** OU.
2. In the **Group Policy Management Console** dialog box, review the following message: "You have selected a link to a Group Policy Object (GPO). Except for changes to link properties, changes you make here are global to the GPO, and will impact all other locations where this GPO is linked."
3. Select the **Do not show this message again** check box, and then select **OK**.
4. In the **Security Filtering** section, you will observe that the GPO applies by default to **Authenticated Users**.
5. In the **Security Filtering** section, select **Authenticated Users**, and then select **Remove**.
6. In the **Group Policy Management** dialog box, select **OK** and then select **OK** again at the message.
7. On the **details** pane, select **Add**.
8. In the **Select User, Computer, or Group** dialog box, in the **Enter the object name to select (examples):** text box, enter **SeattleBranchUsers**, and then select **OK**.
9. On the **details** pane, under **Security Filtering**, select **Add**.
10. In the **Select User, Computer, or Group** dialog box, select **Object Types**.
11. In the **Object Types** dialog box, select the **Computers** check box and then select **OK**.
12. In the **Select User, Computer, or Group** dialog box, in the **Enter Object Names to select (Examples)** text box, enter **LON-CL1**, and then select **OK**.
13. Switch to **LON-CL1**, and then sign in as **Contoso\\Ty** with the password **Pa55w.rd**.

### Task 7: Verify the application of settings

1. Switch to **LON-ADM1**.
1. In **Group Policy Management**, select **Group Policy Results** in the **navigation** pane.
1. Right-click or access the context menu for **Group Policy Results** and then select **Group Policy Results Wizard**.
1. In the **Group Policy Results Wizard**, select **Next**.
1. On the **Computer Selection** page, select **Another Computer**, and then enter **LON-CL1** in the text box. Select **Next**.
1. On the **User Selection** page, in the list of users, select **CONTOSO\Ty**, and then select **Next**.
1. On the **Summary of Selections** page, select **Next**.
1. Select **Finish** when prompted.
1. On the details pane, select the **Details** tab, and then select **show all**.
1. In the report, scroll down until you locate the **User Details** section, and then locate the **Control Panel/Personalization** section. You should observe that the **Screen save timeout** settings are disabled and obtained from the Seattle Application Override GPO.
1. Close **Group Policy Management** console.

**Results**: After this exercise, you should have successfully created and configured GPOs.

## Exercise 3: Deploy and use certificate services

### Scenario

Contoso has expanded; therefore, its security requirements also have increased. The security department is particularly interested in enabling secure access to critical websites and in providing additional security for some features. To address these and other security requirements, Contoso has decided to implement a public key infrastructure (PKI) by using the AD CS role in Windows Server. As a senior network administrator, you are responsible for implementing certificate enrollment. You also will be developing the procedures and process for managing certificate templates. You will manage the Certification Authority which has been installed on the LON-DC1 domain controller.

The main tasks for this exercise are as follows:

1. Create a new template based on the Web Server template.
1. Configure templates so that they can be issued.
1. Enroll the Web Server certificate on LON-ADM1.

### Task 1: Create a new template based on the Web Server template

1. On **LON-ADM1**, in **Server Manager**, select **All Servers**.

1. Right-click or access the context menu for **LON-DC1** and then select **Certification Authority**.

   > NOTE: LON-DC1 hosts the Certification Authority server role.

1. In the **Certification Authority** console, expand **ContosoCA**, right-click or access the context menu for **Certificate Templates**, and then select **Manage**.

1. In the **Certificate Templates Console**, right-click or access the context menu for **Web Server** template in the list, and then select **Duplicate Template**.

1. Select the **General** tab, in the **Template display name** text box, enter **Production Web Server**, and then enter **3** in the **Validity period** text box.

1. Select the **Request Handling** tab, select **Allow private key to be exported**, and then select **OK**. Minimize the **Certificate Templates** **Console**.

1. In the **Certification Authority** console on **LON-ADM1**, right-click or select **Revoked Certificates**, select **All Tasks**, select **Publish**, and then select **OK**.

### Task 2: Configure templates so that they can be issued

1. On **LON-ADM1**, in the **Certification Authority** console, right-click or access the context menu for  **Certificate Templates**, point to **New**, and then select **Certificate Template to Issue**.
1. In the **Enable Certificate Templates** window, select **Production Web Server**, and then select **OK**.

### Task 3: Enroll the Web Server certificate on LON-ADM1

1. Switch to **Windows PowerShell ISE** and run the following command:

   ```powershell
   Install-WindowsFeature Web-Server -IncludeManagementTools
   ```

1. From **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager**.

1. Select **LON-ADM1**, and then in the central pane, double-click **Server Certificates** or select it and then select Enter.

1. In the **Actions** pane, select **Create Domain Certificate**.

1. On the **Distinguished Name Properties** page, complete the following fields, and then select **Next**:

    - Common name: **LON-ADM1.Contoso.com**
    - Organization: **Contoso**
    - Organizational unit: **IT**
    - City/locality: **Seattle**
    - State/province: **WA**
    - Country/region: **US**

1. On the **Online Certification Authority** page, select **Select**, select **ContosoCA**, and then select **OK**.

1. In the **Friendly name** text box, enter **LON-ADM1**, and then select **Finish**.

1. Ensure that the certificate displays in the **Server Certificates** console.

    > **Note**: You may need to restart Certificate Services on **LON-DC1** if you receive an error message.

1. In the **IIS** console, expand **LON-ADM1**, expand **Sites**, and then select **Default Web Site**.

1. In the **Actions** pane, select **Bindings**.

1. In the **Site Bindings** window, select **Add**.

1. In the **Add Site Binding** window, select **https** from the **Type** drop-down list. In the **SSL certificate** drop-down list, select **LON-ADM1**, select **OK**, select **Yes**, and then select **Close**.

1. Close **Internet Information Services (IIS) Manager**.

**Results**: After completing this exercise, you should have configured certificate templates and managed certificates.
