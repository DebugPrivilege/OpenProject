# CyLR

CyLR is a forensic tool built to quickly and securely gather key artifacts from NTFS systems with minimal impact. It collects important data without relying on the Windows API, which makes the process fast and discreet. You can customize what’s collected, even targeting specific types of files like those in use, hidden, or system files, including alternate data streams. The collected data is stored in a ZIP file, with options to adjust compression, set a password, and send it to an SFTP location if needed.

---

## Key Features

CyLR is based on .NET Core and runs smoothly on Windows, Linux, and macOS, with standalone versions for each platform available from version 2.0 onward.

## How to run this tool?

1. Run the following command as an Administrator:

```
CyLR.exe --usnjrnl
```

The *--usnjrnl* option ensures that USN Journal artifacts are included in the collection. Without this option, USN Journal data will not be collected.

![image](https://github.com/user-attachments/assets/cc524d02-01a1-430d-a314-38e999164a0e)






