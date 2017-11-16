

# Add-ScFileWatcher

Adds a file watcher to a specific path.
## Syntax

    Add-ScFileWatcher [-Path] <String> [-Action] <ScriptBlock> [<CommonParameters>]


## Description

`Add-ScFileWatcher` adds a file watcher to a specific path.
Every time a file in this path is changed, created or renamed `$Action` will be called.





## Parameters

    
    -Path <String>
_The path to a folder to watch._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Action <ScriptBlock>
_A script block to execute everytime a file inside the `$Path` changes._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Add-ScFileWatch -Path D:\temp -Action {Write-Host "hey"}































