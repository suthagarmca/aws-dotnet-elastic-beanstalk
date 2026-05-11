$ErrorActionPreference = "Stop"

$sourcePath = "C:\inetpub\wwwroot"
$backupRoot = "C:\temp\backup"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupPath = Join-Path $backupRoot $timestamp

Write-Host "Backing up IIS site content from $sourcePath to $backupPath"

if (Test-Path $sourcePath) {
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
    Copy-Item -Path (Join-Path $sourcePath "*") -Destination $backupPath -Recurse -Force
    Write-Host "Backup completed."
} else {
    Write-Host "Source path not found. Skipping backup."
}
