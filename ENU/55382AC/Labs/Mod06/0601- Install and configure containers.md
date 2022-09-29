---
lab:
    title: 'Lab: Install and configure containers'
    module: 'Module 6: Deploying and managing Windows Server and Hyper-V containers'
---

# Lab: Install and configure containers

## Scenario

The Contoso DevOps team wants to explore container technology to determine whether it can help reduce deployment times for new applications and simplify moving applications to the cloud. You'll work with the DevOps team to evaluate Windows Server containers and whether to provide Internet Information Services (IIS) web services in a container.

## Objectives

After completing this lab, you'll be able to:

- Install Docker and download an image.
- Deploy and configure a container.

## Estimated time: 30 minutes

## Exercise 1: Install Docker and download an image

### Exercise Scenario

In this exercise, you will use PowerShell to download and install Docker on a Windows Server 2022 host. You will then download an image to be used as the base for an IIS container.

The main tasks for this exercise are:

1. Install Docker on Windows Server
1. Download an image

### Task 1: Install Docker on Windows Server

1. Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.
1. Select **Start** and then select **Windows PowerShell ISE**.
1. At the **Windows PowerShell ISE** command prompt enter the following command and then select Enter:

   ```
   Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
   ```

1. At the **NuGet Provider** prompt, select **Yes**.
1. At the **Windows PowerShell ISE** command prompt enter the following command and then select Enter:

   ```
   Install-Package -Name docker -ProviderName DockerMsftProvider
   ```

1. At the confirmation prompt, select **Yes to All**.

1. After the installation is complete, restart the computer by using the following command:

   ```
   Restart-Computer -Force
   ```

### Task 2: Download an image

1. After **LON-SVR1** restarts, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

1. Select **Start** and then select **Windows PowerShell ISE**.

1. At the **Windows PowerShell ISE** command prompt, verify the installed version of Docker by using the following command:

   ```
   Get-Package -Name Docker -ProviderName DockerMsftProvider
   ```

   > **Note**: You may need to run **Start-Service -name Docker** before running the next commands.

1. To verify that the Docker installation works correctly, enter the following command:

   ```
   docker container run hello-world:nanoserver
   ```

   > An error message displays stating that the image cannot be found locally. The image is then pulled from the online repository. It will take a few minutes for the sample container to download from the online repository and the run on the host server. When it is complete, you will receive a hello message from Docker.

1. To verify the Docker images currently pulled, use the following command:

   ```
   Docker images
   ```

   > Notice that the only image in the local repository store is the hello-world nanoserver image.

1. To review docker base images from the online repository, use the following command:

   ```
   Docker search Microsoft
   ```

   > Notice the variety of base images each representing various runtime scenarios. You may need to run the command twice to obtain the list.
   >

1. To download a server core image, with IIS, that matches the host operating system, run the following command:

   ```
   docker pull mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
   ```

   > **Note**: This download may take more than 15 minutes to complete.

### Results

After this exercise, you will have installed Docker on Windows Server and downloaded images from the online repository.

## Exercise 2: Deploy and configure a container

### Exercise Scenario

Now that you have prepared the container host machine and downloaded the image, the next step is to deploy a container image. You will then be able to validate that the container deployed and is functional and ready to be managed.

The main tasks for this exercise are:

1. Deploy a new container
1. Manage the container

### Task 1: Deploy a new container

1. On **LON-SVR1**, confirm the Docker image that is currently pulled by using the following command:

   ```
   Docker images
   ```

   > Notice that both the hello-world and iis images are listed in the local repository store.

1. To run the IIS container, enter the following command:

   ```
   Docker run -d -p 8080:80 --name ContosoSite mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022 cmd
   ```

   > This command runs the IIS image as a background service (-d) named ContosoSite and configures networking such that port 8080 of the container host (LON-SVR1) maps to port 80 of the container.

1. Enter the following command to retrieve the IP address information of the container host:

   ```
   ipconfig
   ```

   > Note the IPv4 address of the Ethernet adapter named vEthernet (nat). This is the address of the new container. Make a note of the IPv4 address of the Ethernet adapter named **Ethernet**. This is the IP address of the Host (LON-SVR1).

1. From the task bar, select **Microsoft Edge**, and then enter **```http://172.16.0.21:8080```**. 

   > Observe the default IIS page provided by IIS running in the docker container.

### Task 2: Manage the container

1. At the **Windows PowerShell ISE** command prompt, run the following command:

   ```
   docker ps
   ```

   > This command provides information on the container that is currently running on LON-SVR1. Take note of the container name as you will use it to stop the container.

1. At the **Windows PowerShell ISE** command prompt, run the following command:

   ```
   docker stop ContosoSite
   ```

1. At the **Windows PowerShell ISE** command prompt, run the following command to confirm that the container has stopped:

   ```
   docker ps
   ```

### Results

After this exercise, you will have deployed and managed a container.
