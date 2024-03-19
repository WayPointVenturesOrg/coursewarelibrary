# Lab 6A: Implementing message security with Preset Security Policies

## Lab scenario

You need to ensure that Contoso is protected from phishing attempts, spoofing, and malicious email messages. With approval from your security team, you decide to launch an email attack simulation to determine how many users can be tricked into opening a link embedded in a suspicious email message. You also decide to review and implement Microsoft Defender Preset Security Policies to protect against spam, phishing, malware, malicious links, and attachments.

>**Note:** This lab requires students to first complete the **Module 1 Lab: Exploring Microsoft 365 and Exchange Online administration portals**, and **Module 2, Lab A: Creating and managing Exchange Online recipients**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234

## Exercise 1: Running an Email Attack Simulation

### Scenario

You have been asked to perform an email phishing attack simulation for users in the company. You need to ensure that any user that fails the simulation goes through the Microsoft-recommended training to help educate the user.

The main tasks for this exercise are as follows:

1. Launch an attack simulation for users.
2. Validate the Email Attack Simulation.
3. Review Attack Simulation reports.

### Task 1: Launch an attack simulation for users

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft 365 admin center opens.

6.  Complete and close any notification prompts that might display.

7.  In the navigation menu, select **Show all**.

>**Note:** All options now display in the navigation menu.

8.  In the navigation menu, under **Admin centers**, select **Security**.

>**Note:** The Microsoft Defender portal opens in a new browser tab.

9.  Complete and close any notification prompts that might display.

10.  In the Microsoft Defender portal, in the navigation pane, expand **Email & collaboration**.

>**Note:** Take note of the email-related security options such as **Investigations**, **Exchange message trace**, **Attack simulation training**, and **Policies & rules**.

11.  On the navigation pane, select **Attack simulation training**.

12.  On the **Attack simulation training** page, select the **Simulations** tab.

13.  On the **Simulations** tab, select **Launch a simulation**.

14.  In the **Simulation** wizard, on the **Select technique** page, under **Credential Harvest**, select **View details of Credential harvest**.

15.  In the **Credential Harvest details** pane, review the attack technique (including the simulation steps), and then close the details pane.

16.  On the **Select technique** page, select **Credential Harvest**, and then select **Next**.

17. On the **Name simulation** page, enter the following details, and then select **Next**.

       - **Name:** `Contoso Credential Harvest Simulation`

       - **Description:** `Simulating URL to malicious website.`


18.  On the **Select payload and login page** step, on the **Global payloads** tab, select **Reset Password**, and then select **Next**.

19.  On the **Target users** page, select **Include only specific users and groups**, and then select **Add users**.

20.  On the **Add users** page, scroll to the **Department** section, select the **HR**, **Research**, and **Sales** checkboxs, and then select **Apply**.

21.  On the **Add users** page, under **User List**, select the checkboxes next to all of the users, and then select **Add 7 User(s)**.

22.  On the **Target users** page, select **Next**.

23.  On the **Exclude users** page, select **Next**.

24.  On the **Assign training** page, configure the following details, and then select **Next**:

    - **Select training content preference:** Microsoft training experience
    - **Assign training for me:** Selected
    - **Select a training due date:** 7 days after Simulation ends

25.  On the **Select Phish landing page** step, configure the following details, and then select **Next**:

    - **Use landing pages from library:** Selected
    - **Add payload indicators to email:** Selected
    - **Microsoft Landing Page Template 1:** Selected

26.  On the **Select end user notification** page, select **Microsoft default notification**.

27.  Under **Notifications**, for the **Microsoft default positive reinforcement notification**, select **Delivery preferences**, and then select **Deliver after simulation**.

28.  Under **Notifications**, for the **Microsoft default training reminder notification**, select **Delivery preferences**, and then select **Twice a week**.

29.  On the **Select end user notification** page, select **Next**.

30.  On the **Launch details** page, select **Launch this simulation as soon as I'm done**, and then select **Next**.

