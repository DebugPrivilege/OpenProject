# Browser History

Browser history logs track the websites and web pages a user visits, along with details like URLs, timestamps, and sometimes additional metadata. In DFIR, these logs can be valuable for tracing user activity, identifying malicious websites, building timelines, and detecting potential data exfiltration attempts. The location of where these browser history logs are stored is the following:

- **Google Chrome**:
```
C:\Users\{Username}\AppData\Local\Google\Chrome\User Data\Default\History
```
- **Microsoft Edge**:
```
C:\Users\{Username}\AppData\Local\Microsoft\Edge\User Data\Default\History
```
- **Mozilla Firefox**:
```
C:\Users\{Username}\AppData\Roaming\Mozilla\Firefox\Profiles\{ProfileFolder}\places.sqlite
```

## How to start?

We can use SQL Lite Browser to parse the browser history logs. SQLite Browser (also known as DB Browser for SQLite) is a free, open-source tool used to interact with SQLite databases. It provides an easy-to-use interface for viewing, editing, and querying SQLite databases without needing to know SQL commands in detail.

1. In my example, the Edge browser history logs happens to be stored at the following location:
```
C:\Users\Admin\Desktop\CyLR_win-x64\DESKTOP-9FOGEDE\C\Users\Admin\AppData\Local\Microsoft\Edge\User Data\Default
```

![image](https://github.com/user-attachments/assets/ae10a1ed-beb0-4a2c-a75a-894e31f643e9)




