# Summary

A crash dump of a process is a file that captures the state of a program at the moment it crashes or encounters a serious error. This file includes detailed information such as the memory in use, active threads, registers, and call stacks, which can help developers or analysts understand what went wrong.

Sometimes malware crashes during execution, leaving behind a crash dump. These dumps capture memory and other details at the moment of the crash, which can be valuable for investigations. By scanning crash dumps with YARA, you can identify patterns or indicators of malware.

## How to start?

In an investigation of a Windows Server 2022 machine, two folders were found to contain process crash dumps by default, without any specific registry settings configured. These folders were located at:

```
C:\Users\<UserName>\AppData\Local\CrashDumps
```

![image](https://github.com/user-attachments/assets/d6ab6899-71ee-4dec-bdf8-66427c0c984f)

```
C:\Windows\System32\config\systemprofile\AppData\Local\CrashDumps
```

![image](https://github.com/user-attachments/assets/88ffbb79-fa1c-4733-9769-57a66841713d)

1. Run the following LOKI command:

```
loki.exe -p C:\Users\Admin\Desktop\CrashDumps --noprocscan
```

LOKI flagged a memory dump as Cobalt Strike:

![image](https://github.com/user-attachments/assets/64b9115b-a597-4f70-90eb-a6842b7a67b7)
