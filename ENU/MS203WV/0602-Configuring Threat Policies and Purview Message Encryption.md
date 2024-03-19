# Lab 6B: Configuring Threat Policies and Purview Message Encryption

## Lab scenario

You need to have more granular control of policies assigned to the Research department that protect against phishing attempts, spoofing, and malicious email messages. First, you need to create a custom Quarantine policy for Anti-phishing and Anti-spam policy settings. Next, you plan to implement custom threat policies with specific protection and quarantine settings. Finally, to help secure email communication, you decide to implement Microsoft Purview Message Encryption to ensure that email messages from the Research group delivered outside of the organization are encrypted.

>**Note:** This lab requires students to first complete the following labs:
>
>- **Module 1 Lab: Exploring Microsoft 365 and Exchange Online administration portals**
>- **Module 2, Lab A: Creating and managing Exchange Online recipients**
>- **Module 6, Lab A: Implementing message security with Preset Security Policies** 
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234

## Exercise 1: Creating a custom Quarantine Policy

### Scenario

You need to create a custom Quarantine policy to be used for Anti-phishing and Anti-spam policy settings. The Quarantine policy must be configured to allow recipients to request a message be released from quarantine or enable recipients to delete a quarantined message themselves. You also need to ensure that all quarantine notification messages are sent out on a weekly basis.

The main tasks for this exercise are as follows:

1. Configure Quarantine Policy Global settings.
2. Create a custom Quarantine policy.
3. Review quarantined messages.

### Task 1: Configure Quarantine Policy Global settings

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://security.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Defender portal opens.

6.  Complete and close any notification prompts that might display.

7.  In the **Microsoft Defender** portal, in the navigation pane, expand **Email & collaboration**, and then select **Policies & rules**.

8.  On the **Policies & rules** page, select **Threat policies**.

9.  In the **Rules** section, select **Quarantine policies**.

10.  Take note of the three default Quarantine policies: 

    - **DefaultFullAccessPolicy**&mdash;configured to permit a recipient to release messages from quarantine, block a sender, delete the message, and preview the message. It has **Quarantine notification** disabled.

    - **AdminOnlyAccessPolicy**&mdash;doesn't permit any recipient interaction with quarantined messages, and also has **Quarantine notification** disabled. 

    - **DefaultFullAccessWithNotificationPolicy**&mdash;is similar to **DefaultFullAccessPolicy**, but with **Quarantine notification** enabled.

11.  On the **Quarantine policy** page, select **Global settings**.

12.  In the **Quarantine notification settings** panel, scroll to the end of the panel, set the **Send end-user spam notifications** drop-down menu to **Weekly**, and then select **Save**.

13.  Close the **Quarantine notification settings** panel.

### Task 2: Create a custom Quarantine policy

1.  On the **Quarantine policy** page, select **Add custom policy**.

>**Note:** The **New policy** panel opens.

2.  On the **Policy name** page, enter **`ContosoQuarantine`**, and then select **Next**.

3.  On the **Recipient message access** page, select **Set specific access (Advanced)**, specify the following details, and then select **Next**:

   - **Select release action preference:** Allow recipients to request a message to be released from quarantine.
   - **Select additional actions recipients can take on quarantined messages:** Select the **Delete** checkbox.

4.  On the **Quarantine notification** page, select the **Enable** checkbox, and then select **Next**.

5.  On the **Summary** page, review the policy settings, and then select **Submit**.

6.  On the confirmation page, select **Done**.

>**Note:** You should now notice that **ContosoQuarantine** is listed on the **Quarantine policy** page.

### Task 3: Review quarantined messages

1.  In the Microsoft Defender portal, in the navigation pane, expand **Email & collaboration**, and then select **Review**.

2.  On the **Review** page, select **Quarantine**.

>**Note:** Notice that the Quarantine is made up of Email, Files, and Teams messages. This is where you would review a quarantined message and decide to preview, release, deny, or delete the message. Note that there are no messages currently in the quarantine.

**Results:** After completing this exercise, you'll have created a custom Quarantine policy.

## Exercise 2: Configuring Threat Policies 

### Scenario

You have been asked to create custom threat policies for the Research department. You will create a policy for Anti-phishing, Anti-spam, Anti-malware, Safe Attachments, and Safe Links. You have been provided specific details for policy settings.

The main tasks for this exercise are as follows:

1. Create an Anti-phishing policy.
2. Create an Anti-spam policy.
3. Create an Anti-malware policy.
4. Create a Safe attachments policy.
5. Create a Safe Links policy.

### Task 1: Create an Anti-phishing policy

1.  In the Microsoft Defender portal, in the navigation pane, expand **Email & collaboration**, and then select **Policies & rules**.

