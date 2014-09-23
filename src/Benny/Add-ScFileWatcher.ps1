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
  }
}
