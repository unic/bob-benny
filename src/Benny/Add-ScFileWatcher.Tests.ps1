$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Add-ScFileWatcher" {
  Context "Should detect file change" {
    $global:invokedScFileWatcher = $false
    $global:scFileWatcherPath = ""

    Add-ScFileWatcher -Path $TestDrive -Action {
      $global:invokedScFileWatcher = $true
      $global:scFileWatcherPath = $Event.SourceEventArgs.FullPath
    }
    Set-Content  -Value "changed" -Path "TestDrive:\test.txt"
    It "Should have invoked action" {
      $global:invokedScFileWatcher | Should Be $true
    }
    It "Should provide the path" {
      $global:scFileWatcherPath | Should Be "$TestDrive\test.txt"
    }
  }
}
