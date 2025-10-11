using module ./Transformer.psm1

<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script, by calling a PHP process.
#>
class SafeTransformer: Transformer {

	<#
	.SYNOPSIS
		Creates a new safe transformer.
	#>
	SafeTransformer(): base() {}

	<#
	.SYNOPSIS
		Creates a new safe transformer.

	.PARAMETER $executable
		The path to the PHP executable.
	#>
	SafeTransformer([string] $executable): base($executable) {}

	<#
	.SYNOPSIS
		Releases any resources associated with this object.
	#>
	[void] Dispose() {}

	<#
	.SYNOPSIS
		Processes a PHP script.

	.PARAMETER $file
		The path to the PHP script.

	.OUTPUTS
		[string] The transformed script.
	#>
	[string] Transform([string] $file) {
		$standardOutput = Invoke-Command { & $this.executable -w (Resolve-Path $file) }
		return $standardOutput.Trim()
	}
}
