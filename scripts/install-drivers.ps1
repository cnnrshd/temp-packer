# Build should be the shorthand name for this version - "windows_10" or "windows_2019" are two examples
$build = $Env:OS_VERS
if ($null -eq $build) {
	write-host "Using env:os_vers didn't work, switching to os_vers"
	$build = $OS_VERS
}
Write-Host $build
# getting links available
$page = wget -UseBasicParsing "http:\\$Env:PACKER_HTTP_ADDR/virtio-drivers/$build"
$page.links | fl -Property *
set-location C:\Users\whiteteam\Desktop

# Download and install viostar driver
$viostor_url="http:\\$Env:PACKER_HTTP_ADDR/virtio-drivers/$build/viostor.zip"
$viostor_outfile="C:\Users\whiteteam\Desktop\viostor.zip"
Invoke-WebRequest -UseBasicParsing $viostor_url -OutFile $viostor_outfile
Expand-Archive ".\viostor.zip"

# Download and install NetKVM driver
$netkvm_url="http:\\$Env:PACKER_HTTP_ADDR/virtio-drivers/$build/NetKVM.zip"
$netkvm_outfile="C:\Users\whiteteam\Desktop\NetKVM.zip"
Invoke-WebRequest -UseBasicParsing $netkvm_url -OutFile $netkvm_outfile
Expand-Archive ".\NetKVM.zip"

Get-ChildItem "C:\Users\whiteteam\Desktop\" -Recurse -Filter "*.inf" | 
ForEach-Object { PNPUtil.exe /add-driver $_.FullName /install }

# Remove the driver folders and zips
Remove-Item -Force -Recurse "C:\Users\whiteteam\Desktop\NetKVM\" 
Remove-Item -Force "C:\Users\whiteteam\Desktop\NetKVM.zip" 
Remove-Item -Force -Recurse "C:\Users\whiteteam\Desktop\viostor\" 
Remove-Item -Force "C:\Users\whiteteam\Desktop\viostor.zip" 