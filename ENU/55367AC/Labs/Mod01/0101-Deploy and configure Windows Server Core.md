---
lab:
    title: 'Lab: Deploy and configure Windows Server'
    module: 'Module 1: Windows Server administration'
---

# Lab: Deploy and configure Windows Server Core

## Scenario

Contoso, Ltd. needs to implement several new servers in their network environment and will use Windows Server Core. They'll also implement Windows Admin Center for remote management of both these servers and other servers in the organization.

## Objectives

- Deploy and configure Server Core.
- Implement and use remote server administration.

## Estimated time: 45 minutes

## Exercise 1: Deploy and configure Server Core

### Scenario

As a part of the deployment plan, you'll implement Server Core and configure it for remote management. 

The main tasks for this exercise are as follows:

1. Install Server Core.
2. Configure Server Core with SConfig and Windows PowerShell.
3. Install Features on Demand on Server Core.

### Task 1: Install Server Core

1. Start **LON-SVR4-B**. 

>Note: **LON-SVR4-B** doesn't have an operating system installed. It has the Windows Server 2022 ISO attached and starts loading the installation files during startup.

2. At the **Microsoft Server Operating System Setup** page, note the **Language to install**, **Time and currency format**, and **Keyboard or input method** settings, and then select **Next**.

3. Select **Install now**.

4. On the **Select the operating system you want to install** page, ensure that **Windows Server 2022 Standard Evaluation** is selected, and then select **Next**.

5. Select the **I accept the Microsoft License Terms** checkbox and then select **Next**.

6. On the **Which type of installation do you want?** page, select **Custom: Install Microsoft Server Operating System only (advanced)**.

7. On the **Where do you want to install the operating system?** page, select **Next**. 

>Note: The operating system begins to install. Installation will take a few minutes and the virtual machine restarts as needed. After the restart, to boot into the installed operating sytem, do **NOT** press any key after the virtual machine restarts.

8. After installation completes, read the message about changing the Administrator password, select **OK**, and then select Enter.

>Note:  You might need to enter Ctrl+Alt+Del first to unlock the screen.

9. In the **New password** and **Confirm password** fields, enter **`Pa55w.rd`**, and then select Enter twice to acknowledge the password has been changed.

>Note: After a few moments, **sconfig** starts automatically and presents the server management screen.

### Task 2: Configure Server Core with SConfig and PowerShell

1. On **LON-SVR4-B**, verify that the server management screen is active. 

>Note:  If the screen isn't active, at the command prompt, enter **`sconfig`**, and then select Enter.

2. To access **Network settings**, enter **`8`**, and then select Enter.

3. To change adapter index #1, enter **`1`**, and then select Enter.

4. To set the network adapter address, enter **`1`**, and then select Enter.

5. To set a static IP address, enter **`S`**, and then select Enter.

6. To set the IP address, enter **`172.16.0.15`**, and then select Enter.

7. To set the subnet mask, enter **`255.255.0.0`**, and then select Enter.

8. To set the default gateway and observe the setting results, enter **`172.16.0.1`**, and then select Enter.

9. Select Enter to continue and return to the main management screen.

10. To access **Network settings**, enter **`8`**, and then select Enter.

11. To change adapter index #1, enter **`1`**, and then select Enter.

12. To set the Domain Name System (DNS) server, enter **`2`**, and then select Enter.

13. Enter **`172.16.0.10`**, and then select Enter. 

14. To leave the alternate DNS server blank, select Enter.

15. Select Enter to continue.

16. To exit to Command Line (PowerShell), enter **`15`**, and then select Enter.

17. At the PowerShell prompt, enter the following command, and then select Enter:

```
Rename-Computer -NewName LON-SVR4 -restart -force
```

>Note: The server is renamed and then it restarts.

18. On **LON-SVR4**, select Ctrl+Alt+Del, enter the password of **`Pa55w.rd`**, and then select Enter.

>Note: After a few moments, **sconfig** starts automatically and presents the server management screen.

19. To exit to Command Line (PowerShell), enter **`15`**, and then select Enter.

20. At the PowerShell prompt, enter the following command, and then select Enter:

```
Add-Computer -DomainName Contoso.com -Credential Contoso\Administrator -restart -force
```

21. In the **Windows PowerShell credential request** window, enter **`Pa55w.rd`**, and then select **OK**.

>Note: **LON-SVR4** is joined to the Contoso.com domain and then restarts.

### Task 3: Install Features on Demand on Server Core

1. On **LON-SVR4**, mount the **Win2022_FOD.iso** image file to the DVD Drive.

2. On **LON-SVR4**, select Ctrl+Alt+Del, enter the password of **`Pa55w.rd`**, and then select Enter.

>Note: After a few moments, **sconfig** starts automatically and presents the server management screen.

3. To exit to Command Line (PowerShell), enter **`15`**, and then select Enter.

4. At the command prompt, enter **`Explorer.exe`**. and then select Enter.

>Note: Note that the command doesn't run and returns an error.

5. At the PowerShell prompt, enter the following command, and then select Enter:

```
Add-Windowscapability -Online -Name Servercore.Appcompatibility~~~~0.0.1.0 -Source D:\LanguagesAndOptionalFeatures\ -LimitAccess
```

>Note: The Features on Demand files install on **LON-SVR4**.

6. At the PowerShell prompt, enter **`Restart-computer`**  and then select Enter.

>Note: **LON-SVR4** restarts and finalizes the installation.

