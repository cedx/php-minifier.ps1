using namespace System.Diagnostics
using namespace System.Net.Http
using namespace System.Net.Sockets
using namespace System.Threading.Tasks
using module ./Transformer.psm1

<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script, by calling a PHP process.
#>
class FastTransformer: Transformer {

	<#
	.SYNOPSIS
		The HTTP client used to query the PHP process.
	#>
	hidden [HttpClient] $httpClient

	<#
	.SYNOPSIS
		The underlying PHP process.
	#>
	hidden [Process] $process

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
		$this.httpClient?.Dispose()
		$this.httpClient = $null
		$this.process?.Kill()
		$this.process?.Dispose()
		$this.process = $null
	}

	<#
	.SYNOPSIS
		Starts the underlying PHP process and begins accepting connections.

	.OUTPUTS
		[int] The TCP port used by the PHP process.
	#>
	[int] Listen() {
		if ($null -ne $this.process) { return $this.httpClient.BaseAddress.Port }

		$address = [ipaddress]::Loopback
		$port = [FastTransformer]::GetPort()

		$startInfo = [ProcessStartInfo]::new($this.executable)
		$startInfo.Arguments = "-S ${address}:$port -t $(Join-Path $PSScriptRoot "../www")"
		$startInfo.CreateNoWindow = $true

		$this.httpClient = [HttpClient]@{ BaseAddress = [uri] "http://${address}:$port/" }
		$this.process = [Process]::Start($startInfo)
		Start-Sleep 1
		return $port
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
		$this.Listen()
		$path = [uri]::EscapeDataString((Resolve-Path $file))
		$response = $this.httpClient.GetStringAsync("index.php?file=$($path)")
		return $response.GetAwaiter().GetResult()
	}

	<#
	.SYNOPSIS
		Gets an ephemeral TCP port chosen by the system.

	.OUTPUTS
		[int] The TCP port chosen by the system.
	#>
	hidden static [int] GetPort() {
		$tcpListener = $null

		try {
			$tcpListener = [TcpListener]::new([ipaddress]::Loopback, 0)
			$tcpListener.Start()
			return ([IPEndpoint] $tcpListener.LocalEndpoint).Port
		}
		finally {
			($tcpListener -as [IDisposable])?.Dispose()
		}
	}
}
