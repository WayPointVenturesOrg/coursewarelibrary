# Lab: Deploy and use certificates

## Lab scenario

You're a senior network administrator at Contoso Corporation. The Security department requires that all access to critical websites must be encrypted. Encryption must also be in place for features such as Encrypting File System (EFS), digital signatures, and virtual private networks (VPNs). The Security department especially wants to evaluate digital signatures in Microsoft Office documents. To address these and other security requirements, Contoso has decided to use certificates issued by the Active Directory Certificate Services (AD CS) role in Windows Server.

You're responsible for implementing certificate enrollment, and you'll be developing the procedures and process for managing certificate templates and deploying and revoking certificates.

## Exercise 1: Configure certificate templates

### Scenario

After deploying the certificate authority (CA) infrastructure, the next step is to deploy the certificate templates that the organization requires. First, Contoso wants to implement a new web-server certificate and certificates for users.

The main tasks for this exercise are as follows:

1. Create a new template based on the Web Server template.

2. Create a new template for users that includes smart-card sign in.

3. Configure templates so they can be issued.

4. Enroll the Web Server certificate on LON-SVR2.


### Task 1: Create a new template based on the Web Server template

1. Sign in to **LON-DC1** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

   > Server Manager starts automatically.

2. In **Server Manager**, select **Tools**, and then select **Certification Authority**.

3. In the **Certification Authority** console, expand **ContosoCA**, right-click or access the context menu for **Certificate** **Templates**, and then select **Manage**.

4. In the **Certificate Templates** **Console**, locate the **Web Server** template in the list, right-click or access the context menu, and then select **Duplicate Template**.

5. Select the **General** tab, in the **Template display name** text box, enter **Production Web Server**, and then enter **3** in the **Validity period** text box.

6. Select the **Request Handling** tab, select **Allow private key to be exported**. 

7. On the **Security** tab, select **Authenticated Users**. Under **Permissions for Authenticated Users**, select the **Allow** check boxes for **Read**, **Enroll**, and **Autoenroll**, and then select **OK**.

8. Close the **Certificate Templates** **Console**.

9. In the **Certification Authority** console, right-click or access the context menu for **Revoked Certificates**, select **All Tasks**, select **Publish**, and then select **OK**.


### Task 2: Create a new template for users that includes smart-card sign in

1. On **LON-DC1**, in the **Certification Authority** console, expand **ContosoCA**, right-click or access the context menu for **Certificate Templates**, and then select **Manage**. 
2. In the **Certificate Templates** **Console**, right-click or access the context menu for the **User** certificate template, and then select **Duplicate** **Template**.
3. In the **Properties** **of** **New** **Template** dialog box, select the **General** tab, and then in the **Template display name** text box, enter **Contoso User**.

4. On the **Subject Name** tab, clear both the **Include e-mail name in subject name** and the **E-mail name** check boxes.

5. On the **Extensions** tab, select **Application Policies**, and then select **Edit**.

6. In the **Edit Application Policies Extension** dialog box, select **Add**.

7. In the **Add Application Policy** dialog box, select **Smart Card Logon**, and then select **OK** twice.

8. Select the **Superseded Templates** tab, select **Add**, select the **User** template, and then select **OK**.

9. On the **Security** tab, select **Authenticated Users**. Under **Permissions for Authenticated Users**, select the **Allow** check boxes for **Read**, **Enroll**, and **Autoenroll**, and then select **OK**.

10. Close the **Certificate Templates** **Console**.


### Task 3: Configure templates so they can be issued

1. On **LON-DC1**, in the **Certification Authority** console, right-click or access the context menu for **Certificate Templates**, point to **New**, and then select **Certificate Template to Issue**.

2. In the **Enable Certificate Templates** window, hold the **Ctrl** key and select both **Contoso User** and **Production Web Server**, and then select **OK**.


### Task 4: Enroll the Web Server certificate on LON-SVR2

1. Switch to **LON-SVR2**.

2. Sign in to **LON-SVR2** as **Contoso\\Administrator** with the password of **Pa55w.rd**.

3. Select **Start**, and then select the **Windows PowerShell** icon.

