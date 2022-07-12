# Lab: Manage user settings with Group Policy

## Lab scenario

Contoso Corporation has deployed Microsoft Office Professional Plus 2021 to users, and you need to use Group Policy to configure and apply settings for some Microsoft Office apps. The IT department uses logon scripts to provide users with drive mapping to shared folders. However, maintaining these scripts is an ongoing problem, because they're large and complex. You decide to use Group Policy preferences to implement drive mapping, which removes reliance on logon scripts.

Your manager also has asked that you place a desktop shortcut to the Notepad app for all users who belong to the IT Security group. Additionally, you must add a new computer administrator’s security group as a local administrator on all servers.

Finally, to help minimize profile sizes, you need to configure Folder Redirection to redirect several profile folders to each user’s home drive.

## Exercise 1: Use administrative templates to manage user settings

### Scenario

To use Group Policy for configuring Microsoft Office settings, you need to first import custom administrative templates.

The main tasks for this exercise are as follows:

1. Import administrative templates for Microsoft Office.

2. Configure Office settings.

3. Apply and verify settings on the client computer.

### Task 1: Import administrative templates for Microsoft Office

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.
2. On **LON-DC1**, on the taskbar, select **File Explorer**.
3. In File Explorer, in the navigation pane, expand **Allfiles (E:)**, expand **Labfiles**, and then select **Mod06**.

4. Open **admintemplates_x64_5287-1000_en-us.exe**.

5. In **The** **Microsoft Office Administrative Templates** dialog box, select the **Click here to accept the Microsoft Software License Terms** check box, and then select **Continue**.

6. In the **Browse for Folder** dialog box, select **Desktop**, and then select **OK**.

7. In **The** **Microsoft Office Administrative Templates** dialog box, select **OK**.

8. In File Explorer, in the navigation pane, select **Desktop**, and then in the content pane, open **admx**.

9. Select Ctrl+A to select all files, right-click or access the context menu, and then select **Copy**.

10. In the navigation pane, expand **Local Disk (C:)**, expand **Windows**, right-click or access the context menu for **PolicyDefinitions**, and then select **Paste**.

11. Close **File Explorer**.


### Task 2: Configure Office settings

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Group Policy Management**.

2. Switch to the **Group Policy Management** window.

3. In the navigation pane, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, and then select **Group Policy Objects**.

4. Right-click or access the context menu for **Group Policy Objects**, and then select **New**.

5. In the **New GPO** dialog box, enter **Office settings**, and then select **OK**.

6. In the contents pane, right-click or access the context menu for **Office settings**, and then select **Edit**.

7. In the **Group Policy Management Editor**, in the navigation pane, expand **User Configuration**, expand **Policies**, expand **Administrative Templates**, and then select **Microsoft Excel 2016**.

8. Expand **Microsoft Excel 2016**, expand **Excel Options**, select **Customize Ribbon**, and then open **Display Developer tab in the Ribbon**.

9. In the **Display Developer tab in the Ribbon** dialog box, select **Enabled**, and then select **OK**.

10. In the **Group Policy Management Editor**, select **Save**, and then open **Default file location**.

11. In the **Default file location** dialog box, select **Enabled**, in the **Default file location** text box, enter **%userprofile%\Desktop**, and then select **OK**.

12. Close the **Group Policy Management Editor**.

13. In Group Policy Management, right-click or access the context menu for the **Contoso.com** domain, and then select **Link an Existing GPO**.

14. In the **Select GPO** dialog box, select **Office settings**, and then select **OK**.


### Task 3: Apply and verify settings on the client computer

1. Switch to **LON-CL1**.

2. Sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. Right-click or access the context menu for **Start**, and then select **Windows Terminal**.

