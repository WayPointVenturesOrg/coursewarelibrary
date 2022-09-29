---
lab:
    title: 'Lab: Migrate server workloads'
    module: 'Module 12: Upgrade and migration in Windows Server'
---

# Lab: Migrate server workloads

## Scenario

Contoso, Ltd. is an engineering, manufacturing, and distribution company that's based in London and that has major offices in Toronto and Sydney, Australia. Having been in business many years, Contoso's existing servers are running many versions of Windows Server. Therefore, you're planning to migrate those services to servers that are running Windows Server 2022.

## Objectives

After completing this lab, you'll be able to:

- Select a process to migrate server workloads.
- Plan how to migrate files with Storage Migration Service.

## Estimated time: 20 minutes

## Lab setup

This lab doesn't require virtual machines (VMs).

## Exercise 1: Select a process to migrate server workloads

### Scenario

Contoso has an Active Directory Domain Services (AD DS) forest with a single Active Directory domain named `contoso.com`. The domain controllers (DCs) for the domain are running a mix of Windows Server 2012 R2 and Windows Server 2016. Many applications are installed in the domain, which means that standardizing on Windows Server 2022 for all DCs is the best option for you.

Contoso has purchased Trey Research, a specialized engineering company that has its own AD DS forest connected by a forest trust. Much of Trey's infrastructure is based upon legacy technology, so you must standardize tools and management systems across the two companies.

There are other server workloads on servers running earlier Windows Server versions, such as the Toronto location, which has Dynamic Host Configuration Protocol (DHCP) on a server running Windows Server 2012 R2. You want to migrate as many of these server workloads as possible to Windows Server 2022.

The main tasks for this exercise are to:

1. Study the scenario.
1. Plan how to update domains controllers to Windows Server 2022.
1. Plan migration of other server workloads.

### Task 1: Study the scenario

1. Study the lab scenario.
1. Study the exercise scenario.

### Task 2: Plan how to update DCs to Windows Server 2019

Answer the following questions based on the scenario:

1. To implement DCs running Windows Server 2022, should you upgrade the existing AD DS forest or migrate to a new AD DS forest?

    > **Answer:** It's rare to migrate to a new AD DS forest. If your main goal is to update DCs to a new Windows Server version, you should update AD DS in the existing server by adding DCs that are running Windows Server 2022. You should only consider migrating to a new AD DS forest when restructuring of domains or forests is required. For example, when two companies merge, you might merge one company's AD DS forest into the other's forest.

1. What are the highest domain and forest functional levels that you can implement?

    > **Answer:** The highest domain and forest functional levels that you can implement are Windows Server 2016. There's no Windows Server 2019 or Windows Server 2022 functional level.

1. Which DC operating systems can you use to implement the highest possible domain and forest functional levels?

    > **Answer:** You can use DCs running Windows Server 2016, Windows Server 2019, or Windows Server 2022 in a domain or forest at the Windows Server 2016 functional level.

1. What steps do you need to take before adding DCs running Windows Server 2022 to an existing AD DS forest?

    > **Answer:** If you have the correct permissions, you don't need to perform any steps before you install the first DC that's running Windows Server 2022. The DC promotion process automatically prepares the forest and domain. However, you do have the option to prepare the domain and forest manually. Prepare the AD DS forest by running `Adprep /forestprep`, and then prepare the domain by running `Adprep /domainprep`. In a multidomain environment, you must prepare each domain.

1. What do you need to consider when removing DCs running previous Windows Server versions?

   > **Answer:** For normal domain authentication, DCs are located by using Domain Name System (DNS) records that automatically update when DCs are added or removed. Therefore, basic authentication doesn't require any special steps when removing a DC, but because they're often used for DNS, you must ensure that clients and servers are updated to use the IP addresses of the new DCs. Additionally, some apps are configured to use specific DCs as Lightweight Directory Access Protocol (LDAP) servers for authentication. You must reconfigure those apps with the IP address or name of new DCs.

### Task 3: Plan migration of other server workloads

Answer the following questions based on the scenario:

1. What steps do you need to perform before running the Windows PowerShell cmdlets in the Windows Server Migration Tools on Windows Server 2022.

   > **Answer:** To use the Windows Server Migration Tools on Windows Server 2022, you must install the Windows Server Migration Tools feature. Then, before you can use the cmdlets, you must load the Windows PowerShell snap-in that contains the cmdlets by running `Add-PSSnapin Microsoft. Windows.Windows.ServerManager.Migration` at a Windows PowerShell prompt.

