@{
	ModuleVersion = "0.1.0"
	RootModule = "src/Compress-Php.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "Minify PHP source code by removing comments and whitespace."
	GUID = "ebfa3521-4dd2-43bf-a54f-404d9b7f4c5d"

	AliasesToExport = @()
	CmdletsToExport = @()
	FunctionsToExport = @()
	VariablesToExport = @()

	# TODO ???
	# RequiredModules = @()

	ScriptsToProcess = @(
		# TODO ??? "Transformer.psm1"
		# "FastTransformer.psm1"
		# "SafeTransformer.psm1"
	)

	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @()

	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @()

	# List of all modules packaged with this module
	# ModuleList = @()

	# List of all files packaged with this module
	# FileList = @("www/index.php")

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/cedx/php-minifier.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/cedx/php-minifier.ps1"
			ReleaseNotes = "https://github.com/cedx/php-minifier.ps1/blob/main/ChangeLog.md"
			Tags = "compress", "minify", "php"
		}
	}
}
