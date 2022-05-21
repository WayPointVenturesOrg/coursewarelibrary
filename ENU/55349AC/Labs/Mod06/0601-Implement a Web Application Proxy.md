# Lab A: Implement a Web Application Proxy

## Lab scenario

Contoso Corporation works with a partner organization that needs access to an internal web application. These external users must not have access to any internal resources except for the specified application. You need to implement and test Web Application Proxy for these users.

## Exercise 1: Implement Web Application Proxy

### Scenario

You need to implement Web Application Proxy to enable external users to access an internal application. You will use the initial deployment as a proof of concept while the developers at Contoso modify the internal application to use AD FS claims-based authentication.

The main tasks for this exercise are as follows:

1. Prepare the environment.

2. Configure LON-CL1 as an external client.

3. Install the Web Application Proxy role service.

4. Configure access to an internal website.

### Task 1: Prepare the environment

#### Disable Routing and Remote Access on EU-RTR

1. Sign in to **EU-RTR** as **Contoso\Administrator** with the password of **Pa55w.rd**.

2. Select the **Start** button, and then select **Server Manager**.

3. In **Server Manager**, select **Tools**, and then select **Routing and Remote Access**.

4. In the **Routing and Remote Access** console, in the left pane, right-click **EU-RTR (local)**, and then select **Disable Routing and Remote Access**. 

5. In the **Routing and Remote Access** dialog box, select **Yes**, and then close the **Routing and Remote Access** window.

   > **Note:** Routing and Remote Access is preconfigured for the purpose of other labs in this course. The Web Application Proxy configuration in this lab will not work properly if you leave Routing and Remote Access enabled on the virtual machine.

### Task 2: Configure LON-CL1 as an external client

#### Remove the client computer from a domain

1. Sign in to **LON-CL1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Right-click the **Start** button, and then select **System**.

3. In the **System** window, select **Advanced system settings**, and then select the **Computer Name** tab.

4. On the **Computer Name** tab, select the **Change** button.

5. In the **Computer Name/Domain Changes** dialog box, select **Workgroup**, in the **Workgroup** box, enter **WORKGROUP**, and then select **OK**.

6. In the **Computer Name/Domain Changes** dialog box, select **OK**.

7. In the **Welcome to the WORKGROUP workgroup** dialog box, select **OK**.

8. To restart the computer, select **OK**.

9. To close the **System Properties** dialog box, select **Close**.

10. Select **Restart Now**, and wait for the computer to restart.


#### Import a root CA certificate on the client

1. Sign in to **LON-CL1** as **Admin** and the password **Pa55w.rd**.

2. On the taskbar, select **File Explorer**.

3. In the **File Explorer** window, in the address bar, enter **`\\172.16.0.10\C$`**,  and then press Enter.

4. When prompted for the user name, enter **Contoso\\Administrator**, with the password **Pa55w.rd**, and then press Enter.

5. In the **File Explorer** window, right-click **ContosoRootCA.cer**, select **Show more options**, and then select **Install Certificate**.

6. In the **Open File – Security Warning** dialog box, select **Open**.

7. On the **Welcome to the Certification Import Wizard** page, select **Local Machine**, and then select **Next**.

8. In the **User Account Control** dialog box, select **Yes**.

9. On the **Certificate Store** page, select **Place all certificates in the following store**, select **Browse**, select **Trusted Root Certification Authorities**, and then select **OK**. 

10. On the **Certificate Store** page, select **Next**, and then select **Finish**.

11. In the **Certificate Import Wizard**, select **OK**.

12. Right-click the **Start** button, and then select **Windows Terminal**.

13. In the **PowerShell** window, enter **mmc**, and then press Enter.

14. In the **User Account Control** dialog box, select **Yes**.

15. In the **MMC**, on the **File** menu, select **Add/Remove Snap-in**.

16. In the **Add or Remove Snap-ins** window, from the **Available snap-ins** list, select **Certificates**, and then select **Add**.

