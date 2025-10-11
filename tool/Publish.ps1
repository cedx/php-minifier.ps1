Write-Output "Publishing the package..."
$version = (Import-PowerShellDataFile "$PSScriptRoot/../PhpMinifier.psd1").ModuleVersion
git tag "v$version"
git push origin "v$version"
