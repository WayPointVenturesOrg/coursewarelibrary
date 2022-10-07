---
lab:
    title: 'Lab: Use MDT to deploy Windows Server'
    module: 'Module 10: Create and manage deployment images '
---

# Lab: Use MDT to deploy Windows Server

## Scenario

Contoso Corporation is a global engineering and manufacturing company with a head office based in London, UK. An IT office and datacenter are located in London to support the London location and other locations. Contoso has recently deployed a Windows Server 2022 server and Windows 11 client infrastructure.

As the datacenter has grown, it has become apparent that there can be significant time savings if server deployment is automated by using customized images rather than manually installing each server. You decide to implement an automation process for deploying servers using the Microsoft Deployment Toolkit (MDT). 

## Objectives

After completing this lab, you will be able to:

- Configure MDT.
- Create and deploy an image.

## Estimated time: 60 minutes

## Exercise 1: Configure MDT

### Scenario

You need to test the capabilities of the Microsoft Deployment Toolkit. MDT has already been installed on LON-SVR1, so your next step is to configure the MDT deployment share to prepare the MDT environment for image deployment.

The main task for this exercise is as follows:

- Configure the deployment share.

### Task 1: Configure the deployment share

1. On **LON-SVR1**, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. On the taskbar, select **File Explorer** and then browse to **E:\\ISOs**.

3. Right-click or access the context menu for **Win2022_Eval.iso** and then select **Mount**. 

   > The ISO mounts as DVD Drive F.

4. Close **File Explorer**.

5. Select **Start**, expand **Microsoft Deployment Toolkit**, and then select **Deployment Workbench**.

6. In the **Deployment Workbench**, right-click or access the context menu for **Deployment Shares** and then select **New Deployment Share**. 

   > The **New Deployment Share Wizard** opens.


7. On the **Path** page, under **Deployment share path**, change the value to **E:\DeploymentShare** and then select **Next**.

8. On the **Share** page, take note of the **Share name**, but do not change it. Select **Next**.

9. On the **Descriptive Name** page, accept the default value and select **Next**.

10. On the **Options** page, configure the following, and then select **Next**:

       - Ask to set the local Administrator password: **Enabled**

       - All other check boxes: **Disabled**

11. On the **Summary** page, review the information and then select **Next**. 

12. On the **Confirmation** page, ensure that the process completed successfully and then select **Finish**.

13. Expand **Deployment Shares**, and then expand the **MDT Deployment Share** folder. 

    > Take note of the various nodes that can be configured for the deployment share. The nodes should include **Applications**, **Operating Systems**, **Out-of-Box Drivers**, **Packages**, **Task Sequences**, **Advanced Configuration**, and **Monitoring**.

### Results

After completing this exercise, you should have configured the MDT Deployment Share.

## Exercise 2: Create and deploy an image

### Scenario

You need to deploy a new Windows Server 2022 virtual machine named LON-SVR7. You will use MDT to deploy the operating system image to a virtual machine created in Hyper-V. You have already created an MDT deployment share, and so your next step is to add components to the share and then configure the task sequence that will perform the steps to deploy the image.

The main tasks for this exercise are as follows:

1. Add Operating System files to the Deployment Share.

2. Create an MDT Task Sequence.

4. Configure Deployment Share Properties and Windows PE settings.

5. Deploy Windows Server 2022 Using MDT.

### Task 1: Add Operating System files to the Deployment Share

1. In the **Deployment Workbench**, expand **Deployment Shares**, expand **MDT Deployment Share**, and then select **Operating Systems**.

2. Right-click or access the context menu for **Operating Systems** and then select **Import Operating System**. 

   > The Import Operating System Wizard opens.

3. In the **Import Operating System Wizard**, on the **OS Type** page, select **Full set of source files** and then select **Next**.

