using module ../src/SafeTransformer.psm1

<#
.SYNOPSIS
	Tests the features of the `SafeTransformer` class.
#>
Describe "SafeTransformer" {
	Describe "Transform()" {
		BeforeAll { $transformer = [SafeTransformer]::new() }
		AfterAll { $transformer.Dispose() }

		It "should remove the inline comments" {
			$transformer.Transform("res/Sample.php") | Should -BeLikeExactly "*<`?= 'Hello World!' `?>*"
		}

		It "remove the multi-line comments" {
			$transformer.Transform("res/Sample.php") | Should -BeLikeExactly "*namespace dummy; class Dummy*"
		}

		It "should remove the single-line comments" {
			$transformer.Transform("res/Sample.php") | Should -BeLikeExactly '*$className = get_class($this); return $className;*'
		}

		It "should remove the whitespace" {
			$transformer.Transform("res/Sample.php") | Should -BeLikeExactly '*__construct() { $this->property*'
		}
	}
}
