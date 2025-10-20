using module ./FastTransformer.psm1
using module ./SafeTransformer.psm1

<#
.SYNOPSIS
	Minifies PHP source code by removing comments and whitespace.
.PARAMETER Path
	The path to the input file or directory.
.PARAMETER DestinationPath
	The path to the output directory.
.PARAMETER Binary
	The path to the PHP executable.
.PARAMETER Extension
	The extension of the PHP files to process.
.PARAMETER Mode
	The operation mode of the minifier.
.PARAMETER Quiet
	Whether to silence the minifier output.
.PARAMETER Recurse
	Whether to process the input directory recursively.
#>
function Compress-Php {
	[OutputType([void])]
	param (
		[Parameter(Mandatory, Position = 0)] [ValidateScript({ Test-Path $_ })] [string] $Path,
		[Parameter(Mandatory, Position = 1)] [ValidateScript({ Test-Path $_ -IsValid })] [string] $DestinationPath,
		[ValidateNotNullOrWhiteSpace()] [string] $Binary = "php",
		[ValidateNotNullOrWhiteSpace()] [string] $Extension = "php",
		[TransformMode] $Mode = [TransformMode]::Safe,
		[switch] $Quiet,
		[switch] $Recurse
	)

	begin {
		$transformer = $Mode -eq [TransformMode]::Fast ? [FastTransformer] $Binary : [SafeTransformer] $Binary
	}
	process {
		$isFilePath = Test-Path $Path -PathType Leaf
		if (-not $DestinationPath) { $DestinationPath = $isFilePath ? (Split-Path $Path) : $Path }

		$files = $isFilePath ? @($Path) : (Get-ChildItem "$Path/*.$Extension" -Recurse:$Recurse)
		foreach ($file in $files) {
			$relativePath = Resolve-Path $file -Relative -RelativeBasePath $Path
		}
	}
	clean {
		$transformer.Dispose()
	}
}

<#
.SYNOPSIS
	Creates a new fast transformer.
.PARAMETER Executable
	The path to the PHP executable.
.INPUTS
	A string that contains the path to a PHP executable.
.OUTPUTS
	The newly created transformer.
#>
function New-FastTransformer {
	[OutputType([Release])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		[Parameter(Position = 0, ValueFromPipeline)]
		[ValidateNotNullOrWhiteSpace()]
		[string] $Executable = "php"
	)

	process {
		[FastTransformer]::new($Executable)
	}
}

<#
.SYNOPSIS
	Creates a new fast transformer.
.PARAMETER Executable
	The path to the PHP executable.
.INPUTS
	A string that contains the path to a PHP executable.
.OUTPUTS
	The newly created transformer.
#>
function New-SafeTransformer {
	[OutputType([Release])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		[Parameter(Position = 0, ValueFromPipeline)]
		[ValidateNotNullOrWhiteSpace()]
		[string] $Executable = "php"
	)

	process {
		[SafeTransformer]::new($Executable)
	}
}
