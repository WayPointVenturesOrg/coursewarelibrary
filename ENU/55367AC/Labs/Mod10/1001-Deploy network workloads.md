---
lab:
    title: 'Lab: Deploy network workloads'
    module: 'Module 10: Remote Access and web services in Windows Server'
---

# Lab: Deploy network workloads

## Scenario

The employees in the IT department at Contoso, Ltd. need to be able to access server systems outside of business hours to correct issues that arise during weekends or holidays. Some of the employees are using computers that aren't members of the contoso.com domain. Other users are running non-Windows operating systems on their computers. To enable remote access for these users, you'll provide remote access to Windows Admin Center, secure it with Web Application Proxy, and deploy a secure virtual private network (VPN) solution using the Secure Socket Tunneling Protocol (SSTP) VPN protocol.

Your company is preparing to deploy a new intranet web application on an internal web server. You need to verify the server configuration and install Internet Information Services (IIS). The website must be accessible using a friendly Domain Name System (DNS) name and all web connections to and from the server must be encrypted.

## Objectives

By completing this lab, you’ll achieve the knowledge and skills to:

- Deploy and configure Web Application Proxy.
- Implement a VPN in Windows Server.
- Deploy and configure a web server.

## Estimated time: 90 minutes
## Exercise 1: Deploy and configure Web Application Proxy

### Scenario

Contoso, Ltd. has decided to make Windows Admin Center available remotely to administrators. To secure Windows Admin Center, you need to deploy Web Application Proxy. For initial testing, you'll use pass-through preauthentication. Active Directory Federation Services (AD FS) is being installed on **LON-SVR1** and Web Application Proxy is being installed on **LON-SVR3**. Certificates are already installed on both servers in preparation for the installation.

The main tasks for this exercise are as follows:

1. Install AD FS on **LON-SVR1**.
2. Create DNS entries for AD FS and Web Application Proxy.
3. Install Remote Access management tools.
4. Install Web Application Proxy.
5. Configure Web Application Proxy.
6. Configure a web application.
7. Configure Windows Defender Firewall to allow remote access.
8. Test the web application.

### Task 1: Install AD FS on LON-SVR1

1. On **LON-SVR1**, select Ctrl+Alt+Del, enter the password **`Pa55w.rd`**, and then select Enter.

>Note: After a few moments **sconfig** starts automatically and presents the server management screen.

2. To exit to the command line (Windows PowerShell), enter **`15`**, and then select Enter.

3. At the Windows PowerShell prompt, enter the following command, and then select Enter:

   `C:\Labfiles\Mod03\InstallADFS.ps1`

>Note: AD FS is installed and then restarts **LON-SVR1**.

### Task 2: Create DNS entries for AD FS and Web Application Proxy

1. Switch to **LON-ADM1** and sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.
2. Select **Start**, and then select **Server Manager**.
3. In **Server Manager**, select **All Servers**.
4. In **Server Manager**, right-select or access the context menu for **LON-DC1**, and then select **DNS Manager**.
5. In the **DNS Manager**, expand **LON-DC1.Contoso.com**, expand **Forward Lookup Zones**, and then select **Contoso.com**.
6. Create a new DNS record with the following information:
   - DNS record type: **Host (A)**
   - Record name: **`remoteapp`**
   - IP address: **`172.16.0.14`**
7. Create a new DNS record with the following information:
   - DNS record type: **Host (A)**
   - Record name: **`fs`**
   - IP address: **`172.16.0.12`**

8. Close the **DNS Manager**.

### Task 3: Install Remote Access management tools

