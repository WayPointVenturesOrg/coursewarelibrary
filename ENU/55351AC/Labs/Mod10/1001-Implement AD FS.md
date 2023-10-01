# Lab: Implement AD FS

## Lab scenario

Contoso Corporation has set up a variety of business relationships with other companies that need to access business applications that are running on the Contoso corporate network. Contoso wants to provide maximum level of functionality and access to these companies. The Security and Operations departments want to ensure that business partners and customers can access only the resources for which they have authorization and also that implementing the solution doesn't significantly increase the workload for the Operations team. 

To meet these business requirements, you plan to implement Active Directory Federation Services (AD FS). In the initial deployment, you plan to use AD FS to implement single sign-on (SSO) for internal users who are accessing an application on a web server. Contoso Corporation is partnering with another company, Trey Research, and its users should be able to access the same application.

As a proof of concept, you'll deploy a sample claims-aware application and configure AD FS to allow both internal users and Trey Research users to access the same application.

## Exercise 1: Configuring the AD FS prerequisites

### Scenario

To deploy AD FS, you must verify the configuration of all required components. You also need to verify that Active Directory Certificate Services (AD CS) is deployed in the organization and configure certificates for the AD FS server and web servers. Lastly, you must configure the Domain Name System (DNS) forwarders to enable communication between Contoso.com and TreyResearch.net.

The main tasks for this exercise are as follows:

1. Configure the DNS forwarders.

2. Configure the certificate trusts.

3. Configure an SSL certificate for the web server.

### Task 1: Configure the DNS forwarders

1.  Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

    > Note: Server Manager starts automatically.

2.  In the **Server Manager** window, select **Tools**, and then select **DNS**.

3.  In **DNS Manager**, expand **LON-DC1**, and then select **Conditional Forwarders**.

4.  Right-click or access the context menu for **Conditional Forwarders**, and then select **New Conditional Forwarder**.

5.  In the **New Conditional Forwarder** window, in the **DNS Domain** box, enter **`TreyResearch.net`**.

6.  In the **IP addresses of the master servers** box, enter **`172.16.10.10`**, and then select Enter.

    > Note: If you receive a notification that the IP address isn't authoritative for the required zone, you can safely ignore and proceed.

7.  Select the **Store this conditional forwarder in Active Directory, and replicate it as follows** check box, select **All DNS servers in this forest**, and then select **OK**.

8.  Close DNS Manager.

9.  Switch to **TREY-DC1**.

10.  Sign in to **TREY-DC1** as **TreyResearch\\Administrator** with the password of **`Pa55w.rd`**.

11.  In the **Server Manager** window, select **Tools**, and then select **DNS**.

12.  In **DNS Manager**, expand **TREY-DC1**, and then select **Conditional Forwarders**.

13.  Right-click or access the context menu for **Conditional Forwarders**, and then select **New Conditional Forwarder**.

14.  In the **New Conditional Forwarder** window, in the **DNS Domain** box, enter **`Contoso.com`**.

15.  In the **IP addresses of the master servers** box, enter **`172.16.0.10`**, and then select Enter.

    > Note: If you receive a notification that the IP address isn't authoritative for the required zone, you can safely ignore and proceed.

16.  Select the **Store this conditional forwarder in Active Directory, and replicate it as follows** check box, select **All DNS servers in this forest**, and then select **OK**.

17.  Close DNS Manager.

    > Note: In a real production environment, you'll probably use Internet DNS instead of conditional forwarders.

### Task 2: Configure the certificate trusts

1.  Switch to **LON-DC1**.

2.  On **LON-DC1**, open **File Explorer**, browse to **`\\TREY-DC1\CertEnroll`**, and then copy **TREY-DC1.TreyResearch.net_TreyResearchCA.crt** to **C:\\**.

3.  Close **File Explorer**.

4.  In **Server Manager**, select **Tools**, and then select **Group Policy Management**.

5.  In **Group Policy Management**, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click or access the context menu for **Default Domain Policy**, and then select **Edit**.

