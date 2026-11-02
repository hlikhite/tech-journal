# This script creates a powershell function used to verify the integrity of a file if you have its intended hash (e.g. sha256)

function hashchk([string]$path, [string]$type, [string]$expected) {
    $output = (Get-FileHash $path -Algorithm $type | Select-Object -ExpandProperty Hash)
    Write-Output "Output: $output"
    Write-Output "Expected: $expected"
    if ($output -eq $expected) {
        $result = $true
    }
    else {
        $result = $false
    }
    Write-Output "Result: $result"
}
