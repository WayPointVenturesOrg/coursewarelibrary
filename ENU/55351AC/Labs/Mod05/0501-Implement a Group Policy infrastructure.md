# Lab: Implement a Group Policy infrastructure

## Lab scenario

You've been asked to use Group Policy Objects (GPOs) to implement standardized security configuration for the Contoso.com domain, and you need to optimize the Group Policy infrastructure and verify that all policies are applied as intended.

## Exercise 1: Create and configure GPOs

### Scenario

You need to ensure that when users leave computers unattended for 10 minutes or more, their computer screens lock automatically. You also need to prevent access to local registry-editing tools on computers. You'll use a GPO to implement these settings and link the GPO to the Contoso.com object in Active Directory.

The main tasks for this exercise are as follows:

1. Create and edit a GPO.

2. Link the GPO.

3. View the effects of the GPO’s settings.

### Task 1: Create and edit a GPO

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager starts automatically.

2. From Server Manager, select **Tools**, and then select **Group Policy Management**.

3. If necessary, switch to the **Group Policy Management** window.

4. In **Group Policy Management Console**, in the navigation pane, expand **Forest: Contoso.com**, **Domains**, and **Contoso.com**, and then select the **Group Policy Objects** container.

5. In the navigation pane, right-click or access the context menu for the **Group Policy Objects** container, and then select **New**.

6. In the **Name** text box, enter **Contoso Standards**, and then select **OK**.

7. In the details pane, right-click or access the context menu for the **Contoso Standards** GPO, and then select **Edit**.

8. In the **Group Policy Management Editor** window, in the navigation pane, expand **User** **Configuration**, expand **Policies**, expand **Administrative** **Templates**, and then select **System**.

9. Open the **Prevent access to registry editing tools** policy setting.

10. In the **Prevent access to registry editing tools** dialog box, select **Enabled**, and then select **OK**.

11. In the navigation pane, expand **User** **Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Control Panel**, and then select **Personalization**.

12. In the details pane, open the **Screen saver timeout** policy setting. 

13. In the **Screen saver timeout** dialog box, select **Enabled**, in the **Seconds** text box, enter **600**, and then select **OK**.

14. Open the **Password protect the screen saver** policy setting.

15. In the **Password protect the screen saver** dialog box, select **Enabled**, and then select **OK**.

16. Close the **Group Policy Management Editor** window.


### Task 2: Link the GPO

1. In the **Group Policy Management** window, in the navigation pane, right-click or access the context menu for the **Contoso.com** domain, and then select **Link an Existing GPO**.

2. In the **Select GPO** dialog box, select **Contoso** **Standards**, and then select **OK**.


### Task 3: View the effects of the GPO’s settings

1. Switch to **LON-CL1**, and then sign in as **Contoso\Administrator** with the password **Pa55w.rd**. 

2. Select **Start**, and then enter **firewall**.

3. In the search results, select **Windows Defender Firewall**.

4. In Windows Defender Firewall, select **Allow an app or feature through Windows Defender Firewall**.

5. In the **Allowed apps and features** list, select the following check boxes, and then select **OK**:

   - **Remote Event Log Management**
   - **Windows Management Instrumentation (WMI)**

6. Sign out of LON-CL1.

7. Sign in as **Contoso\Tonnie** with the password **Pa55w.rd**. 

8. Select **Start**, enter **screen saver**, and then, in the search results, select **Change screen saver**. 

   > In the **Screen Saver Settings** dialog box, notice that the **Wait** option is dimmed and you can't change the time-out. Notice also that the **On resume, display logon screen** option is selected and dimmed, and that you can't change it. If the **On resume, display logon screen** option isn't selected and dimmed, open a command prompt and run the `gpupdate/force` command. 

9. To close the **Screen Saver Settings** dialog box, select **OK**.

10. Right-click or access the context menu for **Start**, and then select **Run**.

11. In the **Run** dialog box, in the **Open** text box, enter **regedit**, and then select **OK**.

    > Notice that an error message displays that states that Registry editing has been disabled by your administrator.

12. In the **Registry Editor** dialog box, select **OK**. 

13. Sign out of **LON-CL1**.

**Results:** After completing this exercise, you should have successfully created, edited, linked, and verified a GPO configuration.

## Exercise 2: Managing GPO scope

### Scenario

You configured a GPO to implement standardized settings to lock computer screens when users leave computers unattended for 10 minutes or more. However, you've been informed that a critical application used by the Research engineering team fails when the screen saver starts. You need to prevent the Contoso Standards GPO from applying to any member of the **Research** security group. 

You have also been asked to exempt conference-room kiosk computers from the Contoso Standards GPO. However, you must ensure that the kiosk computers always use a two-hour screen saver time-out setting, regardless on who signs into the computer. You'll use loopback processing to address this requirement.