17. In the **Certificates snap-in** dialog box, select **Computer account**, select **Next**, select **Finish**, and then select **OK**.

18. In the **MMC**, expand **Certificates**, expand **Trusted Root Certification Authorities**, and then select **Certificates**.

19. Verify that **ContosoCA** exists.

    > **Note:** You perform the preceding steps to import the ContosoCA certificate into the Trusted Root Certification Authorities of **LON-CL1** and then to verify that the ContosoCA certificate is imported into the Trusted Root Certification Authorities of **LON-CL1**. This enables the client to trust the certificates issued by the Contoso Certification Authority.

#### Move the computer to the Internet

1. To move the client from the internal network to the Internet, on **LON-CL1**, right-click the **Start** button, and then select **Network Connections**.

2. Select **Advanced network settings**.

3. Select **More network adapter options**.

4. In **Network Connections**, right-click **London_Network**, and then select **Disable**.

5. Right-click **Internet**, and then select **Enable**.

6. On the taskbar, select the **Microsoft Edge** icon.

7. In Microsoft Edge, in the web address box, enter **`https://lon-svr1.contoso.com`**, and then press Enter. Notice that a Network Error message displays.

8. On LON-CL1, close all open windows.

   > **Note:** You are unable to open the internal website running on **LON-SVR1** because the client cannot access the internal network.

### Task 3: Install the Web Application Proxy role service

1. Switch to **EU-RTR**.

2. Select the **Start** button, and then select **Server Manager**.

3. On the **Dashboard** page, select **Add roles and features**. 

4. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**, on the **Select installation type** page, select **Next**, and then on the **Select destination server** page, select **Next**.

5. On the **Select server roles** page, expand **Remote Access**, select **Web Application Proxy**, and then select **Next**.

6. On the **Select features** page, select **Next**.

7. On the **Confirm installation selections** page, select **Install**.

8. On the **Installation progress** page, verify that the installation is successful, and then select **Close**.


### Task 4: Configure access to an internal website

#### Obtain a certificate for the ADFSWAP farm

1. On **EU-RTR**, right-click the **Start** button, and then select **Windows PowerShell**.

2. In the **Windows PowerShell** window, enter **mmc**, and then press Enter.

3. In the **MMC**, on the **File** menu, select **Add/Remove Snap-In**.

4. In the **Add or Remove Snap-ins** window, select **Certificates**, select **Add**, select **Computer account**, and then select **Next**.

5. Verify that **Local Computer** is selected, select **Finish**, and then select **OK**.

6. In the **MMC**, expand **Certificates (local Computer)**, right-click **Personal**, select **All Tasks**, and then select **Request New Certificate**.

7. On the **Before You Begin** page, select **Next**.

8. On the **Select Certificate Enrollment Policy** page, select **Next**.

9. On the **Request Certificates** page, select **Contoso Web Server**, and then select the **More information is required to enroll for this certificate. select here to configure settings** link.

10. In the **Subject name** section, select the drop-down list, select **Common name**, in the **Value** box, enter **adfswap.contoso.com**, and then select **Add**.

11. In the **Alternative name** list, select the drop-down list, and then select **DNS**. In the **Value** box, enter **adfswap.contoso.com**, and then select **Add**.

12. In the **Alternative name** list, select **DNS**, in the **Value** box, enter **rdgw.contoso.com**, and then select **Add**.

13. In the **Alternative name** list, select **DNS**, in the **Value** box, enter **lon-svr1.contoso.com**, and then select **Add**.

14. Select **OK** to close the **Certificate Properties** dialog box.

15. Select **Enroll** to proceed with Certificate Enrollment.

16. Select **Finish** to close the **Certificate Enrollment** dialog box.

17. Close the MMC console and do not save changes.


#### Configure Web Application Proxy

1. In **Server Manager**, from the **Tools** menu, open the **Remote Access Management** console.

