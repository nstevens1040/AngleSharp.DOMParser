[![Build status](https://ci.appveyor.com/api/projects/status/5x3fsql3hg4aokym?svg=true)](https://ci.appveyor.com/project/nstevens1040/anglesharp-domparser)
# AngleSharp.DOMParser
This library uses [AngelSharp](https://github.com/AngleSharp/AngleSharp) to parse an HTML string into a document object model. The library targets **.NET Framework 4.7.2** so that it is compatible with **Windows PowerShell**.
## Build the Library
Compiling in **Windows PowerShell**
```ps1
git clone https://github.com/nstevens1040/AngleSharp.DOMParser.git
cd .\AngleSharp.DOMParser\
MSBuild.exe -p:RestorePackagesConfig=true -t:restore
MSBuild.exe .\AngleSharp.DOMParser.sln
```
## Load the Library
Into **Windows PowerShell** and then test it.
```ps1
Add-Type -Path .\AngleSharp.DOMParser\build\AngleSharp.DomParser.dll
$html_string = @"
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <title>Testing HTML</title>
    </head>
    <body>
        <h1>Heading</h1>
        <article>
            <section>
                <h2>subtitle</h2>
                <p>paragraph</p>
                <span id="test">Test succeeded!</span>
            </section>
        </article>
    </body>
</html>
"@
$document = [AngleSharp.DomParser]::GetDomDocument($html_string)
$document.GetElementById("test").TextContent
```
If the test succeeds, then your PowerShell output will be
```ps1
Test succeeded!
```
