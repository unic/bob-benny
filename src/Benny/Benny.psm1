$PSScriptRoot = Split-Path  $script:MyInvocation.MyCommand.Path

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1 | Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *

$global:bennyConfig = Get-ScProjectConfig
if(-not $bennyConfig.WebsitePath) {
  Write-Error "Could not find WebsitePath."
  exit
}

Write-Verbose "Register Benny at $($bennyConfig.WebsitePath)"



$job = Add-ScFileWatcher -Path $bennyConfig.WebsitePath -Action {
  $path = $Event.SourceEventArgs.FullPath
  # Visual Studio is producing lot of temp file, so put the further function at the end of the stack
  sleep -m 1
  if((Test-Path $path) -and (Get-Item $path) -isnot [System.IO.DirectoryInfo]) {
    write-host $Event.SourceEventArgs.FullPath
    $relativePath = $Event.SourceEventArgs.FullPath.Replace($bennyConfig.WebsitePath, "")
    $webPath = Join-Path (Join-Path  $bennyConfig.GlobalWebPath ($bennyConfig.WebsiteCodeName)) $bennyConfig.WebFolderName
    cp  $Event.SourceEventArgs.FullPath "$webPath$relativePath"
  }
}
