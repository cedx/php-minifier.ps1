#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-StrictMode -Version Latest

$commandPath = Get-Item $PSCommandPath
$scriptRoot = $commandPath.LinkType ? (Split-Path $commandPath.LinkTarget) : $PSScriptRoot
. (Import-PowerShellDataFile "$scriptRoot/PhpMinifier.psd1").RootModule
Compress-Php @args
