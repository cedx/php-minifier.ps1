<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script.
#>
class ITransformer: IDisposable {

	<#
	.SYNOPSIS
		Releases any resources associated with this object.
	#>
	[void] Dispose() {
		throw [NotImplementedException]::new()
	}

	<#
	.SYNOPSIS
		Processes a PHP script.
	.PARAMETER File
		The path to the PHP script.
	.OUTPUTS
		The transformed script.
	#>
	[string] Transform([string] $File) {
		throw [NotImplementedException]::new()
	}
}
