<#
.SYNOPSIS
This script scans Windows Error Reporting (WER) directories for application crash reports, extracts key details such as event timestamps, SHA1 hashes, application names, and paths, and optionally saves the output to a CSV file.

.DESCRIPTION
The script performs the following tasks:
1. Scans specified directories (or default WER directories if none specified) for WER crash reports.
2. Extracts relevant fields from each Report.wer file, including:
   - EventTime in UTC
   - SHA1 hash of the application
   - Application name
   - Application path (AppPath)
3. Outputs results to the console or saves them as a CSV file if an output path is provided.

.PARAMETER FilePath
Specifies a custom directory path to scan for Report.wer files. If not provided, the script defaults to the standard WER ReportArchive and ReportQueue directories.

.PARAMETER OutputCsv
Specifies a file path to save the output in CSV format. If not provided, the script outputs the results to the console.

.EXAMPLE
# Example 1: Scan default WER directories and display results in the console
.\WERParser.ps1

.EXAMPLE
# Example 2: Scan a specific directory and display results in the console
.\WERParser.ps1 -FilePath "C:\Custom\Path"

.EXAMPLE
# Example 3: Scan default WER directories and save results to a CSV file
.\WERParser.ps1 -OutputCsv "C:\Output\Results.csv"

.EXAMPLE
# Example 4: Scan a specific directory and save results to a CSV file
.\WERParser.ps1 -FilePath "C:\Custom\Path" -OutputCsv "C:\Output\Results.csv"

# Author: DebugPrivilege
# Required Dependencies: None
#>

param (
    [string]$FilePath,
    [string]$OutputCsv
)

# Define default paths if no FilePath parameter is provided
$reportDirectories = if ($FilePath) { @($FilePath) } else { 
    @("C:\ProgramData\Microsoft\Windows\WER\ReportArchive", "C:\ProgramData\Microsoft\Windows\WER\ReportQueue") 
}

# Function to convert FILETIME to UTC DateTime
function Convert-FileTimeToUTC {
    param (
        [string]$fileTime
    )
    # Convert FILETIME (100-nanosecond intervals) to .NET DateTime
    $dateTime = [DateTime]::FromFileTimeUtc([Int64]$fileTime)
    return $dateTime.ToString("yyyy-MM-dd HH:mm:ss 'UTC'")
}

# Function to extract and parse necessary fields from Report.wer
function Get-ParsedReportInfo {
    param (
        [string]$filePath
    )
    # Read file contents and look for the required lines
    $fileContent = Get-Content -Path $filePath
    $eventTime = $null
    $targetAppId = $null
    $appPath = $null

    foreach ($line in $fileContent) {
        if ($line -match "^EventTime=(\d+)") {
            $eventTime = $matches[1]
        }
        elseif ($line -match "^TargetAppId=(.+)") {
            # Capture the TargetAppId value
            $targetAppId = $matches[1]
            # Remove prefix like "W:" or "U:" if present
            $targetAppId = $targetAppId -replace "^[WU]:", ""
        }
        elseif ($line -match "^AppPath=(.+)") {
            $appPath = $matches[1]
        }
    }

    if ($eventTime -and $targetAppId) {
        # Convert EventTime to UTC
        $eventTimeUTC = Convert-FileTimeToUTC -fileTime $eventTime

        # Split TargetAppId to get SHA1 and AppName
        $parsedIdParts = $targetAppId -split '!'
        if ($parsedIdParts.Count -ge 3) {
            # Trim leading 0000 from SHA1 if present
            $sha1 = $parsedIdParts[1] -replace "^0000", ""
            $appName = $parsedIdParts[2]
            return @{
                EventTimeUTC = $eventTimeUTC
                SHA1 = $sha1
                AppName = $appName
                AppPath = $appPath
            }
        }
    }
    return $null
}

# Enumerate through specified or default directories, find Report.wer files, and parse necessary fields
$results = foreach ($dir in $reportDirectories) {
    Get-ChildItem -Path $dir -Recurse -Filter "Report.wer" | ForEach-Object {
        $parsedReportInfo = Get-ParsedReportInfo -filePath $_.FullName
        if ($parsedReportInfo) {
            [PSCustomObject]$parsedReportInfo
        }
    }
}

# Output results
if ($OutputCsv) {
    # Save results to CSV
    $results | Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding UTF8
    Write-Output "Results have been saved to $OutputCsv"
} else {
    # Display results in the console
    $results | Format-Table -AutoSize
}
