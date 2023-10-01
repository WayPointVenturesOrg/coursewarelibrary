# Lab: Deploy and administer AD DS

## Lab scenario

You are an IT administrator at Contoso Corporation. The company is expanding its business and has several new locations. The Active Directory Domain Services (AD DS) administration team is currently evaluating available Windows Server methods for a rapid and remote domain-controller (DC) deployment. Also, the team is looking for a way to automate certain AD DS administrative tasks. The team wants a fast and seamless deployment of new DCs for new locations, and it wants to promote servers to DCs from a central location.

## Exercise 1: Deploy AD DS

### Scenario

Contoso Corporation wants to deploy new domain controllers in remote sites with minimal engagement from remote IT staff. You'll use Windows PowerShell to deploy new DCs and then validate the deployment using the AD DS Best Practices Analyzer.

The main tasks for this exercise are as follows:

1. Install AD DS binaries.

2. Prepare the AD DS installation and promote a remote server.

3. Run the AD DS Best Practices Analyzer.


### Task 1: Install AD DS binaries

1.  Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

    > Note: Server Manager opens automatically.

2.  Select **Start**, and then select **Windows PowerShell ISE**.

3.  At the command prompt in the Windows PowerShell ISE command-line interface, enter the following command, and then select Enter:

   ```
Install-WindowsFeature –Name AD-Domain-Services –ComputerName LON-SVR1
   ```

4.  Enter the following command to verify that the AD DS role is installed on **LON-SVR1**, and then select Enter:

   ```
Get-WindowsFeature –ComputerName LON-SVR1
   ```

5.  In the output of the previous command, search for **Active Directory Domain Services**, and verify the check box is selected. Search for **Remote Server Administration Tools**, search for the **Role Administration Tools** node below it, and then search for the **AD DS and AD LDS Tools** node. 

    > Note: Below the **AD DS and AD LDS Tools** node, only **Active Directory module for Windows PowerShell** has been installed and not the graphical tools, such as the Active Directory Administrative Center. If you centrally manage your servers, you usually won't need these on each server. If you want to install them, you need to specify the AD DS tools by running the **Add-WindowsFeature** cmdlet with the **RSAT-ADDS** command name.

    >Note: You might need to wait a short time after the installation process completes before verifying that the AD DS role has installed. If you don't observe the expected results from the **Get-WindowsFeature** command, you can try again after a few minutes.

### Task 2: Prepare the AD DS installation, and promote a remote server

#### Add LON-SVR1 to Server Manager on LON-DC1

1.  On **LON-DC1**, in **Server Manager**, select the **All Servers** view.

2.  On the **Manage** menu, select **Add Servers**.

3.  In the **Add Servers** dialog box, maintain the default settings, and then select **Find Now**.

4.  In the **Active Directory** list of servers, select **LON-SVR1**, select the arrow to add it to the **Selected** list, and then select **OK**.

#### Remotely configure AD DS by using Server Manager

1.  On **LON-DC1**, ensure that the installation of the AD DS role on **LON-SRV1** is complete and that the server was added to **Server Manager**, and then select the **Notifications** flag symbol.

2.  Note the post-deployment configuration of **LON-SVR1**, and then select the **Promote this server to a domain controller** link.

3.  In the **Active Directory Domain Services Configuration Wizard**, on the **Deployment Configuration** page, under **Select the deployment operation**, verify that **Add a domain controller to an existing domain** is selected. 

4.  Ensure that the **Contoso.com** domain is specified, and then in the **Supply the credentials to perform this operation** section, select **Change**.

5.  In the **Credentials for deployment operation** dialog box, in the **User name** box, enter **`Contoso\Administrator`**, and then in the **Password** box, enter **`Pa55w.rd`**.

6.  Select **OK**, and then select **Next**.

7.  On the **Domain Controller Options** page, clear the selections for **Domain Name System (DNS) server** and **Global Catalog (GC)**. Ensure that **Read-only domain controller (RODC)** is cleared.

8.  In the **Type the Directory Services Restore Mode (DSRM) password** section, enter and confirm the password **`Pa55w.rd`**, and then select **Next**.

9.  On the **Additional Options** page, select **Next**.

10.  On the **Paths** page, keep the default path settings for the **Database** folder, **Log files** folder, and **SYSVOL** folder, and then select **Next**.

11.  On the **Review Options** page, select **View script** to open the generated Windows PowerShell script.

