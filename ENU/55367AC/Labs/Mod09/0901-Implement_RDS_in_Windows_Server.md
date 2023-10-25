---
lab:
    title: 'Lab: Implement RDS in Windows Server'
    module: 'Module 9: RDS in Windows Server'
---

# Lab: Implement RDS in Windows Server

## Scenario

You need to configure a basic Remote Desktop Services (RDS) environment as the starting point for a new infrastructure that'll host a sales application. You plan to deploy RDS services, perform initial configuration, and demonstrate to the delivery team how to connect to an RDS deployment.

You also need to evaluate whether to utilize user-profile disks to store user profiles and then make the  disks available on all of the collection's servers. Users often store unnecessary files in their profiles, so you must determine how to set a limit on profile sizes.

A sales application will be published on the RD Web Access site, so you'll configure RemoteApp programs to provide access from the Remote Desktop Web Access (RD Web Access) portal.

## Objectives

After completing this lab, you'll be able to:

- Implement RDS.
- Configure RemoteApp collection settings.

## Estimated time: 60 minutes
## Exercise 1: Implement RDS

### Scenario

To create the RDS environment, you first need to install RDS on LON-RDS1. You'll then create a session collection and change various collection settings. Finally, you'll configure a User Profile Disk validate the configuration by connecting to a Remote Desktop Session Host (RD Session Host) using the Remote Desktop Web (RD Web) portal.

The main tasks for this exercise are:

1. Install RDS using Server Manager.
2. Create a session collection.
3. Configure session-collection properties.
4. Connect to the session collection from the RD Web portal.

### Task 1: Install RDS using Server Manager

1. Sign in to **LON-RDS1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**

2. Select the **Start** button, and then select **Server Manager**.

3. In **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

4. In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

5. On the **Select installation type** page, select **Remote Desktop Services installation**, and then select **Next**.

6. On the **Select deployment type** page, verify that **Standard deployment** is selected, and then select **Next**.

>Note: You could have selected the **Quick Start** deployment option and have all three required RDS role services installed on **LON-RDS1**. However, you selected the **Standard deployment** option to practice selecting different servers for the RDS role services. Furthermore, the **Quick Start** deployment option creates a collection named **QuickSessionCollection** and publishes the following RemoteApp Programs: **Calculator**, **Paint**, and **WordPad**.

7. On the **Select deployment scenario** page, select **Session-based desktop deployment**, and then select **Next**.

8. On the **Review role services** page, review the description of the role services, and then select **Next**.

9. On the **Specify RD Connection Broker server** page, in the **Server Pool** section, select **LON-RDS1.Contoso.com**. Add the computer to the **Selected** section by selecting the arrow, and then select **Next**.

10. On the **Specify RD Web Access server** page, in the **Server Pool** section, select **LON-RDS1.Contoso.com**. Add the computer to the **Selected** section by selecting the arrow, and then select **Next**.

11. On the **Specify RD Session Host servers** page, in the **Server Pool** section, select **LON-RDS1.Contoso.com**. Add the computers to the **Selected** section by selecting the arrow, and then select **Next**.

12. On the **Confirm selections** page, select the checkbox next to **Restart the destination server automatically if required**, and then select **Deploy**.

>Note: The Remote Desktop Services role services begin to install. **LON-RDS1** restarts as needed. 

13. Sign in to **LON-RDS1** as **`Contoso\Administrator`** with the password **`Pa55w.rd`**

>Note: You can ignore the information message regarding the Remote Desktop licensing mode.

14. Select the **Start** button, and then select **Server Manager**.

>Note: The **Add Roles and Features Wizard** continues.  

15. When the installation completes, close the **Add Roles and Features Wizard**.

#### Configure SSL certificate requirements 

>Note: This task is required because of an incompatibility with the self-signed certificate that's created and installed during the **Remote Desktop Services** role-services deployment.

1. On **LON-RDS1**, select **Start**, enter **certlm.msc**, and then select Enter.

>Note: The **Certificates - Local Computer** console opens.

2. Under **Certificates - Local Computer**, expand **Personal**, and then select **Certificates**.