31.  On the **Review simulation** page, review the details, and then select **Submit**.

>**Note:** It could take a couple of minutes as the simulation is submitted and scheduled.

32.  On the confirmation page, select **Done**.

>**Note:** You are returned to the **Attack simulation training** page. Notice that the **Contoso Credential Harvest Simulation** now displays, and that **In progress** is **1**.

33.  Close Microsoft Edge.

### Task 2: Validate the Email Attack Simulation

1.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

3.  Sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

5.  When Outlook opens, in Alex's Inbox, select the message with the subject line **Action Needed: Password Expired**.

6.  In the email message, select **KEEP SAME PASSWORD**.

7.  When the new browser tab opens, sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Alex is redirected to a landing page that describes the details of the simulation.

8.  Read through the landing page details and review any notification prompts that might display.

>**Note:** The notification prompts describe elements of the email message that suggest it is a phishing message.

9.  At the end of the landing page, select **Go to training**.

>**Note:** A new browser tab opens to Microsoft Defender.

10.  On the **Training playback** page, on the **Web Phishing** page, select **Start**.

11.  Complete the Web Phishing training assignment, and then close Microsoft Edge.

### Task 3: Review Attack Simulation Reports

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://security.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Defender portal opens.

5.  Complete and close any notification prompts that might display.

6.  In the Microsoft Defender portal, in the navigation pane, expand **Email & collaboration**, and then select **Attack simulation training**.

7.  On the **Attack simulation training** page, on the **Overview** tab, in the **Recent Simulations** section, select **Contoso Credential Harvest Simulation**.

8.  Review the **Report** tab.

9.  Review the **Users** tab.

10.  Close Microsoft Edge.

**Results:** After completing this exercise, you'll have created an email attack simulation, validated that the simulation works, and reviewed attack simulation reports.

## Exercise 2: Configuring Preset Security Policies 

### Scenario

As a result of your attack simulation, you decide to implement threat policies to protect your Exchange Online environment. You decide to use the Preset Security Policies to improve your security posture. You will configure Standard protection for all users and apply a baseline protection profile for spam, phishing, and malware threats, along with Safe Links and Safe attachments. Finally, you will configure a Strict protection profile and apply the profile to the Research department. You will configure this to only apply strict protection for spam, phishing, and malware threats.

The main tasks for this exercise are as follows:

1. Review the Built-in protection Preset Security Policy.
2. Configure Standard Protection Preset Security Settings.
3. Configure Strict Protection Preset Security Settings.

### Task 1: Review the Built-in protection Preset Security Policy

1.  From the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://security.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Microsoft Defender portal opens.

5.  Complete and close any notification prompts that might display.

6.  In the Microsoft Defender portal, in the navigation pane, expand **Email & collaboration**, and then select **Policies & rules**.

7.  On the **Policies & rules** page, select **Threat policies**.

>**Note:** The Threat policies page contains policies and rules settings to help protect against a large number of email attacks.

8.  In the **Templated policies** section, select **Preset Security Policies**. Close the **Learn about preset security policies** panel.

>**Note:** Take note of the **Preset security policies** named **Built-in protection**, **Standard protection**, and **Strict protection**.

9.  At the top of the page, select **Threat policies**.

10.  In the **Policies** section, select **Safe Attachments**.

>**Note:** Notice that Safe attachments is assigned the **Built-in protection (Microsoft)** Preset Security Policy. This policy is configured to block and quarantine messages that contain malware and to only permit an administrator to release the message from quarantine. This policy cannot be modified.

11.  At the top of the **Safe attachments** page, select **Threat policies**.

12.  In the **Policies** section, select **Safe Links**.

>**Note:** Notice that Safe Links is assigned the **Built-in protection (Microsoft)** Preset Security Policy. This policy is configured to check URLs against a list of known malicious links when users follow links in an email message. This policy cannot be modified.

13.  At the top of the **Safe Links** page, select **Threat policies**.