12.  In Notepad, edit the generated Windows PowerShell script:

    - Delete the comment lines that begin with the number sign (**#**).

    - Remove the **Import-Module** line.

    - Remove the grave accents (**`**) at the end of each line.

    - Remove the line breaks.

13.  Now the **Install-ADDSDomainController** command and all the parameters are on one line. Place the cursor in front of the line, and then select Shift+End to select the whole line. On the menu, select **Edit**, and then select **Copy**.

14.  Switch to the **Active Directory Domain Services Configuration Wizard**, and then select **Cancel**. 

15.  When prompted for confirmation, select **Yes** to cancel the wizard.

16.  Switch to the **Windows PowerShell ISE** window.

17.  At the Windows PowerShell command prompt, enter the following command:

    ```
Invoke-Command –ComputerName LON-SVR1 { }
    ```

18.  Place the cursor between the braces { }, and then paste the content of the copied script line from the clipboard. The whole line should now be as follows:

    ```
Invoke-Command –ComputerName LON-SVR1 {Install-ADDSDomainController –NoGlobalCatalog:$true –Credential (Get-Credential) –CriticalReplicationOnly:$false –DatabasePath "C:\Windows\NTDS" –DomainName "Contoso.com" –InstallDns:$false –LogPath "C:\Windows\NTDS" –NoRebootonCompletion:$false –SiteName "Default-First-Site-Name" –SysvolPath "C:\Windows\SYSVOL" –Force:$true }
    ```

19.  Select Enter to start the installation.

20.  In the **Windows PowerShell Credential Request** dialog box, enter **`Contoso\Administrator`** in the **User name** box, enter **`Pa55w.rd`** in the **Password** box, and then select **OK**.

21.  When prompted for the **SafeModeAdministratorPassword** password, enter **`Pa55w.rd`**, and then select Enter.

22.  When prompted for confirmation, enter **`Pa55w.rd`**, and then select Enter.

    > Note: Wait until the command runs and the **Status: Success** message is returned. The **LON-SVR1** virtual machine restarts.

23.  Close Notepad without saving the file.

24.  After **LON-SVR1** restarts, on **LON-DC1**, switch to **Server Manager**, and then on the left side, select the **AD DS** node. 

    > Note: Note that **LON-SVR1** has been added as a server and that the warning notification has disappeared. You might have to select **Refresh**.

### Task 3: Run the AD DS Best Practices Analyzer

1.  On **LON-DC1**, in **Server Manager**, select the **All Servers** view.

2.  Go to the **Best Practices Analyzer** section, select the **Tasks** menu, and then select **Start BPA Scan**.

3.  In the **Select Servers** dialog box, select **LON-DC1.Contoso.com** and **LON-SVR1.Contoso.com**.

4.  Select **Start Scan**, and then wait until the Best Practices Analyzer (BPA) finishes the scan.

5.  Review the results of the BPA. 

    > [!Hint]You'll notice many result entries with severity such as Information and Warning. Select some of the entries to view additional information.

**Results:** After this exercise, you'll have successfully created a new DC and reviewed the AD DS BPA results for it.

## Exercise 2: Administer AD DS

### Scenario

The IT team at Contoso Corporation is evaluating the tools that are available in Windows Server for AD DS administration. You need to evaluate the use of the Active Directory Administrative Center and the Windows PowerShell cmdlets performed in the background.

The main task for this exercise is as follows:

- Use the Active Directory Administrative Center.

### Task 1: Use the Active Directory Administrative Center

#### Navigate within the Active Directory Administrative Center

1.  If necessary, sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.
2.  In **Server Manager**, select **Tools**, and then select **Active Directory Administrative Center**.
3.  Expand the **Active Directory Administrative Center** window.
4.  In the navigation pane, select the **Tree View** tab, and then expand **Contoso (local)**.

#### Perform an administrative task within the Active Directory Administrative Center

1.  In the **Active Directory Administrative Center**, select **Overview**.

2.  In the **Reset Password** section, in the **User name** box, enter **`Contoso\Anita`**.

3.  In the **Password** and **Confirm password** boxes, enter **`Pa55w.rd`**.

4.  Clear the **User must change password at next log on** check box, and then select **Apply**.

    >Note: Anita's password is reset.

5.  In the **Global Search** section, in the **Search** box, enter **`Lon`**, and then select Enter.

    >Note: All objects that start with the word **Lon** are displayed.

#### Create objects

1.  In the **Active Directory Administrative Center**, in the navigation pane tree view, expand **Contoso (local)**, and then select the **Computers** container.

2.  In the **Tasks** pane, in the **Computers** section, select **New**, and then select **Computer**.

3.  In the **Create Computer** dialog box, enter the following information, and then select **OK**:

   - Computer name: **`LON-CL4`**

   - Computer (NetBIOS) name: **`LON-CL4`**

#### View all object attributes

1.  In the **Active Directory Administrative Center**, select **Contoso (local)**, and then in the list, open **Computers**.

2.  Select **LON-CL4**, and then in the **Tasks** pane, in the **LON-CL4** section, select **Properties**.

3.  In the **LON-CL4** window, scroll down to the **Extensions** section, select the **Attribute Editor** tab, and note that you can observe all attributes of the computer object here.

4.  Close the **LON-CL4** window by selecting **Cancel**.

#### Use the Windows PowerShell History viewer

1.  In the **Active Directory Administrative Center**, select the **Windows PowerShell History** toolbar at the bottom of the screen.

2.  View the details for the **Set-ADAccountPassword** cmdlet that you used to perform the password reset task.

3.  View the details for the **New-ADComputer** cmdlet that you used to create the LON-CL4 computer account.

4.  Close all open windows.

**Results**: After completing this exercise, you'll have successfully used the Active Directory Administrative Center to manage AD DS and reviewed the Windows PowerShell cmdlets that run in the background.
