---
lab:
    title: 'Lab: Configure security in Windows Server'
    module: 'Module 8: Windows Server security'
---

# Lab: Configure security in Windows Server

## Scenario

Contoso Pharmaceuticals is a medical research company with about 5,000 employees worldwide. They have specific needs for ensuring that medical records and data remain private. The company has a headquarters location and multiple worldwide sites. Contoso Pharmaceuticals has recently deployed a Windows Server and Windows client infrastructure. You've been asked to implement improvements in the server security configuration.

## Objectives

After completing this lab, you'll be able to:

- Configure Windows Defender Credential Guard.
- Locate problematic user accounts.
- Implement and verify Local Administrator Password Solution (LAPS) 

## Estimated time: 40 minutes
## Exercise 1: Configure Windows Defender Credential Guard

### Scenario

You decide to implement Windows Defender Credential Guard on the servers and administrative workstations to help protect against Pass-the-Hash and Pass-the-Ticket credential thefts. You'll use Group Policy to enable Credential Guard on your existing servers. For all new servers, you'll use the Hypervisor-Protected Code Integrity and Windows Defender Credential Guard hardware readiness tool to enable Credential Guard before the new servers are domain joined.

In this lab, you'll set up the Group Policy and run the Hypervisor-Protected Code Integrity and Windows Defender Credential Guard hardware readiness tool on an existing server.

>Note: In the lab environment, Credential Guard won't run on the virtual machines (VMs) because they don't meet the requirements. However, you can still create the Group Policy Objects (GPOs) and run the tool.

The main tasks for this exercise are to:

1. Enable Windows Defender Credential Guard using Group Policy.
2. Enable Windows Defender Credential Guard using the Hypervisor-Protected Code Integrity and Windows Defender Credential Guard hardware readiness tool.

### Task 1: Enable Windows Defender Credential Guard using Group Policy

1. Sign-in to **LON-ADM1** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.
2. Select **Start**, and then enter **Group Policy Management**.
3. Select **Group Policy Management**.
4. In the Group Policy Management Console, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click or access the context menu for the **IT** organizational unit (OU), and then select **Create a GPO in this domain, and Link it here**.
5. In the **New GPO** dialog box, in the **Name** text box, enter **`CredentialGuard_GPO`**, and then select **OK**.
6. In the **Group Policy Management** window, under **IT**, right-click or access the context menu for **CredentialGuard_GPO**, and then select **Edit**.
7. In the Group Policy Management Editor, navigate to **Computer Configuration\\Policies\\Administrative Templates\\System\\Device Guard**.
8. Select **Turn On Virtualization Based Security**, and then select the **policy setting** link.
9. Select **Enabled**.
10. In the **Select Platform Security Level** drop-down list, select **Secure Boot and DMA Protection**.
11. In the **Credential Guard Configuration** drop-down list, select **Enabled with UEFI lock**.
12. In the **Secure Launch Configuration** drop-down list, select **Enabled**, and then select **OK**.
13. Close the Group Policy Management Editor.
14. Close the Group Policy Management Console.

### Task 2: Enable Windows Defender Credential Guard using the Hypervisor-Protected Code Integrity and Windows Defender Credential Guard hardware readiness tools

1. On **LON-ADM1**, select **Start**, and then select **Windows PowerShell ISE**.

2. In the PowerShell Integrated Scripting Environment (ISE) window, enter the following command, and then select Enter:

   ```
cd C:\labfiles\Mod08
   ```

3. Enter the following command, and then select Enter:

   ```powershell-notab
   ./DG_Readiness_Tool.ps1 -Enable -AutoReboot
   ```

>Note: The readiness tool enables services and then restarts **LON-ADM1**. This might take several minutes to complete.

4. After **LON-ADM1** restarts, sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**

### Results

After completing this exercise, you'll have:

1. Used Group Policy to implement Windows Defender Credential Guard on all computers in your organization.
2. Enabled Windows Defender Credential guard on **LON-ADM1**.
## Exercise 2: Locate problematic accounts

### Scenario

You need to check whether your organization has user accounts with passwords that are configured not to expire and remediate this setting. You also want to check which accounts haven’t signed in for 90 of days or more and disable them.

The main tasks for this exercise are to:

1. Locate and reconfigure accounts with passwords that don’t expire.
2. Locate and disable accounts to which no sign-ins have occurred for at least 90 days.

### Task 1: Locate and reconfigure accounts with passwords that don’t expire

1. If necessary, sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**

2. On **LON-ADM1**, select **Start**, and then select **Windows PowerShell ISE**.

3. Enter the following command:

   ```powershell-notab
Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $true}
   ```

4. Review the list of user accounts returned.

5. Enter the following command:

   ```powershell-notab
Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $true} | Set-ADUser -PasswordNeverExpires $false
   ```

6. Rerun the command from step 3 and notice that no users are returned.

### Task 2: Locate and disable accounts to which no sign-ins have occurred for at least 90 days

1. Enter the following commands:

   ```
   $days = (Get-Date).Adddays(-90)
   ```
   ```
   Get-ADUser -Filter {LastLogonTimeStamp -lt $days -and enabled -eq $true} -Properties LastLogonTimeStamp
   ```

