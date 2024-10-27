# CyLR

CyLR is a forensic tool built to quickly and securely gather key artifacts from NTFS systems with minimal impact. It collects important data without relying on the Windows API, which makes the process fast and discreet. You can customize what’s collected, even targeting specific types of files like those in use, hidden, or system files, including alternate data streams. The collected data is stored in a ZIP file, with options to adjust compression, set a password, and send it to an SFTP location if needed.

---

## Compatibility

CyLR is based on .NET Core and runs smoothly on Windows, Linux, and macOS, with standalone versions for each platform available from version 2.0 onward.

## How to run this tool?

1. Run the following command as an Administrator:

```
CyLR.exe --usnjrnl
```

The *--usnjrnl* option ensures that USN Journal artifacts are included in the collection. Without this option, USN Journal data will not be collected.

![image](https://github.com/user-attachments/assets/cc524d02-01a1-430d-a314-38e999164a0e)

2. After collecting all the data, CyLR generates a ZIP file in the same directory where CyLR.exe was run, with the computer name included in the file name by default. This ZIP file should then be shared with the incident response team for further analysis.

![image](https://github.com/user-attachments/assets/d071c488-4316-44c3-b679-18b522947e87)

## Forensic Metadata/Artifacts Collected by CyLR

```
|------------------------|------------------------|
| Windows Event Logs     | NTFS Update Sequence Number Journal ($UsnJrnl:$J) |
| Windows Prefetch Files | Scheduled Tasks        |
| Windows Shortcut Files (.LNK, Jumplists, etc.) | AmCache              |
| Web Browser History    | ShimCache (AppCompatCache) |
| PowerShell Console History | Iconcache Database   |
| NTFS Master File Table ($MFT) | Activitiescache Database |
```