3. In the **details** pane,  right-click or access the context menu for the **LON-RDS1.contoso.com** certificate that's displayed, and then select **Delete**. Select **Yes** to confirm the deletion.

>Note: You have removed the self-signed certificate that was created automatically during the **Remote Desktop Services** role installation. You'll replace this with a new certificate.

4. Right-click or access the context menu for **Certificates**, point to **All Tasks**, and then select **Request New Certificate**.

5. On the **Before You Begin** page, select **Next**.

6. On the **Select Certificate Enrollment Policy** page, select **Next**.

7. On the **Request Certificates** page, select **Contoso Web Server**, and then select **More information is required to enroll for this certificate**.

8. In the **Certificate Properties** page, under **Subject name**, under **Type**, select **Common name** from the drop-down menu.

9. In the **Value** text box, enter **`LON-RDS1.contoso.com`**, and then select **Add**.

10. In the **Certificate Properties** page, under **Alternative name**, under **Type**, select **DNS** from the drop-down menu.

11. In the **Value** text box, enter **`LON-RDS1.contoso.com`**, and then select **Add**.

12. Select the **General** tab, and then in the **Friendly name** text box, enter **`RDS Certificate`**.

13. Select **OK** to close the **Certificate Properties** box.

14. On the **Request Certificates** page, select **Enroll**.

15. On the **Certificate Installation Results** page, select **Finish**, and then close the **certlm** console.

16. On **LON-RDS1**, in **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager**.

17. Expand **LON-RDS1**, expand **Sites**, and then select **Default Web Site**.

18. In the **Actions** pane, select **Bindings**.

19. In the **Site Bindings** window, select **https**, and then select **Edit**.

20. In the **Edit Site Binding** window, under **SSL certificate**, select the drop-down menu, and then select **RDS Certificate**.

21. Select **OK** to close the **Edit Site Binding** window.

22. Select **Close** to close the **Site Bindings** window.

23. Close **Internet Information Services (IIS) Manager**.

### Task 2: Create a session collection 

>Note: RDS in Windows Server supports two types of session collections on a single RD Session Host: an RD session collection or a RemoteApp session collection. You can't run both session-collection types on the same RD Session Host by default. Therefore, when you're doing this exercise, you'll create an RD Session Host collection and verify that it works, and then you'll create a RemoteApp session collection and verify that works, as well.

1. On **LON-RDS1**, in **Server Manager**, select **Remote Desktop Services**.

2. On the **Remote Desktop Service Overview** page, select **Collections**.

3. In the **details** pane under **COLLECTIONS**, select **TASKS**, and then select **Create Session Collection**. 

>Note: You might need to scroll to the right to find this option.

4. In the **Create Collection** wizard, on the **Before you begin** page,  select **Next**.

5. On the **Name the collection** page, in the **Name** field, enter **`IT`**, and then select **Next**.

6. On the **Specify RD Session Host servers** page, in the **Server Pool** section, select **LON-RDS1.Contoso.com**. Add the computers to the **Selected** section by selecting the arrow, and then select **Next**.

7. On the **Specify user groups** page, select **Remove** to remove **CONTOSO\\Domain Users**, and then select **Add**.

8. In **the Enter the object names to select** field, enter **`IT`**.

9. Select **Check Names**, and then select **OK**.

10. Verify that **CONTOSO\\IT** is listed under **User Groups**, and then select **Next**.

11. On the **Specify user profile disks** page, clear the **Enable user profile disks** checkbox, and then select **Next**.

12. On the **Confirm selections** page, select **Create**.

13. When the collection is created successfully, on the **View Progress** page, select **Close**.

### Task 3: Configure the session-collection properties

#### Configure device-redirection settings

1. On **LON-RDS1**, in the **navigation** pane, select the **IT** collection.

2. Next to **PROPERTIES**, select **TASKS**, and then select **Edit Properties**.

3. On the **Session Collection** page, select the various settings and notice how the collection is configured.

4. Select **Client Settings**, and then verify that both **Audio and video playback** and **Audio recording** are enabled.

5. Select **User Profile Disks**, and then verify that **User Profiles Disks** isn't enabled.

