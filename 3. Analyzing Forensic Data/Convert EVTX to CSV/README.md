# EVTX


EVTX files are Windows event log files that store records of system, application, and security events on the computer. They’re used by the Windows Event Viewer to display details about things like hardware changes, software activity, and login attempts. EVTX files are saved in **C:\Windows\System32\winevt\Logs** by default, and they’re useful for tracking what’s happening on a system whether for troubleshooting issues or investigating security events.

## How to start?

1. Use EvtxECmd.exe to parse the EVTX files into a CSV format, which can then be loaded into tools like Timeline Explorer. To do this, run the following command:

```
EvtxECmd.exe -f C:\Users\Admin\Desktop\DC\C\Windows\System32\winevt\Logs\Security.evtx --csv C:\Temp\DFIR
```

![image](https://github.com/user-attachments/assets/25061fe7-a6d6-4e40-96ad-5bd2036fa703)

2. Now, you can use Eric Zimmerman’s Timeline Explorer to load the .CSV output and analyze the raw data.

![image](https://github.com/user-attachments/assets/62d5edc0-068e-4745-86ba-68bca7c14042)

3. You can also load the .CSV file into Azure Data Explorer (ADX), where Microsoft provides a free 100 GB cluster. This lets you run Kusto queries to analyze the data. For EVTX files, this is typically recommended and it's much more efficient than searching in Timeline Explorer.

