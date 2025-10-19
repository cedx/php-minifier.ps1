@{
	ModuleVersion = "0.1.0"
	RootModule = "src/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "Minify PHP source code by removing comments and whitespace."
	GUID = "ebfa3521-4dd2-43bf-a54f-404d9b7f4c5d"

	AliasesToExport = @()
	CmdletsToExport = @()
	FunctionsToExport = @()
	VariablesToExport = @()

	NestedModules = @(
		"src/FastTransformer.psm1"
		"src/ITransformer.psm1"
		"src/SafeTransformer.psm1"
		"src/TransformMode.psm1"
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/cedx/php-minifier.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/cedx/php-minifier.ps1"
			ReleaseNotes = "https://github.com/cedx/php-minifier.ps1/blob/main/ChangeLog.md"
			Tags = "compress", "minify", "php"
		}
	}
}
