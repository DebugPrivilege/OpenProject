# Master File Table (MFT)

The Master File Table (MFT) is a core component of the NTFS file system, which keeps track of all files and directories on a drive, including metadata such as file names, timestamps, and file sizes. In DFIR, analyzing the MFT helps investigators trace file activity and determine when files were created, modified, or accessed. This can provide valuable evidence during an investigation.

## How to start?

1. Use MFTECmd.exe to parse the MFT file into a CSV format, which can then be loaded into tools like Timeline Explorer. To do this, run the following command:

```
MFTECmd.exe -f "C:\Users\Admin\Desktop\DC\C\$MFT" --csv C:\Temp\DFIR
```

![image](https://github.com/user-attachments/assets/1005bb0b-7cb9-48e9-becb-3e1b7a73d408)

2. Now, you can use Eric Zimmerman’s Timeline Explorer to load the .CSV output and analyze the raw data.

![image](https://github.com/user-attachments/assets/721a053a-4e56-4d90-b8b6-5e7dc27c807f)