6.  In the **Group Policy Management Editor**, under **Computer Configuration**, expand **Policies**, expand **Windows** **Settings**, expand **Security Settings**, expand **Public Key Policies**, and then select **Trusted Root Certification Authorities**.

7.  Right-click or access the context menu for **Trusted Root Certification Authorities**, and then select **Import**.

8.  In the **Certificate Import Wizard**, on the **Welcome to the Certificate Import Wizard** page, select **Next**.

9.  On the **File to Import** page, enter **`C:\TREY-DC1.TreyResearch.net_TreyResearchCA.crt`**, and then select **Next**.

10.  On the **Certificate Store** page, select **Place all certificates in the following store**, select **Trusted Root Certification Authorities**, and then select **Next**.

11.  On the **Completing the Certificate Import Wizard** page, select **Finish**, and then select **OK** to close the success message.

12.  Close the Group Policy Management Editor, and then close Group Policy Management.

13.  Switch to **TREY-DC1**.

14.  On **TREY-DC1**, open **File Explorer**, and then browse to **`\\LON-DC1\CertEnroll`**.

15.  Right-click or access the context menu for **LON-DC1.Contoso.com_ContosoCA.crt**, and then select **Install Certificate**.

16.  In the **Certificate Import Wizard**, on the **Welcome to the Certificate Import Wizard** page, select **Local Machine**, and then select **Next**.

17.  On the **Certificate Store** page, select **Place all certificates in the following store**, and then select **Browse**.

18.  In the **Select Certificate Store** window, select **Trusted Root Certification Authorities**, and then select **OK**.

19.  On the **Certificate Store** page, select **Next**.

20.  On the **Completing the Certificate Import Wizard** page, select **Finish**, and then select **OK** to close the success message.

21.  Close File Explorer.

22.  Switch to **LON-SVR1**.

23.  Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

24.  On **LON-SVR1**, select **Start** and then select **Windows PowerShell ISE**.

25.  At the **Windows PowerShell ISE** command prompt, enter **`gpupdate`**, and then select Enter.

26.  Close Windows PowerShell ISE.

    > Note: If you obtain certificates from a trusted certification authority (CA), you don't need to configure a certificate trust between the organizations.

### Task 3: Configure an SSL certificate for the web server

1.  On **LON-SVR1**, open **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager**.

2.  In IIS Manager, expand **LON-SVR1 (Contoso\\Administrator)**, expand **Sites**, select **Default Web Site**, and then in the **Actions** pane, select **Bindings**.

3.  In the **Site Bindings** window, select **Add**.

4.  In the **Add Site Binding** window, in the **Type** list, select **https**.

5.  In the **SSL certificate** list, select **ContosoTestApp Certificate**, and then select **OK**.

    > Note: The ContosoTestApp Certificate has been precreated for this lab.

6.  In the **Site Bindings** window, select **Close**.

7.  Close IIS Manager.

**Results:** After completing this exercise, you'll have enabled DNS resolution and certificate trusts between the domains successfully and enabled an SSL certificate for the website.

## Exercise 2: Installing and configuring AD FS

### Scenario

The first scenario for implementing the proof-of-concept AD FS application is to ensure that internal users can use SSO to access the web application. You plan to configure the AD FS server and a web application to enable this scenario. To start the AD FS implementation, you'll install AD FS on the Contoso.com domain controller  (DC) and configure the server as a standalone federation server. You'll also configure the server to use a CA-signed token-signing certificate.

The main tasks for this exercise are as follows:

1. Create a DNS record for AD FS.
2. Install AD FS.
3. Configure AD FS.

### Task 1: Create a DNS record for AD FS

1.  On **LON-DC1**, in Server Manager, select **Tools**, and then select **DNS**.

2.  In DNS Manager, expand **LON-DC1**, expand **Forward Lookup Zones**, and then select **Contoso.com**.

3.  Right-click or access the context menu for **Contoso.com**, and then select **New Host (A or AAAA)**.

4.  In the **New Host** window, in the **Name** box, enter **`adfs`**.

5.  In the **IP address** box, enter **`172.16.0.10`**, and then select **Add Host**.

6.  In the **DNS** window, select **OK**.

