# USN Journal


The USN (Update Sequence Number) Journal is an NTFS feature that logs file and directory changes on a volume, such as creations, deletions, modifications, and renames. Stored in a hidden file called **$UsnJrnl** within the **$Extend** directory, it tracks changes as they occur.

![image](https://github.com/user-attachments/assets/7925345c-f2ad-46b5-bd36-d1a7823bfa70)

## How to start?

1. Use MFTECmd.exe to parse the $UsnJrnl file into a CSV format, which can then be loaded into tools like Timeline Explorer. To do this, run the following command:

```
MFTECmd.exe -f "C:\Users\Admin\Desktop\DC\C\$MFT" --csv C:\Temp
```

![image](https://github.com/user-attachments/assets/3e364d88-4b6b-4f33-ba56-145d4b7e7378)

2. Now, you can use Eric Zimmerman’s Timeline Explorer to load the .CSV output and analyze the raw data.

![image](https://github.com/user-attachments/assets/d9dcfa30-32aa-4688-907a-82a05d895e0d)

3. You can also load the .CSV file into Azure Data Explorer (ADX), where Microsoft provides a free 100 GB cluster. This lets you run Kusto queries to analyze the data.

![image](https://github.com/user-attachments/assets/24e3fa68-5bf7-44b7-b068-d1d1ee0c5d56)



