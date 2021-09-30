$path = "C:\coding\OS\schedulle\example_folder"
$PathInfo = Get-ChildItem -Path $path

if ($PathInfo) {
    mkdir "$path\NEW";
    Write-Host 'Created'
} else {
    Write-Host 'The folder is empty.'
}