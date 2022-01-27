function Use-DotEnv {
    <#
    .SYNOPSIS
        Set, unset environment variables
    .DESCRIPTION
        Get all variables from a file then set or unset these variables
    .EXAMPLE
        PS C:\> Use-DotEnv -Path .\.env
        Set variables
    .EXAMPLE
        PS C:\> Use-DotEnv -Path .\.env -UnSet 1
        Unset variables
    .PARAMETER Path
    .PARAMETER UnSet
    .NOTES
        Not exported
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Path,
        [bool]$UnSet = $false
    )

    Write-Verbose "Checking $Path exists"
    if (!(Test-Path -Path $Path)) {
        Write-Error "$Path not found"
        return
    }

    Write-Verbose "Getting variables"
    $Pattern = '^(?<key>[a-z,A-Z,0-9,_]+)\=(?<value>.+)?'
    $EnvironmentVariables = (Select-String -Path $Path -Pattern $Pattern -AllMatches)

    foreach ($Match in $EnvironmentVariables.Matches) {
        $Key = $Match.Groups['key']
        $Value = $UnSet ? $null : $Match.Groups['value']
        $Message = $UnSet ? "Unsetting" : "Setting"
        Write-Verbose "$Message $Key"
        [Environment]::SetEnvironmentVariable($Key, $Value, "process")
    }
}

function Set-DotEnv {
    <#
    .SYNOPSIS
        Set variables from a file
    .DESCRIPTION
        Set variables from a file
    .PARAMETER Path
    .EXAMPLE
        PS C:\> Set-DotEnv .\.env
    #>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string]$Path = ".env"
    )
    Use-DotEnv -Path $Path
}

function Redo-DotEnv {
    <#
    .SYNOPSIS
        Unset variables from a file
    .DESCRIPTION
        Unset variables from a file
    .PARAMETER Path
    .EXAMPLE
        PS C:\> Redo-DotEnv .\.env
    #>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string]$Path = ".env"
    )
    Use-DotEnv -Path $Path -UnSet $true
}

Export-ModuleMember -Function Set-DotEnv, Redo-DotEnv