4. At the Windows PowerShell command prompt, enter **`gpupdate/force`**, and then select Enter. 

5. Select **Start**, and then enter **`certlm.msc`** and then select Enter.

   > The Local Computer Certificates console opens.

6. Under **Certificates-Local Computer**, right-click or access the context menu for **Personal**, point to **All Tasks**, and then select **Request New Certificate**.

7. On the **Before you Begin** page, select **Next**.

8. On the **Select Certificate Enrollment Policy** page, select **Active Directory Enrollment Policy**, and then select **Next**.

9. Under **Production Web Server** select the **More information is required to enroll for this certificate** link.

10. On the **Subject** tab, in the **Subject name** box, change **Type** to **Common name**, and then enter **lon-svr2.contoso.com** as the value.

11. Select **Add**.

12. In the **Alternative name** box, change the **Type** to **DNS**, and then enter **lon-svr2.contoso.com** as the value.

13. Select **Add**.

14. On the **General** tab, in the **Friendly name** field, enter **LON-SVR2 Web Server**, and then select **OK**.

15. In the **Request Certificates** dialog box, select **Production Web Server** and then select **Enroll**.

16. In the **Certificate Installation Results** page, ensure that the enrollment has succeeded, and then select **Finish**.

17. Close the **Certificates** console.

18. Select **Start**, and then select **Server Manager**. 

19. From **Server Manager**, select **Tools**, and then select **Internet Information Services (IIS) Manager**. 

20. In the **Internet Information Services (IIS) Manager** console, expand **LON-SVR2**, expand **Sites**, and then select **Default Web Site**.

21. In the **Actions** pane, select **Bindings**.

22. In the **Site Bindings** window, select **Add**.

23. In the **Add Site Binding** window, select **https** from the **Type** drop-down list. In the **SSL certificate** drop-down list, select **LON-SVR2 Web Server**, select **OK**, and then select **Close**.

24. Close **Internet Information Services (IIS) Manager**.

25. Switch to **LON-CL1**. 

26. Sign in to **LON-CL1** as **Contoso\\Administrator** with the password of **Pa55w.rd**

27. From the taskbar, select **Microsoft Edge**.

28. In Microsoft Edge, enter **`https://lon-svr2.contoso.com`** in the address bar, and then select Enter.

29. Ensure that the **Internet Information Services** page opens and that no certificate error displays.

30. In the address bar, select the lock icon to review the security informaton for the site. 

    > The lock icon states that the Connection is secure and has a valid certificate.

31. Close **Microsoft Edge**.

**Results:** After completing this exercise, you'll have configured certificate templates.

## Exercise 2: Enroll and use certificates

### Scenario

The next step in implementing a public key infrastructure (PKI) at Contoso is configuring certificate enrollment. Contoso wants to enable different options for distributing certificates. Users should be able to enroll automatically, and smart-card users should get their smart cards from Enrollment Agents. Contoso has delegated Enrollment Agent rights for the Marketing department group to a user named Ellen Mogensen.

The main tasks for this exercise are as follows:

1. Configure autoenrollment for users.

2. Verify autoenrollment.

3. Configure the enrollment agent for smart-card certificates.

4. Use certificates for digital signing of a Microsoft Office document.


### Task 1: Configure autoenrollment for users

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Group Policy Management**.

2. Expand **Forest: Contoso.com**, expand **Domains**, expand **Contoso.com**, right-click or access the context menu for **Default Domain Policy**, and then select **Edit**.

3. Expand **User Configuration**, expand **Policies**, expand **Windows Settings**, expand **Security Settings**, and then select **Public Key Policies**.

4. In the details pane, open **Certificate Services Client – Auto-Enrollment**.

5. In the **Configuration Model** drop-down list, select **Enabled**, select **Renew expired certificates,** **update pending certificates, and** **remove revoked certificates** and **Update certificates that use certificate templates**, and then select **OK** to close the properties window.

6. In the right pane, open the **Certificate Services Client – Certificate Enrollment Policy** object.

7. On the **Enrollment Policy** tab, set the **Configuration Model** to **Enabled**, and then ensure that the **Certificate Enrollment Policy** list displays the Active Directory Enrollment policy. It should have a check mark next to it and display a status of **Enabled**. Select **OK** to close the window.