4. On the **Source** page, under **Source directory**, enter **`F:\`** and then select **Next**.

5. On the **Destination** page, change the default destination directory name to **Windows Server 2022** and then select **Next**.


6. On the **Summary** page, review the information and then select **Next**. 

   > The operating system source files are copied into the deployment share.

7. On the **Confirmation** page, ensure that the process completed successfully and then select **Finish**.

8. In the **Deployment Workbench**, with **Operating Systems** selected, verify that four operating system objects display. 

   > Each object represents a specific edition and install type for Windows Server 2022.

### Task 2: Create an MDT Task Sequence

1. In the **Deployment Workbench**, expand **Deployment Shares**, expand **MDT Deployment Share**, and then select **Task Sequences**.

2. Right-click or access the context menu for **Task Sequences** and then select **New Task Sequence**. 

   > The **New Task Sequence Wizard** opens.

3. On the **General Settings** page, configure the following and then select **Next**:

   - Task sequence ID: **001**
   - Task sequence name: **Deploy Windows Server 2022**

4. On the **Select Template** page, select **Standard Client Task Sequence**, and then select **Next**.

5. On the **Select OS** page, select **Windows Server 2022 SERVERDATACENTER in Windows Server 2022 install.wim** and then select **Next**.

6. On the **Specify Product Key** page, select **Do not specify a product key at this time**, and then select **Next**.

7. On the **OS Settings** page, configure the following and then select **Next**:

   - Full Name: **Admin**
   - Organization: **Contoso Ltd.**
   - Internet Explorer Home Page: **about:blank**

8. On the **Admin Password** page, select **Use the specified local Administrator password**, and then enter **Pa55w.rd** in both text boxes. Select **Next**.

9. On the **Summary** page, review the information and then select **Next**. 

10. On the **Confirmation** page, ensure that the process completed successfully and then select **Finish**.

11. In the **Deployment Workbench**, with **Task Sequences** selected verify that the **Deploy Windows Server 2022** task sequence displays.

12. Right-click or access the context menu for the **Deploy Windows Server 2022** task sequence, and then select **Properties**. 

13. Select the **Task Sequence** tab. 

14. Expand the **Validation** node and then select **Validate**.

15. On the **Properties** page, remove the check marks next to **Ensure minimum memory** and **Ensure minimum processor speed**. 

16. Next to **Ensure current OS to be refreshed is**, select the drop-down menu and select **Server**.

17. On the **Deploy Windows Server 2022 Properties** window, select **OK**.


### Task 3: Configure Deployment Share Properties and Windows PE settings

1. In the **Deployment Workbench**, expand **Deployment Shares**, and select **MDT Deployment Share**.

2. Right-click or access the context menu for **MDT Deployment Share** and then select **Properties**.

3. In the **MDT Deployment Share Properties** window, on the **General** tab, take note of the information that was provided when the deployment share was created.

4. On the **General** tab, in the **Platforms Supported** section, clear the check box next to **x86**. 

   > Make sure that **x64** is remains selected.

5. Select the **Rules** tab. 

   > The Rules tab displays the content of the **CustomSettings.ini** file. These values were also provided during the creation of the deployment share.


5. Select the **Windows PE** tab. 

   > The Windows PE tab provides options for creating a Windows PE boot disk.

6. On the **Windows PE** tab, next to **Platform**, verify that **x86** is selected.

7. Remove the check mark next to **Generate a Lite Touch bootable ISO image**.

   > You will not need an x86 bootable ISO image for this deployment.

8. On the **Windows PE** tab, next to **Platform**, select the drop-down menu and then select **x64**.

9. In the **Windows PE Customizations** section, next to **Scratch space size**, select **64**.

10. Select the **Features** tab and then select the check box next to the following Feature Packs:

   - **DISM Cmdlets**
   - **Windows PowerShell**
   - **Microsoft Data Access Components (MDAC/ADO) support**

11. Select the **Monitoring** tab.

12. On the **Monitoring** tab, select the check box next to **Enable monitoring for this deployment share**.

13. In the **MDT Deployment Share Properties** window, select **OK**.

14. Right-click or access the context menu for **MDT Deployment Share** and then select **Update Deployment Share**. 

    > The **Update Deployment Share Wizard** opens.

15. On the **Options** page, select **Optimize the boot image updating process** and then select **Next**.

16. On the **Summary** page, select **Next**. 

    > The Deployment Share starts to update and create the Windows PE files. This will take a few minutes to complete.

17. On the **Confirmation** page, ensure that the process completed successfully and then select **Finish**.

### Task 4: Deploy Windows Server 2022 Using MDT

1.  On **LON-SVR1**, on the taskbar, select **Hyper-V Manager**.

2.  In **Hyper-V Manager**, select **Virtual Switch Manager**.


3. Select **New virtual network switch** and then in the details pane, select **External**. Select **Create Virtual Switch**.

4. In the **Virtual Switch Properties** page, in the **Name** text box, enter **External network**.

5. In the **Connection type** section, select **External network** and then from the drop-down menu select **Microsoft Hyper-V Network Adapter #3**.

6. To close the **Virtual Switch Manager for LON-SVR1** window, select **OK**, and then select **Yes**.

7. In **Hyper-V Manager**, select **LON-SVR1** and then in the **Actions** pane, select **New** and then select **Virtual Machine**.

8. On the **Before you Begin** page, select **Next**.

9. On the **Specify Name and Location** page, in the **Name** box type **LON-SVR7**. 

10. Select the check box next to **Store the virtual machine in a different location** and then next to **Location** enter **E:\\VirtualMachines**. Select **Next**.

11. On the **Specify Generation** page, verify that **Generation 1** is selected and then select **Next**.

12. On the **Assign Memory** page, next to **Startup memory** type **8192** and then select **Next**.

13. On the **Configure Networking** page, next to **Connection**, select **External Network** and then select **Next**.

14. On the **Connect Virtual Hard Disk** page, select **Create a virtual hard disk**, enter the following and then select **Next**:

    - Name: **LON-SVR7.vhdx**
    - Location: **E:\\VirtualMachines\\LON-SVR7\\Virtual Hard Disks\\**
    - Size: **60 GB**

15. On the **Installation Options** page, select **Install an operating system from a bootable CD/DVD-ROM** and configure the following:

    - Image file (.iso): **E:\\DeploymentShare\\Boot\\LiteTouchPE_x64.iso**

16. Select **Next** and then **Finish**.

17. In **Hyper-V Manager**, select **LON-SVR7**, select **Connect**,  and then select **Start**. 

18. As the computer starts press any key on the keyboard to invoke the MDT Deployment Wizard. Maximize the window as needed.

    > The Microsoft Deployment Toolkit Deployment Wizard starts.

19. On the **Welcome** page, select **Run the Deployment Wizard to install a new Operating System**.

20. On the **Specify credentials for connecting to network shares** window, enter the following and then select **OK**:

    - User Name: **Administrator**
    - Password: **Pa55w.rd**
    - Domain: **Contoso**

21. On the **Task Sequence** page, select **Deploy Windows Server 2022** and then select **Next**.

22. On the **Computer Details** page, next to **Computer name** enter **LON-SVR7**.

23. Select **Join a domain**, provide the following details, and then select **Next**.

    - 
      Domain to join: **Contoso.com**


24. On the **Locale and Time** page, select **Next**.

25. On the **Applications** page, select **Next**.

26. On the **Administrator Password** page, enter **Pa55w.rd** in both text boxes and then select **Next**.

27. On the **Ready** page, select **Begin**. 

    > The installation begins. It will take some time to complete and will automatically reboot LON-SVR7 during the installation as needed. When the server reboots, **do not** press any key.

28. Switch to the **Deployment Workbench**.

29. In the **Deployment Workbench**, expand **Deployment Shares**, and expand **MDT Deployment Share**.

30. Select **Monitoring** and then right-click or access the context menu for **LON-SVR7** and then select **Properties**.

    > Review the monitoring status during the deployment.

31. Switch to **LON-SVR7**.

    > After the installation is complete, the desktop will open and finalize the deployment. **Server Manager** automatically starts.

32. At the deployment summary, select **Finish**.

33. Close the **Try managing servers with Windows Admin Center** message.

34. In **Server Manager**, select **Local Server**.

35. Verify that the Computer name is **LON-SVR7** and that it has joined the **Contoso.com** domain.

36. Shut down **LON-SVR7** and close the Virtual Machine Connection window.


### Results

After completing this exercise, you will have successfully used the Microsoft Deployment Toolkit to create and deploy a Windows Server 2022 image.