>**Note:** The **Anti-phishing**, **Anti-spam**, and **Anti-malware** policies are not assigned the **Built-in protection** Preset Security Policy. These do, however, have a default policy configuration that can be modified.

### Task 2: Configure Standard Protection Preset Security Settings

1.  In the Microsoft Defender portal, on the **Threat policies** page, select **Preset Security Policies**.

2.  In the **Standard protection** section, select **Manage protection settings**.

3.  In the **Apply standard protection wizard**, on the **Apply Exchange Online Protection** page, select **All recipients**, and then select **Next**.

>**Note:** **Exchange Online Protection** will assign the **Standard protection** Preset Security Policy for **Anti-phishing**, **Anti-spam**, and **Anti-malware** settings. 

4.  On the **Apply Defender for Office 365 protection** page, select **All recipients**, and then select **Next**.

>**Note:** **Defender for Office 365 Protection** will assign the **Standard protection** Preset Security Policy for **Safe Links** and **Safe Attachments** settings. 

5.  On the **Impersonation protection** page, review the details, and then select **Next**.

6.  On the **Protected custom users** page, select the **Add a valid email** text box, select **Lee Gu**, and then select **Add**.

>**Note:** Lee Gu will now have additional protection from impersonation by attackers.

7.  On the **Protected custom users** page, select **Next**.

8.  On the **Protected custom domains** page, select **Next**.

9.  On the **Trusted senders and domains** page, select **Next**.

10.  On the **Policy mode** page, select **Turn on the policy when finished**, and then select **Next**.

11.  On the **Review** page, select **Confirm**, and then select **Done**.

>**Note:** You can confirm that the **Standard protection** Preset security policy is enabled by validating that that the **Standard protection is on** toggle switch is active and enabled.

12.  At the top of the page, select **Threat policies**.

13.  In the **Policies** section, select **Anti-phishing**.

>**Note:** Notice that the **Standard Preset Security Policy** is on and has a higher priority than the default policy. This policy cannot be modified.

14.  At the top of the **Anti-phishing** page, select **Threat policies**.

15.  In the **Policies** section, select **Anti-spam**.

>**Note:** Notice that the **Standard Preset Security Policy** is on and has a higher priority than the default policies. This policy cannot be modified.

16.  At the top of the **Anti-spam policies** page, select **Threat policies**.

17.  In the **Policies** section, select **Anti-malware**.

>**Note:** Notice that the **Standard Preset Security Policy** is on and has a higher priority than the default policies. This policy cannot be modified.

18.  At the top of the **Anti-malware policies** page, select **Threat policies**.

19.  Review the **Safe Attachments** and **Safe Links** policies and verify that they both also have the **Standard Preset Security Policy** assigned with a higher priority than the Built-in protection policy.

### Task 3: Configure Strict Protection Preset Security Settings

1.  In the Microsoft Defender portal, on the **Threat policies** page, select **Preset Security Policies**.

2.  In the **Strict protection** section, select **Manage protection settings**.

3.  In the **Apply strict protection wizard**, on the **Apply Exchange Online Protection** page, select **Specific recipients**.

4.  Select the **Groups** field, enter and select the **`Research`** group, and then select **Next**.

>**Note:** **Exchange Online Protection** will assign the **Strict protection** Preset Security Policy for **Anti-phishing**, **Anti-spam**, and **Anti-malware** settings only to members of the Research group.

5.  On the **Apply Defender for Office 365 protection** page, select **None**, and then select **Next**.

>**Note:** For this example, You will not apply the **Strict Protection** Preset Security Policy for **Safe Links** and **Safe Attachments** settings. 

6.  On the **Impersonation protection** page, review the details, and then select **Next**.

7.  On the **Protected custom users** page, select the **Add a valid email** text box, select **Lee Gu**, and then select **Add**.

8.  On the **Protected custom users** page, select **Next**.

9.  On the **Protected custom domains** page, select **Next**.