7. On **LON-SVR4**, select Ctrl+Alt+Del, enter the password of **`Pa55w.rd`**, and then select Enter.

>Note: After a few moments, **sconfig** starts automatically and presents the server management screen.

8. To exit to Command Line (PowerShell), enter **`15`**, and then select Enter.

9. At the command prompt, enter **`Explorer.exe`**, and then select Enter.

>Note: Note that File Explorer now opens successfully.

10. Close the File Explorer window.

### Results

After completing this exercise, you'll have installed Server Core, configured the networking settings, renamed the server, and joined the Contoso domain.

## Exercise 2: Implement and use remote server administration

### Scenario

Now that you have deployed the Server Core servers, you need to implement Windows Admin Center for remote administration.

The main tasks for this exercise are as follows:

1. Install Windows Admin Center.
2. Add servers for remote administration.
3. Configure Windows Admin Center extensions.
4. Verify remote administration.
5. Administer servers with Remote PowerShell.

### Task 1: Install Windows Admin Center

1. Switch to **LON-ADM1-B**.

2. Sign in as **`Contoso\Administrator`** with a password of **`Pa55w.rd`**.

3. From the taskbar, open File Explorer, and then browse to **C:\\Labfiles\\Mod01**.

4. Select and run **WindowsAdminCenter2110.2.msi**.

5. On the **Windows Admin Center Setup** page, to accept the terms, select the checkbox, and then select **Next**.

6. On the **Send diagnostic data to Microsoft** page, select **Next**.

7. On the **Use Microsoft Update** page, select **Next**.

8. On the **Install Windows Admin Center on Windows Server** page, select **Next**.

9. On the **Installing Windows Admin Center** page, select **Next**.

10. On the **Configure Gateway Endpoint** page, select **Install**.

11. Select **Finish** and then close File Explorer.

>Note: Wait approximately 5-10 minutes for the installation to complete before continuing with Task 2.

### Task 2: Add servers for remote administration

1. On **LON-ADM1**, from the taskbar, open Microsoft Edge.

2. In the address bar, enter `Https://LON-ADM1.contoso.com`, and then select Enter. 

3. At the Windows Security prompt, enter **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

>Note: The Windows Admin Center console opens. Notice that the host server (**lon-adm1.contoso.com**) is listed by default.

4. In Windows Admin Center, close the **Read what's new** box.

5. In the Windows Admin Center, select **Add**.

6. In the **Add or create resources** pane, in the **Servers** box, select **Add**

7. In the **Server name** box, enter **LON-DC1**. 

>Note: In a few moments, a message displays that Credentials are needed, however the server can still be added. 

8. Select **Add**.

9. Select **Add** again and then repeat the steps to add **LON-SVR4**.

### Task 3: Configure Windows Admin Center extensions

1. In Windows Admin Center, in the upper right corner, select the **Settings** icon (the cog wheel).

2. In the left pane, select **Extensions**. 

>Note: Note that there are no available extensions.

3. On the **details** pane, select **Feeds**, and then select **Add**.

4. On the **Add package source** pane, in the **Extension feed URL or path** box, enter **`C:\Labfiles\Mod01`**, and then select **Add**.

5. Select **Available extensions**. 

>Note: Now you can observe the extensions that have been downloaded and stored in the **Extension** path.

6. Select the **DNS (Preview)** extension, and then select **Install**. 

>Note: The extension will install and Windows Admin Center will refresh.

7. On the top menu, next to **Settings**, select the drop-down arrow, and then select **Server Manager**.

8. On the **Server connections** page, select the **LON-DC1** link.

9. On the **Specify your credentials** page, select **Use another account for this connection**, and then enter **`Contoso\Administrator`** with the password of **`Pa55w.rd`**. Select **Continue**.

>Note: The **LON-DC1** connection displays.

10. To review the DNS settings on **LON-DC1**, in the **Tools** menu, select **DNS**.

11. Select the **Contoso.com** zone and observe the records returned in the lower part of the console.

### Task 4: Verify remote administration

1. In Windows Admin Center, select the **Overview** icon in the left pane. 

>Note: Note that the **details** pane for Windows Admin Center displays basic server information and performance monitoring, which is like **Task Manager**.

2. On the left pane, scroll down and observe the basic administration tools available. Select **Roles & features** and note what's installed and what's available to install. 

3. Scroll down and check the box beside **Telnet Client**, and then select **Install**, which will be at the top of the list.

4. To install the Telnet Client, select **Yes**. 

>Note: In a couple of minutes, you'll get a message that the Telnet Client installed successfully.

5. Close the browser.

### Task 5: Administer servers with Remote PowerShell

1. Select **Start**, and then select **Windows PowerShell ISE**.

2. At the PowerShell prompt, enter the following command, and then then select Enter:

   ```Enter-PSSession -ComputerName LON-DC1```

3. At the PowerShell prompt, enter the following command, and then select Enter:

   ```Get-Service -Name AppIDSvc```

>Note: Note that the service is currently stopped.

4. At the PowerShell prompt, enter the following command, and then select Enter:

   ```Start-Service -Name AppIDSvc```

5. At the PowerShell prompt, enter the following command, and then select Enter:

   ```Get-Service -Name AppIDSvc```

>Note: Note that the service is now running.

### Results

After completing this exercise, you'll have installed Windows Admin Center and connected the server to manage. You performed management tasks of installing a feature. Finally, you used Remote PowerShell to check the status of a service and start a service.