4. In the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   Gpupdate /force
   ```

5. Close the **Command Prompt** window.

6. Select **Start**, and then select **Excel **.

7. In the **Accept the license agreement** dialog box, select **Accept** and then select **Close**.

8. Select **Blank workbook**.

9. Verify that the **Developer** tab displays on the ribbon.

10. If the **Developer** tab is not displayed on the ribbon, perform the following steps:

    - Right-click or access the context menu for **Start**, select **Shutdown or Sign out**, and then select **Restart**.

    - After the computer has restarted, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

    - Perform steps 6through 9 again.

11. Select **File**, select **Save**, and then select **Browse**.

12. In the **Save as** dialog box, in the address bar, verify that **Desktop** displays, and then select **Cancel**.

    > This shows that the default save location is the Desktop as configured in the Group Policy setting.

13. Close **Excel**.


**Results:** After this exercise, you'll have extended administrative templates with Microsoft Office templates and configured Office settings by using Group Policy.

## Exercise 2: Implement settings by using Group Policy preferences

### Scenario

You need to provide users with drive mapping to shared folders. You'll do this by using Group Policy preferences, which will replace legacy logon scripts that Contoso currently uses. You also need to place a desktop shortcut to the Notepad app for all users who belong to the IT Security group.

The main tasks for this exercise are as follows:

1. Set up the current environment.

2. Test the mapped drive for Branch Office 1 users.

3. Create a Preferences Group Policy Object (GPO) with the required Group Policy preferences.

4. Test the preferences.

### Task 1: Set up the current environment

1. Switch to **LON-DC1**.

2. On **LON-DC1**, on the taskbar, select **File Explorer**.

3. In the navigation pane, expand **Allfiles (E:)**, expand **Labfiles**, and then select **Mod06**. 

4. In the details pane, right-click or access the context menu for **Mod06-1.ps1**, and then select **Run with PowerShell**.

5. If prompted, enter **`Y`**, and then select Enter.

6. Right-click or access the context menu for **BranchScript.cmd**, and then select **Copy**.

7. Switch to the **Group Policy Management** window.

8. In the navigation pane, right-click or access the context menu for **Group Policy Objects**, and then select **Refresh**.

9. Right-click or access the context menu for the **Branch1** Group Policy Object (GPO), and then select **Edit**. 

10. In the **Group Policy Management Editor** window, under **User Configuration**, expand **Policies**, expand **Windows Settings**, and then select **Scripts (Logon/Logoff)**.

11. In the details pane, open **Logon**.

12. In the **Logon Properties** dialog box, select **Show Files**. 

13. In the details pane, right-click or access the context menu for the blank area, and then select **Paste**.

14. Close the **Logon** window.

15. In the **Logon Properties** dialog box, select **Add**.

16. In the **Add a Script** dialog box, select **Browse**.

17. Select **BranchScript.cmd**, and then select **Open**.

18. Select **OK** twice to close all dialog boxes.

19. Close the **Group Policy Management Editor** window.


### Task 2: Test mapped drive for Branch Office 1 users

1. Switch to **LON-CL1**.

2. Right-click or access the context menu for **Start**, select **Shut down or sign out**, and then select **Restart**.

3. After the computer has restarted, sign in as **Contoso\\Tonnie** with the password **Pa55w.rd**.

4. On the taskbar, select **File Explorer**.

5. In File Explorer, select **This PC**. 

6. Verify that in the details pane, in the **Network Locations** section, drive **S** displays.

7. If drive **S** is not available, perform these steps:

   - Right-click or access the context menu for **Start**, and select **Windows Terminal**.

   - In the **Windows PowerShell** window, enter the following two commands, selecting Enter after each command:

     ```
     Gpupdate /force
     
     Shutdown /r /t 0
     ```

   - Perform steps 3-6 again.


### Task 3: Create a Preferences GPO with the required Group Policy preferences

1. Switch to **LON-DC1**.

2. On **LON-DC1**, switch to **Server Manager**, select **Tools**, and then select **Active Directory Users and Computers**.

3. In the **Active Directory Users and Computers** window, right-click or access the context menu for **IT**, select **New**, and then select **Group**.

4. In the **New Object – Group** dialog box, in the **Group name** text box, enter **Computer Administrators**, and then select **OK**.

5. Switch to the **Group Policy Management Console**, right-click or access the context menu for the **Contoso.com** domain, and then select **Refresh**.

6. Expand **Branch Office 1**, right-click or access the context menu for the **Branch1** GPO, and then select **Delete**.

7. In the **Group Policy Management** dialog box, select **OK**.

8. Right-click or access the context menu for the **Contoso.com** domain, and then select **Create a GPO in this domain, and Link it here**.

9. In the **New GPO** dialog box, in the **Name** text box, enter **Preferences**, and then select **OK**.

10. In the navigation pane, right-click or access the context menu for **Preferences**, and then select **Edit**. 

11. Expand **User Configuration**, expand **Preferences**, expand **Windows Settings**, right-click or access the context menu for **Shortcuts**, select **New**, and then select **Shortcut**. 

12. In the **New Shortcut Properties** dialog box, in the **Action** list, select **Create**. 

13. In the **Name** text box, enter **Notepad**. 

14. In the **Location** box, select the arrow, and then select **All Users** **Desktop**. 

15. In the **Target path** box, enter **C:\\Windows\\System32\\Notepad.exe**.

16. On the **Common** tab, clear the **Run in logged-on user’s security context (user policy option)** check box.

17. Select the **Item-level** **targeting** check box, and then select **Targeting**. 

18. In the **Targeting Editor** dialog box, select **New Item**, and then select **Security Group**. 

19. In the lower part of the dialog box, select the ellipsis button (**…**).

20. In the **Select Group** dialog box, in the **Enter the object name to select (examples)** box, enter **IT**, and then select **OK**.

21. Select **OK** two more times. 

22. Right-click or access the context menu for **Drive Maps**, select **New**, and then select **Mapped Drive**.

23. In the **New Drive Properties** dialog box, in the **Location** text box, enter **\\\\LON-DC1\\Branch1**, and then select the **Reconnect** check box. 
24. In the **Label as** text box, enter **Drive for Branch Office 1**, in the **Use** drop-down list box, select **S**.
25. On the **Common** tab, select the **Run in logged-on user’s security context (user policy option)** check box.

26. Select the **Item-level** **targeting** check box, and then select **Targeting**. 

27. In the **Targeting Editor** dialog box, select **New Item**, and then select **Organizational Unit**. 

28. In the lower part of the dialog box, select the ellipsis button (**…**).

29. In the **Find Custom Search** dialog box, in the **Search results** list, select **Branch Office 1**, and then select **OK**.

30. Select **OK** two more times. 

31. Expand **Computer Configuration**, expand **Preferences**, and then expand **Control Panel Settings**.

32. Right-click or access the context menu for **Local Users and Groups**, hover over **New**, and then select **Local Group**. 

33. In the **New Local Group Properties** dialog box, in the **Group name** text box, enter **Administrators**, and then select **Add**.

34. In the **Local Group Member** dialog box, select the ellipsis button (**…**).

35. In the **Select User, Computer or Group** dialog box, in the **Enter the object name to select (examples)** text box, enter **Computer Administrators**, and then select **OK** twice.

36. In the **New Local Group Properties** dialog box, select the **Common** tab.

37. On the **Common** tab, select the **Item-level targeting** check box, and then select **Targeting**.

38. In the **Targeting Editor** dialog box, select **New Item**, and then select **Operating System**.

39. In the **Product** drop-down list box, select **Windows Server 2022 Family**, and then select **OK** twice.

40. Close all open windows except **Group Policy Management** and **Server Manager**.


### Task 4: Test the preferences

1. Switch to **LON-CL1**.

2. Right-click or access the context menu for **Start**, select **Shut down or sign out**, and then select **Restart**.

3. When the computer has restarted, sign in as **Contoso\\Tonnie** with the password of **Pa55w.rd**.

4. On the taskbar, select **File Explorer**.

5. In File Explorer, select **This PC**. 

6. Verify that in the details pane, in the **Network Locations** section, drive **S** displays. 

   > **Note:** The drive label now is **Drive for Branch Office 1**, which verifies that the drive is mapped through Group Policy preferences.

7. On the desktop, verify that a shortcut exists for Notepad.

8. If the shortcut for Notepad isn't available, perform these steps:

   - Right-click or access the context menu for **Start**, and select **Windows Terminal**.

   - In the **Windows PowerShell** window, enter the following two commands, selecting Enter after each command:

     ```
     Gpupdate /force
     
     Shutdown /r /t 0
     ```

   - Perform step 3 again.


   > The shortcut for Notepad should now display on the desktop.
   >

9. Right-click or access the context menu for **Start**, and then select **Computer Management**.

10. In **Computer Management**, expand **Local Users and Groups**, and then select **Groups**.

11. In the details pane, open **Administrators**. 

12. Verify that the **Computer Administrators** group isn't a member of the **Administrators** group. 

    > **Note:** The **Computer Administrators** group isn't a member of the **Administrators** group because the Preferences setting only applies to servers.

13. Sign out of **LON-CL1**. 


**Results**: After this exercise, you'll have removed the logon scripts, configured preference settings, and then assigned them by using GPOs.

## Exercise 3: Configure Folder Redirection

### Scenario

To help minimize the size of user profiles, you decide to configure Folder Redirection for the branch office users to redirect several profile folders to each user’s home drive.

The main tasks for this exercise are as follows:

1. Create a shared folder to store the redirected folders.

2. Create a new GPO and link it to the Branch Office 1 organizational unit (OU).

3. Edit the Folder Redirection settings in the policy.

4. Test the Folder Redirection settings.

### Task 1: Create a shared folder to store the redirected folders

1. On **LON-DC1**, on the taskbar, select **File Explorer**.

2. In the navigation pane, select **This PC**.

3. In the details pane, open **Local Disk (C:)**, and then on the **Home** tab, select **New** **folder**. Name the new folder **Branch1Redirect**.

4. Right-click or access the context menu for the **Branch1Redirect** folder, select **Give access to**, and then select **Specific** **people**.

5. In the **Network access** dialog box, select the drop-down list box, select **Everyone**, and then select **Add**.

6. For the **Everyone** group, select the **Permission** **Level** drop-down list box, and then select **Read/Write**.

7. Select **Share**, and then select **Done**.

8. Close File Explorer.


### Task 2: Create a new GPO and link it to the Branch Office 1 OU

1. On **LON-DC1**, switch to **Group Policy Management**.

2. In Group Policy Management, right-click or access the context menu for **Branch Office 1**, and then select **Create a GPO in this domain** **and Link it here**.

3. In the **New GPO** dialog box, in the **Name** text box, enter **Folder Redirection**, and then select **OK**.


### Task 3: Edit the Folder Redirection settings in the policy

1. Expand **Branch Office 1**, right-click or access the context menu for **Folder Redirection**, and then select **Edit**. 

2. In the **Group Policy Management Editor** window, under **User Configuration**, expand **Policies**, expand **Windows** **Settings**, and then expand **Folder Redirection**.

3. Right-click or access the context menu for **Documents**, and then select **Properties**.

4. In the **Document Properties** dialog box, on the **Target** tab, in the **Setting** drop-down list box, select **Basic – Redirect everyone’s folder to the same location**.

5. Ensure that the **Target folder location** box is set to **Create a folder for each** **user under the root path**.

6. In the **Root Path** text box, enter **\\\\LON-DC1\\Branch1Redirect**, and then select **OK**.

7. In the **Warning** dialog box, select **Yes**.

8. Right-click or access the context menu for **Pictures**, and then select **Properties**.

9. In the **Pictures Properties** dialog box, on the **Target** tab, in the **Setting** drop-down list box, select **Follow the Documents folder**, and then select **OK**.

10. In the **Warning** dialog box, select **Yes**.

11. Right-click or access the context menu for **Music**, and then select **Properties**.

12. In the **Music Properties** dialog box, on the **Target** tab, in the **Setting** drop-down list box, select **Follow the Documents folder**, and then select **OK**.

13. In the **Warning** dialog box, select **Yes**.

14. Close all open windows on **LON-DC1**.


### Task 4: Test the Folder Redirection settings

1. Switch to **LON-CL1**.

2. Sign in as **Contoso\\Tonnie** with the password of **Pa55w.rd**.

3. Right-click or access the context menu for **Start**, and then select **Windows Terminal**.

4. In the **Windows PowerShell** window, enter the following command, and then select Enter:

   ```
   gpupdate /force
   ```

5. When prompted, enter `Y`, and then select Enter.

6. Sign out, and then sign back in to **LON-CL1** as **Contoso\\Tonnie** with the password of **Pa55w.rd**.

7. On the taskbar, select **File Explorer**.

8. In File Explorer, in the navigation pane, right-click or access the context menu for **Documents**, and then select **Properties**. 

9. In the **Documents** properties dialog box, verify that the location is **\\\\LON-DC1\\Branch1Redirect\\Tonnie**, and then select **OK**. 

   > **Note:** If the location is **C:\\Users\\Tonnie**, perform steps 3 through 9 again. If the location hasn't changed, restart **LON-CL1**, and then perform steps 2 through 9 again.

10. Open **Documents**, and verify that two subfolders, **Music** and **Pictures** exist. 

    > **Note:** This verifies that **Music** and **Pictures** are redirected, as well.

11. Sign out of **LON-CL1**.


**Results**: After this exercise, you'll have successfully configured Folder Redirection to a shared folder on the **LON-DC1** server.
