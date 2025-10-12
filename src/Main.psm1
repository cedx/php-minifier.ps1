using module ./FastTransformer.psm1
using module ./SafeTransformer.psm1

<#
.SYNOPSIS
	The operation mode of the minifier.
#>
enum TransformMode {
	Fast
	Safe
}

<#
.SYNOPSIS
	Minifies PHP source code by removing comments and whitespace.

.PARAMETER $path
	The path to the input directory.

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
	param (
		[Parameter(Mandatory, Position = 0)] [string] $path,
		[Parameter(Mandatory, Position = 1)] [string] $destinationPath,
		[string] $binary = "php",
		[string] $extension = "php",
		[TransformMode] $mode = [TransformMode]::Safe,
		[switch] $quiet,
		[switch] $recurse
	)
	begin {
		$transformer = $mode -eq [TransformMode]::Fast ? [FastTransformer]::new($binary) : [SafeTransformer]::new($binary)
	}
	process {
		#TODO
	}
	clean {
		$transformer.Dispose()
	}
}
