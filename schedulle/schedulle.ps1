Param (
[Parameter (Mandatory=$true, Position=1)]
[string]$path
)

function GetCurretnPath ($filename) {
    $filebase = Join-Path $PSScriptRoot $filename
    return $filebase
}

function GetDate () {
    $date = Get-Date -Format "HH:mm:ss dd/MM/yyyy"
    return "[$date]"
}

function ZipFiles( $filename, $sourcedir) {
    Compress-Archive -Path $sourcedir -DestinationPath "$filename.zip"
}

function LogFile () {
    $date = GetDate
    $curPath = GetCurretnPath "log.txt"
    Write-Output $curPath
    if ( -Not [System.IO.File]::Exists($curPath)) {
        New-Item -Path . -Name "log.txt" -ItemType "file" -Value "$date - Log file was created!`r`n"
    }
}

function Main () {
    LogFile 
    $PathInfo = Get-ChildItem -Path $path -exclude *.zip
    $accumulator = 0
    foreach ($file in $PathInfo) {
        $date = GetDate
        if ([System.IO.File]::Exists("$file.zip")) {
            $accumulator++
        } else {
            ZipFiles $file $path
            Add-Content log.txt -value "$date - $file.zip archive was created!"
        }
    }
    if ($accumulator -ne 0) {
        Add-Content log.txt -value "$date - $accumulator files was skipped during dir scan."
    }
}

Main