[cmdletbinding(DefaultParameterSetName = 'Task')]
param(
    # Build task(s) to execute
    [parameter(ParameterSetName = 'task', position = 0)]
    [string[]]$Task = 'default',

    # Bootstrap dependencies
    [switch]$Bootstrap,

    # Increment Version of Project
    [switch]$IncrementVersion,

    # List available build tasks
    [parameter(ParameterSetName = 'Help')]
    [switch]$Help,

    # Optional properties to pass to psake
    [hashtable]$Properties = @{},

    # Optional parameters to pass to psake
    # -parameters @{ApiKey= '123'; "IncrementMajorVersion" = $true; "IncrementMinorVersion" = $true}
    [hashtable]$Parameters = @{}
)

$ErrorActionPreference = 'Stop'


function Write-ShellMessage {
param (
    [Parameter(Mandatory, Position=0)]
    [AllowEmptyString()]
    [string]
    $Message,

    [Parameter(ValueFromPipeline)]
    [string[]]
    $Detail,

    [Switch]
    $Task,

    [switch]
    $Header,

    [switch]
    $NewLine,

    [int]
    $PrefixPadding = 20
)
Begin {
    filter ToTitleCase {
        $_.substring(0,1).ToUpper() + $_.substring(1).ToLower()
    }
    function write-output_header {
        param (
            $Message
        )
        Write-Host ($Message.Trim(" ").Trim(":") + ': ' ) -ForegroundColor Yellow
    }
    function write-output_regular {
        param (
            $Message,
            $Detail = ''
        )
        $Message = $Message | ToTitleCase
        Write-Host ( ($Message.Trim(" ").Trim(":")).PadRight($PrefixPadding,' ').Substring(0,$PrefixPadding) + $Detail)
    }
    function write-output_task {
        param (
            $Message,
            $Detail = ''
        )
        Write-Host ('{0}' -f $Message.Trim(" ").Trim(":") + ': ' ) -ForegroundColor Cyan -NoNewline
        Write-Host ($Detail.ToUpper()) -ForegroundColor Blue
        Write-Host $null
    }

    $FirstLine = $true


    #Null pipeline detected.  Process block will not run.  just do it here
    #ARGH - the empty pipeline issue is needing more research
    if ( ( $Detail.Count -eq 0 ) -or ( $null -eq $Detail ) ) {
        if ($Header.IsPresent) {
            write-output_header -Message $Message
        } else {
            $Detail = 'N/A'
        }

    }

}
Process {
    if ( -NOT ([string]::IsNullOrEmpty($Message)) ) {
        foreach ($item in $Detail) {

            if ($Task.IsPresent) { #Beginning Title Header Message
                write-output_task -Message $Message -Detail $item
            }

            if ($Header.IsPresent) { #Section Header Message
                write-output_header -Message $Message
            }

            #None of the switches present - Regular Message
            if ((-NOT $Task.IsPresent) -and (-NOT $Header.IsPresent )) {
                if ($FirstLine -eq $true) {
                    $FirstLine = $false
                    write-output_regular -Message $Message -Detail $item
                }
                else {
                    write-output_regular -Message ' ' -Detail $item
                }
            }
        }
    }
}
end {
    if ($NewLine.IsPresent) {
        write-host
    }
}
}

Write-ShellMessage -Message 'Task' -Detail 'Preinit' -Task
Write-ShellMessage -Message 'Shell Details:' -Header

Write-ShellMessage -Message 'task' -Detail $Task
Write-ShellMessage -Message 'BootStrap' -Detail ($Bootstrap -eq $true).ToString()
Write-ShellMessage -Message 'IncrementVersion' -Detail ($IncrementVersion -eq $true).ToString()

if ($Properties.count -lt 1) { $Properties = @{'N/A'='N/A'}}
$Properties.GetEnumerator() | ForEach-Object {$_.Key + ' = ' + $_.Value } | Write-ShellMessage -Message 'Properties'
if ($Parameters.count -lt 1) { $Parameters = @{'N/A'='N/A'}}
$Parameters.GetEnumerator() | ForEach-Object {$_.Key + ' = ' + $_.Value } | Write-ShellMessage -Message 'Parameters'



# Bootstrap dependencies
if ($Bootstrap.IsPresent) {
    Get-PackageProvider -Name Nuget -ForceBootstrap | Out-Null
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    if ((Test-Path -Path ./requirements.psd1)) {
        if (-not (Get-Module -Name PSDepend -ListAvailable)) {
            Install-Module -Name PSDepend -Repository PSGallery -Scope CurrentUser -Force
        }
        Write-ShellMessage -Message 'Initialize Module' -Detail 'PsDepend'
        Import-Module -Name PSDepend -Verbose:$false
        Invoke-PSDepend -Path './requirements.psd1' -Install -Import -Force -WarningAction SilentlyContinue
    } else {
        Write-Warning 'No [requirements.psd1] found. Skipping build dependency installation.'
    }
}

#IncrementVersion
if ($IncrementVersion.IsPresent) {
    Set-BuildEnvironment -Force
    $CurrentVersion = Test-ModuleManifest $ENV:BHPSModuleManifest | Select-Object -ExpandProperty Version
    $Build = $CurrentVersion.Build
    $Minor = $CurrentVersion.Minor
    $Major = $CurrentVersion.Major
    $IncrementMajorVersion = $false
    $IncrementMinorVersion = $false
    $Parameters.GetEnumerator() | ForEach-Object {
        switch ($_.Key) {
            'IncrementMajorVersion' { $IncrementMajorVersion = $true }
            'IncrementMinorVersion' { $IncrementMinorVersion = $true }
            Default {}
        }
    }
    if ($IncrementMajorVersion) { $Major++;$Minor=0;$Build=-1 }
    if ($IncrementMinorVersion) { $Minor++;$Build=-1 }
    $Build++
    $NewVersion = [System.Version]$("{0}.{1}.{2}" -f $Major,$Minor,$Build)
    Update-ModuleManifest -Path $ENV:BHPSModuleManifest -ModuleVersion $NewVersion
    Write-ShellMessage -Message 'Increment Version' -Header
    Write-ShellMessage -Message 'Major Version Changed' -Detail $IncrementMajorVersion.ToString()
    Write-ShellMessage -Message 'Minor Version Changed' -Detail $IncrementMinorVersion.ToString()
    Write-ShellMessage -Message 'New Version Number' -Detail $NewVersion.ToString()

}

Write-ShellMessage '' -NewLine

# Execute psake task(s)
$psakeFile = './psakeFile.ps1'
#Invoke-psake $psakeFile -taskList Import -nologo
if ($PSCmdlet.ParameterSetName -eq 'Help') {
    Get-PSakeScriptTasks -buildFile $psakeFile | Format-Table -Property Name, Description, Alias, DependsOn
} else {
    Set-BuildEnvironment -Force
    Invoke-psake -buildFile $psakeFile -taskList $Task -nologo -properties $Properties -parameters $Parameters
    exit ([int](-not $psake.build_success))
}