7.  Select **Done**, and then close DNS Manager.

### Task 2: Install AD FS

1.  On **LON-DC1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  At the command prompt, enter the following command, and then select Enter:

   ```
   Add-KdsRootKey –EffectiveTime ((Get-Date).AddHours(-10))
   ```
> Note: This command creates the Microsoft Group Key Distribution Service root key to generate group Managed Service Account (gMSA) passwords for the account that you'll use later in this lab. You should receive a globally unique identifier (GUID) as a response to this command.

3.  Select **Start**, select **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

4.  In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

5.  On the **Select installation type** page, select **Role-based or feature-based installation**, and then select **Next**.

6.  On the **Select destination server** page, select **Select a server from the server pool**, select **LON-DC1.Contoso.com**, and then select **Next**.

7.  On the **Select server roles** page, select the **Active Directory Federation Services** check box, and then select **Next**.

8.  On the **Select features** page, select **Next**.

9.  On the **Active Directory Federation Services (AD FS)** page, select **Next**.

10.  On the **Confirm installation selections** page, select **Install**.

11.  When the installation is complete, select **Close**.

12.  Select the **Refresh Dashboard** button to refresh the Server Manager Dashboard.

### Task 3: Configure AD FS

1.  On **LON-DC1**, in **Server Manager**, select the **Notifications** icon, and then select **Configure the federation service on this server**.

2.  In the **Active Directory Federation Services Configuration Wizard**, on the **Welcome** page, select **Create the first federation server in a federation server farm**, and then select **Next**.

3.  On the **Connect to Active Directory Domain Services** page, select **Next** to use **Contoso\\Administrator** to perform the configuration.

4.  On the **Specify Service Properties** page, in the **SSL Certificate** list, select **adfs.contoso.com**.

5.  In the **Federation Service Display Name** box, enter **`Contoso Corporation`**, and then select **Next**.

6.  On the **Specify Service Account** page, select **Create a Group Managed Service Account**.

7.  In the **Account Name** box, enter **`ADFSService`**, and then select **Next**.

8.  On the **Specify Configuration Database** page, select **Create a database on this server using Windows Internal Database**, and then select **Next**.

9.  On the **Review Options** page, select **Next**.

10.  On the **Pre-requisite Checks** page, select **Configure**.

11.  On the **Results** page, select **Close**.

    > Note: The adfs.Contoso.com certificate was preconfigured for this task. In your own environment, you must obtain this certificate.

12.  Restart **LON-DC1**.

13.  After the server restarts, sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

**Results**: After completing this exercise, you should have successfully installed and configured AD FS. 

## Exercise 3: Configuring an internal application for AD FS

### Scenario

You need to ensure that internal users can use SSO to access the web application. You need to configure the AD FS server and a web application to enable this scenario. You also want to verify that internal users can access the application.

The main tasks for this exercise are as follows:

1. Configure the Active Directory claims provider trust.
2. Configure the application to trust incoming claims.
3. Configure a relying party trust for the claims-aware application.
4. Configure claim rules for the relying party trust.
5. Test access to the claims-aware application.

### Task 1: Configure the Active Directory claims provider trust

1.  On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **AD FS Management**.

>Note: It may take a minute or two for the AD FS service to start. If an error message is displayed, wait a minute and then retry step 1.

2.  In the **AD FS** management console, select **Claims Provider Trusts**.

3.  In the list of **Claims Provider Trusts**, right-click or access the context menu for **Active Directory**, and then select **Edit Claim Rules**.

4.  In the **Edit Claims Rules for Active Directory** window, on the **Acceptance Transform Rules** tab, select **Add Rule**.

5.  In the **Add Transform Claim Rule Wizard**, on the **Select Rule Template** page, in the **Claim rule template** list, select **Send LDAP Attributes as Claims**, and then select **Next**.

6.  On the **Configure Rule** page, in the **Claim rule name** box, enter **`Outbound LDAP Attributes Rule`**.

7.  In the **Attribute store** list, select **Active Directory**. 

