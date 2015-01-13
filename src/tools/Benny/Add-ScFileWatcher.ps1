<#
.SYNOPSIS
Adds a file Watch to a specific path.
.DESCRIPTION
`Add-ScFileWatcher` adds a file watcher to a specifc path.
Every time a file in this path is changed, created or renamed `$Action` will be called.

.PARAMETER Path
The path to a folder to watch.

.PARAMETER Action
A script block to execute everytime a file inside the `$Path` changes.

.EXAMPLE
Add-ScFileWatch -Path D:\temp -Action {Write-Host "hey"}

#>
function Add-ScFileWatcher
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string] $Path,
      [Parameter(Mandatory=$true)]
      [ScriptBlock] $Action
  )
  Process
  {
    $filter = '*.*'                             # <-- set this according to your requirements
    $fsw = New-Object IO.FileSystemWatcher $path, $filter -Property @{
     IncludeSubdirectories = $true              # <-- set this according to your requirements
     NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
    }

    Register-ObjectEvent $fsw Changed -Action $Action
    Register-ObjectEvent $fsw Created -Action $Action
    Register-ObjectEvent $fsw Renamed -Action $Action


  }
}
