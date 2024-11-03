<#
.SYNOPSIS
Parses MpLog files from Windows Defender's support folder or a specified file to extract event details.

.DESCRIPTION
This script:
1. Scans a specified MpLog file or all `MpLog-*` files in the specified directory (defaults to the Windows Defender support folder).
2. Extracts information from:
   - SDN Query events
   - Suspicious command lines
   - Detection clean and add events
   - Process image data (e.g., TotalTime, Count, MaxTime, EstimatedImpact)
   - Memory scan (EMS detection) events
3. Displays results in the console or saves them to CSV if a file path is provided.

.PARAMETER FilePath
Specifies a path to a single MpLog file for parsing. If omitted, the script defaults to scanning all `MpLog-*` files in the specified directory.

.PARAMETER Directory
Specifies the directory to scan for all `MpLog-*` files. If omitted, the script defaults to `C:\ProgramData\Microsoft\Windows Defender\Support`.

.PARAMETER CsvOutput
Specifies the file path for saving output in CSV format. If omitted, results are displayed in the console.

.EXAMPLE
.\MpLogParser.ps1
# Parses all `MpLog-*` files in the default Windows Defender support folder and displays results in the console.

.EXAMPLE
.\MpLogParser.ps1 -FilePath "C:\Custom\Path\MpLog-Example.log"
# Parses a specific MpLog file and displays all extracted information.

.EXAMPLE
.\MpLogParser.ps1 -Directory "C:\Users\Admin\Desktop"
# Parses all `MpLog-*` files in the specified directory.

.EXAMPLE
.\MpLogParser.ps1 -CsvOutput "C:\Output\AllResults.csv"
# Parses all `MpLog-*` files in the default Windows Defender folder and saves results to CSV.

.NOTES
Author: DebugPrivilege
#>

param (
    [string]$CsvOutput,                                # Path to save CSV output; enables CSV export if specified
    [string]$Directory = "C:\ProgramData\Microsoft\Windows Defender\Support", # Default directory
    [string]$FilePath                                  # Custom path to a specific MpLog file
)

# Define arrays to store the parsed data
$parsedSDNQuery = @()
$parsedSuspiciousCLI = @()
$parsedDetectionEvent = @()
$parsedProcessImage = @()
$parsedMemoryScan = @()

# Function to convert FILETIME to UTC datetime
function Convert-FileTimeToUTC {
    param (
        [long]$fileTime
    )
    # Define start date as January 1, 1601
    $startDate = [DateTime]::FromFileTimeUtc(0)
    # Add the FILETIME interval to start date
    return $startDate.AddTicks($fileTime)
}

# Check if a specific file path is provided; if so, only parse that file
if ($FilePath) {
    # Check if the specified file exists
    if (Test-Path -Path $FilePath) {
        $logFiles = @($FilePath)  # Use the single file path in an array
    } else {
        Write-Output "Specified file does not exist: $FilePath"
        exit
    }
} else {
    # If no specific file path is provided, get all MpLog files in the default directory
    $logFiles = Get-ChildItem -Path $Directory -Filter "MpLog-*.log" -File
}

