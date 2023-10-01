# Lab: Deploy and configure a two-tier CA hierarchy

## Lab scenario

Your security department requires secure access to critical websites and additional security for Windows and networking services. To address these and other security requirements, you decide to implement a Public Key Infrastructure (PKI) by using the Active Directory Certificate Services (AD CS) role in Windows Server. As a senior network administrator at Contoso, you're responsible for implementing the AD CS deployment.

## Exercise 1: Deploy an offline root CA

### Scenario

Contoso requires a certification authority (CA) infrastructure to distribute and manage certificates for various network services. You decide to use the Windows Server 2022 AD CS server role. To begin the implementation, you need to deploy a standalone root CA, which you'll take offline after it issues a certificate for a subordinate CA. After installation, you need to configure the Certificate Revocation List (CRL) Distribution Point (CDP) and authority information access (AIA) locations correctly. You must also make sure that you have a Domain Name System (DNS) record for the offline root CA so that it's accessible from the network.

The main tasks for this exercise are as follows:

1. Create file and printer sharing exceptions.

2. Install and configure AD CS on CA-SVR1.

3. Create a DNS record for an offline root CA.


### Task 1: Create file and printer sharing exceptions

1.  Sign in to **CA-SVR1** as **Administrator** with the password of **`Pa55w.rd`**.

2.  Select **Start**, and then select **Control** **Panel**.

3.  In the **Control Panel** window, select **View network status and tasks**.

4.  In the **Network and Sharing Center** window, select **Change advanced sharing settings**.

5.  Under **Guest or Public (current profile)**, select the **Turn on file and printer sharing** option, and then select **Save changes**.
6.  Close the **Network and Sharing Center** window.

### Task 2: Install and configure AD CS on CA-SVR1

1.  On **CA-SVR1**, select **Start**, and then select **Server Manager**.

2.  In **Server Manager**, select **Add roles and features**.

3.  On the **Before you begin** page, select **Next**.

4.  On the **Select installation type** page, select **Next**.

5.  On the **Select destination server** page, select **Next**.

6.  On the **Select server roles** page, select **Active Directory Certificate Services**. When the **Add Roles and Features Wizard** window displays, select **Add Features**, and then select **Next**.

7.  On the **Select features** page, select **Next**.

8.  On the **Active Directory Certificate Services** page, select **Next**.

9.  On the **Select role services** page, ensure that **Certification Authority** is selected, and then select **Next**.

10.  On the **Confirm installation selections** page, select **Install**.

11.  After installation completes successfully, on the **Installation progress** page, select the **Configure Active Directory Certificate Services** **on the destination server** link.

12.  In the **AD CS Configuration Wizard**, on the **Credentials** page, select **Next**.

13.  On the **Role Services** page, select **Certification Authority**, and then select **Next**.

14.  On the **Setup Type** page, ensure that **Standalone CA** is selected, and then select **Next**.

15.  On the **CA Type** page, ensure that **Root CA** is selected, and then select **Next**.

16.  On the **Private Key** page, ensure that **Create a new private key** is selected, and then select **Next**.

17.  On the **Cryptography for CA** page, keep the default selections for **Select a cryptographic provider** and **Select the hash algorithm for signing certificates issued by this CA**, but set the **Key length** to **4096**, and then select **Next**.

18.  On the **CA Name** page, in the **Common name** **for this CA** text box, enter **`ContosoRootCA`**, and then select **Next**.

19.  On the **Validity Period** page, select **Next**.

20.  On the **CA Database** page, select **Next**.

21.  On the **Confirmation** page, select **Configure**.

22.  On the **Results** page, select **Close**.

23.  On the **Installation progress** page, select **Close**.

24.  On **CA-SVR1**, in **Server** **Manager**, select **Tools**, and then select **Certification Authority**.

25.  In the **certsrv – [Certification Authority (Local)]** console, right-click or access the context menu for **ContosoRootCA**, and then select **Properties**.

26.  In the **ContosoRootCA** **Properties** dialog box, select the **Extensions** tab.

27.  In the **Select extension** drop-down list, select **CRL Distribution Point (CDP)**, and then select **Add**.

28.  In the **Location** text box, enter **`http://lon-svr1.Contoso.com/CertData/`**.

29.  In the **Variable** drop-down list, select **`<CaName>`**, and then select **Insert**.

30.  In the **Variable** drop-down list, select **`<CRLNameSuffix>`**, and then select **Insert**.

31.  In the **Variable** drop-down list, select **`<DeltaCRLAllowed>`**, and then select **Insert**.

32.  In the **Location** text box, position the cursor at the end of the URL, enter **`.crl`**, and then select **OK**.

33.  Select the following options, and then select **Apply**:

    - **Include in the CDP extension of issued certificates** 
    - **Include in CRLs.** **Clients use this to find Delta CRL locations**
34.  In the **Certification Authority** pop-up window, select **No**.

35.  In the **Select extension** drop-down list, select **Authority Information Access (AIA)**, and then select **Add**.

36.  In the **Location** text box, enter **`http://lon-svr1.Contoso.com/CertData/`**.