8. Close both the **Group Policy Management Editor** window and the **Group Policy Management** console.


### Task 2: Verify autoenrollment

1. On **LON-CL1**, select **Start**, enter **PowerShell**, and then select the **Windows PowerShell** icon.

2. At the **Windows PowerShell** command prompt, enter **`gpupdate /force`**, and then select Enter.

3. After the policy refreshes, enter **`certmgr.msc`**, and then select Enter.

4. Expand **Certificates – Current User**, expand **Personal**, and then select **Certificates**.

5. Verify that a certificate based on the **Contoso User** template is issued for **Administrator**. 

   > To verify the name of the template, scroll to the right in the console window.

6. Close **certmgr** and then sign out of **LON-CL1**.


### Task 3: Configure the enrollment agent for smart-card certificates

1. Switch to **LON-DC1**.
2. In **Server Manager**, select **Tools**, and then open **Certification Authority**.
3. In the **certsrv** console, expand **ContosoCA**, right-click or access the context menu for **Certificate** **Templates**, and then select **Manage**.

4. In the **Certificate Templates** **Console**, open **Enrollment Agent**.

5. Select the **Security** tab, and then select **Add**.

6. In the **Select Users, Computers, Service Accounts, or Groups** window, enter **Ellen**, select **Check Names**, and then select **OK**.

7. On the **Security** tab, select **Ellen Mogensen**, select the **Allow** check box for **Read** and **Enroll** permissions, and then select **OK**.

8. Close the **Certificate Templates** **Console**.

9. In the **certsrv** console, right-click or access the context menu for **Certificate Templates**, point to **New**, and then select **Certificate Template** **to** **Issue**.

10. In the list of templates, select **Enrollment Agent**, and then select **OK**.

11. Switch to **LON-CL1**, and then sign in as **Contoso\\Ellen** with the password **Pa55w.rd**.

12. Select **Start**, enter **`certmgr.msc`**, and then press Enter.
13. Expand **Certificates – Current User**, expand **Personal**, select **Certificates**, right-click or access the context menu for **Certificates**, point to **All** **Tasks**, and then select **Request New Certificate**.
14. In the **Certificate Enrollment Wizard**, on the **Before You Begin** page, select **Next**.

15. On the **Select Certificate Enrollment Policy** page, select **Next**. 

16. On the **Request** **Certificates** page, select **Enrollment Agent**, select **Enroll**, and then select **Finish**.

17. Sign out of **LON-CL1**.

18. Switch to **LON-DC1**.

19. In the **Certification Authority** console, right-click or access the context menu for **ContosoCA**, and then select **Properties**.

20. On the **Enrollment Agents** tab, select **Restrict Enrollment agents**.

21. On the pop-up window that displays, select **OK**.

22. In the **Enrollment agents** section, select **Add**.

23. In the **Select User, Computer or Group** field, enter **Ellen**, select **Check Names**, and then select **OK**.

24. Select **Everyone**, and then select **Remove**.

25. In the **Certificate Templates** section, select **Add**.

26. In the list of templates, select **Contoso User**, and then select **OK**.

27. In the **Certificate Templates** section, select **`<All>`**, and then select **Remove**.

28. In the **Permission** section, select **Add**.

29. In the **Select User, Computer or Group** field, enter **Marketing**, select **Check Names**, and then select **OK**.

30. In the **Permission** section, select **Everyone**, select **Remove**, and then select **OK**.


### Task 4: Use certificates for digital signing of a Microsoft Office document

1. On **LON-CL1**, sign in as **Contoso\\Administrator** with the password of **Pa55w.rd**.

2. Select the **Start** button, and then select **Word**. 

3. If necessary, select **Accept** at the license agreement page, and then close the Your privacy matters page.

4. Select **Blank document**, enter some text, and then save the document to the desktop.

5. On the toolbar, select **Insert**, and then in the **Text** section, in the **Signature Line** drop-down list, select **Microsoft Office** **Signature Line**.

