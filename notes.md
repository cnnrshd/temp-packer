# TODO:
- Change the DNS server to 1.1.1.1 for resolving

## Some weird virtualbox stuff
- IDE controller is called "IDE Controller", and it has 2 ports by default. Both are in use, first

## some weird stuff on GCP
- Packer, or Ubuntu, has an issue with using the {{user `os_version`}} inside the vars - it doesn't seem to copy correctly. It gives the error ```Error initializing core: error interpolating default value for 'autounattend': template: root:1:4: executing "root " at <user `os_version`>: error calling user: test```
  - This needs to be hard-coded for some reason. Changing the floppy string to be the correct location (but based on user`os)
- VT-X needs to be enabled - this is a semi-complicated process https://cloud.google.com/compute/docs/instances/enable-nested-virtualization-vm-instances
## provisioners
### Changed
#### This
```
"execute_command": "{{ .Vars }} cmd /c \"{{ .Path }}\"",
"remote_path": "/tmp/script.bat",
"scripts": [
	"./scripts/pin-powershell.bat",
	"./scripts/compile-dotnet-assemblies.bat",
	"./scripts/set-winrm-automatic.bat",
	"./scripts/uac-enable.bat",
	"./scripts/dis-updates.bat",
	"./scripts/compact.bat"
],
"type": "windows-shell"
```
	
#### Into this
```
"execute_command": "{{ .Vars }} cmd /c \"{{ .Path }}\"",
"remote_path": "/tmp/script.bat",
"scripts": [
	"./scripts/set-winrm-automatic.bat",
	"./scripts/uac-enable.bat",
	"./scripts/dis-updates.bat",
	"./scripts/compact.bat"
],
"type": "windows-shell"

```

### Removed
#### This
```
{
"scripts": [
  "./scripts/set-powerplan.ps1",
  "./scripts/docker/disable-windows-defender.ps1"
],
"type": "powershell"
},
```
#### This
```
{
"execute_command": "{{ .Vars }} cmd /c \"{{ .Path }}\"",
"remote_path": "/tmp/script.bat",
"scripts": [
  "./scripts/vm-guest-tools.bat",
  "./scripts/enable-rdp.bat"
],
"type": "windows-shell"
},
```
#### This
```
{
"scripts": [
  "./scripts/debloat-windows.ps1"
],
"type": "powershell"
},
```

## Builders
- Removed "floppy_file"
  - disable-winrm.ps1
  - win-updates.ps1
  - microsoft-updates.bat