1. On **LON-ADM1**, in **Server Manager**, select **Manage**, and then select **Add Roles and Features**.
2. On the **Before you begin** page, select **Next**.
3. On the **Select installation type** page, ensure that **Role-based or feature based** is selected, and then select **Next**.
4. On the **Select destination server** page, select **LON-ADM1.Contoso.com**, and then select **Next**.
5. On the **Select server roles** page, select **Next**.
6. On the **Select features** page, expand **Remote Server Administration Tools**, expand **Role Administration Tools**, and then select the **Remote Access Management Tools** checkbox.
7. At the **Add Roles and Features Wizard** prompt, select **Add Features**.
8. Select **Next**, and then select **Install**.
9. After the installation succeeded message displays, select **Close**.
10. Close **Server Manager**.

### Task 4: Install Web Application Proxy

1. On **LON-ADM1**, on the taskbar, select **Microsoft Edge**.

2. In Microsoft Edge, select **Windows Admin Center**.

3. Sign in to **Windows Admin Center** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

4. In **Windows Admin Center**, select **lon-svr3.contoso.com**.

5. In the **Specify your credentials** dialog box, select **Use another account for this connection**, and then sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

6. On the **Tools** pane, select **Registry**.

7. On the **details** pane, expand and browse to the following location:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`\

8. Select **Protocols**, and then on the **Registry** pane, select **New Key**.

>Note: You may need to first select the elipse (...) to access additional registry options.

9. In the **New Key** dialog box, enter **`TLS 1.3`**, and then select **OK**.

10. Select **TLS 1.3**, and then create the following new keys:

   - **`Client`**
   - **`Server`**

11. Select **Client**, and then select **Add Value**.

12. In the **Add Value** box, provide the following information, and then select **Save**:

   - Name: **`DisabledByDefault`**
   - Type: **DWORD (32-bit) Value**
   - Data: **`00000001`**

>Note: The registry settings are required to address an issue related to Windows Server 2022 AD FS and Transport Layer Security (TLS) 1.3

13. Select **Client**, and then select **Add Value**.

14. In the **Add Value** box, provide the following information, and then select **Save**:

   - Name: **`Enabled`**
   - Type: **DWORD (32-bit) Value**
   - Data: **`00000000`**

15. Close **Microsoft Edge**.

16. On **LON-ADM1**, open **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

17. On the **Before you begin** page, select **Next**.

18. On the **Select installation type** page, ensure that **Role-based or feature based** is selected, and then select **Next**.

19. On the **Select destination server** page, select **LON-SVR3.Contoso.com**, and then select **Next**.

20. On the **Select server roles** page, select **Remote Access**, and then select **Next**.

21. On the **Select features** page, select **Next**.

22. On the **Remote Access** page, select **Next**.

23. On the **Select role services** page, select **Web Application Proxy**, and then select **Next**.

24. Select the checkbox next to **Restart the destination server automatically if required**, and then select **Install**.

25. After the installation succeeded message displays, select **Close**.

### Task 5: Configure Web Application Proxy

1. On **LON-ADM1**, in **Server Manager**, select **Tools**, and then select **Remote Access Management**.
2. In the **Remote Access Management Console**, on the **Tasks** pane, select **Manage a Remote Server**.
3. In the **Manage a Remote Server** dialog box, enter **`LON-SVR3`**, and then select **OK**.
4. In the **Remote Access Management Console**, select **Web Application Proxy**, and then select **Run the Web Application Proxy Configuration Wizard**.
5. In the **Web Application Proxy Configuration Wizard**, select **Next**.
6. On the **Federation Server** screen, enter the following information, and then select **Next**:
   - Federation service name: **`fs.Contoso.com`**
   - User name: **`Contoso\Administrator`**
   - Password: **`Pa55w.rd`**
7. On the **AD FS Proxy Certificate** screen, in the **Select a certificate to be used by the AD FS proxy** box, select **fs.contoso.com**, and then select **Next**.
8. On the **Confirmation** screen, read the information, and then select **Configure**.
9. On the **Results** screen, select **Close**.

>Note: If you get an error in **Remote Access Management Console** indicating that cmdlets aren't found, restart **Remote Access Management Console** and reconnect to **LON-SVR3**.

### Task 6: Configure a web application

1. On **LON-ADM1**, in the **Remote Access Management Console**, on the **Tasks** pane, select **Publish**.

2. In the **Publish New Application Wizard**, on the **Welcome** screen, select **Next**.

3. On the **Preauthentication** screen, select **Pass-through**, and then select **Next**.

4. On the **Publishing Settings** screen, enter the following information, and then select **Next**.

   - Name: **`RemoteApp`**
   - External URL: **`https://remoteapp.contoso.com`**
   - External certificate: **`remoteapp.contoso.com`**  
   - Backend server URL: **`https://LON-ADM1.contoso.com`**