10.  On the **Trusted senders and domains** page, select **Next**.

11.  On the **Policy mode** page, select **Turn on the policy when finished**, and then select **Next**.

12.  On the **Review** page, select **Confirm**, and then select **Done**.

>**Note:** You can confirm that the **Strict protection** Preset security policy is enabled by validating that that the **Strict protection is on** toggle switch is active and enabled.

13.  At the top of the page, select **Threat policies**.

14.  In the **Policies** section, select **Anti-phishing**.

>**Note:** Notice that the **Strict Preset Security Policy** is on and has a higher priority than all other policies. This policy cannot be modified.

15.  At the top of the **Anti-phishing** page, select **Threat policies**.

16.  In the **Policies** section, select **Anti-spam**.

>**Note:** Notice that the **Strict Preset Security Policy** is on and has a higher priority than all other policies. This policy cannot be modified.

17.  At the top of the **Anti-spam policies** page, select **Threat policies**.

18.  In the **Policies** section, select **Anti-malware**.

>**Note:** Notice that the **Strict Preset Security Policy** is on and has a higher priority than all other policies. This policy cannot be modified.

19.  At the top of the **Anti-malware policies** page, select **Threat policies**.

20.  Review the **Safe Attachments** and **Safe Links** policies and verify that they both do **NOT** have the **Strict Preset Security Policy** assigned.

>**Note:** Safe Attachments and Safe Links only apply to the Microsoft Defender for Office 365 protection settings. You had configured the **Strict Preset Security Policy** recipients setting to **None**.

>**Note:** For more information on the specific settings configured in the Preset Security Policies refer to [Recommended settings for EOP and Microsoft Defender for Office 365 security | Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/recommended-settings-for-eop-and-office365?view=o365-worldwide).

**Results**: After completing this exercise, you will have configured Preset Security Policies.

## Exercise 3: Removing Preset Security Policies 

### Scenario

You decide that to remove the Preset Security Policy settings so that you can create custom threat policies as needed.

The main task for this exercise is as follows:

- Turn off and disable Preset Security Policies

### Task 1: Turn off and disable Preset Security Policies

1.  In the **Microsoft Defender portal**, on the **Threat policies** page, select **Preset Security Policies**.

2.  In the **Standard protection** section, select **Manage protection settings**.

3.  On the **Apply Exchange Online Protection** page, select **None**, and then select **Next**.

4.  On the **Apply Defender for Office 365 protection** page, select **None**, and then select **Next**.

5.  On the **Impersonation protection** page, review the details, and then select **Next**.

6.  On the **Protected custom users** page, remove **Lee Gu**, and then select **Next**.

7.  On the **Protected custom domains** page, select **Next**.

8.  On the **Trusted senders and domains** page, select **Next**.

9.  On the **Review** page, select **Confirm**, and then select **Done**.

>**Note:** You can confirm that the **Standard Protection Preset** Security Policy is turned off by validating that that the **Standard protection is off** toggle switch is turned off. if The toggle is still active, refresh the browser page.

10.  In the **Strict protection** section, select **Manage protection settings**.

11.  On the **Apply Exchange Online Protection** page, remove the **Research** group, select **None**, and then select **Next**.

12.  On the **Apply Defender for Office 365 protection** page, select **None**, and then select **Next**.

13.  On the **Impersonation protection** page, review the details, and then select **Next**.

14.  On the **Protected custom users** page, remove **Lee Gu**, and then select **Next**.

15.  On the **Protected custom domains** page, select **Next**.

16.  On the **Trusted senders and domains** page, select **Next**.

17.  On the **Review** page, select **Confirm**, and then select **Done**.

>**Note:** You can confirm that the **Strict protection** Preset Security Policy is turned off by verifying that the **Strict protection is off** toggle switch is active and enabled. If the toggle is still active, refresh the browser page. 

18.  Close Microsoft Edge.

**Results**: After completing this exercise, you will have removed Preset Security Policies.