37.  In the **Variable** drop-down list, select **`<ServerDNSName>`**, and then select **Insert**.

38.  In the **Location** text box, enter an underscore `(_)`, and in the **Variable** drop-down list, select **`<CaName>`**, and then select **Insert**. Position the cursor at the end of the URL.

39.  In the **Variable** drop-down list, select **`<CertificateName>`**, and then select **Insert**.

40.  In the **Location** text box, position the cursor at the end of the URL, enter **`.crt`**, and then select **OK**.

41.  Select the **Include in the AIA extension of issued certificates** check box, and then select **OK**.

42.  Select **Yes** to restart the Certification Authority service.

43.  In the **Certification Authority** console, expand **ContosoRootCA**, right-click or access the context menu for **Revoked Certificates**, point to **All Tasks**, and then select **Publish**.

44.  In the **Publish CRL** window, select **OK**.

45.  Right-click or access the context menu for **ContosoRootCA**, and then select **Properties**.

46.  In the **ContosoRootCA Properties** dialog box, select **View** **Certificate**.

47.  In the **Certificate** dialog box, select the **Details** tab, and then select **Copy to File**.

48.  In the **Certificate Export Wizard**, on the **Welcome** page, select **Next**.

49.  On the **Export File Format** page, select **DER encoded binary X.509 (.CER)**, and then select **Next**.

50.  On the **File to Export** page, select **Browse**, in the **File name** text box, enter **`\\lon-svr1\C$\RootCA.cer`**, and then select Enter and then **Next**.

51.  Select **Finish**, and then select **OK** three times.

52.  Open a **File Explorer** window, and then browse to **C:\\Windows\\System32\\CertSrv\\CertEnroll**.

53.  In the **CertEnroll** folder, select both files, right-click or access the context menu for the highlighted files, and then select **Copy**.

54.  In the File Explorer address bar, enter **`\\lon-svr1\C$`**, and then select Enter.

55.  Right-click or access the context menu for the empty space, and then select **Paste**.

56.  Close File Explorer.

### Task 3: Create a Domain Name System (DNS) record for an offline root CA

1.  Switch to **LON-DC1** and sign in as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.

    > Note: Server Manager automatically opens.

2.  In **Server Manager**, select **Tools**, and then select **DNS**.

3.  In the **DNS Manager** console, expand **LON-DC1**, expand **Forward Lookup Zones**, select **Contoso.com**, right-click or access the context menu for **Contoso.com**, and then select **New Host (A or AAAA)**.

4.  In the **New Host** window, in the **Name** text box, enter **`CA-SVR1`**.

5.  In the **IP address** window, enter **`172.16.0.40`**, select **Add Host**, select **OK**, and then select **Done**.

6.  Close **DNS Manager**.

**Results:** After completing this exercise, you'll have successfully installed and configured the standalone root CA role on the **CA-SVR1** server. Additionally, you'll have created a DNS record needed so that other servers can resolve the name for **CA-SVR1**.

## Exercise 2: Deploy an enterprise subordinate CA

### Scenario

After deploying the standalone root CA, the next step is to deploy an enterprise subordinate CA. Contoso wants to use an enterprise subordinate CA to utilize Active Directory Domain Services (AD DS) integration. Additionally, because the root CA is a standalone CA, you want to publish its certificate to all clients.

The main tasks for this exercise are as follows:

1. Install and configure AD CS on LON-SVR1.

2. Install a subordinate CA certificate.

3. Publish a root CA certificate through Group Policy.

### Task 1: Install and configure AD CS on LON-SVR1

1.  Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password of **`Pa55w.rd`**.
2.  Select **Start**, select **Server Manager**, and then select **Add roles and features**.
3.  On the **Before you begin** page, select **Next**.

4.  On the **Select installation type** page, select **Next**.

5.  On the **Select destination server** page, select **Next**.

6.  On the **Select server roles** page, select **Active Directory Certificate Services**.

7.  When the **Add Roles and Features Wizard** displays, select **Add Features**, and then select **Next**.

8.  On the **Select features** page, select **Next**.

9.  On the **Active Directory Certificate** **Services** page, select **Next**.

10.  On the **Select role services** page, ensure that **Certification Authority** is selected, and then select **Certification Authority Web Enrollment**.

11.  When the **Add Roles and Features Wizard** displays, select **Add Features**, and then select **Next**.

12.  On the **Confirm installation selections** page, select **Install**.

13.  After installation is successful, on the **Installation progress** page, select the **Configure Active Directory Certificate Services on the destination server** link.

14.  In the **AD CS Configuration** wizard, on the **Credentials** page, select **Next**.

15.  On the **Role Services** page, select **Certification Authority** and **Certification Authority Web Enrollment**, and then select **Next**.

16.  On the **Setup Type** page, select **Enterprise CA**, and then select **Next**.

17.  On the **CA Type** page, select **Subordinate** **CA**, and then select **Next**.

18.  On the **Private Key** page, ensure that **Create a new private key** is selected, and then select **Next**.

19.  On the **Cryptography for CA** page, keep the default selections, and then select **Next**.

20.  On the **CA Name** page, in the **Common name for this CA** text box, enter **`Contoso-IssuingCA`**, and then select **Next**.

