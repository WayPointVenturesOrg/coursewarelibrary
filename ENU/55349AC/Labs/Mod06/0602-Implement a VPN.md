# Lab B: Implement a VPN

## Lab scenario

Contoso Corporation has decided to implement a virtual private network (VPN) solution that'll be based on the Secure Socket Tunneling Protocol (SSTP).

### Prerequisites

You must complete the following lab(s) before beginning this lab:

- 0601-Implement a Web Application Proxy

## Exercise 1: Implement a VPN solution

### Scenario

To implement a VPN solution, you first must verify and configure certificate requirements for the SSTP protocol. You then must configure the Remote Access server to provide VPN connectivity, and create a Remote Access policy to ensure that the clients can connect to the server by using the Point-to-Point Tunneling Protocol (PPTP) and SSTP.

The main tasks for this exercise are:

1. Verify certificate requirements for SSTP.

2. Review the default VPN configuration.

3. Configure the Remote Access policies.

### Task 1: Verify certificate requirements for IKEv2 and SSTP

#### Prepare the environment

1. On **LON-DC1**, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Right-click **Start** to open the context menu, and then select **Windows PowerShell (Admin)**.

3. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   cd E:\Labfiles\Mod06
   ```

4. At the **Windows PowerShell** command prompt, enter the following command, and then select Enter:

   ```
   .\mod6.ps1
   ```

   > Wait for the script to complete, which should take approximately 20 seconds. 
   >

#### Request a certificate for EU-RTR

1. Switch to **EU-RTR**, and sign in as **Contoso\Administrator** with the password of **Pa55w.rd**.

2. Select **Start**, and then enter **Command Prompt**. In the results pane, select **Command Prompt**.

3. At the command prompt, enter the following command, and then select Enter:

   ```
   mmc
   ```

4. In the **Console** window, select **File**, and then select **Add/Remove Snap-in**.

5. In the **Available snap-ins** list, select **Certificates**, and then select **Add**.

6. In the **Certificates snap-in** dialog box, select **Computer account**, and then select **Next**.

7. In the **Select Computer** dialog box, select **Local computer**, select **Finish**, and then select **OK**.

8. In the **Certificates** snap-in, in the console tree of the **Certificates** snap-in, navigate to **Certificates (Local Computer)\Personal**.

9. Right-click **Personal** to open the context menu, point to **All Tasks**, and then select **Request New Certificate**.

10. On the **Before you begin** page, select **Next**, and then, on the **Select Certificate Enrollment Policy** page, select **Next**.

11. On the **Request Certificates** page, select **Contoso Web Server**, and then select **More information is required to enroll for this certificate. select here to configure settings.**

12. In the **Certificate Properties** dialog box, on the **Subject** tab, under **Subject name** and then under **Type**, select **Common name**.

13. In the **Value** text box, enter **131.107.0.10**, and then select **Add**.

14. Select **OK**, select **Enroll**, and then select **Finish**.

15. In the **Certificates** snap-in, expand **Personal**, and select **Certificates**, and then, in the **details** pane, verify that a new certificate with the name **131.107.0.10** is enrolled with **Intended Purposes** of **Server Authentication**.

16. Close the console window. 

17. When you receive a prompt to save the settings, select **No**.


#### Change the HTTPS bindings

1. On **EU-RTR**, open **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager**. 

2. In the **Internet Information Services (IIS) Manager**, expand **EU-RTR (Contoso\Administrator)**.

3. In the **Internet Information Services (IIS) Manager**, in the console tree, expand **Sites**, and then select **Default Web site**.

4. In the **Actions** pane, select **Bindings**, and then select **Add**.

5. In the **Add Site Binding** dialog box, under **Type**, select **https**, and in the **SSL Certificate** list, select the **131.107.0.10** certificate, select **OK**, and then select **Close**.

6. Close the **Internet Information Services (IIS) Manager** console.


### Task 2: Review the default VPN configuration

1. On **EU-RTR**, in the **Server Manager**, select **Tools**, and then select **Routing and Remote Access**.

2. Right-click **EU-RTR (local)** to open the context menu, and then select **Configure and Enable Routing and Remote Access**.

5. On the **Welcome to Routing and Remote Access Server Setup Wizard**, select **Next**.

6. On the **Configuration** page, select **Custom configuration**, and then select **Next**.

7. On the **Custom Configuration** page, select **VPN access** and **LAN routing**, and then select **Next**.

8. On the **Completing the Routing and Remote Access Server Setup Wizard** page, select **Finish**.

9. When you receive a prompt, in the **Routing and Remote Access** dialog box, select **Start service**.

10. Expand **EU-RTR (local)**, right-click **Ports** to open the context menu, and then select **Properties**.

11. In the **Ports** **Properties** dialog box, verify that five ports exist for Secure Socket Tunneling Protocol (SSTP), Internet Key Exchange version 2 (IKEv2), Point to Point Tunneling Protocol (PPTP), and Layer Two Tunneling Protocol (L2TP). 

12. Open **WAN Miniport (SSTP)**. In the **Maximum ports** text box, enter **4**, and then select **OK**. 

13. In the **Routing and Remote Access** message box, select **Yes**.

14. Repeat steps 10 and 11 for **IKEv2**, **PPTP**, and **L2TP**.

15. To close the **Ports Properties** dialog box, select **OK**.

16. Right-click **EU-RTR (local)** to open the context menu, and then select **Properties**.

17. In the **EU-RTR (local) Properties** dialog box, on the **General** tab, verify that **IPv4 Remote access server** is selected.

18. Select the **Security** tab, select the drop-down arrow next to **Certificate**, and then select **131.107.0.10**.

19. Select **Authentication Methods**, verify that **EAP** is selected as the authentication protocol, and then select **OK**.

20. Select the **IPv4** tab, and then verify that the VPN server is configured to assign IPv4 addressing by using **Dynamic Host Configuration Protocol (DHCP)**.

21. Select the drop-down arrow next to **Adapter**, and then select **London_Network**.

22. To close the **EU-RTR (local) Properties** dialog box, select **OK**, and then, when you receive a prompt, select **Yes**. 


### Task 3: Configure the Remote Access policies

1. On **EU-RTR**, in **Server Manager**, on the **Tools** menu, select **Network Policy Server**.

2. In the **Network Policy Server** console, in the **navigation** pane, expand **Policies**, and then select **Network Policies**. 

3. In the navigation pane, right-click **Network Policies** to open the context menu, and then select **New**.

4. In the **New Network Policy** wizard, in the **Policy name** text box, enter **Contoso IT VPN**.

5. In the **Type of network access server** list, select **Remote Access Server(VPN-Dial up)**, and then select **Next**.

6. On the **Specify Conditions** page, select **Add**.

7. In the **Select condition** dialog box, select **Windows Groups**, and then select **Add**.

8. In the **Windows Groups** dialog box, select **Add Groups**.

9. In the **Select Group** dialog box, in the **Enter the object name to select (examples)** text box, enter **IT**, select **Check Names**, and then select **OK**.

10. Select **OK** again, and then select **Next**.

11. On the **Specify Access Permission** page, verify that **Access granted** is selected, and then select **Next**.

12. On the **Configure Authentication Methods** page, clear the **Microsoft Encrypted Authentication (MS-CHAP)** check box.

13. To add **EAP Types**, select **Add**.

14. On the **Add EAP** page, select **Microsoft Secured password (EAP-MSCHAP v2)**, and then select **OK**.

15. To add **EAP Types**, select **Add**.

16. On the **Add EAP** page, select **Microsoft: Smart Card or other certificate**, select **OK**, and then select **Next**.

17. On the **Configure Constraints** page, select **Next**.

18. On the **Configure Settings** page, select **Next**.

19. On the **Completing New Network Policy** page, select **Finish**.

20. Close all open windows.


**Results:** After completing this exercise, you should have successfully modified the Remote Access server configuration to provide VPN connectivity.

## Exercise 2: Validate the VPN deployment

### Scenario

Now that you've deployed the VPN solution, you need to verify that the clients can connect by using VPN. 

The main tasks for this exercise are:

1. Validate that LON-CL1 is an external client.
2. Configure a VPN connection, and then verify connectivity.

### Task 1: Validate that LON-CL1 is an external client

1. Switch to **LON-CL1**, and then sign in as **Admin** with the password of **Pa55w.rd**.

2. Right-click **Start** to open the context menu, and then select **Network Connections**.

3. Select **Advanced network settings**.

4. Select **More network adapter options**.

5. In the **Network Connections** window, verify that **London_Network** is disabled and that **Internet** is enabled.

6. Right-click **Internet** to open the context menu, and then select **Properties**.

7. In the **Internet Properties** dialog box, open **Internet Protocol Version 4 (TCP/IPv4)**.

8. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, ensure that the following settings display, and then select **OK**:

   - IP address: **131.107.0.20**
   - Subnet mask: **255.255.255.0**
   - Preferred DNS server: **131.107.0.100**

9. In the **Internet Properties** dialog box, select **Cancel**.

10. Close all open windows.

11. On the taskbar, select the **File Explorer** icon.

12. In File Explorer, in the address bar, enter **`\\LON-DC1\`**, and then select Enter. Notice that a Network Error message displays.

13. Close all open windows.

    > **Note:** The client is unable to open the resources, because it's not on the internal network.

### Task 2: Configure a VPN connection and verify connectivity

#### Create a VPN profile, and then connect using PPTP

1. On **LON-CL1**, select **Start**, and then select **Settings**.

2. In **Settings**, select **Network & internet**, and then select **VPN**.

3. In **VPN**, next to **VPN connections**, select **Add VPN**.

4. On the **Add a VPN connection** page, configure the following settings, and then select **Save**:
   - VPN provider: **Windows (built-in)**

   - Connection name: **Contoso VPN**

   - Server name or address: **131.107.0.10**

   - VPN type: **Point to Point Tunneling Protocol (PPTP)**

   - Type of sign-in info: **User name and password**

   - Deselect: **Remember my sign in info**

5. On the **VPN** page, next to **Contoso VPN**, select **Connect**.

6. In the **Sign in** dialog box, in the **User name** text box, enter **Contoso\Tonnie**, and in the **Password** text box, enter **Pa55w.rd**, and then select **OK**.

7. On the task bar, select **Start**, and then enter **Network Connections**.

8. Select **View network connections**.

9. In the **Network Connections** window, verify that **WAN Miniport (PPTP)** displays under **Contoso VPN**. 


#### Connect to a VPN by using SSTP

1. In the **Network Connections** window, right-click **Contoso VPN** to open the context menu, and then select **Properties**.

2. In the **Properties** dialog box, select the **Security** tab.

3. In the **Type of VPN** list, select **Secure Socket Tunneling Protocol (SSTP)**, and ensure that **Use Extensible Authentication Protocol (EAP)** is selected.

4. Select **OK** twice.

5. In the **Network Connections** window, open **Contoso VPN**, and then select **Disconnect**.

6. In the **Network Connections** window, open **Contoso VPN**.

7. On the quick settings, select **VPN**, select **Contoso VPN**, and then select **Connect**.

8. In the **Network sign-in** dialog box, in the **User name** box, enter **Contoso\Tonnie**, and in the **Password** box, enter **Pa55w.rd**, and then select **OK**.

9. Switch to the **Network Connections** window, and then verify that the connection is established by using the **SSTP** protocol.

10. In the **Network Connections** window, open **Contoso VPN**, and then select **Disconnect**.

11. Sign out of **LON-CL1**.

**Results:** After completing this exercise, you should have verified that clients can connect by using a VPN.

## Exercise 3: Troubleshoot VPN access

### Scenario

Tonnie reports that she can't connect to the Contoso VPN. You received an incident report, and you must investigate and fix the issue.

| **Incident Record**                              |                                                              |
| ------------------------------------------------ | ------------------------------------------------------------ |
| **Incident Reference Number**                    | IN24578                                                      |
| **User**                                         | Tonnie Thomsen (IT department)                               |
| **Date and Time of Call**                        | November 8 13:42                                             |
| **Incident  Details**                            | The Contoso VPN connection is suddenly not working on Tonnie’s computer, and she can't access intranet resources from her home network. |
| **Additional Information**                       | Tonnie can't connect to intranet resources from home. Tonnie must be able to connect by using VPN from her computer, LON-CL1. |
| **Plan  of Action**                              |                                                              |

The main tasks for this exercise are:

1. Read the help-desk incident record for incident IN24578.

2. Update the Plan of Action section of the incident record.

3. Simulate the issue and try to connect by using the Contoso VPN connection.

4. Implement the fix, and test the solution.

### Task 1: Read the help-desk incident record for incident IN24578

- REview the help-desk **Incident Record IN24578** under the **Exercise Scenario**.


### Task 2: Update the Plan of Action section of the incident record

1. Read the **Additional Information** section of the incident record in the Student Handbook exercise scenario.

2. Update the **Plan of Action** section of the incident record with your recommendations:

   - Try to connect to the VPN by using the Contoso VPN profile.

   - Document the error message when trying to connect.

   - Fix the connection issue, and then test the connection.


### Task 3: Simulate the issue, and then try to connect by using the Contoso VPN connection

1. On **LON-CL1**, sign in by using the user name **Admin** and the password of **Pa55w.rd**.

2. Right-click **Start** to open the context menu, and then select **Windows Terminal (Admin)**. When you receive a prompt in **User Account Control** (UAC), select **Yes**.

3. At the command prompt, enter the following command, and then select Enter:

   ```
   cd C:\Labfiles\Mod06\
   ```

4. At the command prompt, enter the following command, and then select Enter:

   ```
   .\Mod6LabB.ps1
   ```

5. Wait for the script to complete.

6. Select **Start**, and then enter **Network Connections**.

7. Select **View network connections**.

8. In the **Network Connections** window, open **Contoso VPN**.

9. On the **quick settings** page, select **VPN**, select **Contoso VPN**, and then select **Connect**.

10. Wait for the connection attempt to fail, and then notate the error message in the **Plan of Action** section of the incident record in the Student Handbook. If the connection is successful, disconnect and the reattempt the connection. It should fail.



### Task 4: Implement the fix, and test the solution

1. On **LON-CL1**, from the task bar, select **File Explorer**.

2. In the **File Explorer** window, in the address bar, enter **`\\172.16.0.10\C$\`**, and then select Enter.

3. In the **Windows Security** dialog box, enter **Contoso\Administrator** in the **User name** text box and **Pa55w.rd** in the **Password** text box, and then select Enter.

4. In the **File Explorer** window, right-click **ContosoRootCA.cer** to open the context menu, select **Show more options**, and then select **Install Certificate**.

5. In the **Open File – Security Warning** dialog box, select **Open**.

6. On the **Welcome to the Certification Import Wizard** page, select **Local Machine**, and then select **Next**.

7. In the **User Account Control** dialog box, select **Yes**.

8. On the **Certificate Store** page, select **Place all certificates in the following store**, select **Browse**, select **Trusted Root Certification Authorities**, and then select **OK**. 

9. On the **Certificate Store** page, select **Next**, and then select **Finish**.

   > Wait for the import to complete. It takes approximately 15 seconds.

10. In the **Certificate Import Wizard**, select **OK**.

11. Right-click **Start** to open the context menu, and then select **Windows Terminal**.

12. In the **Command Prompt** window, enter **mmc**, and then select Enter.

13. If the **User Account Control** dialog box displays, select **Yes**.

14. In the **MMC**, on the **File** menu, select **Add/Remove Snap-in**.

15. In the **Add or Remove Snap-ins** window, from the **Available snap-ins** list, select **Certificates**, and then select **Add**.

16. In the **Certificates snap-in** dialog box, select **Computer** **account**, select **Next**, select **Finish**, and then select **OK**.

17. In the **MMC**, expand **Certificates**, expand **Trusted Root Certification Authorities**, and then select **Certificates**.

18. Verify that **ContosoCA** exists. 

19. In the **Quick settings** window, select **VPN**, select **Contoso VPN**, and then select **Connect**.

20. In the **Sign-in** dialog box, in the **User name** text box, enter **Contoso\Tonnie**, and in the **Password** text box, enter **Pa55w.rd**, and then select **OK**.

21. Verify that you are now able to connect to the **Contoso** VPN server.

22. Disconnect from Contoso VPN, and then sign out of LON-CL1.


**Results:** After completing this exercise, you should have resolved the VPN access issue successfully, and Tonnie should be able to connect to the Contoso VPN.
