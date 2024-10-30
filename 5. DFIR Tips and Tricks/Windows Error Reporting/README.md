# Windows Error Reporting (WER)

Windows Error Reporting (WER) logs application crashes and system errors in `.wer` files, which captures information like crash timestamps, application paths, and a **SHA1** hash that uniquely identifies the crashed application. In DFIR, this **SHA1** hash can be useful because it helps analysts quickly identify specific applications or potentially malicious files.

@svch0st posted a Twitter thread on the value of .wer files in DFIR, which can be found here: https://x.com/svch0st/status/1550720565480247296. This write-up isn’t about reinventing the wheel, but it’s demonstrating a PowerShell script to help parse .wer files and gather essential information that we then can use to analyze further.