8.  In the **Mapping of LDAP attributes to outgoing claim types** section, select the following values for the **LDAP Attribute** and the **Outgoing Claim Type**, and then select **Finish**:

   - E-Mail-Addresses: **E-Mail Address**

   - User-Principal-Name: **UPN**

   - Display-Name: **Name**

9.  In the **Edit Claim Rules for Active Directory** window, select **OK**.

### Task 2: Configure the application to trust incoming claims

1.  Switch to **LON-SVR1**.

2.  On **LON-SVR1**, open **Server Manager**, select **Tools**, and then select **Windows Identity Foundation Federation Utility**.

3.  On the **Welcome to the Federation Utility Wizard** page, in the **Application configuration location** box, enter **`C:\inetpub\wwwroot\ContosoTestApp\web.config`** for the location of the sample **web.config** file.

4.  In the **Application URI** box, enter **`https://lon-svr1.Contoso.com/ContosoTestApp/`** to indicate the path to the sample application that will trust the incoming claims from the federation server, and then select **Next**. 

5.  On the **Security Token Service** page, select **Use an existing STS**, and then in the **STS WS-Federation metadata document location** box, enter **`https://adfs.Contoso.com/federationmetadata/2007-06/federationmetadata.xml`** and then select **Next**. 

6.  On the **STS signing certificate chain validation error** page, select **Disable certificate chain validation**, and then select **Next**.

7.  On the **Security token encryption** page, select **No encryption**, and then select **Next**.

8.  On the **Offered claims** page, review the claims that will be offered by the federation server, and then select **Next**.

9.  On the **Summary** page, review the changes that will be made to the sample application by the **Federation Utility Wizard**, scroll through the items to understand what each item is doing, and then select **Finish**.

10.  In the **Success** window, select **OK**.

### Task 3: Configure a relying party trust for the claims-aware application

1.  Switch to **LON-DC1**.

2.  On **LON-DC1**, open **Windows PowerShell ISE**, enter the following command to add a relying party trust, and then select Enter:

   ```
   Add-ADFSRelyingPartyTrust –Name 'Contoso Corporation Test App' –MetadataURL 'https://lon-svr1.Contoso.com/ContosoTestApp/federationmetadata/2007-06/federationmetadata.xml'
   ```

### Task 4: Configure claim rules for the relying party trust

1.  On **LON-DC1**, in the **AD FS** management console, select **Relying Party Trusts**, select **Contoso Corporation Test App**, and then select **Edit Claim Issuance Policy**.

2.  In the **Edit Claim Issuance Policy for Contoso Corporation Test App** window, on the **Issuance Transform Rules** tab, select **Add Rule**.

3.  In the **Claim rule template** box, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

4.  In the **Claim rule** **name** box, enter **`Pass through Windows account name`**.

5.  In the **Incoming claim type** list, select **Windows account name**, and then select **Finish**.

6.  On the **Issuance Transform Rules** tab, select **Add Rule**.

7.  In the **Claim rule template** box, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

8.  In the **Claim rule** **name** box, enter **`Pass through E-Mail Address`**.

9.  In the **Incoming claim type** list, select **E-Mail Address**, and then select **Finish**.

10.  On the **Issuance Transform Rules** tab, select **Add Rule**.

11.  In the **Claim rule template** box, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

12.  In the **Claim rule** **name** box, enter **`Pass through UPN`**.

13.  In the **Incoming claim type** list, select **UPN**, and then select **Finish**.

14.  On the **Issuance Transform Rules** tab, select **Add Rule**.

15.  In the **Claim rule template** dialog box, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

16.  In the **Claim rule** **name** box, enter **`Pass through Name`**.

17.  In the **Incoming claim type** list, select **Name**, and then select **Finish**.

18.  On the **Issuance Transform Rules** tab, select **OK**.

19.  In the **AD FS** management console, in the list of **Relying Party Trusts**, select **Contoso Corporation Test App**, and then select **Edit Access Control Policy**.

20.  In **Edit Access Control Policy for Contoso Corporation Test App**, select **Permit everyone**, and then select **OK**.

### Task 5: Test access to the claims-aware application

1.  Switch to **LON-CL1**.

