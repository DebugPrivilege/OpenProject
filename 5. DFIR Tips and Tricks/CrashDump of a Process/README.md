# Summary

A crash dump of a process is a file that captures the state of a program at the moment it crashes or encounters a serious error. This file includes detailed information such as the memory in use, active threads, registers, and call stacks, which can help developers or analysts understand what went wrong.

Sometimes malware crashes during execution, leaving behind a crash dump. These dumps capture memory and other details at the moment of the crash, which can be valuable for investigations. By scanning crash dumps with YARA, you can identify patterns or indicators of malware.

## How to start?

In an investigation of a Windows Server 2022 machine, two folders were found to contain process crash dumps by default, without any specific registry settings configured. These folders were located at:

```
C:\Users\<UserName>\AppData\Local\CrashDumps
```

```
C:\Windows\System32\config\systemprofile\AppData\Local\CrashDumps
```


