---
lab:
    title: 'Lab: Deploy and configure Windows Server'
    module: 'Module 1: Installing, upgrading, and migrating servers and workloads'
---

# Lab: Deploy and configure Windows Server Core

## Scenario

Your team in the IT department at Contoso, Ltd. just purchased a new server that has no operating system. The team decides to install Windows Server 2022 Datacenter Evaluation in Server Core mode to test Server Core functionality. Your task is to perform the installation and configuration of this server. You will name it **LON-SVR6**, give it a static IP address of 172.16.0.26, and join it to the Contoso.com domain with all other default settings. They have also decided to implement Windows Admin Center for remote management of this server and other servers in the organization.

## Objectives

- Deploy and configure Server Core
- Implement and use remote server administration

## Estimated time: 60 minutes

## Exercise 1: Deploy and configure Server Core

### Scenario

As a part of the deployment plan, you will implement Server Core and configure it for remote management. 

The main tasks for this exercise are as follows:

1. Install Server Core.
1. Configure Server Core with sconfig and PowerShell.

### Task 1: Install Server Core

1. Start **LON-SVR6**. 

   > Note: **LON-SVR6** does not have an operating system installed. It has the Windows Server 2022 ISO attached and starts loading the installation files during startup.

1. At the **Microsoft Server Operating System Setup** page, note the **Language to install**, **Time and currency format**, and **Keyboard or input method** settings, and then select **Next**.

1. Select **Install now**.

1. On the **Select the operating system you want to install** page, ensure that **Windows Server 2022 Datacenter Evaluation** is selected, and then select **Next**.

1. Select the **I accept the Microsoft License Terms** check box and then select **Next**.

1. On the **Which type of installation do you want?** page, select **Custom: Install Microsoft Server Operating System only (advanced)**.

1. On the **Where do you want to install the operating system?** page, select **Next**. 

   > The operating system begins to install. Installation will take a few minutes and the virtual machine restarts as needed.

1. After installation completes, read the message about changing the Administrator password, select **OK** and press Enter.

   > **Note:** You may need to enter Ctrl-Alt-Del first to unlock the screen.

1. In the **`New password`** and **`Confirm password`** fields, enter **`Pa55w.rd`**, and then press Enter twice to acknowledge the password has been changed.

   > After a few moments **sconfig** starts automatically and presents the server management screen.

### Task 2: Configure Server Core with sconfig and PowerShell

1. On **LON-SVR6**, verify that the server management screen is active. 

   > **NOTE:** If the screen is not active, at the command prompt, enter **`sconfig`**, and then press Enter.

1. To access **Network settings**, enter **`8`**, and then press Enter.

1. To change adapter index #1, enter **`1`**, and then press Enter.

1. To set the network adapter address, enter **`1`**, and then press Enter.

1. To set a static IP address, enter **`S`**, and then press Enter.

1. To set the IP address, enter **`172.16.0.26`**, and then press Enter.

1. To set the subnet mask, enter **`255.255.0.0`**, and then press Enter.

1. To set the default gateway and observe the setting results, enter **`172.16.0.1`**, and then press Enter.

1. Press Enter to continue and return to the main management screen.

1. To access **Network settings**, enter **`8`**, and then press Enter.

1. To change adapter index #1, enter **`1`**, and then press Enter.

1. To set the Domain Name System (DNS) server, enter **`2`**, and then press Enter.

1. Enter **`172.16.0.10`**, and then press Enter. 

1. To leave the alternate DNS server blank, press Enter.

1. Press Enter to continue.

1. To exit to Command Line (PowerShell), enter **`15`**, and then press Enter.

1. At the PowerShell prompt, enter the following command and then press Enter:

    ```Rename-Computer -NewName LON-SVR6 -restart -force```

   > The server is renamed and then restarts.

1. On **LON-SVR6**, select Ctrl+Alt+Del, enter the password **Pa55w.rd**, and then press Enter.

   > After a few moments **sconfig** starts automatically and presents the server management screen.

1. To exit to Command Line (PowerShell), enter **`15`**, and then press Enter.

1. At the PowerShell prompt, enter the following command and then press Enter:

    ```Add-Computer -DomainName Contoso.com -Credential Contoso\Administrator -restart -force```

1. In the **Windows PowerShell credential request** window, enter **`Pa55w.rd`**, and then select **OK**.

   > LON-SVR6 is joined to the Contoso.com domain and then restarts.

### Results

After completing this exercise, you will have installed Server Core, configured the networking settings, renamed the server, and joined the Contoso domain.

## Exercise 2: Implement and use remote server administration

### Scenario

Now that you have deployed the Server Core server, you need to implement Windows Admin Center for remote administration.