>Note: You'll receive a warning that the external URL and backend URL are different. You can ignore this warning.

5. On the **Confirmation** screen, select **Publish**.

6. On the **Results** screen, select **Close**.

### Task 7: Configure Windows Defender Firewall to allow remote access

1. On **LON-ADM1**, select **Start**, and then enter **Firewall**.
2. In the search results, select **Windows Defender Firewall with Advanced Security**.
3. In the **Windows Defender Firewall with Advanced Security** window, select **Incoming rules**, and then select **New Rule**.
4. In the **New Inbound Rule Wizard** dialog box, on the **Rule Type** page, select **Port**, and then select **Next**.
5. On the **Protocol and Ports** page, select **TCP**, and then next to **Specific local ports**, enter **`443`**. Select **Next**.
6. On the **Action** page, select **Allow the connection**, and then select **Next**.
7. On the **Profile** page, ensure that all profiles are selected, and then select **Next**.
8. On the **Name** page, enter **`SecureWeb`**, and then select **Finish**.
9. Close the **Windows Defender Firewall with Advanced Security** console.

### Task 8: Test the web application

1. Switch to **LON-CL1** and sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.
2. On **LON-CL1**, on the taskbar, select **Microsoft Edge**.
3. In **Microsoft Edge**, in the address bar, enter **`https://remoteapp.contoso.com`**, and then select Enter.
4. In the **Windows Security** dialog box, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.
5. Close **Microsoft Edge**.

**Results:** After completing this exercise, you'll have configured Web Application Proxy to provide secure access to a web application (Windows Admin Center).

## Exercise 2: Implement a VPN in Windows Server

### Scenario

The first step to implementing a VPN is to verify and configure certificate requirements for an SSTP VPN. Then, you must configure the Remote Access server to provide VPN connectivity, and you must also create a remote access policy to ensure that the clients can connect to the server by using the SSTP VPN protocol.

The main tasks for this exercise are as follows:

1. Configure Routing and Remote Access Service (RRAS) service and Network Policy Server (NPS) policies for VPN.
2. Configure a client VPN connection.
3. Test the VPN connection.

### Task 1: Configure RRAS service and NPS policies for VPN

1. On **LON-ADM1**, select **Start**, and then select **Windows PowerShell ISE**.

2. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

```
Install-WindowsFeature -name RemoteAccess,Routing -IncludeManagementTools
```

>Note: Wait for the command to complete, which should take approximately one minute.

3. Leave the **Administrator: Windows PowerShell ISE** window open.

#### Request a certificate for LON-ADM1

1. On **LON-ADM1**, in the **Administrator: Windows PowerShell ISE** window, enter `certlm.msc`, and then select Enter.
2. In the **Certificates-Local Computer** snap-in, expand **Personal**, and then select **Certificates**.
3. Right-click or access the context menu for **Certificates**, point to **All Tasks**, and then select **Request New Certificate**.
4. On the **Before you Begin** page, select **Next**, and then on the **Select Certificate Enrollment Policy** page, select **Next**.
5. On the **Request Certificates** page, select **Contoso Web Server**, and then select the **More information is required to enroll for this certificate. Click here to configure settings** link.
6. In the **Certificate Properties** dialog box, on the **Subject** tab, under **Subject name**, under **Type**, select **Common name**.
7. In the **Value** text box, enter **`vpn.contoso.com`**, and then select **Add**.
8. Select the **General** tab, and in the **Friendly name** field, enter **`Contoso VPN`**.
9. Select **OK**, select **Enroll**, and then select **Finish**.
10. On the **details** pane, verify that a new certificate with the name **vpn.contoso.com** is enrolled with **Intended Purposes** of **Server Authentication**.
11. Close the **Certificates-Local Computer** console.

