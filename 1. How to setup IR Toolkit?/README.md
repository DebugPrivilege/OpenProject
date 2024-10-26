# How to Set Up an IR Toolkit

This guide explains how to set up a virtual environment for your Incident Response (IR) toolkit using Hyper-V Manager and download the tools you’ll need for your investigations.

---

## Step 1: Setting Up a Virtual Machine in Hyper-V Manager

### Prerequisites

- **Hyper-V Enabled**: Hyper-V needs to be enabled on your Windows system. You can enable it by going to:
  - **Control Panel** > **Programs** > **Turn Windows features on or off** > Check **Hyper-V** and **Virtual Machine Platform**.

### Creating a New Virtual Machine

1. **Open Hyper-V Manager**:
   - Press `Win + X` > Select **Hyper-V Manager**.

2. **Create a New Virtual Machine**:
   - In the **Actions** panel, select **New** > **Quick Create** > **Windows 10 MSIX packaging environment**.
  
![image](https://github.com/user-attachments/assets/79c578a2-ed1c-40ac-88a8-76607698ee60)


3. **Configure the VM Settings**:
   - **Name**: Give your VM a descriptive name (e.g., `IR-Toolkit-VM`).
   - **Generation**: Choose **Generation 1** for broad compatibility unless you need advanced features from **Generation 2**.
   - **Assign Memory**: Allocate at least **4 GB** of RAM for basic tasks.
   - **Configure Networking**: Select a network adapter if you need internet connectivity; otherwise, leave it disconnected for a secure, isolated environment.

4. **Configure Post-Installation Settings**:
   - Adjust **CPU and RAM** allocations based on your system’s resources and IR requirements.

---

## Step 2: Downloading and Installing Necessary Tools

Once your VM is set up, you’ll want to install the core tools for your IR toolkit. Here’s a list of recommended tools and how to get them:

### Tool Installation Guide

1. **Forensics Tools**:
   - **CyLR**: https://github.com/orlikoski/CyLR/releases/tag/2.2.0

2. **Log Analysis**:
   - **LogParser**: https://www.microsoft.com/en-us/download/details.aspx?id=24659
   - **Eric Zimmerman tools**: https://ericzimmerman.github.io/#!index.md
   - **Hayabusa**: https://github.com/Yamato-Security/hayabusa/releases
     
3. **Malware Triage**:
   - **PE Studio**: https://www.winitor.com/download
   - **YARA**: https://github.com/virustotal/yara/releases
   - **Capa**: https://github.com/mandiant/capa/releases
   - **SysInternals:** https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite
   - **Loki YARA Scanner**: https://github.com/Neo23x0/Loki/releases
   - **Cobalt Strike Config Extractor**: https://blog.didierstevens.com/programs/cobalt-strike-tools/

4. **Others**
   - **Python for Windows**: https://www.python.org/downloads/windows - Make sure to select "Add python.exe to PATH"
   - **SQL Lite Browser**: https://sqlitebrowser.org/dl/
   - **TOR Browser**: https://www.torproject.org/download/
   - **MemProcFS**: https://github.com/ufrisk/MemProcFS/releases/

This VM is now ready to serve as your IR toolkit environment. Please make sure to create a snapshot of your VM once everything has been configured and installed.

