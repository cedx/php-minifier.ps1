using module ./ITransformer.psm1

<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script, by calling a PHP process.
#>
class SafeTransformer: ITransformer {

	<#
	.SYNOPSIS
		The path to the PHP executable.
	#>
	[ValidateNotNullOrWhiteSpace()]
	hidden [string] $Executable

	<#
	.SYNOPSIS
		Creates a new safe transformer.
	#>
	SafeTransformer() {
		$this.Executable = "php"
	}

	<#
	.SYNOPSIS
		Creates a new safe transformer.
	.PARAMETER Executable
		The path to the PHP executable.
	#>
	SafeTransformer([string] $Executable) {
		$this.Executable = $Executable
	}

	<#
	.SYNOPSIS
		Releases any resources associated with this object.
	#>
	[void] Dispose() {}

	<#
	.SYNOPSIS
		Processes a PHP script.
	.PARAMETER File
		The path to the PHP script.
	.OUTPUTS
		The transformed script.
	#>
	[string] Transform([string] $File) {
		return & $this.Executable -w (Resolve-Path $File)
	}
}
