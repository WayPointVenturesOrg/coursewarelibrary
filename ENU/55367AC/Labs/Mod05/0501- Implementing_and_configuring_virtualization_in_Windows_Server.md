---
lab:
    title: 'Lab: Implement and configure virtualization in Windows Server'
    module: 'Module 5: Hyper-V virtualization and containers in Windows Server'
---

# Lab: Implement and configure virtualization in Windows Server

## Scenario

Contoso recently deployed a Windows Server 2022 server and client infrastructure. Because of many Contoso's physical servers are underutilized, you plan to expand virtualization to optimize the environment, and you want to perform a proof of concept to validate how you can use Hyper-V to manage a virtual-machine (VM) environment. 

The Contoso DevOps team also wants to explore container technology to determine whether it can help reduce deployment times for new applications and simplify moving applications to the cloud. You'll work with the DevOps team to evaluate Windows Server containers and whether to provides Internet Information Services (IIS) web services in a container.

## Objectives

After completing this lab, you'll be able to:

- Create and configure VMs.
- Install and configure containers.

## Estimated time: 60 minutes

## Exercise 1: Create and configure VMs

### Exercise scenario

In this exercise, you use Hyper-V Manager and Windows Admin Center to create and configure a VM. You'll start with creating a private virtual network switch, and then you'll create a differencing drive of a base image that's already been prepared with the operating system (OS) to be installed on the VM. Finally, you'll create a generation 1 VM that uses the differencing drive and private switch that you've prepared for the proof of concept.

The main tasks for this exercise are:

1. Create a Hyper-V virtual switch.
1. Create a virtual hard disk (VHD).
1. Create a VM.
1. Manage VMs by using Windows Admin Center.

### Task 1: Create a Hyper-V virtual switch

1. Sign in to **LON-ADM1** as **Contoso\\Administrator** with the password **Pa55w.rd**.
1. Select **Start**, and then select **Server Manager**.
1. In **Server Manager**, select **All Servers**.
1. In the **Servers** list, right-click or access the context menu for **LON-SVR1**, and then select **Hyper-V Manager**.
1. In **Hyper-V Manager**, ensure that **```LON-SVR1.Contoso.com```** is selected.
1. In the **Actions** pane, select **Virtual Switch Manager**.
1. In the **Virtual Switch Manager**, in the **Create virtual switch** pane, select **Private**, and then select **Create Virtual Switch**.
1. In the **Virtual Switch Properties** box, enter the following details, and then select **OK**:
   - Name: **Contoso Private Switch**
   - Connection type: **Private network**

### Task 2: Create a VHD

1. On **LON-ADM1**, in **Hyper-V Manager**, select **New** and then select **Hard Disk**. 

   > The **New Virtual Hard Disk Wizard** starts.

1. On the **Before you Begin page**, select **Next**.

1. On the **Choose Disk Format** page, select **VHD**, and then select **Next**.

1. On the **Choose Disk Type** page, select **Differencing**, and then select **Next**.

1. On the **Specify Name and Location** page, enter the following, and then select **Next**:
   - Name: **LON-VM1**
   - Location: **C:\Base**

1. On the **Configure Disk** page, in the **Location** box, enter **C:\Base\BaseImage.vhd**, and then select **Next**.

1. On the **Summary** page, select **Finish**.

### Task 3: Create a VM

1. On **LON-ADM1**, in **Hyper-V Manager**, select **New**, and then select **Virtual Machine**. 

   > The **New Virtual Machine Wizard** starts.

1. On the **Before you Begin page**, select **Next**.

1. On the **Specify Name and Location** page, enter **LON-VM1**, and then select the checkbox next to **Store the virtual machine in a different location**.

1. In the **Location** box, enter **C:\Base**, and then select **Next**.

1. On the **Specify Generation** page, select **Generation 1**, and then select **Next**.

1. On the **Assign Memory** page, enter **4096**, and then select **Next**.

1. On the **Configure Networking** page, select the **Connection** drop-down menu, select **Contoso Private Switch**, and then select **Next**.

1. On the **Connect Virtual Hard Disk** page, select **Use an existing virtual hard disk**, and then select **Browse**.

1. Browse to **C:\Base**, select **LON-VM1.vhd**, select **Open**, and then select **Next**.

1. On the **Summary** page, select **Finish**. 

   > Notice that **LON-VM1** displays in the VMs list.

1. Select **LON-VM1**, and then in the **Actions** pane, under **LON-VM1**, select **Settings**.

1. In the **Hardware** list, select **Memory**.

1. In the **Dynamic Memory** section, select the checkbox next to **Enable Dynamic Memory**.

1. Next to **Maximum RAM**, enter **4096**, and then select **OK**.

1. Close **Hyper-V Manager**.

### Task 4: Manage VMs by using Windows Admin Center

1. On **LON-ADM1**, on the taskbar, select **Microsoft Edge**.

1. In Microsoft Edge, on the **Favorites** bar, select **Windows Admin Center**.

1. In the **Windows Security** box, enter **Contoso\\Administrator** with the password **Pa55w.rd**, and then select **OK**.

1. In the **All connections** list, select **LON-SVR1.Contoso.com**.

   > **Note:** You might need to select **Manage As** to enter credentials in the next step.

1. In the **Specify your credentials** page, select **Use another account for this connection**, and then enter **Contoso\Administrator** with the password  **Pa55w.rd**.

1. In the **Tools** list, select **Virtual Machines**, and then review the **Summary** pane.

