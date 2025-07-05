# Fortnite_Highlights_Move.ps1
# This script will help you move Fortnite highlight files to a specified directory.

# Specify the source folder where the highlight files are located
[string]$SourceFolder = "C:\Users\nogar\AppData\Local\Temp\Highlights\Fortnite"
# Specify the destination folder where you want to move the files
[string]$DestinationFolder = "D:\Game_Videos\Fortnite"

[int]$DaysOld = 7



# Only run if FortniteClient-Win64-Shipping.exe is NOT running
while (Get-Process -Name "FortniteClient-Win64-Shipping" -ErrorAction SilentlyContinue) {
    Write-Host "Fortnite is currently running. Waiting for it to close..."
    Start-Sleep -Seconds 30
}

if (!(Test-Path $SourceFolder)) {
    Write-Error "Source folder does not exist: $SourceFolder"
    exit 1
}

if (!(Test-Path $DestinationFolder)) {
    New-Item -ItemType Directory -Path $DestinationFolder | Out-Null
}

$cutoff = (Get-Date).AddDays(-$DaysOld)

Get-ChildItem -Path $SourceFolder  | Where-Object { $_.LastWriteTime -lt $cutoff } | ForEach-Object {
    $dest = Join-Path $DestinationFolder $_.Name
    Move-Item -Path $_.FullName -Destination $dest -Force
    Write-Host "Moved: $($_.FullName) -> $dest"
}

