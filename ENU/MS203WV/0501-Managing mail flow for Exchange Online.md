# Lab 5A: Managing mail flow for Exchange Online

## Lab scenario

Your organization collaborates with a partner organization named Adatum Corporation that uses a domain name of Adatum.com. You need to implement secure email communication between Contoso and Adatum.com by using connectors. You also plan to create a mail flow rule to ensure that whenever anyone sends email to Adatum.com, the message is sent through the proper connector. You also need to create a couple of additional mail flow rules to add a company disclaimer and for detecting email messages based upon key words.

>**Note:** This lab requires students to first complete the **Module 1 lab: Exploring Microsoft 365 and Exchange Online administration portals**, and **Module 2: Lab A: Creating and managing Exchange Online recipients**.
>
>To assist with your sign-in process, enter your Microsoft 365 Tenant name, sign-in username, and password as follows:
>
>- **Microsoft 365 Tenant name (ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Microsoft 365 Username (username@ddmmyyyourinitialsContoso.onmicrosoft.com):** 
>- **Password:** Pa55w.rd1234

## Exercise 1: License preparation for the Microsoft 365 tenant

### Scenario

To enable specific features for your tenant, you need to enable and assign additional licenses to your users. This is needed in preparation for upcoming lab tasks.

The main tasks for this exercise are as follows:

1. Add additional cloud services to the tenant.
2. Disable recurring billing for the Microsoft 365 E5 trial subscription.
3. Assign licenses to users.

### Task 1: Add additional cloud services to the tenant

1.  Sign in to **LON-CL1** as **`Admin`** with the password **`Pa55w.rd`**.

2.  From the taskbar, select **Microsoft Edge**.

3.  In the address bar, enter **`https://admin.microsoft.com`**, and then select Enter.

4.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

5.  At the **Stay signed in** prompt, select **No**.

6.  In the Microsoft 365 admin center, on the navigation menu, expand **Billing**, and then select **Licenses**.

>**Note:** The **Licenses** page displays the current subscriptions and available licenses for the tenant.

7.  On the navigation menu, under **Billing**, select **Purchase services**.

>**Note:** The **Purchase services** page is where you'll review the products and services that you can add on to your subscription.

8.  On the **Purchase services** page, select **All products**.

9.  In the **Search all products** field, enter **E5** and then press Enter.

10.  In the **Microsoft 365 E5** section, select **Details**.

11.  On the **Microsoft 365 E5** page, in the **Select a plan** section, select **Microsoft 365 E5 (Trial)**.

12.  On the **Check out** page, select **Place order**.

13.  Close the **Thanks for your order** page.

### Task 2: Disable recurring billing for the Microsoft 365 E5 trial subscription

>**Important:** Ensure that you follow all the steps listed in this task to disable recurring billing on your subscription before the trial expires.

1.  In the Microsoft 365 admin center, use the navigation pane to expand **Billing**, and then select **Your products**.

>**Note:** Both the **Microsoft 365 E3** and the **Microsoft 365 E5** subscriptions are listed.

3.  Refresh the page until the **Subscription status** for **Microsoft 365 E5** shows **Active**.

2.  Select the **Microsoft 365 E5** item.

3.  On the **Microsoft 365 E5** page, select **Edit recurring billing**. 

4.  On the **Edit recurring billing** page, select **Off**, and then select **Save**, and then at the prompt, select **Yes**.

>**Note:** By disabling recurring billing, you ensure that your subscription will not automatically renew and charge your payment method when the trial expires.

### Task 3: Assign licenses to users

1.  In the Microsoft 365 admin center, use the navigation pane to expand **Users**, and then select **Active users**.

2.  On the menu bar, select the ellipse (...), select **Filter**, and then select **Licensed users**.

2.  Select the checkboxes next to all of the licensed users, except **Patti Fernandez**.

>**Note:** Patti receives her license from a group membership, and cannot be assigned a new license. You would have to modify the group license setting to modify Patti's license.

3.  On the menu bar, select the ellipse (...), and then select **Manage product licenses**.

4.  On the **Manage product licenses** page, verify that the eight users are selected, and then select **Replace**.

5.  Select the checkbox for **Microsoft 365 E5**.

6.  Select **Save changes**, and then select **Done**.

>**Note:** Notice that all selected users are now assigned the Microsoft 365 E5 license.

7.  Close Microsoft Edge.

**Results**: After completing this exercise, you'll have acquired and replaced licenses for users in the tenant.

## Exercise 2: Configuring Connectors to manage mail flow

### Scenario

You plan to implement secure communication between your organization and Adatum.com. Adatum has an on-premises email system and doesn't use Exchange Online. To facilitate secure email with Adatum.com, you need to create two connectors. One connector will ensure that outbound email to Adatum.com uses Transport Layer Security (TLS) to secure the connection. The connection will only occur if the certificate used by Adatum.com is trusted by a certification authority (CA) and uses the common name \*.adatum.com. The second connector will ensure that any email received from Adatum.com is secure by again validating the \*.adatum.com TLS certificate.

The main tasks for this exercise are as follows:

1. Create a new Connector to send email to a partner organization.
2. Create a new Connector to receive email from a partner organization.

### Task 1: Create a new Connector to send email to a partner organization

1.  On **LON-CL1**, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://admin.exchange.microsoft.com`**, and then select Enter.

3.  Sign in as **`username@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

>**Note:** Use the credentials that you provided at the start of this lab.

4.  At the **Stay signed in** prompt, select **No**.

>**Note:** The Exchange admin center opens.

5.  In the navigation pane, expand **Mail flow**, and then select **Connectors**.

6.  On the **Connectors** page, select **Add a connector**.

7.  In the **Add a connector** wizard, on the **New connector** page, configure the following details, and then select **Next**:

   - **Connection from:** Office 365
   - **Connection to:** Partner organization

8.  On the **Connector name** page, enter the following details, and then select **Next**:

   - **Name:** `Send to Adatum.com`
   - **Description:** `Secure connection to Adatum.com`
   - **What do you want to do after the connector is saved?** Turn it on

9.  On the **Use of connector** page, select **Only when I have a transport rule set up that redirects messages to this connector**, and then select **Next**.

10.  On the **Routing** page, select **Use the MX record associated with the partner's domain**, and then select **Next**.

11.  On the **Security restrictions** page, configure the following details, and then select **Next**:

    - **Always use Transport Layer Security (TLS) to secure the connection:** Selected
    - **Issued by a trusted certificate authority:** Selected
    - **Add the subject name or subject alternative name (SAN) matches this domain name:** `*.adatum.com`

12.  On the **Validation email** page, enter **`User1@adatum.com`**, select **Add** (the plus symbol), and then select **Validate**.

>**Note:** The validation may take a few minutes to complete. However, it will fail, which is expected because Adatum is a fictitious company. In a real environment, validation should complete with a successful result.

13.  On the **Validation email** page, select **Next**, and then at the **Are you sure** message, select **Yes, proceed**.

14.  On the **Review connector** page, select **Create connector**, and then select **Done**.

### Task 2: Create a new Connector to receive email from a partner organization

1.  In the Exchange admin center, on the **Connectors** page, select **Add a connector**.

2. In the **Add a connector wizard**, on the **New connector** page, configure the following details, and then select **Next**:

     - **Connection from:** Partner organization

     - **Connection to:** Office 365 (Automatically selected)


3. On the **Connector name** page, enter the following details, and then select **Next**:

     - **Name:** `Receive from Adatum.com`

     - **Description:** `Secure connection from Adatum.com`

     - **What do you want to do after the connector is saved?:** Turn it on


4.  On the **Authenticating sent email** page, select **by verifying that the sender domain matches one of the following domains**.

5.  In the text box, enter **`*.adatum.com`**, select **Add** (the plus symbol), and then select **Next**.

6.  On the **Security restrictions** page, configure the following details, and then select **Next**:

   - **Reject email messages if they aren't sent over TLS:** Selected
   - **And require that the subject name on the certificate that the partner uses to authenticate with Office 365 matches this domain name:** Selected
   - Text box:  **`*.adatum.com`**

7.  On the **Review connector** page, select **Create connector**, and then select **Done**.

**Results:** After completing this exercise, you'll have created two connectors for secure email connectivity with Fabrikam.com.

## Exercise 3: Configuring Mail flow rules

### Scenario

You need to create three mail flow rules. The first mail flow rule will redirect any email addressed to adatum.com to the **Send to Adatum.com** connector. The second mail flow rule will append a company disclaimer to all email messages sent from company users. The third mail flow rule will add Lee Gu as an additional recipient if **Project Status** is detected in the subject or body of any email message.

The main tasks for this exercise are as follows:

1. Configure a rule to redirect email to a connector.
2. Configure a rule to add an email disclaimer.
3. Configure a rule to apply based upon subject or email body message details.

### Task 1: Configure a rule to redirect email to a connector

1.  In the Exchange admin center, from the navigation pane, expand **Mail flow**, and then select **Rules**.

2.  On the **Rules** page, select **Add a rule**, and then select **Create a new rule**.

3.  In the **New transport rule wizard**, on the **Set rule conditions** page, configure the following details:

   - **Name:** `Email to Adatum`
   - **Apply this rule if:** The recipient
     - **Select one:** domain is
     - **Specify domain:** `Adatum.com`

4.  Select **Add**, and then select **Save**

5.  On the **Set rule conditions** page, configure the following details, and then select **Save**:

   - **Do the following:** Redirect the message to
   - **Select one:** The following connector
     - **Select connector:** Send to Adatum

6.  On the **Set rule conditions** page, select **Next**.

7.  On the **Set rule settings** page, configure the following setting, and then select **Next**:

   - **Rule mode:** Enforce

8.  On the **Review and finish** page, select **Finish**, and then select **Done**.

>**Note:** The rule is created in a disabled state.

9.  Select the **Email to Adatum** rule, and then in the **Enable or disable rule** section, select the toggle button to enable the rule. When the rule status is updated succcessfully, close the **Email to Adatum** pane.

>**Note:** The rule should now have a status of **Enabled**.

### Task 2: Configure a rule to add an email disclaimer

1.  In the Exchange admin center, from the navigation pane, expand **Mail flow**, and then select **Rules**.

2.  On the **Rules** page, select **Add a rule**, and then select **Apply disclaimers**.

3.  In the **New transport rule** wizard, on the **Set rule conditions** page, configure the following settings:

   - **Name:** `Contoso email disclaimer`
   - **Apply this rule if:** Apply to all messages

4.  On the **Set rule conditions** page, configure the following settings:

   - **Do the following:** 
     - Apply a disclaimer to the message
     - Append a disclaimer
   - **Enter text:** `IMPORTANT: The contents of this email and any attachments are confidential. They are intended for the named recipient(s) only. If you have received this email by mistake, please notify the sender immediately and do not disclose the contents to anyone or make copies.`
   - **Select one:** Wrap

5.  On the **Set rule conditions** page, select **Next**.

6.  On the **Set rule settings** page, configure the following setting, and then select **Next**:

   - **Rule mode:** Enforce

7.  On the **Review and finish** page, select **Finish**, and then select **Done**.

>**Note:** The rule is created in a disabled state.

8.  Select the **Contoso email disclaimer** rule.

9.  Under the **Enable or disable rule** section, select the toggle button to enable the rule. When the rule status is updated successfully, close the **Contoso email disclaimer** pane.

10.  Verify that the rule now has a status of **Enabled**.

### Task 3: Configure a rule to apply based upon subject or email body message details

1.  In the Exchange admin center, from the navigation pane, expand **Mail flow**, and then select **Rules**.

2.  On the **Rules** page, select **Add a rule**, and then select **Create a new rule**.

3.  In the **New transport rule** wizard, on the **Set rule conditions** page, configure the following details:

   - **Name:** `Redirect to Manager if content contains Project Status`
   - **Apply this rule if:** The subject or body
     - **Select one:** subject or body includes any of these words
     - **Specify words or phrases:** `Project Status`

4.  Select **Add**, and then select **Save**.

5.  On the **Set rule conditions** page, configure the following settings, and then select **Save**:

   - **Do the following:** Add recipients
   - **Select one:** To the Cc box
     - **Select members:** Lee Gu

6.  On the **Set rule conditions** page, select **Next**.

7.  On the **Set rule settings** page, configure the following settings, and then select **Next**:

   - **Rule mode:** Enforce

8.  On the **Review and finish** page, select **Finish**, and then select **Done**.

>**Note:** The rule is created in a disabled state.

9.  Select the **Redirect to Manager** rule, and then under the **Enable or disable rule** section, select the toggle button to enable the rule. When the rule status is updated successfully, close the **Redirect to Manager** pane.

10.  Close Microsoft Edge.

**Results**: After completing this exercise, you should have configured mail flow rules.

## Exercise 4: Validating mail flow rules

### Scenario

You need to validate that the mail flow rules work as expected. In this exercise, you will sign in as Alex and send three email messages to validate the mail flow rules.

The main task for this exercise is as follows:

- Validate mail flow rules.

### Task 1: Validate mail flow rules

1.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

2.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter.

3.  Sign in as **`Alex@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

4.  At the **Stay signed in** prompt, select **No**.

5.  When Microsoft Outlook opens to Alex's inbox, in the menu, select **New mail**.

6.  On the message page, In the **To** field, enter `Kirk@adatum.com`.

7.  Complete the email message with the following settings, and then select **Send**:

   - **Add a subject:** `Adatum project details`
   - **Body of message:** `Here are the details for the Adatum project.`

>**Note:** The first email is sent, which will use the **Send to Adatum.com** connector.

8.  In the menu, select **New mail**.

9.  On the message page, In the **To** field, enter `Alex Wilber`.

>**Note:** You will send yourself an email to  validate the disclaimer message.

10.  Complete the email message with the following settings, and then select **Send**:

    - **Add a subject:** `Test of disclaimer`
    - **Body of message:** `This is a test email to view the disclaimer`

11.  In the Outlook Inbox, select the **Test of disclaimer** message from Alex Wilber.

>**Note:** Notice that the disclaimer displays as configured in the Mail Flow rule.

12.  In the menu, select **New mail**.

13.  On the message page, in the **To** field, enter `Joni Sherman`.

>**Note:** You will send an email to Joni with the words **Project Status**.

14.  Complete the email message with the following settings, and then select **Send**:

    - **Add a subject:** `Project Status`
    - **Body of message:** `Here is the Project Status`

15.  Close Microsoft Edge.

16.  On LON-CL1, from the taskbar, select **Microsoft Edge**.

17.  In the address bar, enter **`https://outlook.office.com`**, and then select Enter. .

18.  Sign in as **`Lee@ddmmyyyourinitialsContoso.onmicrosoft.com`** with the password **`Pa55w.rd1234`**. 

19.  At the **Stay signed in** prompt, select **No**.

>**Note:** Outlook opens to Lee's inbox. Notice the message regarding Project Status. This was automatically delivered to Lee as a result of the Mail Flow rule.

20.  Close Microsoft Edge.

**Results**: After completing this exercise, you'll have sent two email messages to validate the mail flow rules.