2.  Sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

3.  From the task bar, open **Microsoft Edge**.

4.  In Microsoft Edge, on the address bar, enter **`https://lon-svr1.Contoso.com/ContosoTestApp/`**, and then select Enter.

    > Note: Be sure to include the trailing forward slash (/) in the URL for step 4.

5.  In the **Sign In** window, sign in as **`Contoso\Oscar`** with the password of **`Pa55w.rd`**.

6.  Review the claim information that the application displays.

7.  Close Microsoft Edge.

**Results**: After completing this exercise, you should have configured AD FS successfully to support application authentication.

## Exercise 4: Configuring AD FS for federated business partners

### Scenario

The second deployment scenario is to enable Trey Research users to access the web application. You plan to configure the integration of AD FS at Trey Research with AD FS at Contoso Corporation and then verify that Trey Research users can access the application. You also need to confirm that you can configure access that is based on user groups. You must ensure that all users at Contoso Corporation and only users who are in the Sales group at Trey Research can access the application.

The main tasks for this exercise are as follows:

1. Create a DNS record for AD FS at Trey Research.

2. Install AD FS for Trey Research.

3. Configure AD FS for Trey Research.

4. Configure a claims provider trust for the Trey Research AD FS server.

5. Configure a relying party trust for the Contoso Corporation application.

6. Verify access to the website.

7. Configure issuance-authorization claim rules to allow access only for specific groups.

8. Verify access to the website with the group restrictions.

### Task 1: Create a DNS record for AD FS at Trey Research

1.  On **TREY-DC1**, in Server Manager, select **Tools**, and then select **DNS**.

2.  In DNS Manager, expand **TREY-DC1**, expand **Forward Lookup Zones**, and then select **TreyResearch.net**.

3.  Right-click or access the context menu for **TreyResearch.net**, and then select **New Host (A or AAAA)**.

4.  In the **New Host** window, in the **Name** box, enter **`adfs`**.

5.  In the **IP address** box, enter **`172.16.10.10`**, and then select **Add Host**.

6.  In the **DNS** window, select **OK**.

7.  Select **Done**, and then close DNS Manager.

### Task 2: Install AD FS for Trey Research

1.  On **TREY-DC1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  At the command prompt, enter the following command, and then select Enter:

   ```
   Add-KdsRootKey –EffectiveTime ((Get-Date).AddHours(-10))
   ```

> Note: This command creates the Key Distribution Service root key to generate gMSA passwords for the account that you'll use later in this lab. You should receive a GUID as a response to this command.

3.  Select **Start**, select **Server Manager**, select **Manage**, and then select **Add Roles and Features**.

4.  In the **Add Roles and Features Wizard**, on the **Before you begin** page, select **Next**.

5.  On the **Select installation enter** page, select **Role-based or feature-based installation**, and then select **Next**.

6.  On the **Select destination server** page, select **Select a server from the server pool**, select **TREY-DC1.TreyResearch.net**, and then select **Next**.

7.  On the **Select server roles** page, select the **Active Directory Federation Services** check box, and then select **Next**.

8.  On the **Select features** page, select **Next**.

9.  On the **Active Directory Federation Services (AD FS)** page, select **Next**.

10.  On the **Confirm installation selections** page, select **Install**.

11.  When the installation completes, select **Close**.

12.  Select the **Refresh Dashboard** button to refresh the Server Manager Dashboard.

### Task 3: Configure AD FS for Trey Research

1.  On **TREY-DC1**, in Server Manager, select the **Notifications** icon, and then select **Configure the federation service on this server**.

2.  In the **Active Directory Federation Services Configuration Wizard**, on the **Welcome** page, select **Create the first federation server in a federation server farm**, and then select **Next**.

3.  On the **Connect to Active Directory Domain Services** page, select **Next** to use **TreyResearch\\Administrator** to perform the configuration.

4.  On the **Specify Service Properties** page, in the **SSL Certificate** list, select **adfs.treyresearch.net**.

    > Note:  The adfs.treyresearch.net certificate was preconfigured for this task. In your own environment, you must obtain this certificate

