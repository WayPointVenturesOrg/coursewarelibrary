---
lab:
    title: 'Lab: Install and configure containers'
    module: 'Module 6: Deploy and manage Windows Server and Hyper-V containers'
---

# Lab: Install and configure containers

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

In this exercise, you'll use Windows PowerShell to download and install Docker on a Windows Server 2022 host. You'll then download an image to use as the base for an IIS container.

The main tasks for this exercise are:

1. Install Docker on Windows Server.
2. Download an image.

### Task 1: Install Docker on Windows Server

1.  Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2.  Select **Start**, and then select **Windows PowerShell ISE**.

3.  In the **Windows PowerShell ISE** script pane enter the following commands on the first two lines:

   ```
   Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
   .\install-docker-ce.ps1
   ```
4.  From the Windows PowerShell ISE toolbar, select the **Run Script** command.

> The Invoke-Webrequest command downloads the runtime environment needed to run containers. After running the install-docker-ce.ps1 command, LON-SVR1 restarts.

5.  After **LON-SVR1** restarts, sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

> A Windows PowerShell window opens and the installation continues. 

6.  When you receive the message **Script complete!**, close PowerShell.

> If you recieve an error message, rerun the script from step 3. 

### Task 2: Download an image

1.  On LON-SVR1, select **Start**, and then select **Windows PowerShell ISE**.

2.  Select **OK** at the message and then close the Untitled1 script pane. Do not save changes.

3.  To verify that the Docker installation works correctly, enter the following command in the command window:

   ```
   docker container run hello-world:nanoserver
   ```

> An error message displays indicating the image can't be found locally. The image is then pulled from the online repository. It'll take a few minutes for the sample container to download from the online repository and run on the host server. When it's complete, you'll receive a message that states **Hello from Docker!**

4.  To verify the Docker images currently pulled, use the following command:

   ```
   Docker images
   ```

>Notice that the only image in the local repository store is the **hello-world** nanoserver image.

5.  To review Docker base images from the online repository, use the following command:

   ```
   Docker search Microsoft
   ```

>Notice the variety of base images, each representing various runtime scenarios. You might need to run the command twice to obtain the list.

6.  To download a server-core image that matches the host operating system (OS), run the following command:

   ```
   docker pull mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
   ```

> This download might take more than 15 minutes to complete.

### Results

After this exercise, you'll have installed Docker on Windows Server and downloaded images from the online repository.

## Exercise 2: Deploy and configure a container

### Exercise Scenario

Now that you've prepared the container host machine and downloaded the image, the next step is to deploy a container image. You'll then be able to validate that the container deployed, is functional, and is ready to be managed.

The main tasks for this exercise are:

1. Deploy a new container.
2. Manage the container.

### Task 1: Deploy a new container

1.  On **LON-SVR1**, confirm the Docker image that's currently pulled by running the following command in Windows PowerShell ISE:

   ```
   Docker images
   ```

>Notice that both the **hello-world** and **IIS** images are listed in the local repository store.

2.  To run the IIS container, enter the following command:

   ```
   Docker run -d -p 8080:80 --name ContosoSite mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022 cmd
   ```

>This command runs the IIS image as a background service (-d) named **ContosoSite** and configures networking such that port 8080 of the container host (**LON-SVR1**) maps to port 80 of the container.

3.  Enter the following command to retrieve the container host's IP address information:

   ```
   ipconfig
   ```

>Note the IPv4 address of the Ethernet adapter named **vEthernet (nat)**. This is the new container's IP address. Make a note of the IPv4 address of the Ethernet adapter named **Private Network**. This is the IP address of the Host (**LON-SVR1**).

4.  From the taskbar, select **Microsoft Edge**, and then enter **`http://172.16.0.21:8080`**. 

>Observe the default IIS page provided by IIS running in the Docker container.

5. Close Microsoft Edge.

### Task 2: Manage the container

1.  At the **Windows PowerShell ISE** command prompt, run the following command:

   ```
   docker ps
   ```

>This command provides information on the container that's currently running on **LON-SVR1**. Take note of the container name as you'll use it to stop the container.

