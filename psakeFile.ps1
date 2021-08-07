properties {
    # Set this to $true to create a module with a monolithic PSM1
    $PSBPreference.Build.CompileModule = $false
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
}

task Default -depends Build

task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'

task Build -FromModule PowerShellBuild -minimumVersion '0.6.1'

task Import {
    Import-Module ('{0}\{1}.psd1' -f $ENV:BHBuildOutput, $ENV:BHProjectName )
}

task Remove {
    Get-Module $ENV:BHProjectName | Remove-Module
}

task IncrementVersion {
    $ManifestPath = $ENV:BHPSModuleManifest
    $CurrentVersion = Test-ModuleManifest $ManifestPath | Select-Object -ExpandProperty Version
    $Build = $CurrentVersion.Build
    $Minor = $CurrentVersion.Minor
    $Major = $CurrentVersion.Major
    if ($IncrementMajorVersion){$Major++;$Minor=0;$Build=-1}
    elseif ($IncrementMinorVersion){$Minor++;$Build=-1}
    $Build++
    $NewVersion = [System.Version]$("{0}.{1}.{2}" -f $Major,$Minor,$Build)
    Update-ModuleManifest -Path $ManifestPath -ModuleVersion $NewVersion
}