2.  On the **Policies & rules** page, select **Threat policies**.

3.  In the **Policies** section, select **Anti-phishing**.

4.  On the **Anti-phishing** page, select **Create**.

5.  In **Create a new anti-phishing policy wizard**, on the **Policy name** page, specify the following details, and then select **Next**:

   - **Name:** `ContosoAntiPhishPolicy`
   - **Description:** `Custom policy for Contoso`

6.  On the **Users, groups, and domains** page, specify the following setting, and then select **Next**:

   - **Groups:** `Research`

7.  On the **Phishing threshold & protection** page, specify the following details, and then select **Next**:

   - **Phishing email threshold:** 2 - Aggressive

>**Note:** Leave all other selections at the default settings.

8.  On the **Actions** page, specify the following details, and then select **Next**:

   - **Honor DMARC record policy when the message is detected as spoof:** Not selected
   - **If a message is detected as spoof by spoof intelligence:** Quarantine the message
     - **Apply quarantine policy:** ContosoQuarantine

>**Note:** Leave all other selections at the default settings.

9.  On the **Review** page, review the settings, select **Submit**, and then select **Done**.

10.  At the top of the page, select **Threat policies** to return to the **Threat policies** page.

### Task 2: Create an Anti-spam policy

1.  On the **Threat policies** page, in the **Policies** section, select **Anti-spam**.

2.  On the **Anti-spam** page, select the drop-down menu for **Create policy**, and then select **Inbound**.

3.  In the **Create anti-spam inbound wizard**, on the **Name your policy** page, specify the following details, and then select **Next**:

   - **Name:** `ContosoAntiSpamPolicy`
   - **Description:** `Custom policy for Contoso`

4.  On the **Users, groups, and domains** page, specify the following details, and then select **Next**:

   - **Groups:** `Research`

5.  On the **Bulk email threshold & spam properties** page, specify the following details, and then select **Next**:

   - **Image links to remote websites:** On
   - **Numeric IP address in URL:** On
   - **Sensitive words:** On

>**Note:** Leave all other selections at the default settings.

6.  On the **Actions** page, specify the following details, and then select **Next**:

   - **High confidence spam:** Quarantine message

     - **Select quarantine policy:** ContosoQuarantine

   - **Phishing:** Quarantine message

     - **Select quarantine policy:** AdminOnlyAccessPolicy

    >**Note:** The AdminOnlyAccessPolicy ensures only administrators have access to the quarantined message.

   - **Retain spam in quarantine for this many days:** 30

>**Note:** Leave all other selections at the default settings.

7.  On the **Allow & block list** page, keep the default settings, and then select **Next**.

8.  On the **Review** page, review the settings, select **Create**, and then select **Done**.

9.  At the top of the page, select **Threat policies** to return to the **Threat policies** page.

### Task 3: Create an Anti-malware policy

1.  On the **Threat policies** page, in the **Policies** section, select **Anti-malware**.

2.  On the **Anti-malware** page, select **Create**.

3.  In the **Create a new anti-malware policy wizard**, on the **Policy name** page, specify the following details, and then select **Next**:

   - **Name:** `ContosoAntiMalwarePolicy`
   - **Description:** `Custom policy for Contoso`

4.  On the **Users and domains** page, specify the following setting, and then select **Next**:

   - **Groups:** `Research`

5.  On the **Protection settings** page, specify the following details, and then select **Next**:

   - **Enable zero-hour auto purge for malware:** Selected
   - **Notify an admin about undelivered messages from internal senders:** Selected
   - **Admin email address:** `username@ddmmyyyourinitialsContoso.onmicrosoft.com`

>**Note:** Leave all other selections at the default settings.

6.  On the **Review** page, review the settings, select **Submit**, and then select **Done**.

7.  At the top of the page, select **Threat policies** to return to the **Threat policies** page.

### Task 4: Create a Safe attachments policy

1.  On the **Threat policies** page, in the **Policies** section, select **Safe Attachments**.

2.  On the **Safe attachments** page, select **Create**.

3.  In the **Create Safe Attachments policy wizard**, on the **Name your policy** page, specify the following details, and then select **Next**:

   - **Name:** `ContosoSafeAttachmentsPolicy`
   - **Description:** `Custom policy for Contoso`

4.  On the **Users and domains** page, specify the following setting, and then select **Next**:

   - **Groups:** `Research`

5.  On the **Settings** page, specify the following setting, and then select **Next**:

   - **Safe Attachments unknown malware response:** Dynamic Delivery

>**Note:** Dynamic Delivery can prevent email delivery delays occurring from attachments being scanned. This option will deliver a message immediately and reattach the attachments after scanning is complete.

