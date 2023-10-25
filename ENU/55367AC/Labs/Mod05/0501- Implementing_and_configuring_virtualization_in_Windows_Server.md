---
lab:
    title: 'Lab: Implement and configure virtualization in Windows Server'
    module: 'Module 5: Hyper-V virtualization and containers in Windows Server'
---

# Lab A: Implement and configure virtualization in Windows Server

## Scenario

Contoso recently deployed a Windows Server 2022 server and client infrastructure. Because of many Contoso's physical servers are underutilized, you plan to expand virtualization to optimize the environment, and you want to perform a proof of concept to validate how you can use Hyper-V to manage a virtual-machine (VM) environment. 

## Objectives

After completing this lab, you'll be able to:

- Create and configure VMs.

## Estimated time: 30 minutes
## Exercise 1: Create and configure VMs

### Exercise scenario

In this exercise, you use Hyper-V Manager and Windows Admin Center to create and configure a VM. You'll start with creating a private virtual network switch, and then you'll create a differencing drive of a base image that's already been prepared with the operating system (OS) to be installed on the VM. Finally, you'll create a generation 1 VM that uses the differencing drive and private switch that you've prepared for the proof of concept.

The main tasks for this exercise are:

1. Create a Hyper-V virtual switch.
2. Create a virtual hard disk (VHD).
3. Create a VM.
4. Manage VMs by using Windows Admin Center.

### Task 1: Create a Hyper-V virtual switch

1. Sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.
2. Select **Start**, and then select **Server Manager**.
3. In **Server Manager**, select **All Servers**.
4. In the **Servers** list, right-click or access the context menu for **LON-SVR1**, and then select **Hyper-V Manager**.
5. In **Hyper-V Manager**, ensure that **LON-SVR1.Contoso.com** is selected.
6. In the **Actions** pane, select **Virtual Switch Manager**.
7. In the **Virtual Switch Manager**, in the **Create virtual switch** pane, select **Private**, and then select **Create Virtual Switch**.
8. In the **Virtual Switch Properties** box, enter the following details, and then select **OK**:
   - Name: **`Contoso Private Switch`**
   - Connection type: **Private network**

### Task 2: Create a VHD

1. On **LON-ADM1**, in **Hyper-V Manager**, select **New** and then select **Hard Disk**. 

>Note: The **New Virtual Hard Disk Wizard** starts.

2. On the **Before you Begin page**, select **Next**.

3. On the **Choose Disk Format** page, select **VHD**, and then select **Next**.

4. On the **Choose Disk Type** page, select **Differencing**, and then select **Next**.

5. On the **Specify Name and Location** page, enter the following, and then select **Next**:

   - Name: **`LON-VM1`**
   - Location: **`C:\Base`**

6. On the **Configure Disk** page, in the **Location** box, enter **`C:\Base\BaseImage.vhd`**, and then select **Next**.

7. On the **Summary** page, select **Finish**.

### Task 3: Create a VM

1. On **LON-ADM1**, in **Hyper-V Manager**, select **New**, and then select **Virtual Machine**. 

>Note: The **New Virtual Machine Wizard** starts.

2. On the **Before you Begin page**, select **Next**.

3. On the **Specify Name and Location** page, enter **`LON-VM1`**, and then select the checkbox next to **Store the virtual machine in a different location**.

4. In the **Location** box, enter **`C:\Base`**, and then select **Next**.

5. On the **Specify Generation** page, select **Generation 1**, and then select **Next**.

6. On the **Assign Memory** page, enter **`4096`**, and then select **Next**.

7. On the **Configure Networking** page, select the **Connection** drop-down menu, select **Contoso Private Switch**, and then select **Next**.

8. On the **Connect Virtual Hard Disk** page, select **Use an existing virtual hard disk**, and then select **Browse**.

9. Browse to **C:\Base**, select **LON-VM1.vhd**, select **Open**, and then select **Next**.

10. On the **Summary** page, select **Finish**. 

>Note: Notice that **LON-VM1** displays in the VMs list.

11. Select **LON-VM1**, and then in the **Actions** pane, under **LON-VM1**, select **Settings**.

12. In the **Hardware** list, select **Memory**.

13. In the **Dynamic Memory** section, select the checkbox next to **Enable Dynamic Memory**.

14. Next to **Maximum RAM**, enter **`4096`**, and then select **OK**.

15. Close **Hyper-V Manager**.

### Task 4: Manage VMs by using Windows Admin Center

1. On **LON-ADM1**, on the taskbar, select **Microsoft Edge**.

2. In Microsoft Edge, on the **Favorites** bar, select **Windows Admin Center**.

3. In the **Windows Security** box, enter **`Contoso\Administrator`** with the password **`Pa55w.rd`**, and then select **OK**.

