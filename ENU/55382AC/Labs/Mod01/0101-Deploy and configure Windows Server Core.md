---
lab:
    title: 'Lab: Deploy and configure Windows Server Core'
    module: 'Module 1: Installing, upgrading, and migrating servers and workloads'
---

# Lab: Deploy and configure Windows Server Core

## Scenario

Your team in the IT department at Contoso, Ltd. just purchased a new server that has no operating system (OS) installed. The team decided to install Windows Server 2022 Datacenter Evaluation in Server Core mode to test the Server Core functionality. Your task is to perform the installation and configuration of this server. You will name it **LON-SVR6**, assign it the static IP address of 172.16.0.26, and then join it to the Contoso.com domain with all other default settings. The team has also decided to implement Windows Admin Center for remote management of this server and other servers within the organization.

## Objectives

- Deploy and configure Server Core.
- Implement and use remote server administration.

## Estimated time: 60 minutes

## Exercise 1: Deploy and configure Server Core

### Scenario

As a part of the deployment plan, you'll implement Server Core and then configure it for remote management. 

The main tasks for this exercise are as follows:

1. Install Server Core.
1. Configure Server Core with sconfig and Windows PowerShell.

### Task 1: Install Server Core

1. Start **LON-SVR6**. 

   > Note: **LON-SVR6** doesn't have an OS installed yet. However, it has the Windows Server 2022 ISO attached and starts loading the installation files during startup.

1. At the **Microsoft Server Operating System Setup** page, note the **Language to install**, **Time and currency format**, and **Keyboard or input method** settings, and then select **Next**.

1. Select **Install now**.

1. On the **Select the operating system you want to install** page, ensure that **Windows Server 2022 Datacenter Evaluation** is selected, and then select **Next**.

1. Select the **I accept the Microsoft License Terms** checkbox, and then select **Next**.

1. On the **Which type of installation do you want?** page, select **Custom: Install Microsoft Server Operating System only (advanced)**.

1. On the **Where do you want to install the operating system?** page, select **Next**. 

   > The OS begins to install. Installation will take a few minutes and the virtual machine (VM) will restart as needed.

1. After installation completes, review the message about changing the Administrator password. Select **OK**, and then select Enter.

   > **Note:** You might need to select Ctrl-Alt-Del first to unlock the screen.

1. In the **`New password`** and **`Confirm password`** text boxes, enter **`Pa55w.rd`**, and then select Enter twice to acknowledge the password has been changed.

   > After a few moments, the Server Configuration tool (**sconfig**) starts automatically and presents the server management menu.

### Task 2: Configure Server Core with sconfig and PowerShell

1. On **LON-SVR6**, verify that the Server Configuration tool is active. 

   > **NOTE:** If the tool isn't active, at the command prompt, enter **`sconfig`**, and then select Enter.

1. To access **Network settings**, enter **`8`**, and then select Enter.

1. To change adapter index #1, enter **`1`**, and then select Enter.

1. To set the network adapter address, enter **`1`**, and then select Enter.

1. To set a static IP address, enter **`S`**, and then select Enter.

1. To set the IP address, enter **`172.16.0.26`**, and then select Enter.

1. To set the subnet mask, enter **`255.255.0.0`**, and then select Enter.

1. To set the default gateway and observe the setting results, enter **`172.16.0.1`**, and then select Enter.

1. Select Enter again to continue and return to the main management screen.

1. To access **Network settings**, enter **`8`**, and then select Enter.

1. To change adapter index #1, enter **`1`**, and then select Enter.

1. To set the Domain Name System (DNS) server, enter **`2`**, and then select Enter.

1. Enter **`172.16.0.10`**, and then select Enter. 

1. To leave the alternate DNS server blank, select Enter.

1. Select Enter again to continue.

1. To exit to Command Line (PowerShell), enter **`15`**, and then select Enter.

1. At the PowerShell prompt, enter the following command, and then select Enter:

    ```Rename-Computer -NewName LON-SVR6 -restart -force```

   > The server is renamed and then restarts.

1. On **LON-SVR6**, select Ctrl+Alt+Del, enter the password **Pa55w.rd**, and then select Enter.

   > After a few moments **sconfig** starts automatically and presents the Server Configuration tool.

1. To exit to Command Line (PowerShell), enter **`15`**, and then select Enter.

1. At the PowerShell prompt, enter the following command, and then select Enter:

    ```Add-Computer -DomainName Contoso.com -Credential Contoso\Administrator -restart -force```

1. In the **Windows PowerShell credential request** window, enter **`Pa55w.rd`**, and then select **OK**.

   > **LON-SVR6** is joined to the Contoso.com domain and then restarts.

### Results

After completing this exercise, you will have installed Server Core, configured the networking settings, renamed the server, and joined the Contoso domain.

## Exercise 2: Implement and use remote server administration

### Scenario

