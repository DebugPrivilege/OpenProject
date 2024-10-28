# Prefetch

Prefetch is a Windows feature that optimizes the performance of frequently accessed applications by preloading portions of their files into memory. It stores information about the last 8 executions of an executable, including timestamps and file paths. These Prefetch files (.pf) are located in the **C:\Windows\Prefetch** directory and are created when a program is run.

## How to start?

1. Use PECmd.exe to parse the .PF file into a readable format, which can then be further examined. To do this, run the following command:

```
PECmd.exe -f "C:\Windows\Prefetch\LBB.EXE-368666EF.pf"
```

The information shows the last time the binary was executed.

![image](https://github.com/user-attachments/assets/644e5908-4e5f-4625-b18d-d4779e2b9eb4)

2. As you can see, LockBit 3.0 (LBB) was actively encrypting multiple files, clearly visible in the provided data.

![image](https://github.com/user-attachments/assets/1f9be41a-7bef-4aff-b024-2944c838ead6)

3. All folders where the ransomware is generating its ransom note

![image](https://github.com/user-attachments/assets/8afdb7c4-38a6-4f08-abdd-fbb3aa9b62cb)


