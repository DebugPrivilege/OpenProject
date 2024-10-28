# LNK Files

LNK files (also known as shortcut files) are small files with the .lnk extension in Windows that point to other files, folders, or applications. These files store information like the path to the target file, timestamps (when the target was created, accessed, or modified), and details about the system or drive where the target file resides. They get created automatically when users create a shortcut, and sometimes even by the system itself (e.g., in "Recent Items").

## How to start?

1. Use LECmd.exe to parse the .lnk file into a readable format, which can then be further examined. To do this, run the following command:

```
LECmd.exe -f C:\Users\xxxx\AppData\Roaming\Microsoft\Windows\Recent\Document1.lnk
```

![image](https://github.com/user-attachments/assets/4c882451-e695-4ec6-8071-8232463eeab4)
