"Publishing the package..."
$version = (Import-PowerShellDataFile "PhpMinifier.psd1").ModuleVersion
git tag "v$version"
git push origin "v$version"
