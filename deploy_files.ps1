$ErrorActionPreference = "Stop"

$stagingRoot = "C:\temp\release"
$deploymentId = $env:DEPLOYMENT_ID
$destinationPath = "C:\inetpub\wwwroot"

if ([string]::IsNullOrWhiteSpace($deploymentId)) {
    throw "DEPLOYMENT_ID is not available."
}

$stagingPath = Join-Path $stagingRoot $deploymentId

if (!(Test-Path $stagingPath)) {
    throw "Staged deployment files not found: $stagingPath"
}

Write-Host "Deploying files from $stagingPath to $destinationPath"

New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
Copy-Item -Path (Join-Path $stagingPath "*") -Destination $destinationPath -Recurse -Force

Write-Host "Deployment copy completed."