6. In the **Signature Setup** window, enter your name in the **Suggested signer** text box, enter **Administrator** in the **Suggested signer’s title** text box, enter **`Administrator@contoso.com`** in the **Suggested signer’s e-mail address** text box, and then select **OK**.

7. Right-click or access the context menu for the signature line in the document, and then select **Sign…**.

8. In the **Sign** window, select **Change**.

9. In the **Windows Security** window under **Select a certificate**, select the **Administrator** certificate with today’s date, and then select **OK**.

10. In the text box to the right of the **X**, enter your name, select **Sign**, and then select **OK**. 

    > Instead of typing your name, you also can select an image. This image can be your scanned signature that you've written.

11. Close Microsoft Word, and then save changes if you receive a prompt.

12. Sign out of **LON-CL1**.


**Results**: After completing this exercise, you'll have implemented certificate enrollment.

## Exercise 3: Configure and implement key recovery

### Scenario

As a part of establishing a PKI, you want to configure and test procedures for private key recovery. You want to assign a key recovery agent (KRA) certificate for an administrator, and then configure a CA and specific certificate templates to allow key archival. Additionally, you want to test a procedure for key recovery.

The main tasks for this exercise are as follows:

1. Configure the certification authority to issue KRA certificates.

2. Acquire the KRA certificate.

3. Configure the CA to allow key recovery.

4. Configure a custom template for key archival.

5. Verify key archival functionality.


### Task 1: Configure the certification authority to issue KRA certificates

1. Switch to **LON-DC1**.
2. On **LON-DC1**, in the **Certification Authority** console, expand the **ContosoCA** node, right-click or access the context menu for the **Certificates Templates** folder, and then select **Manage**.
3. In the details pane, right-click or access the context menu for the **Key Recovery Agent** certificate, and then select **Properties**.

4. In the **Key Recovery Agent Properties** dialog box, select the **Issuance Requirements** tab, and then clear the **CA certificate manager approval** check box. 

5. Select the **Security** tab. Notice that **Domain Admins** and **Enterprise Admins** are the only groups that have the **Enroll** permission, and then select **OK**.

6. Close the **Certificate Templates** **Console**.

7. In the **Certification Authority** console, right-click or access the context menu for **Certificate Templates**, point to **New**, and then select **Certificate Template to Issue**.

8. In the **Enable Certificate Templates** dialog box, select the **Key Recovery Agent** template, and then select **OK**.

9. Close the **Certification Authority** console.


### Task 2: Acquire the KRA certificate

1. On **LON-DC1**, select **Start**, enter **`certmgr.msc`** and then select Enter. 

2. Expand the **Certificates - Current User** node, right-click or access the context menu for **Personal**, point to **All Tasks**, and then select **Request New Certificate**.

3. In the **Certificate Enrollment Wizard**, on the **Before You Begin** page, select **Next**.

4. On the **Select Certificate Enrollment Policy** page, select **Next**.

5. On the **Request Certificates** page, select the **Key Recovery Agent** check box, select **Enroll**, and then select **Finish**.

6. Expand **Personal** and then select **Certificates**.
7. Verify the KRA certificate in the personal store; scroll across the certificate properties and verify that **Key Recovery Agent** is present.
8. Close **certmgr**.


### Task 3: Configure the CA to allow key recovery

1. On **LON-DC1**, in **Server Manager**, select **Tools**, and then select **Certification Authority**. 
2. In the **Certification Authority** console, right-click or access the context menu for **ContosoCA**, and then select **Properties**.
3. In the **ContosoCA Properties** dialog box, select the **Recovery Agents** tab, and then select **Archive the key**.

4. Under **Key recovery agent certificates**, select **Add**.

5. In the **Key Recovery Agent Selection** dialog box, select **OK**.

6. In the **ContosoCA Properties** dialog box, select **OK**. When prompted to restart the certification authority (CA), select **Yes**.


### Task 4: Configure a custom template for key archival

1. On **LON-DC1**, in the **Certification Authority** console, expand **ContosoCA**. right-click or access the context menu for the **Certificates Templates** folder, and then select **Manage**.

2. In the **Certificate Templates** **Console**, right-click or access the context menu for the **User** certificate, and then select **Duplicate Template**.

