# Fortnite_Highlights_Delete.ps1
# This script will help you delete Fortnite highlight files older than a specified number of days.

[string]$SourceFolder = "C:\Users\nogar\AppData\Local\Temp\Highlights\Fortnite"
[int]$DaysOld = 7
#[string]$FilePattern = "*.mp4"
Write-Host $SourceFolder
write-host $DaysOld
#Write-Host $FilePattern

# Only run if FortniteClient-Win64-Shipping.exe is NOT running
while (Get-Process -Name "FortniteClient-Win64-Shipping" -ErrorAction SilentlyContinue) {
    Write-Host "Fortnite is currently running. Waiting for it to close..."
    Start-Sleep -Seconds 30
}

if (!(Test-Path $SourceFolder)) {
    Write-Error "Source folder does not exist: $SourceFolder"
    exit 1
}

$cutoff = (Get-Date).AddDays(-$DaysOld)

Get-ChildItem -Path $SourceFolder -Recurse -File | Where-Object { $_.LastWriteTime -lt $cutoff } | ForEach-Object {
    #Remove-Item -Path $_.FullName -Force #uncomment to actually delete files
    # Write-Host "Deleted: $($_.FullName)"
    Write-Host "Would delete: $($_.FullName)"
    # Remove-Item -Path $_.FullName -Force
}
