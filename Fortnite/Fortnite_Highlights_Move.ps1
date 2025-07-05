# Fortnite_Highlights_Move.ps1
# This script will help you move Fortnite highlight files to a specified directory.

param (
    [Parameter(Mandatory=$true)]
    # Only run if FortniteClient-Win64-Shipping.exe is NOT running
    while (Get-Process -Name "FortniteClient-Win64-Shipping" -ErrorAction SilentlyContinue) {
        Write-Host "Fortnite is currently running. Waiting for it to close..."
        Start-Sleep -Seconds 30
    }
    [string]$SourceFolder,
    [int]$DaysOld = 7,
    [Parameter(Mandatory=$true)]
    <#
    .SYNOPSIS
    Specifies the destination folder path.

    .DESCRIPTION
    The DestinationFolder parameter is a string that defines the path to the folder where files or highlights will be moved or copied.

    .PARAMETER DestinationFolder
    A string representing the full path to the destination directory.

    .EXAMPLE
    # Example usage:
    # Move highlights to the specified destination folder
    .\Fortnite_Highlights_Move.ps1 -SourceFolder "D:\Temp\Fortnite\Highlights" -DestinationFolder "D:\Videos\Fortnite\Highlights"
    #>
    [string]$DestinationFolder,

    [string]$FilePattern = "*.mp4"
)

if (!(Test-Path $SourceFolder)) {
    Write-Error "Source folder does not exist: $SourceFolder"
    exit 1
}

if (!(Test-Path $DestinationFolder)) {
    New-Item -ItemType Directory -Path $DestinationFolder | Out-Null
}

Get-ChildItem -Path $SourceFolder -Filter $FilePattern | ForEach-Object {
    $dest = Join-Path $DestinationFolder $_.Name
    Move-Item -Path $_.FullName -Destination $dest -Force
    Write-Host "Moved: $($_.FullName) -> $dest"
}