>Note: No accounts will be returned in the lab environment.

2. Enter the following command:

   ```
   Get-ADUser -Filter {LastLogonTimeStamp -lt $days -and enabled -eq $true} -Properties LastLogonTimeStamp | Disable-ADAccount
   ```

>Note: No results will be returned in the lab environment.

3. Close Windows PowerShell ISE.
## Exercise 3: Implement LAPS

### Scenario

At present, the same local administrator account password is used across all servers and workstations at Contoso Pharmaceuticals. To remedy this problem, you'll configure and deploy Local Administrator Password Solution (LAPS).

The main tasks for this exercise are to:

1. Prepare OU and computer accounts for LAPS.
2. Prepare Active Directory Domain Services (AD DS) for LAPS.
3. Deploy LAPS client-side extension.
4. Verify LAPS.

### Task 1: Prepare OU and computer accounts for LAPS

1. If necessary, sign in to **LON-ADM1** as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**

2. On **LON-ADM1**, select **Start**, and then select **Windows PowerShell ISE**.

3. Enter the following commands:

   ```
New-ADOrganizationalUnit -Name "Seattle_Servers"
   ```
   ```
Get-ADComputer LON-SVR1 | Move-ADObject –TargetPath "OU=Seattle_Servers,DC=Contoso,DC=com"
   ```

4. Enter the following command:

   ```powershell-notab
Msiexec /I C:\Labfiles\Mod08\LAPS.x64.msi
   ```

5. When the **Local Administrator Password Solution Setup Wizard** opens, select **Next**.

6. Select **I accept the terms in the License Agreement**, and then select **Next**.

7. Under **Custom Setup**, in the drop-down menu next to **Management Tools**, select **Entire feature will be installed on the local hard drive**.

8. Select **Next**, select **Install**, and then select **Finish**.

### Task 2: Prepare AD DS for LAPS

1. In Windows PowerShell ISE, enter the following commands:

   ```
Import-Module admpwd.ps
   ```
   ```
Update-AdmPwdADSchema
   ```
   ```
Set-AdmPwdComputerSelfPermission -Identity "Seattle_Servers"
   ```

2. Select **Start**, and then enter **Group Policy**.

3. Select **Group Policy Management**.

4. In the Group Policy Management Console, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click or access the context menu for the **Seattle_Servers** OU, and then select **Create a GPO in this domain, and Link it here**.

5. In the **New GPO** dialog box, in the **Name** text box, enter **`LAPS_GPO`**, and then select **OK**.

6. In the **Group Policy Management** window, under **Seattle_Servers**, right-click or access the context menu for **LAPS_GPO**, and then select **Edit**.

7. In the **Group Policy Management Editor** window, under **Computer Configuration**, expand the **Policies** node, expand the **Administrative Templates** node, and then select **LAPS**.

8. Select the **Enable local admin password management** policy, and then select the **policy setting** link.

9. In the **Enable local admin password management** window, select **Enabled**, and then select **OK**.

10. Select the **Password Settings** policy, and then select the **policy setting** link.

11. In the **Password Settings** policy dialog box, select **Enabled**, and then configure **Password Length** to **`20`**.

12. Verify that the **Password Age (Days)** is configured to **30**, and then select **OK**.

13. Close the Group Policy Management Editor.

### Task 3: Deploy LAPS client-side extension

1. Switch to **LON-SVR1** and sign in as **`Contoso\Administrator`** with the password of **`Pa55w.rd`**.

>Note: You'll be prompted to change your password, because of the previous exercise. Provide a new password of **Pa55w.rd123** and use it in place of the documented password throughout the remainder of the lab.

2. At the SConfig management screen, enter `15` to exit to the command line (PowerShell)

3. At the PowerShell command prompt, enter the following command and select Enter:

```
Msiexec /I \\LON-ADM1\c$\Labfiles\Mod08\LAPS.x64.msi
```

4. When the **Local Administrator Password Solution Setup Wizard** opens, select **Next**.

5. Select **I accept the terms in the License Agreement**, and then select **Next**.

6. Select **Next** again, and then select **Install**.

7. Select **Finish**.

8. Enter the following command and then select Enter:

   ```cmd-notab
   gpupdate /force
   ```

### Task 4: Verify LAPS

1. Switch to **LON-ADM1**.

2. Select **Start**, select **LAPS**, and then select **LAPS UI**.

3. In the **LAPS UI** dialog box, in the **ComputerName** text box, enter **`LON-SVR1`**, and then select **Search**.

4. Review the **Password** and the **Password expires** values, and then select **Exit**.

5. In the Windows PowerShell ISE window, enter the following command:

   ```powershell-notab
Get-ADComputer LON-SVR1 -Properties ms-Mcs-AdmPwd
   ```

6. Review the password assigned to **LON-SVR1**.

7. Close the Windows PowerShell ISE window.

### Results

After completing this lab, you'll have:

- Prepared an OU and computer accounts for LAPs.
- Prepared your AD DS for LAPS.
- Deployed LAPS client-side extension.
- Verified that you implemented LAPS successfully.
