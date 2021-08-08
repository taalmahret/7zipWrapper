# This is a PSake script that supports the following tasks:
# clean, build, test and publish.  The default task is build.
#
# The publish task uses the Publish-Module command to publish
# to either the PowerShell Gallery (the default) or you can change
# the $Repository property to the name of an alternate repository.
#
# The test task invokes Pester to run any Pester tests in your
# workspace folder. Name your test scripts <TestName>.Tests.ps1
# and Pester will find and run the tests contained in the files.
#
# You can run this build script directly using the invoke-psake
# command which will execute the build task.  This task "builds"
# a temporary folder from which the module can be published.
# The version number will auto increment in the manifest file
#
# PS C:\> invoke-psake build.ps1
#
# You can increment the Major and Minor versions of this module
# by specifying the increment parameters on the coomand line.
# This task "builds" increments the version number both Major
# and minor by 1.  if the version was 0.1.1 then it is now 1.2.1
#
# PS C:\> invoke-psake build.ps1 -properties @{IncrementMajorVersion=$true; IncrementMinorVersion=$true}
#
# You can run your Pester tests (if any) by running the following command.
#
# PS C:\> invoke-psake build.ps1 -taskList test
#
# You can execute the publish task with the following command. Note that
# the publish task will run the test task first. The Pester tests must pass
# before the publish task will run.  The first time you run the publish
# command, you will be prompted to enter your PowerShell Gallery NuGetApiKey.
# After entering the key, it is encrypted and stored so you will not have to
# enter it again.
#
# PS C:\> invoke-psake build.ps1 -taskList publish
#
# This module is designed to use GitHubs Encrypted Secrets
#
# PS C:\> invoke-psake build.ps1 -taskList showKey
#
# You can store a new NuGetApiKey with this command. You can leave off
# the -properties parameter and you'll be prompted for the key.
#
# PS C:\> invoke-psake build.ps1 -taskList storeKey -properties @{NuGetApiKey='test123'}
#

###############################################################################
# Customize these properties for your module.
###############################################################################
Properties {
    # Path to the release notes file.  Set to $null if the release notes reside in the manifest file.
    $ReleaseNotesPath = ('{0}\RELEASENOTES.md' -f $env:BHProjectPath )

    # Your NuGet API key for the PSGallery. The build will store the key
    # encrypted in a file, so that on subsequent publishes you will no longer
    # be prompted for the API key. Create an environment key prior to running
    # this script.  This is meant to represent a GitHub Repository Secret
    # value that is only available during this script running.
    $NuGetApiKey = $env:NUGET_KEY
    #$EncryptedApiKeyPath = ("{0}\vscode-powershell\NuGetApiKey.clixml" -f (Get-SpecialFolder 'LocalApplicationData').Path )

    # Set this to $true to create a module with a monolithic PSM1
    $PSBPreference.Build.CompileModule = $false
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
    $PSBPreference.Publish.PSRepositoryApiKey = $NuGetApiKey

}

Task default -Depends Test

task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'

###############################################################################
# Customize these tasks for performing operations before and/or after publish.
###############################################################################
Task PrePublish {
}

Task PostPublish {
}

###############################################################################
# Core task implementations - this possibly "could" ship as part of the
# vscode-powershell extension and then get dot sourced into this file.
###############################################################################

Task Publish -Depends Test, PrePublish, PublishImpl, PostPublish -FromModule PowerShellBuild -minimumVersion '0.6.1'

Task PublishImpl -Depends Test -requiredVariables NuGetApiKey, EncryptedApiKeyPath {

    $publishParams = @{
        Path        = $env:BHBuildOutput
        NuGetApiKey = $NuGetApiKey #Get-NuGetApiKey $NuGetApiKey $EncryptedApiKeyPath
    }

    if ($Repository) {
        $publishParams['Repository'] = $Repository
    }

    Publish-Module @publishParams -WhatIf
}

###############################################################################
# Customize these tasks for performing operations before and/or after build.
###############################################################################
Task PreBuild -requiredVariables ReleaseNotesPath {
    # I cannot seem to use StageFiles task so i named it prebuild
    # Get contents of the ReleaseNotes file and update the copied module manifest file
    # with the release notes.
    if ($ReleaseNotesPath) {
        $releaseNotes = @(Get-Content $ReleaseNotesPath)
        Update-ModuleManifest -Path $Env:BHPSModuleManifest -ReleaseNotes $releaseNotes
    }

}

Task Build -FromModule PowerShellBuild -minimumVersion '0.6.1'

Task BuildAll -Depends Clean, PreBuild, Build

# Task Clean  {
#     # Sanity check the dir we are about to "clean".  If $env:BHBuildOutput were to
#     # inadvertently get set to $null, the Remove-Item commmand removes the
#     # contents of \*.  That's a bad day.  Ask me how I know?  :-(
#     if ($env:BHBuildOutput) {
#         Remove-Item ('{0}\*' -f $env:BHBuildOutput) -Recurse -Force
#     }
# }

# Task Init -Depends IncrementVersion{
#    if (!(Test-Path $env:BHBuildOutput)) {
#        $null = New-Item $env:BHBuildOutput -ItemType Directory
#    }
# }

task Remove {
    Get-Module $ENV:BHProjectName | Remove-Module
}

task Import {
    if ($env:BHBuildOutput) {
        Import-Module ('{0}\{1}.psd1' -f $ENV:BHBuildOutput, $ENV:BHProjectName )
    }

}

