<#
.SYNOPSIS
Starts Benny and registers the file watcher for the current project.
.DESCRIPTION
`Initialize-Benny` starts Benny by adding a file watcher to the website directory.
When a file changes, which matches the `BennyFileWatcher`, it will be copied to the WebRoot.

.EXAMPLE
Initialize-Benny

#>
function Initialize-Benny {

    $global:bennyConfig = Get-ScProjectConfig
    if(-not $bennyConfig.WebsitePath) {
        Write-Error "Could not find WebsitePath."
        exit
    }

    if($global:bennyFileWatcher) {
        $global:bennyFileWatcher.Dispose()
    }

    Write-Verbose "Register Benny at $($bennyConfig.WebsitePath)"

    $global:bennyFileWatcher = Add-ScFileWatcher -Path $bennyConfig.WebsitePath -Action {
        $path = $Event.SourceEventArgs.FullPath
        # Visual Studio is producing lot of temp file, so put the further function at the end of the stack
        sleep -m 1
        if((Test-Path $path) -and (Get-Item $path) -isnot [System.IO.DirectoryInfo]) {
            $filters = $bennyConfig.BennyFileWatcher.Split(";") | % {$_.Trim()}

            $item = Get-ScProjectItem -Path ($Event.SourceEventArgs.FullPath)
            $projectPath = $item.ContainingProject.FullName.Substring(0, $item.ContainingProject.FullName.LastIndexOf("\") + 1)
            $relativePath = $Event.SourceEventArgs.FullPath.Replace($projectPath, "")
            foreach($filter in $filters) {
                if($relativePath -like $filter) {
                    if($item.Properties.Item("ItemType").Value -eq "Content") {
                        $webPath = $bennyConfig.WebRoot
                        cp  $Event.SourceEventArgs.FullPath "$webPath\$relativePath"
                    }
                }
            }
        }
    }
}
