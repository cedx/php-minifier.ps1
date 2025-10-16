<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script.
#>
class ITransformer: IDisposable {

	<#
	.SYNOPSIS
		Prevents instantiation of the class.
	#>
	hidden ITransformer() {
		throw [NotSupportedException]::new()
	}

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
	.PARAMETER $file
		The path to the PHP script.
	.OUTPUTS
		The transformed script.
	#>
	[string] Transform([string] $file) {
		throw [NotImplementedException]::new()
	}
}
