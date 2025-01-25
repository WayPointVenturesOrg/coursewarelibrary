# Lab 2B: Managing Address lists and Address book policies in Exchange Online

## Lab scenario

To help organize user contact information, you decide to create and assign custom address lists for the Sales and Research departments. You have also been asked to create a custom Address Book Policy (ACB) for users with the company named attribute of **Adatum**. This ABP will be assigned to users that have recently been acquired from Adatum Corp.

>**Important:** This lab requires students to first complete the **Module 1 lab: Exploring Microsoft 365 and Exchange Online administration portals** and the **Module 2 lab A: Creating and managing Exchange Online recipients**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234
## Exercise 1: Creating address lists

### Scenario

You need to create two new address lists for the Sales and Research departments. These address lists will display mailboxes that have the **Sales** and **Research** attributes configured.

The main tasks for this exercise are as follows:

1. Assign role permissions for modifying Address Lists.
2. Use Exchange Online PowerShell to create address lists.
3. View the new address lists.

### Task 1: Assign role permissions for modifying Address Lists

1. On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2. In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3. At the **User Account Control**, select **Yes**.

4. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-ExchangeOnline`

5. Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

6.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

```
New-ManagementRoleAssignment -SecurityGroup "Organization Management" -Role "Address Lists" -RecipientRelativeWriteScope Organization
```

>**Note:** By default, no user has permission to create or modify Address Lists. You added the Address Lists role to the Organization Management role group to permit address lists management. You will learn more about role-based access control (RBAC) in Module 3.

7.  Close Windows PowerShell ISE.

>**Note:** You need to restart Windows PowerShell ISE with the new role assignment.

### Task 2: Use Exchange Online PowerShell to create address lists

1. On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2. In the search results, under **Windows PowerShell ISE**, select **run as administrator**.

3. At the **User Account Control**, select **Yes**.

4. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-ExchangeOnline`

5. Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

6. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

```
New-AddressList -Name "Research" -IncludedRecipients MailboxUsers -ConditionalDepartment "Research"
```

>**Note:** The **New-AddressList** cmdlet is used to create a new address list named **Research** that contains all mailbox users that have the **Department** attribute set to **Research**.

7.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

```
New-AddressList -Name "Sales" -IncludedRecipients MailboxUsers -ConditionalDepartment "Sales"
```

>**Note:** The **New-AddressList** cmdlet is used to create a new address list named **Sales** that contains all mailbox users that have the **Department** attribute set to **Sales**.

### Task 3: View the new address lists

>**Note:** Wait 3-5 minutes before continuing with the next task. It may take a few minutes for the new address lists to register.

1.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

3.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Outlook opens with the Inbox selected.

4.  In the **Outlook** navigation menu, select the **People** icon.

5.  On the **Contact list** page, scroll down and expand **Directory**.

>**Note:** Notice that both the **Research** and the **Sales** address lists now display in the directory.

6.  Select the **Research** address list.

>**Note:** The Research address list displays all users that have the **Research department** attribute. It may take some time for users to display.

7.  Select the **Sales** address list.

>**Note:** The Sales address list displays all users that have the **Sales department** attribute. It may take some time for users to display.

8.  Close Microsoft Edge.

**Results:** After completing this exercise, you'll have created new address lists for your Exchange Online environment.

## Exercise 2: Creating and assigning Address book policies

### Scenario

You need to create a custom address book policy for the users that have been acquired from Adatum Corp. The Address Book Policy will contain a custom global address list named **Adatum GAL**, an offline address book named **OAB_Adatum**, and a room list named **Conference Rooms**. The policy will be assigned to all users with their **Company** attribute set to **Adatum**.

The main tasks for this exercise are as follows:

1. Enable Address Book Policy Routing.
2. Create a new Global Address List.
3. Create an Offline Address Book.
4. Create a Room List.
5. Create an Address Book Policy.
6. Assign the Address Book Policy to Users.
7. Verify the Address Book Policy.
8. Review Mailbox Policy settings by using the Exchange admin center.

### Task 1: Enable Address Book Policy Routing

1. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Set-TransportConfig -AddressBookPolicyRoutingEnabled $true`

2. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Get-TransportConfig | Format-List AddressBookPolicyRoutingEnabled`

>**Note:** The **AddressBookPolicyRoutingEnabled** parameter should display **True** as an indictor that it's enabled. 

### Task 2: Create a new Global Address List

1. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `New-GlobalAddressList -Name "Adatum GAL" -IncludedRecipients AllRecipients -ConditionalCompany Adatum`

2. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Get-GlobalAddressList -Identity "Adatum GAL" | Format-List Name,RecipientFilterType,RecipientFilter,IncludedRecipients,Conditional*`

>**Note:** If you receive an error message, the role assignment process has not completed for the tenant. It may take a couple of hours to complete the role assignment process. You may need to return at a later time to complete Exercise 2.

>**Note:** The **Adatum GAL** is configured to only display recipients with the **Company** attribute set to **Adatum**. 

### Task 3: Create an Offline Address Book

1. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `New-OfflineAddressBook -Name "OAB_Adatum" -AddressLists "\Adatum GAL"`

>**Note:** Results should display to indicate that the new OAB has been created. 

### Task 4: Create a Room List

1. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `New-AddressList -Name "Conference Rooms" -RecipientFilter {(RecipientDisplayType -eq 'ConferenceRoomMailbox')}`

>**Note:** Results should display to indicate that the new room list has been created. 

### Task 5: Create an Address Book Policy

1. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `New-AddressBookPolicy -Name "Adatum" -AddressLists "\Sales" -OfflineAddressBook "\OAB_Adatum" -GlobalAddressList "\Adatum GAL" -RoomList "\Conference Rooms"`

2. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Get-AddressBookPolicy`

>**Note:** The **Get-AddressBookPolicy** cmdlet displays the configured address book policy named **Adatum**. 

### Task 6: Assign the Address Book Policy to Users

1. At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Get-Recipient -Filter '(Company -eq "Adatum") -and (recipienttypedetails -eq "usermailbox")' | Set-Mailbox -AddressBookPolicy Adatum`

>**Note:** This PowerShell command assigns the Adatum Address Book Policy to any user that's configured with the **Company** attribute set to **Adatum**. 

### Task 7: Verify the Address Book Policy

>**Note:** Wait five minutes before continuing with Task 7. The address book settings may take some time to process.

1.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

3.  Sign in as **`Joni@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Outlook opens with the **Inbox** selected.

4.  In the Outlook navigation menu, select the **People** icon.

5.  On the Contact list page, scroll down and expand **Directory**.

>**Note:** Notice that only the **Adatum GAL**, **Conference Rooms**, and **Sales** address lists display. If you do not see the Adatum GAL, sign out and then sign back in again as Joni.

6.  Select the **Adatum GAL** address list.

>**Note:** The **Adatum GAL** address list displays all users with the **Adatum** company attribute. It may take some time for users to display.

7.  Select the **Sales** address list.

>**Note:** The **Sales** address list displays all users with the **Sales department** attribute. It may take some time for users to display.

8.  Close Microsoft Edge.

### Task 8: Review Mailbox Policy settings by using the Exchange admin center

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

5.  Complete and close any notification prompts that might display.

6.  In the **Exchange admin center** navigation pane, expand **Recipients**, and then select **Mailboxes**.

7.  On the **Manage mailboxes** page, select **Joni Sherman**.

8.  In the **Joni Sherman** details panel, select the **Mailbox** tab, and then select **Manage mailbox policies**.

>**Note:** Verify that the Address book policy for Joni is set to **Adatum**.

9.  Close the **Mailbox policies** page for Joni Sherman.

10.  On the **Manage mailboxes** page, select **Raul Razo**.

11.  On the **Raul Razo** details panel, select the **Mailbox** tab, and then select **Manage mailbox policies**.

12.  Verify that the Address book policy for Raul is set to **Adatum**.

13.  Close the **Edit organization** page for Raul Razo.

14.  Close Microsoft Edge.

**Results**: After completing this exercise, you should have created and assigned an Address Book Policy to users with the company attribute set to **Adatum**.