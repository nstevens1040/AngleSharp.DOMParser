
    [cmdletbinding()]
    Param()
    cd ..\..\
    #cd [System.IO.FileInfo]::New($MyInvocation.MyCommand.Path).Directory.FullName
    remove-item "$($PWD.Path)\ilmerge.3.0.41.nupkg" -ea 0
    remove-item -Recurse -Force -Path "$($PWD.Path)\ilmerge.3.0.41" -ea 0
    remove-item "$($PWD.Path)\ilmerge.3.0.41.zip" -ea 0
    remove-item ".\bin\AngleSharp.DomParser.ILMerge.log" -ea 0
    if((Get-ExecutionPolicy) -notin @([Microsoft.PowerShell.ExecutionPolicy]::Unrestricted,[Microsoft.PowerShell.ExecutionPolicy]::Bypass))
    {
        if(
            [Security.Principal.WindowsPrincipal]::New([Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        ){
            Set-ExecutionPolicy -Scope Process Bypass -Force
            Set-ExecutionPolicy -Scope CurrentUser Bypass -Force
            Set-ExecutionPolicy -Scope LocalMachine Bypass -Force
            Set-ExecutionPolicy Bypass -Force
        } else {
            Set-ExecutionPolicy -Scope Process Bypass -Force
            Set-ExecutionPolicy -Scope CurrentUser Bypass -Force
        }
    }
    [System.Net.WebClient]::New().DownloadFile(
        "https://globalcdn.nuget.org/packages/ilmerge.3.0.41.nupkg",
        "$($PWD.Path)\ilmerge.3.0.41.nupkg"
    )
    $null = mkdir "$($PWD.Path)\ilmerge.3.0.41"
    Move-Item "$($PWD.Path)\ilmerge.3.0.41.nupkg" "$($PWD.Path)\ilmerge.3.0.41.zip"
    Expand-Archive -Path "$($PWD.Path)\ilmerge.3.0.41.zip" -Destination "$($PWD.Path)\ilmerge.3.0.41"
    $ilmerge = "$($PWD.Path)\ilmerge.3.0.41\tools\net452\ILMerge.exe"
    if(!(Test-Path ".\bin\build" -ea 0)){ $null = mkdir ".\bin\build" }
    . $ilmerge /lib:.\bin\Debug `
    /log:.\bin\AngleSharp.DomParser.ILMerge.log `
    /target:library `
    /targetplatform:v4 `
    /out:.\bin\build\AngleSharp.DomParser.dll `
    .\bin\Debug\AngleSharp.DOMParser.dll `
    .\bin\Debug\System.Text.Encoding.CodePages.dll `
    .\bin\Debug\AngleSharp.dll `
    .\bin\Debug\System.Buffers.dll `
    .\bin\Debug\System.Memory.dll `
    .\bin\Debug\System.Numerics.Vectors.dll `
    .\bin\Debug\System.Runtime.CompilerServices.Unsafe.dll
    remove-item -Recurse -Force -Path "$($PWD.Path)\ilmerge.3.0.41" -ea 0
    remove-item "$($PWD.Path)\ilmerge.3.0.41.zip" -ea 0