21.  On the **Certificate Request** page, ensure that **Save a certificate request to file on the target machine** is selected, and then select **Next**.

22.  On the **CA Database** page, select **Next**.

23.  On the **Confirmation** page, select **Configure**.

24.  On the **Results** page, ignore the warning messages, and then select **Close**.

25.  On the **Installation** **progress** page, select **Close**.

### Task 2: Install a subordinate CA certificate

1.  On **LON-SVR1**, open a **File Explorer** window, and then browse to **Local Disk (C:)**.

2.  Right-click or access the context menu for **RootCA.cer**, and then select **Install Certificate**.

3.  In the **Certificate Import** wizard, select **Local Machine**, and then select **Next**.

4.  On the **Certificate Store** page, select **Place all certificates in the following store**, and then select **Browse**.

5.  Select **Trusted Root Certification Authorities**, select **OK**, select **Next**, and then select **Finish**.

6.  When the **Certificate Import Wizard** window appears, select **OK**.

7.  In the **File Explorer** window, select the **ContosoRootCA.crl** and **CA-SVR1_ContosoRootCA.crt** files, right-click or access the context menu for the files, and then select **Copy**.

8.  Open the **inetpub** folder, and then open the **wwwroot** folder.

9.  Create a new folder, and then name it **CertData**.

10.  Paste the two copied files into the **CertData** folder.

11.  Switch to **Local Disk (C:)**.

12.  Right-click or access the context menu for the **LON-SVR1.Contoso.com_Contoso-LON-SVR1-CA.req** file, and then select **Copy**.

13.  In the File Explorer address bar, enter **`\\CA-SVR1\C$`**, and then select Enter.

14.  In the **File Explorer** window, right-click or access the context menu for an empty space, and then select **Paste**. 

    > Note: Make sure that the request file copies to **CA-SVR1**.

15.  Switch to the **CA-SVR1** server.

16.  In the **Certificate Authority** console, right-click or access the context menu for **ContosoRootCA**, point to **All Tasks**, and then select **Submit new request**.

17.  In the **Open Request File** window, navigate to **Local Disk (C:)**, select the **LON-SVR1.Contoso.com_Contoso- LON-SVR1-CA.req** file, and then select **Open**.

18.  In the **Certification Authority** console, select the **Pending Requests** container, right-click or access the context menu for **Pending Requests**, and then select **Refresh**.

19.  In the details pane, right-click or access the context menu for the request (with ID 2), point to **All Tasks**, and then select **Issue**.

20.  In the **Certification Authority** console, select the **Issued Certificates** container.

21.  In the details pane, open the certificate, select the **Details** tab, and then select **Copy to File**.

22.  In the **Certificate Export** wizard, on the **Welcome** page, select **Next**.

23.  On the **Export File Format** page, select **Cryptographic Message Syntax Standard – PKCS #7 Certificates (.P7B)**, select **Include all certificates in the certification path if possible**, and then select **Next**.

24.  On the **File to Export** page, in the File name field, enter **`\\lon-svr1\C$\SubCA.p7b`** and then select **Next**, select **Finish**, and then select **OK** twice.

25.  Switch to **LON-SVR1**.

26.  In **Server Manager**, select **Tools**, and then select **Certification Authority**.

27.  In the **Certification Authority** console, right-click or access the context menu for **Contoso-IssuingCA**, point to **All Tasks**, and then select **Install CA** **Certificate**.

28.  Go to **Local Disk (C:)**, select the **SubCA.p7b** file, and then select **Open**.

29.  Wait for 15 to 20 seconds, and then on the toolbar, select the **Start this service** button to start the CA service.

    > Note: Ensure that the CA successfully starts.

30.  Switch to **CA-SVR1**, and then shut down the server.

    > Note:  From this point, you can safely take the root CA offline and use just the enterprise subordinate CA.

### Task 3: Publish a root CA certificate through Group Policy

1.  On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Group** **Policy Management**.

2.  In the **Group Policy Management** Console, expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click or access the context menu for **Default Domain Policy**, and then select **Edit**.

3.  In the **Computer Configuration** node, expand **Policies**, expand **Windows** **Settings**, expand **Security** **Settings**, expand **Public Key Policies**, right-click or access the context menu for **Trusted Root Certification Authorities**, select **Import**, and then select **Next**.

4.  On the **File to Import** page, select **Browse**.

5.  In the **file name** text box, enter **`\\lon-svr1\C$`**, and then select Enter.

6.  Select file **RootCA.cer**, and then select **Open**.

7.  Select **Next** two times, and then select **Finish**.

8.  When the **Certificate Import** wizard window appears, select **OK**.

    > Note:  It might take 15 to 20 seconds for this window to appear.

9.  Close the **Group Policy Management Editor** and the **Group Policy Management** Console.

**Results**: After completing this exercise, you'll have successfully deployed and configured an enterprise subordinate CA. You also should have a subordinate CA certificate issued by a root CA installed on **LON-SVR1**. To establish trust between the root CA and domain member clients, you configured Group Policy to deploy a root CA certificate.