5.  In the **Federation Service Display Name** box, enter **`Trey Research`**, and then select **Next**.

6.  On the **Specify Service Account** page, select **Create a Group Managed Service Account**.

7.  In the **Account Name** box, enter **`ADFSService`**, and then select **Next**.

8.  On the **Specify Configuration Database** page, select **Create a database on this server using Windows Internal Database**, and then select **Next**.

9.  On the **Review Options** page, select **Next**.

10.  On the **Pre-requisite Checks** page, select **Configure**.

11.  On the **Results** page, select **Close**.

12.  Right-click or access the context menu for **Start**, select **Shut down or sign out**, select **Restart,** and then select **Continue**.

13.  After the server restarts, sign in as **TreyResearch\\Administrator** with the password of **`Pa55w.rd`**.

### Task 4: Configure a claims provider trust for the Trey Research AD FS server

1.  Switch to **LON-DC1**.

2.  On **LON-DC1**, at the **Windows PowerShell ISE** command prompt, enter the following command to add a claims provider trust, and then select Enter:

   ```
   Add-AdfsClaimsProviderTrust –Name 'Trey Research' –MetadataUrl 'https://adfs.treyresearch.net/federationmetadata/2007-06/federationmetadata.xml'
   ```
>Note: It may take a minute or two for the AD FS service to start on TREY-DC1. If an error message is displayed, wait a minute and then retry step 2.

3.  Because of compatibility issues with Microsoft Edge, enter the following command to disable token binding in AD FS, and then select Enter:

   ```
Set-AdfsProperties –IgnoreTokenBinding $true
   ```

4.  On **LON-DC1**, open the **AD FS** management console.

5.  Select **Claims Provider Trusts**, right-click or access the context menu for **Trey Research**, and then select **Edit Claim Rules…**. 

    > Note: You may need to refresh Claims Provider Trusts if Trey Research isn't displayed.

6.  In the **Edit Claim Rules for Trey Research** window, on the **Acceptance Transform Rules** tab, select **Add Rule**.

7.  In the **Add Transform Claim Rule Wizard**, on the **Select Rule Template** page, in the **Claim rule template** list, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

8.  On the **Configure Rule** page, in the **Claim rule name** box, enter **`Pass through Windows account name`**.

9.  In the **Incoming claim type** list, select **Windows account name**. 

10.  Select **Pass through all claim values**, and then select **Finish**.

11.  In the **AD FS Management** dialog box, select **Yes** to acknowledge the warning.

12.  In the **Edit Claim Rules for Trey Research** window, select **OK**, and then close the **AD FS** management console.

### Task 5: Configure a relying party trust for the Contoso Corporation application

1.  On **TREY-DC1**, open the **Windows PowerShell ISE** command prompt.

2.  At the **Windows PowerShell ISE** command prompt, enter the following to create a new relying party trust, and then select Enter:

   ```
Add-ADFSRelyingPartyTrust –Name 'Contoso Corporation' –MetadataURL 'https://adfs.Contoso.com/federationmetadata/2007-06/federationmetadata.xml'
   ```

3.  In the Server Manager, select **Tools**, and then select **AD FS Management**. 

4.  In the **AD FS** management console, select **Relying Party Trusts**.

5.  In the **Actions** pane, select **Edit Claim Issuance Policy**.

6.  In the **Edit Claim Issuance Policy for Contoso Corporation** window, select **Add Rule**.

7.  In the **Add Transform Claim Rule Wizard**, on the **Select Rule Template** page, in the **Claim rule template** box, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

8.  On the **Configure Rule** page, in the **Claim rule name** box, enter **`Pass through Windows account name`**.

9.  In the **Incoming claim type** list, select **Windows account name**. 

10.  Select **Pass through all claim values**, select **Finish**, and then select **OK**.

11.  In the **Edit Claim Issuance Policy for Contoso Corporation** window, select **OK**.

12.  In the list of **Relying Party Trusts**, select **Contoso Corporation**, and then select **Edit Access Control Policy**.

13.  In **Edit Access Control Policy for Contoso Corporation**, select **Permit everyone**, and then select **OK**.

