using namespace System.Diagnostics.CodeAnalysis
using module ../src/SafeTransformer.psm1

<#
.SYNOPSIS
	Tests the features of the `SafeTransformer` module.
#>
Describe "SafeTransformer" {
	Context "Transform" {
		BeforeAll {
			[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "")]
			$transformer = [SafeTransformer]::new()
		}

		It "should remove comments and whitespace" -TestCases @(
			@{ Expected = "<?= 'Hello World!' ?>" }
			@{ Expected = "namespace dummy; class Dummy" }
			@{ Expected = "`$className = get_class(`$this); return `$className;" }
			@{ Expected = "__construct() { `$this->property" }
		) {
			$transformer.Transform("res/Sample.php") | Should -BeLikeExactly "*$expected*"
		}

		AfterAll {
			$transformer.Dispose()
		}
	}
}