2.  At the **Windows PowerShell ISE** command prompt, run the following command:

   ```
docker stop ContosoSite
   ```

3.  At the **Windows PowerShell ISE** command prompt, run the following command to confirm that the container has stopped:

   ```
   docker ps
   ```
4. Close Windows PowerShell ISE.

### Results

After this exercise, you'll have deployed and managed a container.

## Exercise 3: Run a Windows container by using Windows Admin Center

### Exercise Scenario

In this exercise, you use Windows Admin Center to run and manage containers. To manage containers, you need to install the Containers extension in Windows Admin Center.

The main tasks for this exercise are:

1. Install Windows Admin Center.
2. Install the Containers extension.
3. Manage Containers.
4. Run a Container.

### Task 1: Install Windows Admin Center

1. On **LON-SVR1**, from the taskbar, open File Explorer, and then browse to **E:\\Labfiles\\Mod01**.

2. Select and run **WindowsAdminCenter2110.2.msi**.

3. On the **Windows Admin Center Setup** page, to accept the terms, select the checkbox, and then select **Next**.

4. On the **Send diagnostic data to Microsoft** page, select **Next**.

5. On the **Install Windows Admin Center on Windows Server** page, select **Next**.

6. On the **Installing Windows Admin Center** page, select **Next**.

7. On the **Configure Gateway Endpoint** page, select **Install**.

8. Select **Finish**, and then close File Explorer.

>  Wait approximately 3 to 4 minutes for installation to complete before continuing with Task 2.

### Task 2: Install the Containers extension

1. On **LON-SVR1**, from the taskbar, open Microsoft Edge.

2. In the address bar, enter ```https://LON-SVR1.contoso.com```, and then select Enter. 

3. At the Windows Security prompt, enter **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

> When the Windows Admin Center console opens, notice that the host server (**Lon-svr1.contoso.com**) is listed by default.

4. In Windows Admin Center, close the **Read what's new** message box.

5. In Windows Admin Center, in the upper right corner, select the **Settings** (cog wheel) icon.

6. In the left pane, select **Extensions**. 

>A list of available extensions is displayed.

7. Scroll down the list, select the **Containers** extension, and then select **Install**. 

>The extension will install, and Windows Admin Center will refresh.

8. On the top menu, select the **Settings** drop-down menu, and then select **Server Manager**.

9. On the **Server connections** page, select the **lon-svr1.contoso.com** link.

### Task 3: Manage Containers

1. In the left pane, scroll and select **Containers**. 

>Take note that the **Overview** option is selected. The details page provides the Overview information for all Containers, Images, Networks, and Volumes.

2. In the **Container host** section, select **Containers**.

>The Containers page provides a list and status of all containers available on the server.

3. In the **Container host** section, select **Images**.

>Notice the images that you have already previously downloaded.

4. On the **Images** page, select **Pull**.

>**Pull Container Image** opens to enable you to download a container image from a specified repository.

5. In the **Repository** text box, enter **`mcr.microsoft.com/windows/servercore`**.

6. In the **Tag** text box, enter **`ltsc2022`**.

7. Select **Pull** to download the Windows servercore base image for containers.

>You should receive a message that says **Successfully Pulled new image**. It will take a moment or two to refresh the Images page.

>Notice the new image named ltsc2022.

### Task 4: Run a Container

1. In the **Container host** section, select **Images**.

2. Select the **windowsservercore-ltsc2022** image, and then select **Run**.

3. On the **run image** page, for **Container Name**, enter **`app1`**.

>The name of the container must be lower case.

4. In the **Publish Port(s)** field, enter **`8080:80`** and then select **Run**.

5. In the **Container host** section, select **Containers**.

6. On the **Containers** page, select **app1**.

>Review the details for app1. You should notice CPU and Memory details displayed.

7. On the **Containers** page, select **app1** and then selct **End**. 

8. At the **End container** prompt, select **End**.

>A message displays that indicates that the app1 container has successfully ended.

### Results
After this exercise, you'll have run a Windows container by using Windows Admin Center.