4. In the **All connections** list, select **LON-SVR1.Contoso.com**.

5. In the **Specify your credentials** page, select **Use another account for this connection**, and then enter **`Contoso\Administrator`** with the password  **`Pa55w.rd`**.

6. In the **Tools** list, select **Virtual Machines**, and then review the **Summary** pane.

7. Select the **Inventory** tab, and notice the two VMs.

8. Select **LON-VM1**. 

9. Select **Settings**, and then select **Disks**.

10. Select **Add disk**.

11. Select **New Virtual Hard Disk**, and then in the **Size (GB)** box, enter **`5`** gigabytes (GBs). Select **Create**.

12. Select **Save disks settings**, and then select **Close**.

13. Select **LON-VM1**, select **Power**, and then select **Start**.

14. Scroll down and display the statistics for the running VM.

15. Select **Power**, and then select **Shut down**. Select **Yes** to confirm.

>Note: It may take several minutes before the Power options become available.

16. In the **Tools** list, select **Virtual switches**. Notice the two switches that have been configured.

17. Close all open windows on **LON-ADM1**.

### Results

After this exercise, you'll have used Hyper-V Manager and Windows Admin Center to create a virtual switch and VHD, and then create and manage a VM.

# Lab B: Install and configure containers

## Scenario

The Contoso, Ltd. DevOps team wants to explore container technology to determine whether it can help reduce deployment times for new applications and simplify moving applications to the cloud. You'll work with the DevOps team to evaluate Windows Server containers and whether to provide Internet Information Services (IIS) web services in a container.

## Objectives

After completing this lab, you'll be able to:

- Install Docker and download an image.
- Deploy and configure a container.
- Run a Windows container by using Windows Admin Center

## Estimated time: 60 minutes
## Exercise 1: Install Docker and download an image

### Exercise Scenario

In this exercise, you'll use PowerShell Remote to download and install Docker on LON-SVR1. You'll then download an image to use as the base for an IIS container.

The main tasks for this exercise are:

1. Install Docker on Windows Server.
2. Download an image.

### Task 1: Install Docker on Windows Server

1. If necessary, sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

2. Select **Start**, and then select **Windows PowerShell ISE**.

3. In the **Windows PowerShell ISE** command prompt, enter the following command and then press Enter:

   ```
   Enter-PSSession -computername LON-SVR1
   ```
4. Open the **Windows PowerShell ISE** script pane, and then enter the following commands on the first two lines:

   ```
   Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
   .\install-docker-ce.ps1
   ```
5. From the Windows PowerShell ISE toolbar, select the **Run Script** command.

>Note:  The Invoke-Webrequest command downloads the runtime environment needed to run containers. After running the install-docker-ce.ps1 command, LON-SVR1 restarts.

6. Close Windows PowerShell ISE without saving changes.

7. Switch to **LON-SVR1**, and then after **LON-SVR1** restarts, sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

>Note:  A Windows PowerShell window opens and the installation continues. 

8. When you receive the message **Script complete!**, close the PowerShell window on LON-SVR1.

>Note:  If you recieve an error message, rerun the script from step 4. 

### Task 2: Download an image

1. Switch to **LON-ADM1**.

2. Select **Start**, and then select **Windows PowerShell ISE**.

3. In the **Windows PowerShell ISE** command prompt, enter the following command and then press Enter:

   ```
Enter-PSSession -computername LON-SVR1
   ```

4. To verify that the Docker installation works correctly, enter the following command in the Windows PowerShell ISE command window:

   ```
   docker container run hello-world:nanoserver
   ```

>Note:  An error message displays indicating the image can't be found locally. The image is then pulled from the online repository. It'll take a few minutes for the sample container to download from the online repository and run on the host server. When it's complete, you'll receive a message that states **Hello from Docker!**

5. To verify the Docker images currently pulled on LON-SVR1, use the following command:

   ```
   Docker images
   ```

>Note:  Notice that the only image in the local repository store is the **hello-world** nanoserver image.

6. To review Docker base images from the online repository, use the following command:

   ```
   Docker search Microsoft
   ```

>Note:  Notice the variety of base images, each representing various runtime scenarios. You might need to run the command twice to obtain the list.

7. To download a server-core image that matches the host operating system (OS), run the following command:

   ```
   docker pull mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
   ```

>Note:  This download might take more than 15 minutes to complete.

### Results

After this exercise, you'll have installed Docker on Windows Server and downloaded images from the online repository.

## Exercise 2: Deploy and configure a container

### Exercise Scenario

Now that you've prepared the container host machine and downloaded the image, the next step is to deploy a container image. You'll then be able to validate that the container deployed, is functional, and is ready to be managed.

The main tasks for this exercise are:

1. Deploy a new container.
2. Manage the container.

