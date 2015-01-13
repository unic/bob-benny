<#
.SYNOPSIS
Gets a Visual Studio project item object from a specific path.
.DESCRIPTION
Gets a Visual Studio project item object from a specific path.
All projects of the current Solution will be searched for thee specified path.
If this command is not run inside Viusal Studio or if there is no solution nothing will be returned.
This object contains all informations stored in the csproj about this file.
When the file is not in the csproj, nothing will be returned.


.PARAMETER Path
The path to the file.

.EXAMPLE
Get-ScProjectItem .\MyClass.cs

#>
function Get-ScProjectItem
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string] $Path
  )
  Process
  {
    foreach($project in $dte.Solution.Projects) {
      $projectFolder = $project.FullName.Substring(0, $project.FullName.LastIndexOf("\") + 1)
      if($Path.StartsWith($projectFolder)) {
        $relativePath = $Path.Replace($projectFolder, "")
        $parts = $relativePath.Split("\")
        $item = $project
        $i = 0
        while($i -lt $parts.Count -and $item) {
          $part = $parts[$i]
          #write-host $item.ProjectItems
          $item = $item.ProjectItems | ? {$_.Name -eq $part}
          $i++;
        }
        if($item) {
          return $item;
        }

      }
    }
  }
}
