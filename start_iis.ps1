$ErrorActionPreference = "Stop"

Write-Host "Starting IIS..."
iisreset /start
Write-Host "IIS started."
