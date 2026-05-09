# AWS .NET 10 Web App

Minimal ASP.NET Core web application targeting .NET 10.

## Run locally

```powershell
dotnet restore
dotnet run
```

Browse to the local URL shown in output.

## CI/CD target

This repository is prepared for:
- Source in GitHub
- Build in AWS CodeBuild using `buildspec.yml`
- Deploy in AWS CodePipeline to Elastic Beanstalk