#### Change the HTTPS bindings

1. On **LON-ADM1**, open **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager.**
2. In the **Internet Information Services (IIS) Manager**, expand **LON-ADM1 (CONTOSO\Administrator)**.
3. In the **Internet Information Services (IIS) Manager**, in the console tree, expand **Sites**, and then select **Default Web site**.
4. On the **Actions** pane, select **Bindings**, and then select **Add**.
5. In the **Add Site Binding** dialog box, under the **Type** select **https**, in the Secure Sockets Layer (SSL) Certificate list, select the **Contoso VPN** certificate, select **OK**, select **Yes** when prompted, and then select **Close**.
6. Close the **Internet Information Services (IIS) Manager** console.

#### Configure and enable VPN configuration

1. On **LON-ADM1**, in the **Server Manager**, select **Tools**, and then select **Routing and Remote Access**.
2. Right-click or access the context menu for **LON-ADM1 (local)**, and then select **Configure and Enable Routing and Remote Access**.
3. On the **Welcome to Routing and Remote Access Server Setup Wizard**, select **Next**.
4. On the **Configuration** page, select **Custom configuration**, and then select **Next**.
5. On the **Custom Configuration** page, select **VPN access** and **LAN routing**, and then select **Next**.
6. On the **Completing the Routing and Remote Access Server Setup Wizard** page, select **Finish**.
7. In the **Routing and Remote Access** dialog box, select **OK**, and then select **Start service**.
8. Expand **LON-ADM1 (local)**, right-click or access the context menu for **Ports**, and then select **Properties**.
9. In the **Ports Properties** dialog box, verify that 2 ports exist for **WAN Miniport (SSTP)**, **WAN Miniport (IKEv2)**, **WAN Miniport (L2TP)**, and **WAN Miniport (PPTP)**.
10. Select **WAN Miniport (PPTP)**, and then select **Configure**. 
11. In the **Configure Device - WAN Miniport (PPTP)** windows, remove the check mark next to **Remote access connections (inbound only)** and **Demand-dial routing connections (Inbound and outbound)**, and then select **OK**.
12. To close the **Ports Properties** dialog box, select **OK**.
13. Right-click or access the context menu for **LON-ADM1 (local)**, and then select **Properties**.
14. In the **LON-ADM1 (local) Properties** dialog box, on the **General** tab, verify that **IPv4 Remote access server** is selected.
15. Select the **Security** tab, and then select **Authentication Methods**. Verify that **Extensible authentication protocol (EAP)** is selected as the authentication protocol, and then select **OK**.
16. On the **Security** tab, select the drop-down arrow next to **Certificate**, and then select **vpn.contoso.com**.
17. Select the **IPv4** tab, and then verify that the VPN server is configured to assign IP version 4 (IPv4) addressing by using **Dynamic Host Configuration Protocol (DHCP)**.
18. To close the **LON-ADM1 (local) Properties** dialog box, select **OK**, and then select **Yes** when prompted.

#### Configure the Remote Access policies on NPS

