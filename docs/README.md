<div class="chapterlogo"><img src="./Benny.jpg"></div>

# Benny

Benny provides functionality to perform deployments of single files without a whole deployment. When Benny is installed to a Solution, as soon as Visual Studio will be started, Benny watches for changes on the file system and deploys them to the coresponding web root.

## How to use Benny in my Project?

To install Benny into your solution simply install the NuGet package "Unic.Bob.Benny"

    PM> Install-Package Unic.Bob.Benny

After the package is installed a file-system-watcher is initilized. This watcher watches for changes to files in the Website-project, which matches "BennyFilter" and have set their build action to "Content". Following keys of Bob.config are important for Benny:

| Key | Description | Example |
| --- | ----------- | ------- |
| BennyFilter | A list of file-matches which Benny looks for changes. The matches must be separated by semicolons. The matches are relative to the project-root folder. This means `App_Config\*.config` will match `App_Config\Unic.config` but not `Dummy\App_Config\Unic.config`. | `*.cshtml; App_Config\*.config` |

## Technical Documentation

Benny is basically a NuGet package with a PowerShell module loaded in the init.ps1.

The file-watcher will be started as soon as the PowerShell module is loaded.
