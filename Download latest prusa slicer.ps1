
$response = (Invoke-RestMethod -Uri 'https://api.github.com/repos/prusa3d/PrusaSlicer/releases')[0]
$asset = $response.assets | Where-Object { $_.name -like "*win64*.zip" } 
$downloadUrl= $asset.browser_download_url
$fileName = $asset.name


# Set the output path for the downloaded file to the user's Downloads directory
$outputPath = "${env:USERPROFILE}\Downloads\$fileName"

# Download the latest release
Start-BitsTransfer -Source $downloadUrl -Destination $outputPath

$zipPath = (Split-Path -Path $outputPath) + "\"
Expand-Archive -Path $outputPath -DestinationPath $zipPath -Force

$folder = $zipPath + $fileName.Replace('_signed.zip','')
start $folder