6. In the **IT Properties** dialog box, select **Cancel**.

7. Minimize **Server Manager**.

8. Select **Start**, and then select **Windows PowerShell ISE**.

9. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

  ```
Get-RDSessionCollectionConfiguration –CollectionName IT –Client | Format-List
  ```

10. Examine the output, and notice that next to **ClientDeviceRedirectionOptions**, the following entries are listed:

   - **AudioVideoPlayBack**
   - **AudioRecording**
   - **PlugAndPlayDevice**
   - **SmartCard**
   - **Clipboard**
   - **Drive**

11. In the **Administrator: Windows PowerShell** window, enter the following command, and then select Enter:

   ```
Set-RDSessionCollectionConfiguration –CollectionName IT –ClientDeviceRedirectionOptions PlugAndPlayDevice, SmartCard,Clipboard,Drive
   ```

12. In the **Administrator: Windows PowerShell** window, enter the following command, and then select Enter:

   ```
Get-RDSessionCollectionConfiguration –CollectionName IT –Client | Format-List
   ```

13. Examine the output, and notice that next to **ClientDeviceRedirectionOptions**, only the following entries are listed now:

   - **PlugAndPlayDevice**
   - **SmartCard**
   - **Clipboard**
   - **Drive**

#### Configure user-profile disks for IT collection

1. Switch to **LON-DC1**, and then sign in as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

2. Select **Start**, and then select **Windows PowerShell ISE**.

3. In the **Administrator: Windows PowerShell ISE** window, enter the following commands, one line at a time, selecting Enter after each:

```
New-Item C:\RDSUserProfiles -itemtype directory
New-SMBShare –Name "RDSUserProfiles" –Path "C:\RDSUserProfiles" –FullAccess "Contoso\LON-RDS1$", "Contoso\administrator"
$acl = Get-Acl C:\RDSUserProfiles
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Contoso\LON-RDS1$","FullControl","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl C:\RDSUserProfiles
```

   Verify that each command executes successfully.

4. Switch to **LON-RDS1**.

5. In Server Manager, in the navigation pane, select the **IT** collection.

6. Next to **PROPERTIES**, select **TASKS**, and then select **Edit Properties**.

7. On the **Session Collection** page, select **User Profile Disks**, and then select **Enable user profile disks**.

8. In the **Location** field, enter **`\\LON-DC1\RDSUserProfiles`**. In the **Maximum size (in GB)**, enter **`10`**, and then select **OK**.

9. Restart **LON-RDS1**, and then sign in as **`Contoso\Administrator`** with the password **`Pa55w.rd`**.

>Note: Wait for **LON-RDS1** to restart, and then sign in before continuing with the next task.

### Task 4: Connect to the session collection from RD Web portal

1. Switch to **LON-CL1** and sign in as **`Contoso\Tonnie`** with the password of **`Pa55w.rd`**.
2. On **LON-CL1**, on the taskbar, select the **Microsoft Edge** icon. Complete the setup as prompted.
3. In **Microsoft Edge**, in the address bar, enter **`https://LON-RDS1.Contoso.com/rdweb`**.

