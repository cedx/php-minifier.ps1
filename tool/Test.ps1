"Running the test suite..."
pwsh -Command {
	Import-Module Pester
	Invoke-Pester test

	if (Get-Module BurntToast -ListAvailable) {
		Import-Module BurntToast
		$message = $LASTEXITCODE -eq 0 ? "were successfully completed" : "failed with $LASTEXITCODE $($LASTEXITCODE -gt 1 ? "errors" : "error")"
		New-BurntToastNotification -AppLogo Program.ico -Text "PHP Minifier", "The tests $message." -UniqueIdentifier Belin.PhpMinifier
	}

	exit $LASTEXITCODE
}
