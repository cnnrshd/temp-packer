New-Item -Path "C:\" -Name "Updates" -ItemType Directory

# Because this is such a large package, I recommend downloading it and placing it in /files/win-7-files/windows6.1-KB976932-X64.exe
# If it exists there, this script will download it from the Packer web server - otherwise, it will download from Microsoft

$url="http://$Env:PACKER_HTTP_ADDR/win-7-files/windows6.1-KB976932-X64.exe"
$outfile="C:\Updates\windows6.1-KB976932-X64.exe"
try {
	Invoke-WebRequest -UseBasicParsing $url -OutFile $outfile
} catch {
	Write-Host "$(Get-Date -Format G): Unable to download from Packer Web Server - Switching to Microsoft."
	Write-Host "$(Get-Date -Format G): Downloading and installing Windows 7 Service Pack 1."
	Write-Host "$(Get-Date -Format G): This process can take up to 30 minutes."

	Write-Host "$(Get-Date -Format G): Downloading Windows 7 Service Pack 1"
	(New-Object Net.WebClient).DownloadFile("https://download.microsoft.com/download/0/A/F/0AFB5316-3062-494A-AB78-7FB0D4461357/windows6.1-KB976932-X64.exe", "C:\Updates\windows6.1-KB976932-X64.exe")
}

# Service Pack 1 is an absolute requirement. Installing updates from Windows Update
# will fail if SP1 is not installed.

Write-Host "$(Get-Date -Format G): Installing Windows 7 Service Pack 1"
Start-Process -FilePath "C:\Updates\Windows6.1-KB976932-X64.exe" -ArgumentList "/unattend /nodialog /norestart" -Wait
Write-Host "$(Get-Date -Format G): Finished installing Windows 7 Service Pack 1."

# Remove-item got an error 
#﻿You must provide a value expression on the right-hand side of the '-f' operator
#==> virtualbox-iso: .
#==> virtualbox-iso: At C:\Windows\Temp\script-5e1e320a-685e-3177-3954-f081a8c66727.ps1:15 char:17
#==> virtualbox-iso: +  "C:\Updates" -F <<<< orce -Recurse
# It should probably be 
# Remove-Item -Force -Recurse "C:\Updates"
Write-Host "$(Get-Date -Format G): Removing C:\Updates"
Remove-Item -LiteralPath "C:\Updates" -Force -Recurse -ErrorAction SilentlyContinue
#Remove-Item -Force -Recurse "C:\Updates"
Write-Host "$(Get-Date -Format G): The VM will now reboot and continue the installation process."
Write-Host "$(Get-Date -Format G): This may take a couple of minutes."