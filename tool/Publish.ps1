. $PSScriptRoot/Default.ps1

"Publishing the package..."
$module = Get-Item "PhpMinifier.psd1"
$version = (Import-PowerShellDataFile $module).ModuleVersion
git tag "v$version"
git push origin "v$version"

$output = "var/package"
New-Item $output -ItemType Directory
Copy-Item $module $output
Copy-Item *.md $output
Copy-Item src $output -Recurse
Copy-Item www $output -Recurse

Compress-PSResource $output var
Publish-PSResource -ApiKey $Env:PSGALLERY_API_KEY -NupkgPath "var/$($module.BaseName).$version.nupkg"