1. On **LON-ADM1**, in **Server Manager**, on the **Tools** menu, select **Network Policy Server**.
2. In the **Network Policy Server** console, on the **navigation** pane, expand **Policies**, and then select **Network Policies**.
3. On the **navigation** pane, right-click or access the context menu for **Network Policies**, and then select **New**.
4. In the **New Network Policy** wizard, in the **Policy name** text box, enter **`Contoso IT VPN`**.
5. In the **Type of network access server** list, select **Remote Access Server(VPN-Dial up)**, and then select **Next**.
6. On the **Specify Conditions** page, select **Add**.
7. In the **Select condition** dialog box, select **Windows Groups**, and then select **Add**.
8. In the **Windows Groups** dialog box, select **Add Groups**.
9. In the **Select Group** dialog box, in the **Enter the object name to select (examples)** text box, enter **`IT`**, select **Check Names**, and then select **OK**. Select **OK** again, and then select **Next**.
10. On the **Specify Access Permission** page, verify that **Access granted** is selected, and then select **Next**.
11. On the **Configure Authentication Methods** page, clear the **Microsoft Encrypted Authentication (MS-CHAP)** checkbox.
12. To add **EAP Types**, select **Add**.
13. On the **Add EAP** page, select **Microsoft Secured password (EAP-MSCHAP v2)**, and then select **OK**.
14. To add **EAP** types, select **Add**.
15. On the **Add EAP** page, select **Microsoft: Smart Card or other certificate**, select **OK**, and then select **Next**.
16. On the **Configure Constraints** page, select **Next**.
17. On the **Configure Settings** page, select **Next**.
18. On the **Completing New Network Policy** page, select **Finish**.
19. Close all open windows on **LON-ADM1**.

### Task 2: Configure a client VPN connection

1. On **LON-CL1**, right-click or access the context menu for the **Start** button, and then select **Network Connections**.
2. In **Network & Internet**, select **VPN**, and then select **Add VPN**.
3. In the **Add a VPN connection** wizard, configure the following settings, and then select **Save**:
   - VPN provider: **Windows (built-in)**
   - Connection name: **`Contoso VPN`**
   - Server name or address: **`vpn.contoso.com`**
   - VPN type: **Secure Socket Tunneling Protocol (SSTP)**
   - Type of sign-in info: **User name and password**
   - Remember my sign-in info: **Cleared**. You might need to scroll down to find this setting.

### Task 3: Test the VPN connection

1. In **Network & Internet**, select **Contoso VPN**, and then select **Connect**.
2. In the **Sign in** dialog box, in the **User name** text box, enter **`Contoso\Tonnie`**. In the **Password text** box, enter **`Pa55w.rd`**, and then select **OK**.
3. Verify that **Connected** displays under **Contoso VPN**, indicating that you're now connected to the VPN server.
4. Select **Network & Internet**, select **Advanced network settings**, and then under **Related settings**, select **More network adapter options**.
5. In **Network Connections**, verify that **WAN Miniport (SSTP)** displays under **Contoso VPN**.

#### Verify connection on client and VPN server

1. On **LON-CL1**, select **Start**, and then enter **Windows PowerShell ISE**.

2. In the search results, select **Windows PowerShell ISE**.

3. In the **Administrator: Windows PowerShell ISE** window, at the command prompt, enter the following command, and then select Enter:

   `Get-NetIPConfiguration`

>Note: Examine the output and verify that **Contoso VPN** is listed next to **InterfaceAlias**. Also verify that the **Contoso VPN** interface has been issued an Internet Protocol (IP) address. This is the IP address for the VPN connection assigned by RRAS.

**Results**: After completing this exercise, you'll have installed and configured the Remote Access server to successfully provide VPN access.

## Exercise 3: Deploy and configure a web server

### Scenario

You need to install the Web Server role on an internal server. You'll verify the installation of IIS and configure remote management of IIS. You'll then add an A record in DNS for the new website and enroll a web server certificate. Finally, you'll verify that you can reach the website using the new DNS name and that the connection to the website is encrypted using SSL.

The main tasks for this exercise are as follows:

1. Install the Web Server role.
2. Configure Web Server options.
3. Create and configure a new site.
4. Verify site functionality.

### Task 1: Install the Web Server role

