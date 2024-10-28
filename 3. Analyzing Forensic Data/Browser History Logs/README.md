# Browser History

Browser history logs track the websites and web pages a user visits, along with details like URLs, timestamps, and sometimes additional metadata. In DFIR, these logs can be highly valuable for tracing user activity, identifying malicious websites, building timelines, and detecting potential data exfiltration attempts. The location of where these browser history logs are stored is the following:

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
