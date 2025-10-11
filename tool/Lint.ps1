Write-Output "Performing the static analysis of source code..."
Invoke-ScriptAnalyzer $PSScriptRoot -Recurse
Invoke-ScriptAnalyzer src -Recurse
Invoke-ScriptAnalyzer test -ExcludeRule PSUseDeclaredVarsMoreThanAssignments -Recurse
