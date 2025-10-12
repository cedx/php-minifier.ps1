using module ../src/FastTransformer.psm1

<#
.SYNOPSIS
	Tests the features of the `FastTransformer` class.
#>
Describe "FastTransformer" {
	Describe "Listen()" {
		It "should not throw, even if called several times" {
			$transformer = [FastTransformer]::new()
			{ $transformer.Listen() } | Should -Not -Throw
			{ $transformer.Listen() } | Should -Not -Throw
			$transformer.Dispose()
		}
	}

	Describe "Transform()" {
		BeforeAll { $transformer = [FastTransformer]::new() }
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