1. Switch to **LON-SVR1**.

2. If necessary, sign in to **LON-SVR1** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

3. At the Server Configuration tool (SConfig) management screen, enter `15`, and then select Enter to exit to the command line (PowerShell).

4. In the **Administrator C:\Windows\system32\cmd.exe - powershell** window, enter the following command, and then select Enter:

```
Install-WindowsFeature -name Web-Server -IncludeManagementTools
```

>Note: Wait for the command to complete, which should take approximately one minute.

5. Verify that **True** displays under **Success** in the output.

#### Verify the Web Server installation

1. In the Windows PowerShell command prompt, enter the following command, and then select Enter:

```
Get-eventLog System -After (Get-Date).AddHours(-1)
```

>Note: Verify that no errors display under the **EntryType** column.

2. Still in the Windows PowerShell command prompt, enter the following command, and then select Enter:

```
Get-eventLog Application -After (Get-Date).AddHours(-1)
```

>Note: Verify that only errors with word **License** display under the **Message** column.

#### Verify that the Windows Firewall rules for HTTP and HTTPS traffic are enabled

1. On **LON-SVR1**, in a Windows PowerShell command prompt, enter the following command, and then select Enter:

```
Get-NetFirewallProfile -Name Domain | Get-NetFirewallRule | where-Object {$_.DisplayName -like "World Wide Web*"}
```

>Note: This will return information about three rules, including one for HTTP and one for HTTPS. Verify that the rules are enabled and allow inbound traffic.

2. Examine the **Enabled** value. It should display **True**. Also examine the **Direction** value, which should display **Inbound**.

3. Leave the Windows PowerShell command prompt open.

#### Test the default website

1. Switch to **LON-ADM1**, and in the taskbar, select **Microsoft Edge**.

2. In Microsoft Edge, enter **`http://LON-SVR1`** in the address bar, and then select Enter.

>Note: Verify that IIS displays the default, **Internet Information Services** webpage.

3. In Microsoft Edge, enter **`http://172.16.0.12`** in the address bar, and then select Enter.

4. Verify that IIS displays the default, **Internet Information Services webpage**.

5. Leave Microsoft Edge open.

### Task 2: Configure Web Server options

#### Configure DNS for the default website

1. On **LON-ADM1**, select **Start**, and then select **Windows PowerShell ISE**.

2. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

```
Add-DnsServerResourceRecordA -ComputerName LON-DC1 -Name "www" -ZoneName "contoso.com" -AllowUpdateAny -IPv4Address "172.16.0.12"
```

3. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

```
Get-DnsServerResourceRecord -ComputerName LON-DC1 -ZoneName "contoso.com"
```

4. In the output, verify that **www** displays in the **HostName** column.

#### Test the website by using DNS names

1. In Microsoft Edge, enter **`http://www.contoso.com`** in the address bar, and then select Enter.
2. Verify that IIS displays the default, **Internet Information Services webpage**.

#### Enable remote management of IIS using IIS Manager

1. Switch to **LON-SVR1**.

2. On **LON-SVR1**, in the Windows PowerShell command prompt, enter the following command, and then select Enter:

```
Install-WindowsFeature -Name Web-Mgmt-Service
```

>Note: Wait for the command to complete, which should take approximately one minute.

3. On **LON-SVR1**, in the Windows PowerShell command prompt, enter the following command, and then select Enter:

```
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WebManagement\Server' -Name EnableRemoteManagement -Value 1
```

4. On **LON-SVR1**, in the Windows PowerShell command prompt, enter the following command, and then select Enter:

```
Restart-Service wmsvc
```

>Note: Setting this registry key to 1 will enable remote management of IIS. You must restart the **Web Management Service (wmsvc)** after changing the registry key.

5. On **LON-ADM1**, switch to Windows PowerShell Integrated Scripting Environment (ISE).

6. On **LON-ADM1**, enter the following command, and then select Enter:

