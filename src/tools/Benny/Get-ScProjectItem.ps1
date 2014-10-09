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
