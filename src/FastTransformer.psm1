using namespace System.Diagnostics
using namespace System.Management.Automation
using namespace System.Net.Http
using namespace System.Net.Sockets
using module ./ITransformer.psm1

<#
.SYNOPSIS
	Removes comments and whitespace from a PHP script, by calling a PHP process.
#>
class FastTransformer: ITransformer {

	<#
	.SYNOPSIS
		The path to the PHP executable.
	#>
	hidden [ValidateNotNullOrWhiteSpace()] [string] $Executable

	<#
	.SYNOPSIS
		The underlying PHP job.
	#>
	hidden [Job] $Job

	<#
	.SYNOPSIS
		The port that the PHP process is listening on.
	#>
	hidden [int] $Port = -1

	<#
	.SYNOPSIS
		Creates a new fast transformer.
	#>
	FastTransformer() {
		$this.Executable = "php"
	}

	<#
	.SYNOPSIS
		Creates a new fast transformer.
	.PARAMETER Executable
		The path to the PHP executable.
	#>
	FastTransformer([string] $Executable) {
		$this.Executable = $Executable
	}

	<#
	.SYNOPSIS
		Releases any resources associated with this object.
	#>
	[void] Dispose() {
		if ($this.Job) { Remove-Job $this.Job -Force }
		$this.Job = $null
	}

	<#
	.SYNOPSIS
		Starts the underlying PHP process and begins accepting connections.
	.OUTPUTS
		The TCP port used by the PHP process.
	#>
	[int] Listen() {
		if ($this.Job) { return $this.Port }

		$this.Port = [FastTransformer]::GetPort()
		$this.Job = & $this.Executable -S "$([ipaddress]::Loopback):$($this.Port)" -t (Join-Path $PSScriptRoot "../www") &
		Start-Sleep 1
		return $this.Port
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
		$query = @{ file = Resolve-Path $File }
		$tcpPort = $this.Listen()
		return (Invoke-WebRequest "http://$([ipaddress]::Loopback):$tcpPort/index.php" -Body $query).Content
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