### Task 1: Deploy a new container

1. On **LON-ADM1**, confirm the Docker images currently pulled on LON-SVR1 by running the following command in Windows PowerShell ISE:

   ```
   Docker images
   ```

>Note:  Notice that both the **hello-world** and **IIS** images are listed in the local repository store on LON-SVR1.

2. To run the IIS container, enter the following command:

   ```
   Docker run -d -p 8080:80 --name ContosoSite mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022 cmd
   ```

>Note:  This command runs the IIS image as a background service (-d) named **ContosoSite** and configures networking such that port 8080 of the container host (**LON-SVR1**) maps to port 80 of the container.

3. Enter the following command to retrieve the container host's IP address information:

   ```
   ipconfig
   ```

>Note:  Note the IPv4 address of the Ethernet adapter named **vEthernet (nat)**. This is the new container's IP address. Make a note of the IPv4 address of the Ethernet adapter named **Private Network**. This is the IP address of the Host (**LON-SVR1**).

4. From the taskbar, select **Microsoft Edge**, and then enter **`http://172.16.0.12:8080`**. 

>Note:  Observe the default IIS page provided by IIS running in the Docker container.

5.  Close Microsoft Edge.

### Task 2: Manage the container

1. At the **Windows PowerShell ISE** command prompt, run the following command:

   ```
   docker ps
   ```

>Note:  This command provides information on the container that's currently running on **LON-SVR1**. Take note of the container name as you'll use it to stop the container.

2. At the **Windows PowerShell ISE** command prompt, run the following command:

   ```
docker stop ContosoSite
   ```

3. At the **Windows PowerShell ISE** command prompt, run the following command to confirm that the container has stopped:

   ```
   docker ps
   ```
4.  Close Windows PowerShell ISE.

### Results

After this exercise, you'll have deployed and managed a container.

## Exercise 3: Run a Windows container by using Windows Admin Center

### Exercise Scenario

In this exercise, you use Windows Admin Center to run and manage containers. To manage containers, you need to install the Containers extension in Windows Admin Center.

The main tasks for this exercise are:

1. Install the Containers extension.
2. Manage Containers.
3. Run a Container.

### Task 1: Install the Containers extension

1.  On **LON-SVR1**, from the taskbar, open Microsoft Edge.

2.  In the favorites bar, select **Windows Admin Center**. 

3.  At the Windows Security prompt, enter **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

4.  In Windows Admin Center, in the upper right corner, select the **Settings** (cog wheel) icon.

5.  In the left pane, select **Extensions**. 

>Note:  A list of available extensions is displayed.

7.  Scroll down the list, select the **Containers** extension, and then select **Install**. 

>Note:  The extension will install, and Windows Admin Center will refresh.

8.  On the top menu, select the **Settings** drop-down menu, and then select **Server Manager**.

9.  On the **Server connections** page, select the **lon-svr1.contoso.com** link.

10. In the **Specify your credentials** page, select **Use another account for this connection**, and then enter **`Contoso\Administrator`** with the password  **`Pa55w.rd`**.

### Task 2: Manage Containers

1.  In the left pane, scroll and select **Containers**. 

>Note: Take note that the **Overview** option is selected. The details page provides the Overview information for all Containers, Images, Networks, and Volumes.

2.  In the **Container host** section, select **Containers**.

>Note: The Containers page provides a list and status of all containers available on the server.

3.  In the **Container host** section, select **Images**.

>Note: Notice the images that you have already previously downloaded.

4.  On the **Images** page, select **Pull**.

>Note: **Pull Container Image** opens to enable you to download a container image from a specified repository.

5.  In the **Repository** text box, enter **`mcr.microsoft.com/windows/servercore`**.

6.  In the **Tag** text box, enter **`ltsc2022`**.

7.  Select **Pull** to download the Windows servercore base image for containers.

>Note: You should receive a message that says **Successfully Pulled new image**. It will take a moment or two to refresh the Images page.

>Note: Notice the new image named ltsc2022.

### Task 3: Run a Container

1.  In the **Container host** section, select **Images**.

2.  Select the **windowsservercore-ltsc2022** image, and then select **Run**.

3.  On the **run image** page, for **Container Name**, enter **`app1`**.

>Note: The name of the container must be lower case.

4.  In the **Publish Port(s)** field, enter **`8080:80`** and then select **Run**.

5.  In the **Container host** section, select **Containers**.

6.  On the **Containers** page, select **app1**.

>Note: Review the details for app1. You should notice CPU and Memory details displayed.

7.  On the **Containers** page, select **app1** and then selct **End**. 

8.  At the **End container** prompt, select **End**.

>Note: A message displays that indicates that the app1 container has successfully ended.

### Results
After this exercise, you'll have run a Windows container by using Windows Admin Center.
