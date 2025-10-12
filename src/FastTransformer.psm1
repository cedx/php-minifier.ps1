using namespace System.Diagnostics
using namespace System.Management.Automation
using namespace System.Net.Http
using namespace System.Net.Sockets
using module ./Transformer.psm1

<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script, by calling a PHP process.
#>
class FastTransformer: Transformer {

	<#
	.SYNOPSIS
		The base URL of the PHP service.
	#>
	hidden [uri] $baseUri

	<#
	.SYNOPSIS
		The underlying PHP job.
	#>
	hidden [Job] $job

	<#
	.SYNOPSIS
		Creates a new fast transformer.
	#>
	FastTransformer(): base() {}

	<#
	.SYNOPSIS
		Creates a new fast transformer.
	.PARAMETER $executable
		The path to the PHP executable.
	#>
	FastTransformer([string] $executable): base($executable) {}

	<#
	.SYNOPSIS
		Releases any resources associated with this object.
	#>
	[void] Dispose() {
		if ($this.job) { Remove-Job $this.job -Force }
		$this.baseUri = $this.job = $null
	}

	<#
	.SYNOPSIS
		Starts the underlying PHP process and begins accepting connections.
	.OUTPUTS
		The TCP port used by the PHP process.
	#>
	[int] Listen() {
		if ($this.job) { return $this.baseUri.Port }

		$address = [ipaddress]::Loopback
		$port = [FastTransformer]::GetPort()

		$this.baseUri = "http://${address}:$port/"
		$this.job = & $this.executable -S ${address}:$port -t (Join-Path $PSScriptRoot "../www") &
		Start-Sleep 1
		return $port
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
		$this.Listen()
		$uri = [uri]::new($this.baseUri, "index.php?file=$([uri]::EscapeDataString((Resolve-Path $file)))")
		return (Invoke-WebRequest $uri).Content
	}

	<#
	.SYNOPSIS
		Gets an ephemeral TCP port chosen by the system.
	.OUTPUTS
		The TCP port chosen by the system.
	#>
	hidden static [int] GetPort() {
		$tcpListener = $null

		try {
			$tcpListener = [TcpListener]::new([ipaddress]::Loopback, 0)
			$tcpListener.Start()
			return ([IPEndpoint] $tcpListener.LocalEndpoint).Port
		}
		finally {
			if ($tcpListener) { $tcpListener.Dispose() }
		}
	}
}
