function Build-Array {
    [CmdletBinding()]
    param (
        [Parameter()]
        [object]$value
    )

    if ($($value.ColumnType) -eq 'string') {
        return ", tostring(column_ifexists('$($value.ColumnName)', ''))"
    }
    if ($($value.ColumnType) -eq 'int') {
        return ", toint(column_ifexists('$($value.ColumnName)', ''))"
    }
    if ($($value.ColumnType) -eq 'long') {
        return ", tolong(column_ifexists('$($value.ColumnName)', ''))"
    }
    if ($($value.ColumnType) -eq 'dynamic') {
        return ", todynamic(column_ifexists('$($value.ColumnName)', ''))"
    }
    if ($($value.ColumnType) -eq 'datetime') {
        return ", todatetime(column_ifexists('$($value.ColumnName)', ''))"
    }
}

Function Build-Schema {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$FilesPath,

        [Parameter()]
        [ValidateSet('AuditEvent', 'Authentication', 'Dhcp', 'Dns', 'FileEvent', 'NetworkSession', 'ProcessEvent', 'RegistryEvent', 'UserManagement', 'WebSession')]
        [string]$Schema,

        [Parameter(Mandatory)]
        [ValidateSet('Optional', 'Recommended')]
        [string]$Scope = 'Recommended'
    )

    $csv = Get-ChildItem -Path $FilesPath -Filter '*.csv' | Import-Csv -Delimiter ','

    if ($Scope -eq 'Recommended') {
        $class = @('Mandatory', 'Recommended')
    } else {
        $class = @('Mandatory', 'Recommended', 'Optional')
    }

    $array       = ($csv | Where-Object schema -eq $Schema)
    $resultArray = [PSCustomObject]@()
    $_subArray   = [PSCustomObject]@()

    foreach ($type in $class) {
        foreach ($value in $array | Where-Object Class -eq $type) {
            $resultArray += Build-Array -value $value
            # create a list to check for aliases or conditionals
            $_subArray += $value
        }
    }

    foreach ($item in $array) {
        if ($item.aliased -in $_subArray.ColumnName -and ($item.class -eq 'Conditional' -or $item.class -eq 'Alias')) {
            Write-Debug "Adding $($item.ColumnName) as alias for $($item.Aliased) to list"
            $resultArray += Build-Array -value $item
        }
    }

    return ('{0}{1}' -f "T | project `n  ",  ($resultArray | Out-String).Substring(2))
}