14.  Close the **AD FS** management console.

### Task 6: Verify access to the website

1.  On **TREY-DC1**, click **Start**, enter **Internet Options**, and then press Enter. 

2.  Select **Privacy**, and then select **Sites**.

3.  On the **Per Site Privacy Actions** page, in the **Address of website** box, enter **`Contoso.com`**, select **Allow**, select **OK** to close the **Per Site Privacy Actions** page, and then select **OK** to close the **Internet Options** window.

4.  On **TREY-DC1**, open Microsoft Edge, and then in the address bar, enter **`https://lon-svr1.Contoso.com/Contosotestapp/`**, and then select Enter.

5.  On the **Contoso Corporation** page, select **Trey Research**.

    > Note: If you receive the error message **This page cannot be displayed**, select **Refresh**, and then try this step again.

6.  In the **Sign in** page, sign in as **`TreyResearch\Connie`** with the password of **`Pa55w.rd`**.

7.  After the application loads, close **Microsoft Edge**.

8.  Open **Microsoft Edge** again, and then in the address bar, enter **`https://lon-svr1.Contoso.com/Contosotestapp/`**, and then select Enter.

9.  In the **Sign in** page, sign in as **TreyResearch\\Connie** with the password of **`Pa55w.rd`**.

10.  Close Microsoft Edge.

    > Note: You aren't prompted for a home realm on the second access. After a user selects a home realm and a realm authority authenticates that user, the relying party’s federation server issues a **_LSRealm** cookie. The default lifetime for the cookie is 30 days. Therefore, to sign in multiple times, you should delete that cookie after each sign-in attempt to return to a clean state.

### Task 7: Configure issuance-authorization claim rules to allow access only for specific groups

1.  On **TREY-DC1**, in Server Manager, select **Tools**, and then select **AD FS Management**.

2.  In the **AD FS** management console, select **Relying Party Trusts**.

3.  Right-click or access the context menu for **Contoso Corporation**, and then select **Edit Claim Issuance Policy**.

4.  In the **Edit Claim Issuance Policy for Contoso Corporation** window, on the **Issuance Transform Rules** tab, select **Remove Rule**, and then select **Yes**.

5.  Select **Add Rule**.

6.  In the **Claim rule template** box, select **Pass Through or Filter an Incoming Claim**, and then select **Next**.

7.  On the **Claim rule name** box, enter **`Allow Sales Members`**.

8.  On the **Incoming claim type**, select **Group**.

9.  Select **Pass through only a specific claim value**, and then in the Incoming claim value, enter **`TreyResearch-Sales`**.

10.  Select **Finish**, and then select **OK**.

11.  In the **AD FS** management console, select **Claims Provider Trusts**, right-click or access the context menu for **Active Directory**, and then select **Edit Claim Rules**.

12.  In the **Edit Claim Rules for Active Directory** window, select **Add Rule**.

13.  In the **Add Transform Claim Rule Wizard**, on the **Select Rule Template** page, in the **Claim rule template** box, select **Send Group Membership as a Claim**, and then select **Next**.

14.  On the **Configure Rule** page, in the **Claim rule name** box, enter **`Sales Group Claim`**.

15.  To set the **User’s group**, select **Browse**, enter **`Sales`**, and then select **OK**.

16.  In the **Outgoing claim type** box, select **Group**.

17.  In the **Outgoing claim value** box, enter **`TreyResearch-Sales`**, and then select **Finish**.

18.  In the **Edit Claim Rules for Active Directory** window, select **OK**.

19.  Close the **AD FS** management console.

### Task 8: Verify access to the website with the group restrictions

1.  On **TREY-DC1**, open Microsoft Edge, and on the address bar, enter **`https://lon-svr1.Contoso.com/Contosotestapp/`**.

2.  In the **Sign in** page, sign in as **`TreyResearch\Allan`** with the password of **`Pa55w.rd`**.

3.  Verify Allan can access the application.

4.  Close Microsoft Edge.

**Results**: After completing this exercise, you should have successfully configured access for a claims-aware application in a partner organization.