4. On the **Work Resources** page, in the **Domain\\user name** field, enter **`Contoso\Tonnie`**. In the **Password** field, enter **`Pa55w.rd`**, and then select **Sign in**.
5. If prompted by **Microsoft Edge** to save the password, select **Never**.
6. On the **Work Resources** page, under **Current folder: /**, select **IT**, and when prompted, in the **Downloads** box, select **Open file**.
7. In the **Remote Desktop Connection** dialog box, select **Connect**.

>Note: This prompts the **Unknown publisher** pop up window because certificates for RDS services haven't been configured.

8. In the **Windows Security** dialog box, in the **Password** field, enter **`Pa55w.rd`**, and then select **OK**.

>Note: Tonnie connects to the desktop of LON-RDS1.

9. In the **LON-RDS1.Contoso.com** remote desktop window, right-click or access the context menu for **Start**, select **Shut down or sign out**. and then select **sign-out**.

10. Back on the **Work Resources** page, select **Sign out**.

11. Close **Microsoft Edge**.

#### Verify User Profile Disk creation

1. Switch to **LON-DC1**, and in the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:
   `cd\`

2. Enter the following command, and then select Enter:
   `cd RDSUserProfiles`

3. Enter the following command, and then select Enter:
   `dir`

4. Examine the contents of the **RDSUserProfiles** folder. 

>Note: Verify that there's a **.vhdx** file with an SID (a long string that starts with **S-1-5-21**) in its name.

### Results

After completing this exercise, you have installed RDS, created and modified a session collection, and validated the connection to the collection using the RD Web portal.

## Exercise 2: Configuring RemoteApp collection settings

### Scenario

In this exercise, you explore how to add RemoteApp Programs to RDS using both Server Manager and Windows PowerShell. You will then run a RemoteApp Program from the RD Web portal.

The main tasks for this exercise are as follows:

1. Create and configure a RemoteApp collection using Server Manager.
2. Create and configure a RemoteApp program using Windows PowerShell.
3. Run RemoteApp from RD Web portal.

### Task 1: Create and configure a RemoteApp collection using Server Manager

1. Switch to **LON-RDS1**.
2. If necessary, open **Server Manager**, select **Remote Desktop Services**, and then select the **IT** collection.
3. In the **details** pane, next to **REMOTEAPP PROGRAMS**, select **TASKS**, and then select **Publish RemoteApp Programs**.
4. On the **Select RemoteApp programs** page, scroll down in the list under **The RemoteApp programs are populated from LON-RDS1.CONTOSO.COM**. Select **WordPad** and select **Next**.
5. On the **Confirmation** page, select **Publish**, and wait for the RemoteApp to be published.
6. On the **Completion** page, verify that **WordPad** is listed in the **details** pane under **RemoteApp Program**, and then select **Close**.

### Task 2: Create and configure a RemoteApp program using Windows PowerShell

1. On **LON-RDS1**, select **Start**, and then select **Windows PowerShell ISE**.

2. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

  ```
New-RDRemoteApp -Alias Paint -DisplayName Paint -FilePath "C:\Windows\system32\mspaint.exe" -ShowInWebAccess 1 -collectionname IT -ConnectionBroker LON-RDS1.Contoso.com
  ```

>Note: When the command has completed, review the information about the published app.

3. In the **Administrator: Windows PowerShell ISE** window, enter the following command, and then select Enter:

  ```
Get-RDRemoteApp -CollectionName IT
  ```

>Note: Examine the command's output, and notice that you get a list of all published RemoteApp programs.

4. Maximize **Server Manager**, and then select **Overview**.

5. Refresh **Server Manager** by selecting F5.

6. In **Server Manager**, in the **navigation** pane, select the **IT** collection, and then verify that **Paint** is listed in the **details** pane under **REMOTEAPP PROGRAMS**.

### Task 3: Run RemoteApp from RD Web portal

1. Switch to **LON-CL1**.

2. On **LON-CL1**, on the taskbar, select the **Microsoft Edge** icon. 

3. In Microsoft Edge, in the address bar, enter **`https://LON-RDS1.Contoso.com/rdweb`**, and then select Enter.

4. On the **RD Web Access** page, in the **Domain\\user name** field, enter **`Contoso\Tonnie`**. In the **Password** field, enter **`Pa55w.rd`**, and then select **Sign in**. If prompted by Microsoft Edge to save the password, select **Never**.

5. On the **Work Resources** page, under **Current folder: /**, select **Paint**, and when prompted, select **Open file**.

6. In the **RemoteApp** dialog box, select **Connect**.

7. In the **Windows Security** dialog box, in the **Password** field, enter **`Pa55w.rd`**.

>Note: Wait for the RemoteApp **Paint** program to start, and then test its functionality.

8. In **Paint**, select **File**, and then select **Exit** to close the application.

9. Repeat steps 4 through 7, and verify that you can connect to **WordPad**.

10. On the **RD Web Access** page, select **Sign out**.

11. Close Microsoft Edge.

### Results

After completing this exercise, you'll have created a RemoteApp collection with WordPad and Paint, and verified that you can access the collection by using the RD Web portal.