The main tasks for this exercise are as follows:

1. Create and link the required GPOs.
2. Verify the order of precedence.
3. Configure the scope of a GPO with security filtering.
4. Configure loopback processing.

### Task 1: Create and link the required GPOs

1. On **LON-DC1**, in **Group Policy Management Console**, in the navigation pane, if necessary, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, and then select **Research**.

2. Right-click or access the context menu for the **Research** organizational unit (OU), and then select **Create a GPO in this domain, and Link it here**.

3. In the **New GPO** dialog box, in the **Name** text box, enter **Research Application Override**, and then select **OK**.

4. In the details pane, right-click or access the context menu for the **Research Application Override** GPO, and then select **Edit**. 

5. In the console tree, expand **User** **Configuration**, expand **Policies**, expand **Administrative** **Templates**, expand **Control Panel**, and then select **Personalization**.

6. Open the **Screen saver timeout** policy setting.

7. Select **Disabled**, and then select **OK**. 

8. Close the **Group Policy Management Editor** window.


### Task 2: Verify the order of precedence

1. In the Group Policy Management Console tree, select the **Research** OU, and then select the **Group Policy Inheritance** tab. 

   > Notice that the **Research Application Override** GPO has higher precedence than the **Contoso Standards** GPO. The screen saver time-out policy setting that you just configured in the **Research Application Override** GPO is applied after the setting in the **Contoso Standards** GPO. Therefore, the new setting will overwrite the standards setting and will prevail. Screen saver time-out will be unavailable for users within the scope of the **Research Application Override** GPO.

### Task 3: Configure the scope of a GPO with security filtering

1. On **LON-DC1**, in **Group Policy Management Console**, in the navigation pane, if necessary, expand the **Research** OU, and then select the **Research Application Override** GPO.

2. In the **Group Policy Management Console** dialog box, read the message, select the **Do not show this message again** check box, and then select **OK**. 

   > In the **Security Filtering** section, notice that the GPO applies by default to the **Authenticated Users** group.
   >

3. In the **Security Filtering** section, select **Authenticated Users**, and then select **Remove.**

4. In the **Group Policy Management** dialog box, select **OK**.

5. Read the warning message, and then select **OK**.

6. In the details pane, select **Add**. 

7. In the **Select User, Computer, or Group** dialog box, in the **Enter the object name to select (examples):** text box, enter **Research**, and then select **OK**.

8. In the details pane, under **Security Filtering**, select **Add**.

9. In the **Select User, Computer, or Group** dialog box, select **Object Types**.

10. In the **Object Types** dialog box, select the **Computers** check box, and then select **OK**.

11. In the **Select User, Computer, or Group** dialog box, in the **Enter Object Names to select (Examples)** text box, enter **LON-CL1**, and then select **OK**.


### Task 4: Configure loopback processing

1. On **LON-DC1**, in **Group Policy Management Console**, in the navigation pane, select **Contoso.com**, right-click or access the context menu for **Contoso.com**, and then select **New Organizational** **Unit**.

2. In the **New Organizational** **Unit** dialog box, in the **Name** text box, enter **Kiosks**, and then select **OK**.

3. Right-click or access the context menu for **Kiosks**, and then select **New Organizational Unit**.

4. In the **New Organizational** **Unit** dialog box, in the **Name** text box, enter **Conference Room**, and then select **OK**.

5. In the navigation pane, expand the **Kiosks** OU, and then select the **Conference Room** OU.

6. Right-click or access the context menu for the **Conference Room** OU, and then select **Create a GPO in this domain, and Link it here**.

7. In the **New GPO** dialog box, in the **Name** text box, enter **Conference Room Settings**, and then select **OK**.

8. In the navigation pane, expand **Conference Room**, and then select the **Conference Room Settings** GPO.

9. In the navigation pane, right-click or access the context menu for the **Conference Room Settings** GPO, and then select **Edit**.

10. In the **Group Policy Management Editor** window, in the navigation pane, expand **User** **Configuration**, expand **Policies**, expand **Administrative** **Templates**, expand **Control Panel**, and then select **Personalization**.

11. In the details pane, open the **Screen saver** **timeout** policy setting, and then select **Enabled**.

12. In the **Seconds** text box, enter **7200**, and then select **OK**

13. In the navigation pane, expand **Computer Configuration**, expand **Policies**, expand **Administrative Templates**, expand **System**, and then select **Group Policy**. 

14. In the details pane, open the **Configure user Group Policy** **loopback processing mode** policy setting, and then select **Enabled**.

15. In the **Mode** drop-down list, select **Merge**, and then select **OK**.

16. Close the **Group Policy Management Editor** window.
17. Close the Group Policy Management console.
18. Sign out of LON-DC1.

**Results**: After completing this exercise, you should have successfully configured the required scope for the GPOs.