# Loop through each log file
foreach ($logFile in $logFiles) {
    # Determine the path for Get-Content based on whether a single file or directory scan is used
    $filePathToRead = if ($FilePath) { $FilePath } else { $logFile.FullName }

    # Read the file line by line
    $lines = Get-Content -Path $filePathToRead

    foreach ($line in $lines) {
        # Parse SDN query events (now includes both SHA1 and SHA256)
        if ($line -match "(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z) SDN:Issuing SDN query for (\\?.+?) \((\\?.+?)\) \(sha1=(\w{40}), sha2=(\w{64})\)") {
            $timestamp = $matches[1]
            $filePath = $matches[2]
            $sha1 = $matches[4]
            $sha256 = $matches[5]

            # Store SDN query result
            $parsedSDNQuery += [PSCustomObject]@{
                Timestamp = $timestamp
                FilePath = $filePath
                SHA1 = $sha1
                SHA256 = $sha256
            }
        }

        # Parse suspicious command line detections
        if ($line -match "(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z) Engine:command line reported as (.+?): (.+?)\((.+?)\)") {
            $timestamp = $matches[1]
            $detectionType = $matches[2]
            $filePath = $matches[3]
            $commandLine = $matches[4]

            # Store suspicious CLI result
            $parsedSuspiciousCLI += [PSCustomObject]@{
                Timestamp = $timestamp
                FilePath = $filePath
                CommandLine = $commandLine
                DetectionType = $detectionType
            }
        }

        # Parse detection events
        if ($line -match "(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z) DETECTION_CLEANEVENT (\S+) (\S+) (\S+) (\S+) (.+)") {
            $timestamp = $matches[1]
            $source = $matches[2]
            $action = $matches[3]
            $threatID = $matches[4]
            $threatName = $matches[5]
            $details = $matches[6]

            # Extract additional details if available
            $containerFile = if ($details -match "containerfile:(\S+)") { $matches[1] } else { "" }
            $filePath = if ($details -match "file:(\S+)") { $matches[1] } else { "" }
            $webFile = if ($details -match "webfile:(\S+)") { $matches[1] } else { "" }
            $processData = if ($details -match "pid:(\d+),ProcessStart:(\d+)") { 
                $processID = $matches[1]
                $startTime = Convert-FileTimeToUTC([long]$matches[2])
                "PID: $processID, StartTime: $startTime"
            } else { "" }

            # Store detection clean event result with consistent columns
            $parsedDetectionEvent += [PSCustomObject]@{
                Timestamp = $timestamp
                ThreatName = $threatName
                Source = $source
                Action = $action
                ThreatID = $threatID
                ContainerFile = $containerFile
                FilePath = $filePath
                WebFile = $webFile
                ProcessData = $processData
                PropBag = ""
            }
        }

        # Parse DETECTION_ADD events
        elseif ($line -match "(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z) DETECTION_ADD#\d+ (\S+) (.+)") {
            $timestamp = $matches[1]
            $threatName = $matches[2]
            $details = $matches[3]

            # Extract additional details if available
            $webFile = if ($details -match "webfile:(\S+)") { $matches[1] } else { "" }
            $containerFile = if ($details -match "containerfile:(\S+)") { $matches[1] } else { "" }
            $processData = if ($details -match "pid:(\d+),ProcessStart:(\d+)") { 
                $processID = $matches[1]
                $startTime = Convert-FileTimeToUTC([long]$matches[2])
                "PID: $processID, StartTime: $startTime"
            } else { "" }
            $propBag = if ($details -match "PropBag \[length: \d+, data: (\S+)\]") { $matches[1] } else { "(null)" }

            # Store detection add event result with consistent columns
            $parsedDetectionEvent += [PSCustomObject]@{
                Timestamp = $timestamp
                ThreatName = $threatName
                Source = ""
                Action = ""
                ThreatID = ""
                ContainerFile = $containerFile
                FilePath = ""
                WebFile = $webFile
                ProcessData = $processData
                PropBag = $propBag
            }
        }

        # Parse EMS detection events (Memory scan) by default
        if ($line -match "(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z) Engine:EMS detection: (\S+), sigseq=(\S+), sigsha=(\S+), pid=(\d+)") {
            $timestamp = $matches[1]
            $threatName = $matches[2]
            $sigSeq = $matches[3]
            $sigSha = $matches[4]
            $processID = $matches[5]

            # Store EMS detection event
            $parsedMemoryScan += [PSCustomObject]@{
                Timestamp = $timestamp
                ThreatName = $threatName
                SigSeq = $sigSeq
                SigSha = $sigSha
                ProcessID = $processID
            }
        }

        # Parse process image data
        if ($line -match "ProcessImageName: (\S+), (?:Pid: (\d+), )?TotalTime: (\d+), Count: (\d+), MaxTime: (\d+), MaxTimeFile: (\S+), EstimatedImpact: (\d+)%") {
            $processImageName = $matches[1]
            $processID = if ($matches[2]) { $matches[2] } else { "" }
            $totalTime = $matches[3]
            $count = $matches[4]
            $maxTime = $matches[5]
            $maxTimeFile = $matches[6]
            $estimatedImpact = $matches[7]

            # Store process image result
            $parsedProcessImage += [PSCustomObject]@{
                ProcessImageName = $processImageName
                ProcessID = $processID
                TotalTime = $totalTime
                Count = $count
                MaxTime = $maxTime
                MaxTimeFile = $maxTimeFile
                EstimatedImpact = "$estimatedImpact%"
            }
        }
    }
}

# Display all results in the console
if ($parsedSDNQuery.Count -gt 0) {
    Write-Output "SDN Query Results:"
    $parsedSDNQuery | Format-Table -Property Timestamp, FilePath, SHA1, SHA256 -AutoSize
}

if ($parsedSuspiciousCLI.Count -gt 0) {
    Write-Output "`nSuspicious Command Line Results:"
    $parsedSuspiciousCLI | Format-Table -Property Timestamp, FilePath, CommandLine, DetectionType -AutoSize
}

if ($parsedDetectionEvent.Count -gt 0) {
    Write-Output "`nDetection Event Results:"
    $parsedDetectionEvent | Format-Table -Property Timestamp, ThreatName, Source, Action, ThreatID, ContainerFile, FilePath, WebFile, ProcessData, PropBag -AutoSize
}

if ($parsedMemoryScan.Count -gt 0) {
    Write-Output "`nMemory Scan Results:"
    $parsedMemoryScan | Format-Table -Property Timestamp, ThreatName, SigSeq, SigSha, ProcessID -AutoSize
}

if ($parsedProcessImage.Count -gt 0) {
    Write-Output "`nProcess Image Results:"
    $parsedProcessImage | Format-Table -Property ProcessImageName, ProcessID, TotalTime, Count, MaxTime, MaxTimeFile, EstimatedImpact -AutoSize
}

# Export all data to CSV if CsvOutput is specified
if ($CsvOutput) {
    try {
        $parsedSDNQuery | Export-Csv -Path ([System.IO.Path]::ChangeExtension($CsvOutput, "_SDNQuery.csv")) -NoTypeInformation -Force
        $parsedSuspiciousCLI | Export-Csv -Path ([System.IO.Path]::ChangeExtension($CsvOutput, "_SuspiciousCLI.csv")) -NoTypeInformation -Force
        $parsedDetectionEvent | Export-Csv -Path ([System.IO.Path]::ChangeExtension($CsvOutput, "_DetectionEvent.csv")) -NoTypeInformation -Force
        $parsedMemoryScan | Export-Csv -Path ([System.IO.Path]::ChangeExtension($CsvOutput, "_MemoryScan.csv")) -NoTypeInformation -Force
        $parsedProcessImage | Export-Csv -Path ([System.IO.Path]::ChangeExtension($CsvOutput, "_ProcessImage.csv")) -NoTypeInformation -Force
        Write-Output "All data exported to CSV files successfully."
    } catch {
        Write-Output "Failed to export data to CSV: $_"
    }
}
