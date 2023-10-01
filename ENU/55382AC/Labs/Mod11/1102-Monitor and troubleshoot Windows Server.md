---
lab:
    title: 'Lab: Monitor and troubleshoot Windows Server'
    module: 'Module 11: Maintain and monitor Windows Server installations'
---

# Lab: Monitor and troubleshoot Windows Server

## Scenario

You've deployed several new Windows servers at Contoso Ltd. To assist with monitoring and troubleshooting services, it's important to establish a performance baseline that indicates a typical load for these new servers. You need to establish a performance baseline and configure centralized monitoring of event logs for your organization's new servers. 

## Objectives

After completing this lab, you'll be able to:

- Establish a performance baseline.
- Identify the source of a performance problem.
- Review and configure centralized event logs.

## Estimated time: 60 minutes
## Exercise 1: Establish a performance baseline

### Scenario

In this exercise, you'll use Performance Monitor on **LON-SVR1** to create a baseline by using typical performance counters.

The main tasks for this exercise are:

1. Create and start a data collector set.
2. Create a typical workload on the server.
3. Analyze the collected data.

### Task 1: Create and start a data collector set

1.  Sign in to **LON-SVR1** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

2.  Select **Start**, enter **Perfmon**, and then in the **Best match** list, select **Performance Monitor**.

3.  In **Performance Monitor**, in the **navigation** pane, expand **Data Collector Sets**, and then select **User Defined**. 

4.  Right-click or access the context menu for **User Defined**, point to **New**, and then select **Data** **Collector Set**.

5.  In the **Create new Data Collector Set** wizard, in the **Name** box, enter **`LON-SVR1 Performance`**. 

6.  Select **Create manually (Advanced)**, and then select **Next**.

7.  On the **What type of data do you want to include?** page, select the **Performance counter** checkbox, and then select **Next**.

8.  On the **Which performance counters would you like to log?** page, select **Add**.

9.  In the **Available counters** list, expand **Processor**, select **% Processor Time**, and then select **Add >>**.

10.  In the **Available counters** list, expand **Memory**, select **Pages/sec**, and then select **Add >>**.

11.  In the **Available counters** list, expand **PhysicalDisk**, select **% Disk Time**, and then select **Add >>**.

12.  Select **Avg. Disk Queue Length**, and then select **Add >>**.

13.  In the **Available counters** list, expand **System**, select **Processor Queue Length**, and then select **Add >>**.

14.  In the **Available counters** list, expand **Network Interface**, select **Bytes Total/sec**, select **Add >>**, and then select **OK**.

15.  On the **Which performance counters would you like to log?** page, in the **Sample interval** text box, enter **1**, and then select **Next**.

16.  On the **Where would you like the data to be saved?** page, select **Next**.

17.  On the **Create the data collector set?** page, select **Save** **and close**, and then select **Finish**.

18.  In Performance Monitor, in the **Results** pane, right-click or access the context menu for **LON-SVR1 Performance**, and then select **Start**.

### Task 2: Create a typical workload on the server

1.  Select **Start**, and then select **Windows PowerShell ISE**.

2.  At the command prompt, enter the following command, and then select Enter:

   ```
Fsutil file createnew bigfile 104857600
   ```

3.  At the command prompt, enter the following command, and then select Enter:

   ```
Copy bigfile \\LON-dc1\c$
   ```

4.  At the command prompt, enter the following command, and then select Enter:

   ```
Copy \\LON-dc1\c$\bigfile bigfile2
   ```

5.  At the command prompt, enter the following command, and then select Enter:

   ```
Del bigfile*.*
   ```

6.  At the command prompt, enter the following command, and then select Enter:

   ```
Del \\LON-dc1\c$\bigfile*.*
   ```

7.  Close the **Windows PowerShell ISE** window.

### Task 3: Analyze the collected data

1.  Switch to **Performance Monitor**.

2.  In the navigation pane, right-click or access the context menu for **LON-SVR1 Performance**, and then select **Stop**.

3.  In Performance Monitor, in the **navigation** pane, expand **Reports**, expand **User Defined**, expand **LON-SVR1 Performance**, and then select **LON-SVR1_DateTime-000001**.

4.  On the toolbar, on the **Change graph type** icon, select the drop-down arrow, select **Report**, and then review the report data.

5.  Record the values that the report lists for later analysis. Recorded values include:

   - **Memory, Pages/sec**: @lab.TextBox(memory)

   - **Network Interface, Bytes Total/sec**: @lab.TextBox(network)

   - **PhysicalDisk, % Disk Time**: @lab.TextBox(Disktime)

   - **PhysicalDisk, Avg. Disk Queue Length**: @lab.TextBox(DiskLength)

   - **Processor, % Processor Time**: @lab.TextBox(Processortime)

   - **System, Processor Queue Length**: @lab.TextBox(ProcessorLength)

