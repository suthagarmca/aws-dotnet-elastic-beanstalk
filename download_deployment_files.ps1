$ErrorActionPreference = "Stop"

$bundleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourcePath = Join-Path $bundleRoot "web"
$stagingRoot = "C:\temp\release"
$deploymentId = $env:DEPLOYMENT_ID

if ([string]::IsNullOrWhiteSpace($deploymentId)) {
    $deploymentId = Get-Date -Format "yyyyMMddHHmmss"
}

$stagingPath = Join-Path $stagingRoot $deploymentId

Write-Host "Preparing deployment files from $sourcePath"

if (!(Test-Path $sourcePath)) {
    throw "Deployment source folder not found: $sourcePath"
}

New-Item -ItemType Directory -Path $stagingPath -Force | Out-Null
Copy-Item -Path (Join-Path $sourcePath "*") -Destination $stagingPath -Recurse -Force

Write-Host "Deployment files staged at $stagingPath"
