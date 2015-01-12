function Initialize-Benny {

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
            $filters = $bennyConfig.BennyFileWatcher.Split(";") | % {$_.Trim()}

            $relativePath = $Event.SourceEventArgs.FullPath.Replace($bennyConfig.WebsitePath.Trim("\") + "\", "")
            foreach($filter in $filters) {
                if($relativePath -like $filter) {
                    $item = Get-ScProjectItem -Path ($Event.SourceEventArgs.FullPath)
                    if($item.Properties.Item("ItemType").Value -eq "Content") {
                        $webPath = Join-Path (Join-Path  $bennyConfig.GlobalWebPath ($bennyConfig.WebsiteCodeName)) $bennyConfig.WebFolderName
                        cp  $Event.SourceEventArgs.FullPath "$webPath\$relativePath"
                    }
                }
            }
        }
    }
}