### Results

After this exercise, you'll have established a baseline for performance-comparison purposes.

## Exercise 2: Identify the source of a performance problem

### Scenario

In this exercise, you simulate a load to represent the live system so you can gather performance data by using your data collector set, and then determine the potential cause of the performance problem.

The main tasks for this exercise are:

1. Capture performance data by using a data collector set.
2. Create additional workload on the server.
3. Remove the workload, and then review the performance data.

### Task 1: Capture performance data by using a data collector set

1.  On **LON-SVR1**, switch to **Performance Monitor**.

2.  In Performance Monitor, go to **Data Collector Sets\User Defined**, and then in the **results** pane, start the **LON-SVR1 Performance** data collector set.

### Task 2: Create additional workload on the server

1.  On **LON-SVR1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  In Windows PowerShell ISE, select the **Open** button, and then open the following script:

   ```
E:\Labfiles\Mod11\StressTest.ps1
   ```

3.  In Windows PowerShell ISE, select the **Run Script (F5)** button.

4.  Wait until the script has finished running, and then close Windows PowerShell ISE.

### Task 3: Remove the workload, and then review the performance data

1.  Switch to **Performance Monitor**.

2.  In the **navigation** pane, right-click or access the context menu for **LON-SVR1 Performance**, and then select **Stop**.

3.  In Performance Monitor, in the **navigation** pane, expand **Reports**, expand **User Defined**, expand **LON-SVR1 Performance**, and then select **LON-SVR1_DateTime-000002**.

4.  On the toolbar, on the **Change graph type** icon, select the drop-down arrow, select **Report**, and then review the report data.

5.  Record the following values: 


   - **Memory, Pages/sec**: @lab.TextBox(memory2)

   - **Network Interface, Bytes Total/sec**: @lab.TextBox(network2)

   - **PhysicalDisk, % Disk Time**: @lab.TextBox(Disktime2)

   - **PhysicalDisk, Avg. Disk Queue Length**: @lab.TextBox(DiskLength2)

   - **Processor, % Processor Time**: @lab.TextBox(Processortime2)

   - **System, Processor Queue Length**: @lab.TextBox(ProcessorLength2)

   > **Question:** Compared with your previous report, which values have changed?
   >
   ><details>
<summary>**Answer**</summary>
   > **Answer:** Memory and disk activity are lower, but processor activity has increased significantly.
</details>

   > **Question:** What would you recommend?
   >
   ><details>
<summary>**Answer**</summary>
   > **Answer:** You should continue to monitor the server to ensure that the processor workload doesn't reach capacity.
</details>

6.  Close **Performance Monitor**.

### Results

After this exercise, you'll have used performance tools to identify a potential performance bottleneck.

## Exercise 3: Review and configure centralized event logs

### Scenario

In this exercise, you use **LON-CL1** to collect event logs from **LON-DC1**. Specifically, you'll use this process to gather performance-related alerts from your network servers.

The main tasks for this exercise are:

1. Configure subscription prerequisites.
2. Create a subscription.
3. Configure a performance counter alert.
4. Introduce additional workload on the server.
5. Verify the results.

### Task 1: Configure subscription prerequisites

1.  Sign in to **LON-DC1** as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

>**Server Manager** starts automatically.

2.  Select **Start**, enter **Cmd**, and then select Enter.

>The **Administrator: Command Prompt** window opens.

3.  At the command prompt, enter the following command, and then select Enter:

   ```
winrm quickconfig
   ```

4.  If prompted, enter **`Y`**, and then select Enter.

5.  In Server Manager, select **Tools**, and then select **Active Directory Users and Computers**.

6.  In the **Active Directory Users and Computers** console, in the **navigation** pane, expand **Contoso.com**, and then select **Builtin**.

7.  In the **results** pane, right-click or access the context menu for **Administrators**, and then select **Properties**.

8.  In the **Administrators Properties** dialog box, select the **Members** tab.

9.  Select **Add**, and then in the **Select Users**, **Contacts**, **Computers**, **Service Accounts, or Groups** dialog box, select **Object Types**.

10.  In the **Object Types** dialog box, select the **Computers** checkbox, and then select **OK**.

11.  In the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box, in the **Enter the object names to select** box, enter **LON-CL1**, and then select **OK**.

12.  In the **Administrators Properties** dialog box, select **OK**.