2. In the navigation pane, select **Web Application Proxy**.

3. In the middle pane, select **Run the Web Application Proxy Configuration Wizard**.

4. In the **Web Application Proxy Configuration Wizard**, on the **Welcome** page, select **Next**.

5. In the **Federation service name** box, enter **adfswap.contoso.com**, which is the FQDN of the federation service.

6. In the **User name** box, enter **Administrator**, in the **Password** box, enter **Pa55w.rd**, and then select **Next**.

7. On the **AD FS Proxy Certificate** page, in the list of certificates currently installed on the Web Application Proxy server, select **adfswap.contoso.com**, and then select **Next**.

8. On the **Confirmation** page, review the settings and then select **Configure**. 

9. On the **Results** page, verify that the configuration is successful, and then select **Close**.

   > **Note:** If you receive an error message, check if **LON-SVR2** is started and if the AD FS service is running on **LON-SVR2**. Then return to step 2 to run the **Web Application Proxy Configuration Wizard** again.

#### Publish the internal website

1. On the Web Application Proxy server, in the **Remote Access Management** console, in the navigation pane, select **Web Application Proxy**, and then in the **Tasks** pane, select **Publish**.

2. In the **Publish New Application Wizard**, on the **Welcome** page, select **Next**.

3. On the **Preauthentication** page, select **Pass-through**, and then select **Next**.

4. On the **Publishing Settings** page, perform the following steps:

   - In the **Name** box, enter **Contoso LOB Web App** (**LON-SVR1)**.

   - In the **External URL** box, enter **`https://lon-svr1.contoso.com`**.

   - In the **External certificate** list, select **adfswap.contoso.com**.

   - In the **Backend server URL** box, ensure that **`https://lon-svr1.contoso.com`** is listed, and then select **Next**.


   > **Note:** The value for **Backend server URL** is automatically entered when you enter the external URL.

5. On the **Confirmation** page, review the settings, and then select **Publish**. 

6. On the **Results** page, ensure that the application published successfully, and then select **Close**.

7. Close the Remote Access Management Console.


#### Configure internal website authentication

1. Switch to **LON-SVR1** and sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select the **Start** button, and then select **Server Manager**. 
3. Select the **Tools** menu, and then select **Internet Information Services (IIS) Manager**.
4. In the **Internet Information Services (IIS) Manager** console, expand **LON-SVR1 (Contoso\administrator)**.

5. Expand **Sites**, and then select **Default Web site**.

6. In the **Internet Information Services (IIS) Manager** console, in the **Default Web Site Home** pane, double-click **Authentication**.

7. In the **Internet Information Services (IIS) Manager** console, in the **Authentication** pane, right-click **Windows Authentication**, and then select **Enable**.

8. In the **Internet Information Services (IIS) Manager** console, in the **Authentication** pane, right-click **Anonymous Authentication**, and then select **Disable**.

9. Close the **Internet Information Services (IIS) Manager** console.


**Results:** After completing this exercise, you should have successfully implemented Web Application Proxy.

## Exercise 2: Validate the Web Application Proxy deployment

### Scenario

Now that you have deployed the Web Application Proxy role service, you need to verify that external users can access the internal application through the proxy.

The main task for this exercise is as follows:

1. Verify access to the internal website from the client computer.

### Task 1: Verify access to the internal website from the client computer

1. Switch to **LON-CL1**.

2. On the taskbar, select **Microsoft Edge**. 

3. In the web address box, enter **`https://lon-svr1.contoso.com`** and then press Enter.

4. When you receive a Windows Security prompt, enter **Contoso\\susan** for the user name and **Pa55w.rd** for the password, and then select **OK**.

5. Verify that the default Internet Information webpage for **LON-SVR1** opens.

6. Close **Microsoft Edge** and sign out of **LON-CL1**.


**Results:** After completing this exercise, you will have verified that external users are able to access the internal application through the Web Application Proxy.