Now that you've deployed the Server Core server, you need to implement Windows Admin Center for remote administration.

The main tasks for this exercise are as follows:

1. Install Windows Admin Center.
1. Add servers for remote administration.
1. Configure Windows Admin Center extensions.
1. Verify remote administration.
1. Administer remote servers with Windows PowerShell remoting.

### Task 1: Install Windows Admin Center

1. Switch to **LON-SVR1**.

1. Sign in as **Contoso\\Administrator** with a password of **Pa55w.rd**.

1. From the taskbar, open File Explorer, and then browse to **E:\\Labfiles\\Mod01**.

1. Select and run **WindowsAdminCenter2110.2.msi**.

1. On the **Windows Admin Center Setup** page, to accept the terms, select the checkbox, and then select **Next**.

1. On the **Send diagnostic data to Microsoft** page, select **Next**.

1. On the **Install Windows Admin Center on Windows Server** page, select **Next**.

1. On the **Installing Windows Admin Center** page, select **Next**.

1. On the **Configure Gateway Endpoint** page, select **Install**.

1. Select **Finish**, and then close File Explorer.

   > **Note:** Wait approximately 3 to 4 minutes for installation to complete before continuing with Task 2.

### Task 2: Add servers for remote administration

1. On **LON-SVR1**, from the taskbar, open Microsoft Edge.

1. In the address bar, enter ```Https://LON-SVR1.contoso.com```, and then select Enter. 

1. At the Windows Security prompt, enter **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > When the Windows Admin Center console opens, notice that the host server (**Lon-svr1.contoso.com**) is listed by default.

1. In Windows Admin Center, close the **Read what's new** message box.

1. In Windows Admin Center, select **Add**.

1. In the **Add or create resources** pane, in the **Servers** box, select **Add**

1. In the **Server name** text box, enter **LON-DC1**. 

   > In a few moments, a message displays that Credentials are needed. However, the server can still be added. 

1. After the message displays, select **Add**.

1. Select **Add** again, and then repeat the steps 7 and 8 to add **LON-SVR6**.

### Task 3: Configure Windows Admin Center extensions

1. In Windows Admin Center, in the upper right corner, select the **Settings** (cog wheel) icon.

1. In the left pane, select **Extensions**. 

   > Note that there are no available extensions.

1. In the **details** pane, select **Feeds**, and then select **Add**.

1. In the **Add package source** pane, in the **Extension feed URL or path** text box, enter **E:\\Labfiles\\Mod01**, and then select **Add**.

1. Select **Available extensions**. 

   > Now the extensions that have been downloaded and stored in the Extension path display.

1. Select the **DNS (Preview)** extension, and then select **Install**. 

   > The extension will install, and Windows Admin Center will refresh.

1. On the top menu, select the **Settings** drop-down menu, and then select **Server Manager**.

1. On the **Server connections** page, select the ```LON-DC1``` link.

1. On the **Specify your credentials** page, select **Use another account for this connection**. Enter **Contoso\\Administrator** with the password of **Pa55w.rd**, and then select **Continue**.

   > The LON-DC1 connection displays.

1. To review the DNS settings on **LON-DC1**, from the **Tools** menu select **DNS**.

1. Select the ```Contoso.com``` zone, and review the records returned in the lower part of the console.

### Task 4: Verify remote administration

1. On the top menu, select the **Settings** drop-down menu, and then select **Server Manager**.

1. On the **Server connections** page, select the ```LON-SVR6``` link.

1. On the **Specify your credentials** page, select **Use another account for this connection**. Enter **Contoso\\Administrator** with the password of **Pa55w.rd**, and then select **Continue**.

   > The LON-SVR6 connection displays.

1. In the left pane, scroll down and review the basic administration tools available. 

1. Select **Roles & features**, and note what's installed and what's available to install. 

1. Scroll down and select the **Telnet Client** checkbox, and then at the top of the list, select **Install**.

1. To install the telnet client, select **Yes**. 

   >In a few moments, you'll receive a message stating that the telnet client installed successfully.

1. Close the browser.

### Task 5: Administer remote servers with Windows PowerShell remoting

1. On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

1. At the PowerShell prompt, enter the following command, then then select Enter:

    ```Enter-PSSession -ComputerName LON-SVR6```

1. At the PowerShell prompt, enter the following command, and then select Enter:

    ```Get-Service -Name AppIDSvc```

   > Note that the service is currently stopped.

1. At the PowerShell prompt, enter the following command, and then select Enter:

    ```Start-Service -Name AppIDSvc```

1. At the PowerShell prompt, enter the following command, and then select Enter:

    ```Get-Service -Name AppIDSvc```

   > Note that the service is now running.

### Results

After completing this exercise, you will have installed Windows Admin Center and connected the server to manage. You also performed the management tasks of installing a feature. Finally, you used Windows PowerShell remoting to start a service, and check the status of a service.
