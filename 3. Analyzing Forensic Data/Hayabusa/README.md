# Hayabusa

**Hayabusa** is an open-source tool developed by Yamato Security that helps analyze Windows Event Logs. It was created to make detecting malicious activity or attacks easier by processing and searching through these logs for signs of suspicious behavior.

One of the key features of Hayabusa is its use of Sigma rules, which are community-driven, generic detection rules for logs. Sigma provides a framework to define detection logic in a simple, readable format, which can then be applied across various log sources, including Windows Event Logs. Hayabusa translates these Sigma rules into queries that can search through the parsed event logs for patterns that match known attack techniques.


---

## How to start?

1. Start by extracting the ZIP file from the machine where you collected the forensic data.

![image](https://github.com/user-attachments/assets/c2df754d-9076-45eb-8335-7c8d7ff28c6e)

2. Run the following command to scan the evtx files with Hayabusa:

```
hayabusa-2.17.0-win-x64.exe csv-timeline -d C:\Users\Admin\Desktop\DC\C\Windows\System32\winevt\Logs -o DC.csv
```

![image](https://github.com/user-attachments/assets/d0313e12-e7d0-4fa1-9c4b-fa6680cd2a6e)

3. You'll now be prompted to choose an option in the scan wizard. I recommend selecting option **5**, which includes all event and alert rules.

![image](https://github.com/user-attachments/assets/ba9c0ed3-440b-41b5-814c-27c7c1c53f7f)

4. Next, you'll be prompted to choose a set of detection rules to load, which may include deprecated, unsupported, or noisy rules, among others. Here’s what I selected in this example:

![image](https://github.com/user-attachments/assets/2cd1c64d-49ab-42d0-ac49-010c74dcec43)

5. When the scan finishes, you’ll see a summary of all triggered detections, each marked with a severity level: high, medium, low or informational.

![image](https://github.com/user-attachments/assets/e837a44b-a4e7-489e-b584-3d2065f535ac)

6. Now, we can use Eric Zimmerman’s Timeline Explorer to load the .CSV output from Hayabusa and analyze the raw data.

![image](https://github.com/user-attachments/assets/0cd6f5c7-ab5b-40dd-836e-361319392772)

7. You can also load the .CSV file into Azure Data Explorer (ADX), where Microsoft provides a free 100 GB cluster. This lets you run Kusto queries to analyze the data.

![image](https://github.com/user-attachments/assets/fcd6ae7d-5310-4ba9-af7a-71f82e4ab555)

