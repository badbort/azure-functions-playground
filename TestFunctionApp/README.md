# Introduction

Just messing around with a function app

## Setup

- Install [azure-functions-core-tools](https://github.com/Azure/azure-functions-core-tools) for the `func` cli
- Install the [dotnet packing tools](https://github.com/quamotion/dotnet-packaging) for the `dotnet-zip` command. This makes it very quick and easy to publish and zip up the app. Quicker than having to mess around with powershell  
    ```
    dotnet tool install --global dotnet-zip
    ```
- (Initial setup only) `dotnet zip install`. Has already been done. Including just for reference for other apps

## Build and deploy

- Run `dotnet-zip`. This will restore, build and create a zip file.
- Upload the zip:  
    ```
    az functionapp deployment source config-zip -g azure-functions-playground -n silly-function-app --src "<path-to-zip-file"
    ```

## Local Testing

`func host start --verbose`