>**Note:** Leave all other selections at the default settings.

6.  On the **Review** page, review the settings, select **Submit**, and then select **Done**.

7.  At the top of the page, select **Threat policies** to return to the **Threat policies** page.

### Task 5: Create a Safe Links policy

1.  On the **Threat policies** page, in the **Policies** section, select **Safe Links**.

2.  On the **Safe Links** page, select **Create**.

3.  In the **Create safe links policy wizard**, on the **Name your policy** page, specify the following details, and then select **Next**:

   - **Name:** `ContosoSafeLinksPolicy`
   - **Description:** `Custom policy for Contoso`

4.  On the **Users and domains** page, specify the following setting, and then select **Next**:

   - **Groups:** `Research`

5.  On the **URL & click protection settings** page, in the **Click protection settings** section, specify the following setting, and then select **Next**:

   - **Let users click through to the original URL:** Not selected

>**Note:** Leave all other selections at the default settings.

6.  On the **Notification** page, leave the default setting, and then select **Next**.

7.  On the **Review** page, review the settings, select **Submit**, and then select **Done**.

8.  Close Microsoft Edge.

**Results**: After completing this exercise, you will have configured custom Threat Policies for the Research department.

## Exercise 3: Configuring Microsoft Purview Message Encryption

### Scenario

You need to ensure that any email sent from the Research department to external recipients is encrypted using Microsoft Purview Message Encryption. You need to validate that Purview message encryption is enabled for the tenant, and then create a mail flow rule configured to apply encryption to senders that are members of the Research department.

The main tasks for this exercise are as follows:

1. Verify that Purview Message Encryption is configured in the tenant.
2. Create a mail flow rule to apply Microsoft Purview Message Encryption.

### Task 1: Verify that Purview Message Encryption is configured in the tenant

1.  On **LON-CL1**, select **Start**, and then enter **`PowerShell ISE`**.

2.  In the search results, under **Windows PowerShell ISE**, select **Run as administrator**.

3.  At the **User Account Control**, select **Yes**.

4.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Connect-ExchangeOnline`

5.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

6.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Get-IRMConfiguration`

>**Note:** You should have a value of **$True** for the **AzureRMSLicensingEnabled** parameter, which indicates that Microsoft Purview Message Encryption is configured in the tenant.

7.  At the Windows PowerShell ISE command prompt, enter the following command, and then select Enter:

   `Test-IRMConfiguration -Sender alex@ddmmyyyourinitialsContoso.onmicrosoft.com -Recipient alex@ddmmyyyourinitialsContoso.onmicrosoft.com`

>**Note:** You should receive results that indicate RMS templates are acquired, and that encryption and decryption of the test message is verified. This indicates that Purview Message Encryption is functional.

8.  Close the Windows PowerShell ISE window.

### Task 2: Create a mail flow rule to apply Microsoft Purview Message Encryption

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Exchange admin center opens.

5.  Complete and close any notification prompts that might display.

6.  In the Exchange admin center, from the navigation pane, expand **Mail flow**, and then select **Rules**.

7.  On the **Rules** page, select **Add a rule**, and then select **Apply Office 365 Message Encryption and rights protection to messages**.

>**Note:** The **New transport rule** pane opens.

8.  On the **Set rule conditions** page, configure the following details, and then select **Save**:

   - **Name:** `Encrypted email to external recipients`
   - **Apply this rule if:** The sender
     - **Select one:** is a member of this group
     - **Select Members:** Research

9.  In the **Apply this rule if** section, select **Add** (+ symbol) to add an **And** statement. 

10.  On the **Set rule conditions** page, under the **And** statement, configure the following details, and then select **Save**:

    - **And:** The recipient
      - **Select one:** is external/internal 
      - Outside the organization

11.  On the **Set rule conditions** page, configure the following details, and then select **Next**:

    - **Do the following:** Modify the message security
    - **Select one:** Apply Office 365 Message Encryption and rights protection
    - **Rights protect message with:** Encrypt

12.  On the **Set rule conditions** page, select **Next**.

13.  On the **Set rule settings** page, configure the following setting, and then select **Next**:

    - **Rule mode:** Enforce

14.  On the **Review and finish** page, select **Finish**, and then select **Done**.

>**Note:** The rule is created in a disabled state.

15.  Select the **Encrypted email to external recipients** rule, and then in the **Enable or disable rule** section, select the toggle button to enable the rule.

>**Note:** The rule should now display a status of **Enabled**. It might take a few moments for the status to indicate that is has updated successfully.

16.  Close the **Encrypted email to external recipients** panel.

17.  Close Microsoft Edge.

**Results:** After completing this exercise, you will have verified and enabled Microsoft Purview Message Encryption.