The main tasks for this exercise are as follows:

1. Install Windows Admin Center.
1. Add servers for remote administration.
1. Configure Windows Admin Center extensions.
1. Verify remote administration.
1. Administer remote servers with Remote PowerShell.

### Task 1: Install Windows Admin Center

1. Switch to **LON-SVR1**.

1. Sign in as **Contoso\\Administrator** with a password of **Pa55w.rd**.

1. From the taskbar, open File Explorer, and then browse to **E:\\Labfiles\\Mod01**.

1. Select and run **WindowsAdminCenter2110.2.msi**.

1. On the **Windows Admin Center Setup** page, to accept the terms, select the check box, and then select **Next**.

1. On the **Send diagnostic data to Microsoft** page, select **Next**.

1. On the **Install Windows Admin Center on Windows Server** page, select **Next**.

1. On the **Installing Windows Admin Center** page, select **Next**.

1. On the **Configure Gateway Endpoint** page, select **Install**.

1. Select **Finish** and then close File Explorer.

   > **Note:** Wait approximately 3-4 minutes for the installation to complete before continuing with Task 2.

### Task 2: Add servers for remote administration

1. On **LON-SVR1**, from the taskbar, open Microsoft Edge.

1. In the address bar, enter ```Https://LON-SVR1.contoso.com```, and then press Enter. 

1. At the Windows Security prompt, enter **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > The Windows Admin Center console opens. Notice that the host server (**Lon-svr1.contoso.com**) is listed by default.

1. In Windows Admin Center, close the **Read what's new** message box.

1. In the Windows Admin Center, select **Add**.

1. In the **Add or create resources** pane, in the **Servers** box, select **Add**

1. In the **Server name** box, enter **LON-DC1**. 

   > In a few moments, a message displays that Credentials are needed, however the server can still be added. 

1. Select **Add**.

1. Select **Add** again and then repeat the steps to add **LON-SVR6**.

### Task 3: Configure Windows Admin Center extensions

1. In Windows Admin Center, in the upper right corner, select the **Settings** icon (the cog wheel).

1. In the left pane, select **Extensions**. 

   > Note that there are no available extensions.

1. In the **details** pane, select **Feeds**, and then select **Add**.

1. In the **Add package source** pane, in the **Extension feed URL or path** box, enter **E:\\Labfiles\\Mod01**, and then select **Add**.

1. Select **Available extensions**. 

   > Now you can observe the extensions that have been downloaded and stored in the Extension path.

1. Select the **DNS (Preview)** extension, and then select **Install**. 

   > The extension will install and Windows Admin Center will refresh.

1. On the top menu, next to **Settings**, select the drop-down arrow, and then select **Server Manager**.

1. On the **Server connections** page, select the ```LON-DC1``` link.

1. On the **Specify your credentials** page, select **Use another account for this connection**, and then enter **Contoso\\Administrator** with the password of **Pa55w.rd**. Select **Continue**.

   > The LON-DC1 connection displays.

1. To review the DNS settings on LON-DC1, in the Tools menu select **DNS**.

1. Select the ```Contoso.com``` zone and observe the records returned in the lower part of the console.

### Task 4: Verify remote administration

1. On the top menu, next to **Settings**, select the drop-down arrow, and then select **Server Manager**.

1. On the **Server connections** page, select the ```LON-SVR6``` link.

1. On the **Specify your credentials** page, select **Use another account for this connection**, and then enter **Contoso\\Administrator** with the password of **Pa55w.rd**. Select **Continue**.

   > The LON-SVR6 connection displays.

1. In the left pane, scroll down and observe the basic administration tools available. Select **Roles & features** and note what is installed and what is available to install. 

1. Scroll down and check the box beside **Telnet Client**, and then select **Install**, which will be at the top of the list.

1. To install the Telnet Client, select **Yes**. In a few moments, you will get a message that the Telnet Client installed successfully.

1. Close the browser.

### Task 5: Administer remove servers with Remote PowerShell

1. On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

1. At the PowerShell prompt, enter the following command then then press Enter:

    ```Enter-PSSession -ComputerName LON-SVR6```

1. At the PowerShell prompt, enter the following command then press Enter:

    ```Get-Service -Name AppIDSvc```

   > Note that the service is currently stopped.

1. At the PowerShell prompt, enter the following command and then press Enter:

    ```Start-Service -Name AppIDSvc```

1. At the PowerShell prompt, enter the following command and then press Enter:

    ```Get-Service -Name AppIDSvc```

   > Note that the service is now running.

### Results

After completing this exercise, you will have installed Windows Admin Center and connected the server to manage. You performed management tasks of installing a feature. Finally, you used Remote PowerShell to check the status of a service and start a service.