using module ../src/FastTransformer.psm1

<#
.SYNOPSIS
	Tests the features of the `FastTransformer` module.
#>
Describe "FastTransformer" {
	Context "Listen" {
		It "should not throw, even if called several times" {
			$transformer = [FastTransformer]::new()
			{ $transformer.Listen() } | Should -Not -Throw
			{ $transformer.Listen() } | Should -Not -Throw
			$transformer.Dispose()
		}
	}

	Context "Transform" {
		BeforeAll { $transformer = [FastTransformer]::new() }
		AfterAll { $transformer.Dispose() }

		It "should remove comments and whitespace" -TestCases @(
			@{ Expected = "<?= 'Hello World!' ?>" }
			@{ Expected = "namespace dummy; class Dummy" }
			@{ Expected = "`$className = get_class(`$this); return `$className;" }
			@{ Expected = "__construct() { `$this->property" }
		) {
			$transformer.Transform("res/Sample.php") | Should -BeLikeExactly "*$expected*"
		}
	}
}
