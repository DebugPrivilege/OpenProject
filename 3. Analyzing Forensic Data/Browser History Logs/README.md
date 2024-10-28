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

2. Load the History file in SQL Lite Browser

![image](https://github.com/user-attachments/assets/612357fb-f04b-4efb-937a-a9b0f5960e44)

3. Click on ''urls'' and then Browse table

![image](https://github.com/user-attachments/assets/8d94deb6-c383-4368-bba2-152bdc0ed9c7)

4. We have now a list of URLs that were visited

![image](https://github.com/user-attachments/assets/d2d096bb-176e-4c2a-861e-05fa7fd20af0)

However, the last_visit_time column isn't properly formatted in UTC, which is commonly expected in DFIR investigations.

![image](https://github.com/user-attachments/assets/0d143ab0-fa0f-4388-8c73-3fc2566fc229)

5. Click on View and then Execute SQL and run the following SQL Lite query:

```
SELECT 
    url,
    title,
    visit_count,
    datetime((last_visit_time / 1000000) - 11644473600, 'unixepoch') AS last_visit_time_utc
FROM urls;
```

![image](https://github.com/user-attachments/assets/961c5f56-4c51-4c42-a221-fc1ee1ae3cf3)