```
Install-WindowsFeature -Name Web-Mgmt-Console,Web-Scripting-Tools
```

>Note: Wait for the command to complete, which should take approximately one minute.

>Note: The output from this command will return **NoChangeNeeded** under the **Exit Code** column. This is because you already installed the management tools during exercise 1. This step has been left here intentionally to exhibit the complete process of enabling remote management of IIS.

7. On **LON-ADM1**, select the **Start** button, and then select the **Server Manager** tile. In **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager**.
8. On the **Start Page**, under **Connection tasks**, select **Connect to a server**. Use the following information and select **Finish** to complete the wizard:
   - Server name: **`LON-SVR1`**
   - User name: **`contoso\administrator`**
   - Password: **`Pa55w.rd`**
   - When prompted by the **Server Certificate Alert** dialog window, select **Connect**.
   - Connection name: **`LON-SVR1`**
9. On the **Connections** pane, select **Start Page**. Notice **Recent connections**, **Connection tasks**, **Online resources**, and **IIS News**.
10. On the **Connections** pane, select **LON-SVR1 (contoso\administrator)**. Notice the icons listed on the **Features View** pane. On the **Actions** pane, notice the list of **Manage Server** actions.
11. On the **Connections** pane, expand **LON-SVR1 (contoso\administrator)**, and then select **Sites**. On the **Features View** pane, notice the **Name** of the listed website and its **Status**.
12. On the **Actions** pane, select **Set Website Defaults**. In the **Website Defaults** dialog box, notice the **Application Pool** setting. Select **Cancel**.
13. Leave **Internet Information Services (IIS) Manager** open. 

### Task 3: Create and configure a new site

#### Create a webpage in the default website

1. Switch to **LON-SVR1**, and in the **Administrator C:\Windows\system32\cmd.exe - powershell** window, enter the following command, and then select Enter: `notepad`
2. In **Notepad**, enter the following: **```<p>Contoso intranet running on LON-SVR1</p>```**
3. In the menu bar, select **File**, and then select **Save As**. In the **Save As** dialog box, select **File name**, and then delete **.txt**. In the **File name** box, enter **`c:\inetpub\wwwroot\default.htm`**. 
4. In the **Text Documents (*.txt)** drop-down box, select **All Files**. Then select **Save**. Close **Notepad**.

#### Request a new Web Server certificate

1. On **LON-SVR1**, in the **Administrator C:\Windows\system32\cmd.exe - powershell** window, enter the following command, and then select Enter:

```
Get-Certificate -Template ContosoWebServer -DnsName www.contoso.com -CertStoreLocation cert:\LocalMachine\My
```

>Note: Wait for the command to complete, which should take approximately 30 seconds.

2. In the output, verify that **Issued** displays under **Status**.

### Task 4: Verify site functionality

1. Switch to **LON-ADM1**, and in the **Internet Information Services (IIS) Manager**, right-click or access the context menu for **Default Web Site** for **LON-SVR1**, and then select **Edit Bindings**.
2. In the **Site Bindings** dialog box, select **Add**, and then under **type**, select **https**.
3. Under **SSL certificate**, select the certificate displayed with a globally unique identifier (GUID), select **OK**, and then select **Close**. 

>Note: The GUID will be similar to: **35B56A0F8D0AC682579BA893524EDFC6EC8FBA83**.

4. In Microsoft Edge, enter **`http://www.contoso.com`** in the address bar, and then select Enter.
5. Verify that IIS displays the default **Internet Information Services webpage**. 

>Note: Notice that **Not secure** displays next to **www.contoso.com**.

6. In the address bar, enter **`https://www.contoso.com`**. 

>Note: Verify that IIS displays the website. Notice that a padlock displays next to **www.contoso.com**. This means that the website is protected using SSL.

**Results**: By completing this exercise, you'll have deployed and configured a web server on Server Core.
