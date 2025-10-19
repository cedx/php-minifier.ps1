using module ./FastTransformer.psm1
using module ./SafeTransformer.psm1

<#
.SYNOPSIS
	Minifies PHP source code by removing comments and whitespace.
.PARAMETER $path
	The path to the input file or directory.
.PARAMETER $destinationPath
	The path to the output directory.
.PARAMETER $binary
	The path to the PHP executable.
.PARAMETER $extension
	The extension of the PHP files to process.
.PARAMETER $mode
	The operation mode of the minifier.
.PARAMETER $quiet
	Whether to silence the minifier output.
.PARAMETER $recurse
	Whether to process the input directory recursively.
#>
function Compress-Php {
	[OutputType([void])]
	param (
		[Parameter(Mandatory, Position = 0)] [ValidateScript({ Test-Path $_ })] [string] $path,
		[Parameter(Mandatory, Position = 1)] [ValidateScript({ Test-Path $_ -IsValid })] [string] $destinationPath,
		[ValidateNotNullOrWhiteSpace()] [string] $binary = "php",
		[ValidateNotNullOrWhiteSpace()] [string] $extension = "php",
		[TransformMode] $mode = [TransformMode]::Safe,
		[switch] $quiet,
		[switch] $recurse
	)

	begin {
		$transformer = $mode -eq [TransformMode]::Fast ? [FastTransformer] $binary : [SafeTransformer] $binary
	}
	process {
		$isFilePath = Test-Path $path -PathType Leaf
		if (-not $destinationPath) { $destinationPath = $isFilePath ? (Split-Path $path) : $path }

		$files = $isFilePath ? @($path) : (Get-ChildItem "$path/*.$extension" -Recurse=$recurse)
		foreach ($file in $files) {
			$relativePath = Resolve-Path $file -Relative -RelativeBasePath $path
		}
	}
	clean {
		$transformer.Dispose()
	}
}