3. In the **Properties of New Template** dialog box, on the **General** tab, in the **Template display name** text box, enter **Archive User**.

4. On the **Request** **Handling** tab, select the **Archive subject's encryption private key** check box.

5. If a pop-up window displays, select **OK**.

6. Select the **Subject Name** tab, clear the **E-mail name** and **Include E-mail name in subject name** check boxes, and then select **OK**.

7. Close the **Certificate Templates** **Console**.

8. In the **Certification Authority** console, right-click or access the context menu for the **Certificates Templates** folder, point to **New**, and then select **Certificate Template to Issue**.

9. In the **Enable Certificate Templates** dialog box, select the **Archive User** template, and then select **OK**.

10. Close the **Certification Authority** console.


### Task 5: Verify key archival functionality

1. Sign in to **LON-CL1** as **Contoso\\Oscar** with the password of **Pa55w.rd**.

2. Select **Start**, enter **`certmgr.msc`** and the press Enter. 

3. Expand the **Certificates - Current User** node, expand **Personal**, select and then right-click or access the context menu for **Personal**, select **All Tasks**, and then select **Request New Certificate**.

4. In the **Certificate Enrollment Wizard**, on the **Before You Begin** page, select **Next**.

5. On the **Select Certificate Enrollment Policy** page, select **Next**.

6. On the **Request Certificates** page, select the **Archive User** check box, select **Enroll**, and then select **Finish**.

7. Refresh the console, expand **Personal**, and then select **Certificates**. 

   > Note that a certificate is issued to Oscar based on the Archive User certificate template.

8. Simulate the loss of a private key by deleting the certificate. In the central pane, right-click or access the context menu for the certificate you just enrolled, select **Delete**, and then select **Yes** to confirm.

9. Switch to **LON-DC1**.

10. Open the **Certification Authority** console, expand **ContosoCA**, and then select the **Issued** **Certificates** store.

11. In the details pane, open a certificate with a **Requestor Name** of **Contoso\\Oscar** and a **Certificate Template** name of **Archive User**.

12. Select the **Details** tab, copy the **Serial number**, and then select **OK**. You can copy the number either by selecting it and selecting Ctrl+C or by noting it in a document.

13. Select the **Start** button, and then select the **Windows PowerShell** icon.

14. At the **Windows PowerShell** command prompt, enter the following command, where `<serial number>` is the serial number that you copied, and then select Enter:

    ```
    Certutil –getkey <serial number> outputblob 
    ```

    > **Note:** If you copy and paste the serial number, remove the spaces between the numbers or enclose the serial number between double quotes.

15. In the command prompt, enter `dir` to verify that the **Outputblob** file now displays in the **C:\\Users\\Administrator** folder.

16. To convert the **Outputblob** file into a .pfx file, at the **Windows PowerShell** command prompt, enter the following command, and then select Enter: 

    ```
    Certutil –recoverkey outputblob Oscar.pfx
    ```

17. When prompted for the new password, enter **Pa55w.rd**, and then confirm the password.

18. After the command executes, close Windows PowerShell.

19. Open File Explorer and browse to **C:\\Users\\Administrator**, and then verify that **Oscar.pfx** (which is the recovered key) is created.

20. Switch to **LON-CL1**.

21. Open **File Explorer**, and then browse to **\\\\LON-DC1.Contoso.com\\c$\\users\\administrator**. When prompted for credentials, use **Contoso\\Administrator** with the password of **Pa55w.rd**.

22. Right-click or access the context menu for the **Oscar.pfx** file, and then select **Install PFX**.

23. On the **Welcome to the Certificate Import Wizard** page, select **Next**.

24. On the **File to Import** page, select **Next**.

25. On the **Password** page, enter the password **Pa55w.rd**, and then select **Next**.

26. On the **Certificate Store** page, select **Next**, select **Finish**, and then select **OK**.

27. In **certmgr**, expand the **Certificates - Current User** node, expand **Personal**, and then select **Certificates**.

28. Refresh the console, and then verify that the certificate for Oscar is restored.


**Results**: After completing this exercise, you'll have implemented certificate enrollment and archive functionality.
