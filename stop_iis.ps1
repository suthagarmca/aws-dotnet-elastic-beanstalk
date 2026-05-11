$ErrorActionPreference = "Stop"

Write-Host "Stopping IIS..."
iisreset /stop
Write-Host "IIS stopped."