13.  Switch to **LON-CL1** and sign in as **Contoso\\Administrator** with the password **`Pa55w.rd`**.

14.  Select **Start**, enter **Cmd**, and then select Enter.

15.  At the command prompt, enter the following command, and then select Enter:

    ```
Wecutil qc
    ```

16.  When prompted, enter **`Y`**, and then select Enter.

### Task 2: Create a subscription

1.  On **LON-CL1**, select **Start**, and then enter **Event Viewer**.

2.  In the results, select **Event Viewer**.

>**Event Viewer** opens.

3.  In **Event Viewer**, in the **navigation** pane, select **Subscriptions**.

4.  Right-click or access the context menu for **Subscriptions**, and then select **Create Subscription**.

5.  In the **Subscription Properties** dialog box, in the **Subscription** **name** text box, enter **`LON-DC1 Events`**.

6.  Select **Collector initiated**, and then select **Select Computers**.

7.  In the **Computers** dialog box, select **Add Domain Computers**.

8.  In the **Select Computer** dialog box, in the **Enter the object name to select** text box, enter **`LON-DC1`**, and then select **OK**.

9.  In the **Computers** dialog box, select **OK**.

10.  In the **Subscription Properties – LON-DC1** **Events** dialog box, select **Select Events**.

11.  In the **Query Filter** dialog box, in the **Logged** drop-down list, select **Last** **7 days**.

12.  Select the **Critical**, **Warning**, **Information**, **Verbose**, and **Error** checkboxes.

13.  In the **Event logs** drop-down list, expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand **Diagnosis-PLA**, and then select the **Operational** checkbox.

14.  Switch to the **Query Filter** dialog box, and then select **OK**.

15.  In the **Subscription Properties – LON-DC1** **Events** dialog box, select **OK**.

### Task 3: Configure a performance counter alert

1.  Switch to the **LON-DC1** computer.

2.  Open **Performance Monitor**.

3.  In **Performance Monitor**, in the **navigation** pane, expand **Data Collector Sets**, and then select **User Defined**. 

4.  Right-click or access the context menu for **User** **Defined**, point to **New**, and then select **Data** **Collector** **Set**.

5.  In the **Create new Data Collector** **Set** wizard, in the **Name** text box, enter **`LON-DC1 Alert`**. 

6.  Select **Create manually (Advanced)**, and then select **Next**.

7.  On the **What type of data do you want to include?** page, select **Performance Counter Alert**, and then select **Next**.

8.  On the **Which performance counters would you like to monitor?** page, select **Add**.

9.  In the **Available counters** list, expand **Processor**, select **% Processor Time**, select **Add >>**, and then select **OK**.

10.  On the **Which performance counters would you like to monitor?** page, in the **Alert** **when** list, select **Above**.

11.  In the **Limit** text box, enter **10**, and then select **Next**.

12.  On the **Create the data collector set?** page, select **Finish**.

13.  In the **navigation** pane, expand the **User Defined** node, and then select **LON-DC1 Alert**.

14.  In the **results** pane, right-click or access the context menu for **DataCollector01**, and then select **Properties**.

15.  In the **DataCollector01 Properties** dialog box, in the **Sample interval** text box, enter **1**, and then select the **Alert Action** tab.

16.  Select the **Log an entry in the application** **event log** checkbox, and then select **OK**.

17.  In the **navigation** pane, right-click or access the context menu for **LON-DC1 Alert**, and then select **Start**.

### Task 4: Introduce additional workload on the server

1.  On **LON-DC1**, select **Start**, and then select **Windows PowerShell ISE**.

2.  In Windows PowerShell Integrated Scripting Environment (ISE), select the **Open** button, and then open the following script:

   ```
E:\Labfiles\Mod11\StressTest.ps1
   ```

3.  In Windows PowerShell ISE, select the **Run Script (F5)** button.

4.  Wait until the script has finished running.

5.  Close Windows PowerShell ISE.

### Task 5: Verify the results

1.  Switch to **LON-CL1**.

2.  In **Event Viewer**, in the navigation pane, expand **Windows Logs**.

3.  Select **Forwarded Events**. 

   > **Question:** Are there any performance-related alerts?
   
   ><details>
<summary>**Answer**</summary>
   > **Answer:** Answers might vary, but there should be some events that relate to the workload imposed on **LON-DC1**. Events will have an ID of **2031**. It might take 10-15 minutes for events to display. Be sure to refresh the page to review the latest events.
</details>

### Results

At the end of this exercise, you'll have successfully centralized event logs and examined these logs for performance-related events.
