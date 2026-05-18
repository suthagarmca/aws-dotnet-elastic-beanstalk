$ErrorActionPreference = "Stop"

$bundleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$zipPath = Join-Path $bundleRoot "build.zip"
$stagingRoot = "C:\temp\release"
$deploymentId = $env:DEPLOYMENT_ID

if ([string]::IsNullOrWhiteSpace($deploymentId)) {
    $deploymentId = Get-Date -Format "yyyyMMddHHmmss"
}

$stagingPath = Join-Path $stagingRoot $deploymentId

Write-Host "Preparing deployment files from $zipPath"

if (!(Test-Path $zipPath)) {
    throw "Deployment zip file not found: $zipPath"
}

New-Item -ItemType Directory -Path $stagingPath -Force | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $stagingPath)

Write-Host "Deployment files staged at $stagingPath"
