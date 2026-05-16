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

# Extract to a temp directory first
$tempExtractPath = Join-Path $env:TEMP ("extract_" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tempExtractPath -Force | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $tempExtractPath)

# Copy only the contents of the 'web' folder to the staging path
$webPath = Join-Path $tempExtractPath "web"
if (!(Test-Path $webPath)) {
    throw "Expected 'web' folder not found in extracted zip: $webPath"
}
New-Item -ItemType Directory -Path $stagingPath -Force | Out-Null
Copy-Item -Path (Join-Path $webPath "*") -Destination $stagingPath -Recurse -Force

# Clean up temp extract directory
Remove-Item -Path $tempExtractPath -Recurse -Force

Write-Host "Deployment files staged at $stagingPath"
