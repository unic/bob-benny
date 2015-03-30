param($installPath, $toolsPath, $package)

Import-Module (Join-Path $toolsPath "Benny") -Force

try
{
    Initialize-Benny -Verbose
}
catch
{
    Write-Warning $error[0]
}