task IncrementVersion {
    $CurrentVersion = Test-ModuleManifest $ENV:BHPSModuleManifest | Select-Object -ExpandProperty Version
    $Build = $CurrentVersion.Build
    $Minor = $CurrentVersion.Minor
    $Major = $CurrentVersion.Major
    if ($IncrementMajorVersion){$Major++;$Minor=0;$Build=-1}
    elseif ($IncrementMinorVersion){$Minor++;$Build=-1}
    $Build++
    $NewVersion = [System.Version]$("{0}.{1}.{2}" -f $Major,$Minor,$Build)
    Update-ModuleManifest -Path $ENV:BHPSModuleManifest -ModuleVersion $NewVersion

    #This is not how this is normally done but there are no docs on how to reset the psake environment from inside of psake
    $env:BHBuildOutput = $env:BHBuildOutput.Replace($CurrentVersion, $NewVersion)

}

Task StoreKey -requiredVariables NuGetApiKey, EncryptedApiKeyPath {
    if (Test-Path $EncryptedApiKeyPath) { Remove-Item $EncryptedApiKeyPath }

    $null = Get-NuGetApiKey $NuGetApiKey $EncryptedApiKeyPath
    "The NuGetApiKey has been stored in $EncryptedApiKeyPath"
}

Task ShowKey -requiredVariables EncryptedApiKeyPath {
    $Result = Get-NuGetApiKey $null $EncryptedApiKeyPath
    "The stored NuGetApiKey is: $Result"
}

# Task ? -description 'Lists the available tasks' {
#     "Available tasks:"
#     $psake.context.Peek().tasks.Keys | Sort-Object
# }

###############################################################################
# Helper functions
###############################################################################
function Get-NuGetApiKey() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [String]
        $NuGetApiKey,

        [Parameter()]
        $EncryptedApiKeyPath
    )

    $storedKey = $null
    if (!$NuGetApiKey) {
        if (Test-Path $EncryptedApiKeyPath) {
            $storedKey = Import-Clixml $EncryptedApiKeyPath | ConvertTo-SecureString
            $cred = New-Object -TypeName PSCredential -ArgumentList 'kh',$storedKey
            $NuGetApiKey = $cred.GetNetworkCredential().Password
            Write-Verbose "Retrieved encrypted NuGetApiKey from $EncryptedApiKeyPath"
        }
        else {
            $apiKeySS = Read-Host -Prompt "Enter your NuGet API Key" -AsSecureString
            $cred = New-Object -TypeName PSCredential -ArgumentList 'dw',$apiKeySS
            $NuGetApiKey = $cred.GetNetworkCredential().Password
        }
    }

    if (!$storedKey) {
        # Store encrypted NuGet API key to use for future invocations
        if (!$apiKeySS) {
            $apiKeySS = ConvertTo-SecureString -String $NuGetApiKey -AsPlainText -Force
        }

        $parentDir = Split-Path $EncryptedApiKeyPath -Parent
        if (!(Test-Path -Path $parentDir)) {
            $null = New-Item -Path $parentDir -ItemType Directory
        }

        $apiKeySS | ConvertFrom-SecureString | Export-Clixml $EncryptedApiKeyPath
        Write-Verbose "Stored encrypted NuGetApiKey to $EncryptedApiKeyPath"
    }

    $NuGetApiKey
}

function Get-SpecialFolder {
    <#
    .SYNOPSIS
    Gets special (known) folders.

    .DESCRIPTION
    Gets items representing special folders (directories), i.e.,
    folders whose purpose is predefined by the operating system.

    In a string context, each such item expands to the full, literal path it
    represents.
    If no name is given, all special folders known to the current OS
    are listed. Use -All to include those that are special on other platforms.

    .PARAMETER Name
    The name(s) of specific special folders to get.
    Note that wildcards are not supported.

    .EXAMPLE
    Get-SpecialFolder UserProfile, Desktop

    Gets items representing the current OS's user-profile (home) folder
    and desktop folder.

    .EXAMPLE
    "The application-data folder is: $(Get-SpecialFolder ApplicationData)"
    Uses the function in an expandable string, showing how the item returned
    expands to its full, literal directory path.

    .NOTES
    This is a very shortened list of folders that are on all three platforms
    The full list of folders is listed below. This function is convenient,
    but not fast.  This was modified for cross platform predictable behavior.

    Special thanks to Michael Klement for the heavy lifting of mapping out
    all folders across all three operating systems.

    .LINK
    https://gist.github.com/mklement0/c0a5d8a0aa44369689800c57e2b747c2
    #>

    [CmdletBinding(PositionalBinding=$False)]
    param(
        [Parameter(Mandatory, Position=0)]
        [ValidateSet('ApplicationData', 'CommonApplicationData', 'Desktop', 'DesktopDirectory', 'LocalApplicationData', 'MyDocuments', 'MyMusic', 'MyPictures', 'UserProfile')]
        [string[]] $Name
    )
    $Result = [System.Collections.ArrayList]@()

    $specialFolders = [ordered] @{
        'ApplicationData' = @{ Name = ''; Path = $null}
        'CommonApplicationData' = @{ Name = ''; Path = $null}
        'Desktop' = @{ Name = ''; Path = $null}
        'DesktopDirectory' = @{ Name = ''; Path = $null}
        'LocalApplicationData' = @{ Name = ''; Path = $null}
        'MyDocuments' = @{ Name = ''; Path = $null}
        'MyMusic' = @{ Name = ''; Path = $null}
        'MyPictures' = @{ Name = ''; Path = $null}
        'UserProfile' = @{ Name = ''; Path = $null}
    }

    # Get the list and flesh out the output objects.
    $specialFolders.GetEnumerator() | Where-Object { $_.Key -in $Name } | ForEach-Object {
        $Result += [PSCustomObject]@{
            Name = $_.Key
            Path = [Environment]::GetFolderPath($_.Key)
        }
    }

    $Result
}



