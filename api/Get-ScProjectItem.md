

# Get-ScProjectItem

Gets a Visual Studio project item object from a specific path.
## Syntax

    Get-ScProjectItem [-Path] <String> [<CommonParameters>]


## Description

Gets a Visual Studio project item object from a specific path.
All projects of the current Solution will be searched for thee specified path.
If this command is not run inside Viusal Studio or if there is no solution nothing will be returned.
This object contains all informations stored in the csproj about this file.
When the file is not in the csproj, nothing will be returned.





## Parameters

    
    -Path <String>
_The path to the file._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-ScProjectItem .\MyClass.cs































