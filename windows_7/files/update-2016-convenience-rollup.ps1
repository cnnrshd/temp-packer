New-Item -Path "C:\" -Name "Updates" -ItemType Directory

# Because this is such a large package, I recommend downloading it and placing it in /files/win-7-files/windows6.1-kb3125574-v4-x64.msu
# If it exists there, this script will download it from the Packer web server - otherwise, it will download from Microsoft

$url="http://$Env:PACKER_HTTP_ADDR/win-7-files/windows6.1-kb3125574-v4-x64.msu"
$outfile="C:\Updates\windows6.1-kb3125574-v4-x64.msu"
try {
	Invoke-WebRequest -UseBasicParsing $url -OutFile $outfile
} catch {
	Write-Host "$(Get-Date -Format G): Unable to download from Packer Web Server - Switching to Microsoft."

	Write-Host "$(Get-Date -Format G): Downloading Convenience rollup update for Windows 7"
	(New-Object Net.WebClient).DownloadFile("http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu", "C:\Updates\windows6.1-kb3125574-v4-x64.msu")
}


$kbid="windows6.1-kb3125574-v4-x64"
$update="Convenience rollup update for Windows 7"

Write-Host "$(Get-Date -Format G): Extracting $update"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\$kbid.msu /extract:C:\Updates" -Wait

Write-Host "$(Get-Date -Format G): Installing $update"
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\$kbid.cab /quiet /norestart /LogPath:C:\Windows\Temp\$kbid.log" -Wait

Remove-Item -LiteralPath "C:\Updates" -Force -Recurse
Write-Host "$(Get-Date -Format G): Finished installing $update. The VM will now reboot and continue the installation process."