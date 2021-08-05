[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $AlternatePath
)

[bool]$7zEXE = $false
$ScriptPath = $MyInvocation.MyCommand.Path

#See if 7zip is installed otherwise use the script directory
try {
    $P = (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\7z*').GetValue("Path")
} catch {
    #If an alternate path is given lets use that.  If not lets try to use the current script running command path.
    $P = if ( [string]::IsNullOrEmpty($AlternatePath) ) { $ScriptPath } else { $AlternatePath }
} finally {
    $7z = Join-Path $P -ChildPath "7z.exe"
    if (Test-Path -PathType Leaf $7z) { [string]$7zEXE = $7z }

    $7za = Join-Path $P -ChildPath "7za.exe"
    if (Test-Path -PathType Leaf $7za) { [string]$7zEXE = $7za }

}


if ($false -eq $7zEXE) {
    $Output = ('Locations Searched: {0}7z.exe: {1}{0}7za.exe: {2}' -f "`r`n", $7z, $7za)

    throw ('7-zip not installed or in path. This file is required for all operations of this module{0}{1}' -f "`r`n", $Output)

<#
    #This appears to be too early in the modules startup to even use this function.  I'll keep it simple for now
    Debug-ThrowException `
        -Message '7-zip not installed or in path. This file is required for all operations of this module' `
        -Verb 'Initialization' `
        -Path $AlternatePath `
        -Output $Output `
        -LineNumber Get-CurrentLineNumber `
        -Filename Get-CurrentFileName `
        -Executable "Not Found" `
        -Exception ([IO.FileNotFoundException]::new('7zip executable not found'))
#>


}



$7zSettings = [ordered]@{
    Path7zEXE       = $7zEXE
    ScriptDirectory = if ($null -ne $ScriptPath) { Split-Path -Path $ScriptPath -Parent } else { (Get-Location) }
    ScriptFilePath  = if ($null -ne $ScriptPath) { Split-Path -Path $ScriptPath } else { Join-Path -Path (Get-Location) -ChildPath 'UnknownScriptFileName.ps1' }
}
New-Variable -Name 7zSettings -Value $7zSettings -Scope Script -Force