1. Select the **Inventory** tab, and notice the two VMs.

1. Select **LON-VM1**. 

1. Select **Settings**, and then select **Disks**.

1. Select **Add disk**.

1. Select **New Virtual Hard Disk**, and then in the **Size (GB)** box, enter **5** gigabytes (GBs). Select **Create**.

   > **Note:** The **New Disk** setting might be greyed out, which is a known issue. We recommend that you go to the **Overview** page, and then select **Restart** to restart **LON-SVR1** or create the disk using Hyper-V Manager, if necessary.

1. Select **Save disks settings**, and then select **Close**.

1. Select **LON-VM1**, select **Power**, and then select **Start**.

1. Scroll down and display the statistics for the running VM.

1. Select **Power**, and then select **Shut down**. Select **Yes** to confirm.

1. In the **Tools** list, select **Virtual switches**. Notice the two switches that have been configured.

1. Close all open windows on **LON-ADM1**.

### Results

After this exercise, you'll have used Hyper-V Manager and Windows Admin Center to create a virtual switch and VHD, and then create and manage a VM.

## Exercise 2: Install and configure containers

### Exercise Scenario

In this exercise, you'll use Docker to install and run Windows containers, and then use Windows Admin Center to manage containers.

The main tasks for this exercise are:

1. Install Docker on Windows Server.
1. Install and run a Windows container.
1. Use Windows Admin Center to manage containers.

### Task 1: Install Docker on Windows Server

1. On **LON-ADM1**, from the taskbar, open **Microsoft Edge**.
1. On the **Favorites** bar, select **Windows Admin Center**.
1. In the Windows Security box, enter the following credentials:

   - User name: **Contoso\\Administrator**
   - Password: **Pa55w.rd**
1. On the **All connections** page, select **LON-SVR1.Contoso.com**.
1. On the **Specify your credentials** page, select **Use another account for this connection**. Provide the **Contoso\\Administrator** credentials, and then select **Continue**.
1. In the **Tools** list, select **PowerShell**. Provide the **Contoso\\Administrator** credentials, and then select **Enter**. You're now connected to **LON-SVR1** using a Remote PowerShell connection.

   > **Note:** The PowerShell connection in **WAC** might be slow because of nested virtualization that's used in the lab. A recommended alternative method is to use **Enter-PSSession -computername LON-SVR1** from a PowerShell window on **LON-ADM1**.

1. At the PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
   ```

1. At the **NuGet Provider** prompt, enter **`Y`** for yes, and then select Enter.
1. At the PowerShell command prompt, enter the following command, and then select Enter:

   ```
   Install-Package -Name docker -ProviderName DockerMsftProvider
   ```

1. At the confirmation prompt, enter **`A`** for Yes to All, and then select Enter.

1. After the installation is complete, restart the computer by using the following command:

   ```
   Restart-Computer -Force
   ```

### Task 2: Install and run a Windows container

1. After **LON-SVR1** restarts, reconnect the PowerShell tool, and then provide the **Contoso\\Administrator** credentials.

1. Verify the installed version of Docker by using the following command:

   ```
   Get-Package -Name Docker -ProviderName DockerMsftProvider
   ```

   > **Note:** You might need to run **Start-Service -name Docker** before running the next commands.

1. To verify whether any Docker images are currently pulled, use the following command:

   ```
   Docker images
   ```

   > Notice that there are no images in the local repository store.

1. To review Docker base images from the online repository, use the following command:

   ```
   Docker search Microsoft
   ```

   > Notice the variety of base images, each representing various runtime scenarios. You might need to run the command twice to obtain the list.
   >

1. To download a server-core image, with IIS, that matches the host OS, run the following command:

   ```
   docker pull mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
   ```

   > **Note:** This download might take more than 15 minutes to complete.

1. To confirm the Docker image that's currently pulled, use the following command:

   ```
   Docker images
   ```

   > Notice that there's now an image listed in the local repository store.

1. To run the container, enter the following command:

   ```
   Docker run -d -p 80:80 --name ContosoSite mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022 cmd
   ```

   > This command runs the IIS image as a background service (-d) named ContosoSite and configures networking such that port 80 of the container host (**LON-SVR1**) maps to port 80 of the container.

1. Enter the following command to retrieve the IP address information of the container host:

   ```
   ipconfig
   ```

   > Note the IPv4 address of the Ethernet adapter named vEthernet (nat). This is the new container's address. Make a note of the IPv4 address of the Ethernet adapter named **Ethernet**, which is the IP address of the host (**LON-SVR1**).

1. In Microsoft Edge, open another tab, and then enter **```http://172.16.0.12```**. 

   > Observe the default IIS page provided by IIS running in the Docker container.

1. In the remote PowerShell session, enter the following command:

   ```
   docker ps
   ```

   > This command provides information on the container that's currently running on LON-SVR1. Take note of the container name, as you'll use it to stop the container.

1. In the remote PowerShell session, enter the following command:

     ```
     docker stop ContosoSite
     ```

1. Rerun the `docker ps` command to confirm that the container has stopped.

### Task 3: Use Windows Admin Center to manage containers

1. On **LON-ADM1**, ensure that **LON-SVR1** is targeted in the Windows Admin Center, and then select the **Containers** tool.
1. Browse through each of the **Overview**, **Containers**, **Images**, **Networks**, and **Volumes** tabs.

### Results

After this exercise, you'll have installed Docker on Windows Server and installed and run a Windows container that has web services.
