# ShimCache

ShimCache, also known as the AppCompatCache, is a feature of Windows that records information about executables that have been accessed on a system. It logs details such as the file path, size, and last modification time but does not track actual execution or timestamp of execution. Its primary purpose is to ensure compatibility of applications when Windows updates are applied. 

ShimCache is useful for determining whether a file was present on the system, even if it was deleted or not executed. However, like AmCache, it cannot confirm program execution definitively.

## How to start?

1. Use AppCompatCacheParser.exe to parse the SYSTEM Hive file into a CSV format, which can then be loaded into tools like Timeline Explorer. To do this, run the following command:

```
AppCompatCacheParser.exe -f "C:\Users\Admin\Desktop\DC\C\Windows\System32\config\SYSTEM" --csv C:\Temp
```

![image](https://github.com/user-attachments/assets/5e479490-19cd-4a1a-a669-ec1b671c815c)


2. Now, you can use Eric Zimmerman’s Timeline Explorer to load the .CSV output and analyze the raw data.

![image](https://github.com/user-attachments/assets/b0e72215-9cae-45b8-83a4-989ea089633e)

3. You can also load the .CSV file into Azure Data Explorer (ADX), where Microsoft provides a free 100 GB cluster. This lets you run Kusto queries to analyze the data.

![image](https://github.com/user-attachments/assets/c5c2cadb-7320-4469-a150-c5be9522f415)

## Good thing to know

The AppCompatCache, or ShimCache, doesn't have a direct *"execution"* flag to confirm if a file was actually run on the system. In earlier Windows versions, there wasn’t a reliable way to tell if a file had been executed based on ShimCache alone. Windows 10 improved this by adding a flag that gives a better indication of execution, though it's not foolproof. Forensic analysts still need to check other sources, like Prefetch files or event logs, to be certain a file was executed.

In ShimCache, the *"LastModifiedTime"* refers to when the file’s contents were last changed, not when it was executed or accessed. This timestamp shows the last time the file itself was modified, and it’s recorded when the file is added to the cache. However, it can be misleading, as it reflects the file’s modification time rather than the actual time it was opened or run by the system or user.

