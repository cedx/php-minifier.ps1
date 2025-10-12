<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script.
#>
class Transformer: IDisposable {

	<#
	.SYNOPSIS
		The path to the PHP executable.
	#>
	hidden [string] $executable

	<#
	.SYNOPSIS
		Creates a new transformer.
	#>
	Transformer() {
		$this.executable = "php"
	}

	<#
	.SYNOPSIS
		Creates a new transformer.
	.PARAMETER $executable
		The path to the PHP executable.
	#>
	Transformer([string] $executable) {
		$this.executable = $executable
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
		[string] The transformed script.
	#>
	[string] Transform([string] $file) {
		throw [NotImplementedException]::new()
	}
}
