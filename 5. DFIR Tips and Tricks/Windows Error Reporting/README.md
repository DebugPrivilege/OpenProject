# Windows Error Reporting (WER)

Windows Error Reporting (WER) logs application crashes and system errors in `.wer` files, which captures information like crash timestamps, application paths, and a **SHA1** hash that uniquely identifies the crashed application. In DFIR, this **SHA1** hash can be useful because it helps analysts quickly identify specific applications or potentially malicious files.

@svch0st posted a Twitter thread on the value of `.wer` files in DFIR, which can be found here: https://x.com/svch0st/status/1550720565480247296. This write-up isn’t about reinventing the wheel, but it’s demonstrating a PowerShell script to help parse `.wer` files and gather essential information that we then can use to analyze further.

## How to parse WER files?

1. When working with a disk image, VHD(X), or similar, the `WERParser.ps1` script can quickly extract valuable information from all `Report.wer` files. Running the script without any parameters will default to scanning the local machine in the directories `C:\ProgramData\Microsoft\Windows\WER\ReportArchive` and `C:\ProgramData\Microsoft\Windows\WER\ReportQueue`

Run the following command as an administrator:
```
.\WERParser.ps1
```

The `AppPath` can be quite lengthy, which limits the visibility of other columns in the console output.

![image](https://github.com/user-attachments/assets/603e2da5-7ea7-42e8-ba66-50f3b53acabb)

2. By using the `-OutputCsv` option, we can specify a file path to save the output in a CSV file that includes all columns.

```
.\WERParser.ps1 -OutputCsv C:\Temp\Output.csv
```

![image](https://github.com/user-attachments/assets/e9d70407-659c-4f67-8003-b78754dbf074)

3. Now, you can use Eric Zimmerman’s Timeline Explorer to load the .CSV output and analyze the raw data.

![image](https://github.com/user-attachments/assets/a4b1f4c9-f351-4ff0-90bb-2e9f174a3b5f)
