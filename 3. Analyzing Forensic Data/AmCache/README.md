# AmCache

AmCache is a Windows registry hive file that records detailed metadata about executables, drivers, and installed applications on a system. It includes information like SHA1 hashes, file paths, installation dates, and publisher details. While it cannot confirm program execution (because of automated OS scans that log files for compatibility checks), it provides evidence of file presence. AmCache is useful in DFIR for timeline creation, threat hunting, and correlating hashes with known malicious files.

![image](https://github.com/user-attachments/assets/28004575-8850-4000-ae4d-5c2f44a6bd4a)

## How to start

1. Use AppCompatCacheParser.exe to parse the AmCache.hve file into a CSV format, which can then be loaded into tools like Timeline Explorer. To do this, run the following command:

```
AmcacheParser.exe -f "E:\Windows\AppCompat\Programs\Amcache.hve" --csv C:\Temp
```

![image](https://github.com/user-attachments/assets/a64856f0-5edb-480a-84bc-6dda61e4b252)

2. Now, you can use Eric Zimmerman’s Timeline Explorer to load the .CSV output and analyze the raw data.

![image](https://github.com/user-attachments/assets/b3df5b67-636a-4297-b7e3-0be1b6a1fff1)

3. You can also load the .CSV file into Azure Data Explorer (ADX), where Microsoft provides a free 100 GB cluster. This lets you run Kusto queries to analyze the data.

![image](https://github.com/user-attachments/assets/beb252aa-98d3-43e8-9c18-5b4aa9eee380)

A good thing to know is that the timestamp in the "File Key Last Write Timestamp" column of AmCache represents the last time that the entry for the file in question was modified, which is not necessarily when the file was executed.
