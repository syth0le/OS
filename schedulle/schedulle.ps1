$path = "C:\coding\OS\schedulle\example_folder"
$path_source = "C:\coding\OS\schedulle"
$PathInfo = Get-ChildItem -Path $path


function GetDate () {
    $date = Get-Date -Format "HH:mm:ss dd/MM/yyyy"
    return "[$date]"
}


function ZipFilesNot( $zipfilename, $sourcedir )
{
   Add-Type -Assembly System.IO.Compression.FileSystem -OutputType .zip
   $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
   [System.IO.Compression.ZipFile]::CreateFromDirectory($sourcedir,
        $zipfilename, $compressionLevel, $false)
}

function ZipFiles( $filename, $sourcedir) {
    # Compress-Archive -Path $sourcedir -DestinationPath "$path\$filename.zip"
    Compress-Archive -Path $sourcedir -DestinationPath "$filename.zip"
}

function LogFile () {
    $date = GetDate
    if ( -Not [System.IO.File]::Exists("$path_source\log.txt")) {
        New-Item -Path . -Name "log.txt" -ItemType "file" -Value "$date - Log file was created!`r`n"
    }
}

function Main () {
    LogFile 
    $accumulator = 0
    foreach ($file in $PathInfo) {
        $date = GetDate
        if ([System.IO.File]::Exists("$path_source\$file.zip")) {
            $accumulator++
            # Add-Content log.txt -value "$date - $file archive already created!"
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