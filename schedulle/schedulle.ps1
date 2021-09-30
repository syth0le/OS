$path = "C:\coding\OS\schedulle\example_folder"
$path_source = "C:\coding\OS\schedulle"
$PathInfo = Get-ChildItem -Path $path -exclude *.zip


function GetDate () {
    $date = Get-Date -Format "HH:mm:ss dd/MM/yyyy"
    return "[$date]"
}

function ZipFiles( $filename, $sourcedir) {
    Compress-Archive -Path $sourcedir -DestinationPath "$filename.zip"
}

function LogFile () {
    $date = GetDate
    if ( -Not [System.IO.File]::Exists("$path_source\log.txt")) {
        New-Item -Path . -Name "log.txt" -ItemType "file" -Value "$date - Log file was created!`r`n"
    }
}

function Main () {
#     Write-Output $PathInfo
    LogFile 
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