1. What steps do you need to perform on a source server that's running Windows Server 2012 R2 before you can use the Windows PowerShell cmdlets in the Windows Server Migration Tools?

   > **Answer:** To install the Windows Server Migration Tools on a down-level server, you need to run `SmigDeploy.exe` to create a deployment folder for that specific operating system. The deployment folder copies to the source server and installs by running `SmigDeploy.exe` from the deployment folder, and you then can load the snap-in for the Windows Server Migration Tools at a Windows PowerShell prompt on the source server.

1. Which cmdlet can you use to verify which features you can migrate from a source server?

   > **Answer:** The `Get-SmigServerFeature` cmdlet lists the Windows features that you can migrate from either a local computer or a migration stored. [[Conan: Do we mean "migration store" here?]]

1. List the high-level steps for using the Windows Server Migration Tools to migrate settings from a source server to a destination server.

   > **Answer:** To migrate feature configuration from a source server to a destination server, you first install the feature on the target server, and you then run `Export-SmigServerSetting` on the source server and `Import-SmigServerSetting` on the destination server.

## Exercise 2: Plan how to migrate files by using Storage Migration Service

### Scenario

Contoso has file servers running multiple Windows Server versions, with the oldest file server running Windows Server 2008 R2. There are also a few Linux servers that Contoso developers are using for file storage. Some of the Linux servers are using Samba, but others are using Network File System (NFS). A new policy is being implemented that requires all file servers be migrated to Windows Server 2022.

The main tasks for this exercise are to:

1. Study the scenario.
1. Plan the migration of file servers.
1. Plan how to use Storage Migration Service.

### Task 1: Study the scenario

1. Study the lab scenario.
1. Study the exercise scenario.

### Task 2: Plan the migration of file servers

Answer the following questions based on the scenario:

1. Can you use Storage Migration Service to migrate files shares from Windows Server 2008 R2 to Windows Server 2022?

   > **Answer:** Yes, Storage Migration Service supports migrating file shares from Windows Server 2003 or newer Windows Server versions.

1. Can you use Storage Migration Service to migrate files on Linux servers?

   > **Answer:** Yes, if the source Linux servers are providing file shares accessible to Windows clients by using Samba. Storage Migration Service can't migrate files on Linux servers using only NFS.

1. Can you use Storage Migration Service to combine multiple file servers to a single new server?

   > **Answer:** No. Storage Migration Service doesn't have the ability to merge the identities of multiple servers onto a single server.

1. Can you use Storage Migration Service to migrate file shares to a VM in Azure?

    > **Answer:** Yes. Storage Migration Service can migrate file shares to a VM in Azure. If Azure is properly configured, Storage Migration Service can create the VM automatically, based on specifications that you provide.

### Task 3: Plan how to use Storage Migration Service

Answer the following questions based on the scenario:

1. What software do you need to install to use Storage Migration Service?

     > **Answer:** To use Storage Migration Service, you need to install the Storage Migration Service feature on the orchestrator server. On the destination server running Windows Server 2022, you also must install the Storage Migration Service Proxy feature. However, you don't need to install any software on the source server.

1. What firewall configuration do you need to implement to use Storage Migration Service?

     > **Answer:** The Storage Migration Service needs to copy data and configure the source and destination servers. When you install the Storage Migration Service Proxy on a destination server, the firewall is configured automatically, although you should verify its configuration. On the source and destination servers, you must enable the following firewall rules: File and Printer Sharing (SMB-In), Netlogon Service (NP-In), Windows Management Instrumentation (DCOM-In), and Windows Management Instrumentation (WMI-In). On the orchestrator server, you must enable the File and Printer Sharing (SMB-In) rule.

1. What accounts and permissions do you need to configure to use Storage Migration Service?

     > **Answer:** To perform the migrations, you can use a single account that has administrator permissions on the source server, the orchestrator server, and the destination server. Alternatively, you can split the accounts into a source migration account and a destination migration account. A source migration account needs to have administrator permissions on the source server and the orchestrator server, while a destination migration account needs to have administrator permissions in the destination server and the orchestrator server.

1. Which tool do you use to create and manage jobs?

     > **Answer:** You can create and manage Storage Migration Service jobs from Windows Admin Center in the Storage Migration Service node.

1. What is the relationship between volumes in the source server and the destination server?

     > **Answer:** A volume on the source server maps to a volume on the target server. If there are three source volumes, there must be three destination volumes. There's no logic for renaming folders with conflicting names.

1. After cutover, which identity information moves from the source server to the destination server?

     > **Answer:** The source server's name and IP addresses are moved to the destination server, and the source server is renamed and give a new IP address.

1. Which data won't be migrated from the source server to the destination server?

     > **Answer:** Storage Migration Service can't copy locked files, so if users have a file open during a copy attempt, the file won't migrate. Previous versions of files also aren't migrated.
